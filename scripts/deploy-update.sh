#!/usr/bin/env bash
set -Eeuo pipefail

APP_DIR="${APP_DIR:-/opt/skipper-cms}"
BRANCH="${BRANCH:-main}"
REMOTE="${REMOTE:-origin}"
GIT_TIMEOUT_SECONDS="${GIT_TIMEOUT_SECONDS:-120}"
FORCE_REBUILD="${FORCE_REBUILD:-false}"

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

compose_build_no_cache_plain() {
  if docker compose version >/dev/null 2>&1; then
    docker compose --progress=plain build --no-cache "$@"
  elif command_exists docker-compose; then
    docker-compose build --no-cache "$@"
  else
    echo "Docker Compose was not found. Please install docker compose plugin or docker-compose."
    exit 1
  fi
}

retry_git() {
  local attempt=1
  local max_attempts="${GIT_RETRY_TIMES:-3}"

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
  echo "This script will not rebuild from stale local files because new code cannot be pulled."
  echo "Please replace ${APP_DIR} with a Git clone, or download the latest archive before deploying."
  echo ""
  echo "Recommended Git setup:"
  echo "  cd /opt"
  echo "  sudo mv skipper-cms skipper-cms.bak.\$(date +%Y%m%d%H%M%S)"
  echo "  sudo git clone --depth 1 https://github.com/skippersky/skipper_cms.git skipper-cms"
  echo "  sudo cp skipper-cms.bak.*/.env skipper-cms/.env"
  exit 2
fi

log "Repository"
echo "Path:   ${APP_DIR}"
echo "Remote: ${REMOTE}"
echo "Branch: ${BRANCH}"
git remote -v

log "Fetching ${REMOTE}/${BRANCH}"
BEFORE_COMMIT="$(git rev-parse HEAD)"
echo "Current commit: ${BEFORE_COMMIT}"
retry_git fetch --prune "$REMOTE" "${BRANCH}:refs/remotes/${REMOTE}/${BRANCH}"

if ! git rev-parse --verify "${REMOTE}/${BRANCH}" >/dev/null 2>&1; then
  echo "No ${REMOTE}/${BRANCH} reference is available. Cannot determine what to deploy."
  exit 1
fi

AFTER_COMMIT="$(git rev-parse "${REMOTE}/${BRANCH}")"
echo "Remote commit:  ${AFTER_COMMIT}"

if [ "$BEFORE_COMMIT" = "$AFTER_COMMIT" ] && [ "$FORCE_REBUILD" != "true" ]; then
  log "No code changes detected"
  echo "Already deployed commit: ${BEFORE_COMMIT}"
  echo "Tip: run FORCE_REBUILD=true $0 to rebuild containers from the current code."
  compose_cmd ps
  exit 0
fi

CHANGED_FILE_LIST="$(mktemp)"
if [ "$BEFORE_COMMIT" = "$AFTER_COMMIT" ]; then
  : > "$CHANGED_FILE_LIST"
else
  git diff --name-only "$BEFORE_COMMIT" "$AFTER_COMMIT" > "$CHANGED_FILE_LIST"
fi

if [ -s "$CHANGED_FILE_LIST" ]; then
  log "Changed files"
  cat "$CHANGED_FILE_LIST"
else
  log "No Git file diff, force rebuild mode is active"
fi

log "Updating working tree"
git checkout -B "$BRANCH" "$AFTER_COMMIT"
git reset --hard "$AFTER_COMMIT"
DEPLOYED_COMMIT="$(git rev-parse HEAD)"
echo "Deployed commit: ${DEPLOYED_COMMIT}"

if [ "$DEPLOYED_COMMIT" != "$AFTER_COMMIT" ]; then
  echo "Working tree did not update to expected commit."
  exit 1
fi

declare -a services_to_build=()
needs_up=false

if [ "$FORCE_REBUILD" = "true" ] || contains_path '^(server/|docker-compose\.yml|\.env\.example)$'; then
  services_to_build+=("server")
  needs_up=true
fi

if [ "$FORCE_REBUILD" = "true" ] || contains_path '^(frontend/site/|docker-compose\.yml|\.env\.example)$'; then
  services_to_build+=("site")
  needs_up=true
fi

if [ "$FORCE_REBUILD" = "true" ] || contains_path '^(frontend/admin/|docker-compose\.yml|\.env\.example)$'; then
  services_to_build+=("admin")
  needs_up=true
fi

if contains_path '^(docker-compose\.yml|scripts/|docs/NGINX_REVERSE_PROXY\.md)$'; then
  needs_up=true
fi

if [ "${#services_to_build[@]}" -gt 0 ]; then
  log "Building changed services: ${services_to_build[*]}"
  declare -a normal_build_services=()
  for service in "${services_to_build[@]}"; do
    if [ "$service" = "server" ]; then
      log "Building server without Docker cache"
      compose_build_no_cache_plain server
    else
      normal_build_services+=("$service")
    fi
  done

  if [ "${#normal_build_services[@]}" -gt 0 ]; then
    compose_build_plain "${normal_build_services[@]}"
  fi
fi

if [ "$needs_up" = true ]; then
  log "Applying compose changes"
  compose_cmd up -d
else
  log "No deployable service changes detected"
fi

log "Service status"
compose_cmd ps

log "Deployed revision"
git --no-pager log -1 --oneline

rm -f "$CHANGED_FILE_LIST"
