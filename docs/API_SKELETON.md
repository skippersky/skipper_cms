# API 骨架

## 官网接口

- `GET /api/site/home`
- `GET /api/site/company`
- `GET /api/site/products`
- `GET /api/site/products/{slug}`
- `GET /api/site/contact`
- `POST /api/site/inquiries`

## 后台接口

- `POST /api/admin/auth/login`
- `GET /api/admin/auth/profile`
- `GET /api/admin/products`
- `POST /api/admin/products`
- `PUT /api/admin/products/{id}`
- `GET /api/admin/inquiries`
- `PUT /api/admin/inquiries/{id}/status`
- `POST /api/admin/media/upload`

## 响应式图片结构

```json
{
  "id": 1001,
  "alt": "CNC precision hardware part",
  "originalUrl": "/uploads/original/part.jpg",
  "variants": {
    "mobile": { "url": "/uploads/mobile/part.webp", "width": 750, "height": 520, "format": "webp" },
    "tablet": { "url": "/uploads/tablet/part.webp", "width": 1024, "height": 720, "format": "webp" },
    "desktop": { "url": "/uploads/desktop/part.webp", "width": 1600, "height": 900, "format": "webp" },
    "thumb": { "url": "/uploads/thumb/part.webp", "width": 320, "height": 220, "format": "webp" }
  }
}
```

