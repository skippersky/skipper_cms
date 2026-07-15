# Incremental Deploy

Use `scripts/deploy-init.sh` for first deployment.

Use `scripts/deploy-update.sh` for later iterations. It compares the current local commit with `origin/main`, detects changed paths, and rebuilds only the affected services.

```bash
cd /opt/skipper-cms
sudo ./scripts/deploy-update.sh
```

Detection rules:

- `server/**` changes rebuild `server`
- `frontend/site/**` changes rebuild `site`
- `frontend/admin/**` changes rebuild `admin`
- `docker-compose.yml` changes rebuild affected app services and applies compose changes
- non-service docs changes do not rebuild containers

If `/opt/skipper-cms` is not a Git repository, the script cannot calculate Git diffs and falls back to rebuilding `server site admin` from the current files. For best incremental behavior, deploy from a Git clone.

