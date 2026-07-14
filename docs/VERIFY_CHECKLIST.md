# 验证清单

## 移动端模拟截图

每个官网页面需要在 Chrome DevTools 中检查并保存截图：

- iPhone SE: 375 x 667
- iPhone 14 Pro: 393 x 852
- iPad Mini: 768 x 1024

页面范围：

- 首页 `/`
- 公司展示 `/company`
- 产品展示 `/products`
- 联系我们 `/contact`

检查项：

- 导航抽屉展开后 body 滚动锁定。
- 点击区域不小于 44 x 44px。
- 表单输入框高度不小于 48px。
- 正文不小于 16px，辅助文字不小于 14px。
- 产品参数表在移动端横向滚动，不缩放页面。
- 询盘按钮在产品移动端固定底部，无遮挡。
- 图片使用 `<picture>` 与 `srcset`，移动端优先加载 mobile WebP。

## Lighthouse 移动端目标

- LCP: 3G Fast <= 2.5s，4G <= 1.5s
- CLS <= 0.1
- 首屏 JS gzip 后 <= 150KB
- 首页缓存命中接口 P99 <= 20ms

## SEO

- 每个页面有唯一 title 与 description。
- 产品详情使用规范化 URL。
- 图片有 alt 文本。
- 面包屑移动端允许中间层省略，但结构化数据保留完整层级。

## 安全

- `/api/site/*` 无需登录，但必须限流。
- `/api/admin/*` 强制 JWT。
- 官网接口不返回未发布内容、后台备注、操作日志、用户字段。
- 后台接口不返回 passwordHash、JWT secret、上传物理路径。
- CORS 通过环境变量配置，不硬编码域名。

