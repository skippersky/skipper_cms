#!/usr/bin/env bash
set -Eeuo pipefail

REPO_URL="${REPO_URL:-https://github.com/skippersky/skipper_cms.git}"
APP_DIR="${APP_DIR:-/opt/skipper-cms}"
BRANCH="${BRANCH:-main}"

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
  local max_attempts=5

  until git -c http.version=HTTP/1.1 "$@"; do
    if [ "$attempt" -ge "$max_attempts" ]; then
      echo "Git command failed after ${max_attempts} attempts."
      return 1
    fi
    echo "Git network command failed. Retrying in $((attempt * 3)) seconds... (${attempt}/${max_attempts})"
    sleep $((attempt * 3))
    attempt=$((attempt + 1))
  done
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

if [ ! -d "$APP_DIR/.git" ]; then
  log "Cloning repository to ${APP_DIR}"
  retry_git clone --depth 1 --single-branch --branch "$BRANCH" "$REPO_URL" "$APP_DIR"
else
  log "Updating repository in ${APP_DIR}"
  retry_git -C "$APP_DIR" fetch --depth 1 origin "$BRANCH"
  git -C "$APP_DIR" checkout "$BRANCH"
  retry_git -C "$APP_DIR" pull --ff-only origin "$BRANCH"
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
compose_cmd build --progress=plain server site admin

log "Starting services"
compose_cmd up -d

log "Service status"
compose_cmd ps

echo ""
echo "Skipper CMS deployment is complete."
echo "Site:   http://<server-ip>:$(grep '^SITE_PUBLIC_PORT=' .env | cut -d= -f2)"
echo "Admin:  http://<server-ip>:$(grep '^ADMIN_PUBLIC_PORT=' .env | cut -d= -f2)"
echo "Server: http://<server-ip>:$(grep '^SERVER_PUBLIC_PORT=' .env | cut -d= -f2)"
echo ""
echo "Useful commands:"
echo "  cd ${APP_DIR}"
echo "  docker compose ps"
echo "  docker compose logs -f server"
echo "  docker compose down"
