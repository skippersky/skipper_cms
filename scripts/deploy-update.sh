#!/usr/bin/env bash
set -Eeuo pipefail

APP_DIR="${APP_DIR:-/opt/skipper-cms}"
BRANCH="${BRANCH:-main}"
GIT_TIMEOUT_SECONDS="${GIT_TIMEOUT_SECONDS:-45}"

log() {
  echo ""
  echo "==> $*"
}

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

compose_cmd() {
  if docker compose version >/dev/null 2>&1; then
    docker compose "$@"
  elif command_exists docker-compose; then
    docker-compose "$@"
  else
    echo "Docker Compose was not found. Please install docker compose plugin or docker-compose."
    exit 1
  fi
}

compose_build_plain() {
  if docker compose version >/dev/null 2>&1; then
    docker compose --progress=plain build "$@"
  elif command_exists docker-compose; then
    docker-compose build "$@"
  else
    echo "Docker Compose was not found. Please install docker compose plugin or docker-compose."
    exit 1
  fi
}

retry_git() {
  local attempt=1
  local max_attempts=3

  until timeout "$GIT_TIMEOUT_SECONDS" git -c http.version=HTTP/1.1 "$@"; do
    if [ "$attempt" -ge "$max_attempts" ]; then
      echo "Git command failed after ${max_attempts} attempts."
      return 1
    fi
    echo "Git network command failed. Retrying in $((attempt * 3)) seconds... (${attempt}/${max_attempts})"
    sleep $((attempt * 3))
    attempt=$((attempt + 1))
  done
}

contains_path() {
  local pattern="$1"
  grep -Eq "$pattern" "$CHANGED_FILE_LIST"
}

if ! command_exists git; then
  echo "git was not found. Please install git first."
  exit 1
fi

if ! command_exists docker; then
  echo "docker was not found. Please install docker first."
  exit 1
fi

if [ ! -d "$APP_DIR" ]; then
  echo "${APP_DIR} does not exist. Run scripts/deploy-init.sh first."
  exit 1
fi

cd "$APP_DIR"

if [ ! -d ".git" ]; then
  log "Current app directory is not a Git repository"
  echo "Cannot perform Git diff based incremental deployment."
  echo "Run scripts/deploy-init.sh, or deploy from a Git clone to enable incremental updates."
  echo "Falling back to rebuilding app services from current files."
  compose_build_plain server site admin
  compose_cmd up -d
  compose_cmd ps
  exit 0
fi

log "Fetching ${BRANCH}"
BEFORE_COMMIT="$(git rev-parse HEAD)"
retry_git fetch origin "$BRANCH"
AFTER_COMMIT="$(git rev-parse "origin/${BRANCH}")"

if [ "$BEFORE_COMMIT" = "$AFTER_COMMIT" ]; then
  log "No code changes detected"
  compose_cmd ps
  exit 0
fi

CHANGED_FILE_LIST="$(mktemp)"
git diff --name-only "$BEFORE_COMMIT" "$AFTER_COMMIT" > "$CHANGED_FILE_LIST"

log "Changed files"
cat "$CHANGED_FILE_LIST"

log "Updating working tree"
git checkout -B "$BRANCH" "$AFTER_COMMIT"
git reset --hard "$AFTER_COMMIT"

declare -a services_to_build=()
needs_up=false

if contains_path '^(server/|docker-compose\.yml|\.env\.example)$'; then
  services_to_build+=("server")
  needs_up=true
fi

if contains_path '^(frontend/site/|docker-compose\.yml|\.env\.example)$'; then
  services_to_build+=("site")
  needs_up=true
fi

if contains_path '^(frontend/admin/|docker-compose\.yml|\.env\.example)$'; then
  services_to_build+=("admin")
  needs_up=true
fi

if contains_path '^(docker-compose\.yml|scripts/|docs/NGINX_REVERSE_PROXY\.md)$'; then
  needs_up=true
fi

if [ "${#services_to_build[@]}" -gt 0 ]; then
  log "Building changed services: ${services_to_build[*]}"
  compose_build_plain "${services_to_build[@]}"
fi

if [ "$needs_up" = true ]; then
  log "Applying compose changes"
  compose_cmd up -d
else
  log "No deployable service changes detected"
fi

log "Service status"
compose_cmd ps

rm -f "$CHANGED_FILE_LIST"
