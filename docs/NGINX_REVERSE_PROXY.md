# Nginx Reverse Proxy

CMS containers bind only to `127.0.0.1` on the host:

- site: `127.0.0.1:8888`
- admin: `127.0.0.1:8889`

Put the public `80/443` entry in one unified Nginx service or host-level Nginx.

```nginx
server {
  listen 80;
  server_name example.com;

  location / {
    proxy_pass http://127.0.0.1:8888;
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
  }
}

server {
  listen 80;
  server_name cms.example.com;

  location / {
    proxy_pass http://127.0.0.1:8889;
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
  }
}
```

If you manage multiple systems in one compose stack, keep only the gateway Nginx service on public ports:

```yaml
services:
  nginx:
    ports:
      - "80:80"
      - "443:443"

  erp:
    ports:
      - "127.0.0.1:8080:8080"

  cms-site:
    ports:
      - "127.0.0.1:8888:80"

  cms-admin:
    ports:
      - "127.0.0.1:8889:80"
```
