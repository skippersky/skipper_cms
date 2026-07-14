#!/usr/bin/env bash
set -Eeuo pipefail

REPO_URL="${REPO_URL:-https://github.com/skippersky/skipper_cms.git}"
APP_DIR="${APP_DIR:-/opt/skipper-cms}"
BRANCH="${BRANCH:-main}"

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

compose_cmd() {
  if docker compose version >/dev/null 2>&1; then
    docker compose "$@"
  elif command_exists docker-compose; then
    docker-compose "$@"
  else
    echo "未检测到 Docker Compose。请安装 docker compose plugin 或 docker-compose。"
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

if ! command_exists git; then
  echo "未检测到 git，请先安装 git。"
  exit 1
fi

if ! command_exists docker; then
  echo "未检测到 docker，请先安装 docker。"
  exit 1
fi

mkdir -p "$(dirname "$APP_DIR")"

if [ ! -d "$APP_DIR/.git" ]; then
  git clone --branch "$BRANCH" "$REPO_URL" "$APP_DIR"
else
  git -C "$APP_DIR" fetch origin "$BRANCH"
  git -C "$APP_DIR" checkout "$BRANCH"
  git -C "$APP_DIR" pull --ff-only origin "$BRANCH"
fi

cd "$APP_DIR"

if [ ! -f .env ]; then
  cp .env.example .env
  MYSQL_ROOT_PASSWORD="$(make_secret)"
  MYSQL_PASSWORD="$(make_secret)"
  CMS_JWT_SECRET="$(make_secret)$(make_secret)"

  sed -i "s#^MYSQL_ROOT_PASSWORD=.*#MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}#" .env
  sed -i "s#^MYSQL_PASSWORD=.*#MYSQL_PASSWORD=${MYSQL_PASSWORD}#" .env
  sed -i "s#^CMS_JWT_SECRET=.*#CMS_JWT_SECRET=${CMS_JWT_SECRET}#" .env
fi

compose_cmd pull mysql redis
compose_cmd up -d --build

echo ""
echo "Skipper CMS 部署完成。"
echo "官网地址:  http://<服务器IP>:$(grep '^SITE_PUBLIC_PORT=' .env | cut -d= -f2)"
echo "后台地址:  http://<服务器IP>:$(grep '^ADMIN_PUBLIC_PORT=' .env | cut -d= -f2)"
echo "后端接口:  http://<服务器IP>:$(grep '^SERVER_PUBLIC_PORT=' .env | cut -d= -f2)"
echo ""
echo "常用命令："
echo "  cd ${APP_DIR}"
echo "  docker compose ps"
echo "  docker compose logs -f server"
echo "  docker compose down"

