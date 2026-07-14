# Skipper CMS

五金工厂行业官网与 CMS 后台管理系统。

## 架构

- `server`: Spring Boot 3 单体服务端，暴露 `/api/site/*` 与 `/api/admin/*`
- `frontend/site`: Vue 3 + TypeScript 官网，Mobile-First 响应式
- `frontend/admin`: Vue 3 + TypeScript 后台，Desktop-Primary
- `frontend/shared`: 前端共享 Design Token 与类型

## 核心约束

- 官网 CSS 必须移动端优先，使用 `min-width` 媒体查询扩展桌面端。
- 后台接口强制 JWT + RBAC，官网接口公开但限流。
- 媒体上传生成 desktop/tablet/mobile/thumb 多尺寸 WebP 变体。
- 内容变更通过 Spring Event 触发缓存失效。

