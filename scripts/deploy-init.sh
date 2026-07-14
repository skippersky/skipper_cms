#!/usr/bin/env bash
set -Eeuo pipefail

REPO_URL="${REPO_URL:-https://github.com/skippersky/skipper_cms.git}"
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

make_secret() {
  if command_exists openssl; then
    openssl rand -base64 36 | tr -d '\n'
  else
    date +%s%N | sha256sum | awk '{print $1}'
  fi
}

set_env_value() {
  local key="$1"
  local value="$2"
  local file=".env"

  if grep -q "^${key}=" "$file"; then
    sed -i "s#^${key}=.*#${key}=${value}#" "$file"
  else
    printf "\n%s=%s\n" "$key" "$value" >> "$file"
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

update_from_archive() {
  local archive_url="https://codeload.github.com/skippersky/skipper_cms/tar.gz/refs/heads/${BRANCH}"
  local tmp_dir
  local env_backup

  if ! command_exists curl || ! command_exists tar; then
    echo "curl and tar are required for archive fallback."
    return 1
  fi

  log "Falling back to GitHub archive download"
  tmp_dir="$(mktemp -d)"
  env_backup="${tmp_dir}/env.backup"

  if [ -f "${APP_DIR}/.env" ]; then
    cp "${APP_DIR}/.env" "$env_backup"
  fi

  curl -fL --retry 5 --retry-delay 3 --connect-timeout 20 "$archive_url" -o "${tmp_dir}/source.tar.gz"
  tar -xzf "${tmp_dir}/source.tar.gz" -C "$tmp_dir"

  mkdir -p "$APP_DIR"
  find "$APP_DIR" -mindepth 1 -maxdepth 1 ! -name ".env" -exec rm -rf {} +
  cp -a "${tmp_dir}/skipper_cms-${BRANCH}/." "$APP_DIR/"

  if [ -f "$env_backup" ]; then
    cp "$env_backup" "${APP_DIR}/.env"
  fi

  rm -rf "$tmp_dir"
}

if ! command_exists git; then
  echo "git was not found. Please install git first."
  exit 1
fi

if ! command_exists docker; then
  echo "docker was not found. Please install docker first."
  exit 1
fi

log "Docker version"
docker --version
if docker compose version >/dev/null 2>&1; then
  docker compose version
elif command_exists docker-compose; then
  docker-compose --version
fi

mkdir -p "$(dirname "$APP_DIR")"

if [ ! -e "$APP_DIR" ]; then
  log "Cloning repository to ${APP_DIR}"
  retry_git clone --branch "$BRANCH" "$REPO_URL" "$APP_DIR" || update_from_archive
elif [ ! -d "$APP_DIR/.git" ]; then
  log "${APP_DIR} is not a Git repository; updating from GitHub archive"
  update_from_archive
else
  log "Updating repository in ${APP_DIR}"
  if retry_git -C "$APP_DIR" fetch origin "$BRANCH"; then
    git -C "$APP_DIR" checkout "$BRANCH"
    git -C "$APP_DIR" reset --hard "origin/${BRANCH}"
  else
    update_from_archive
  fi
fi

cd "$APP_DIR"

if [ ! -f .env ]; then
  log "Creating .env"
  cp .env.example .env
  set_env_value "MYSQL_ROOT_PASSWORD" "$(make_secret)"
  set_env_value "MYSQL_PASSWORD" "$(make_secret)"
  set_env_value "CMS_JWT_SECRET" "$(make_secret)$(make_secret)"
fi

set_env_value "SITE_PUBLIC_PORT" "8888"
set_env_value "ADMIN_PUBLIC_PORT" "8889"

log "Pulling database images"
compose_cmd pull mysql redis

log "Building application images"
compose_build_plain server site admin

log "Starting services"
compose_cmd up -d

log "Service status"
compose_cmd ps

echo ""
echo "Skipper CMS deployment is complete."
echo "Site local target:  http://127.0.0.1:$(grep '^SITE_PUBLIC_PORT=' .env | cut -d= -f2)"
echo "Admin local target: http://127.0.0.1:$(grep '^ADMIN_PUBLIC_PORT=' .env | cut -d= -f2)"
echo "Expose them through your unified Nginx service on ports 80/443."
echo ""
echo "Useful commands:"
echo "  cd ${APP_DIR}"
echo "  docker compose ps"
echo "  docker compose logs -f server"
echo "  docker compose down"
