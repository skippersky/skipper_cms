#!/usr/bin/env bash
set -Eeuo pipefail

APP_DIR="${APP_DIR:-/opt/skipper-cms}"

compose_cmd() {
  if docker compose version >/dev/null 2>&1; then
    docker compose "$@"
  elif command -v docker-compose >/dev/null 2>&1; then
    docker-compose "$@"
  else
    echo "Docker Compose was not found."
    exit 1
  fi
}

echo "==> Docker"
docker --version || true
docker compose version || docker-compose --version || true

echo ""
echo "==> App directory"
ls -la "$APP_DIR" || true

if [ -d "$APP_DIR" ]; then
  cd "$APP_DIR"

  echo ""
  echo "==> Git"
  git status --short || true
  git log --oneline -3 || true

  echo ""
  echo "==> Compose config"
  compose_cmd config --services || true

  echo ""
  echo "==> Compose ps"
  compose_cmd ps || true

  echo ""
  echo "==> Recent logs"
  compose_cmd logs --tail=120 || true
fi
