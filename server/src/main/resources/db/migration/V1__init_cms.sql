CREATE TABLE cms_site_config (
  id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
  config_key VARCHAR(120) NOT NULL COMMENT '配置键',
  config_value JSON NOT NULL COMMENT '配置值',
  enabled TINYINT NOT NULL DEFAULT 1 COMMENT '是否启用',
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  deleted TINYINT NOT NULL DEFAULT 0 COMMENT '逻辑删除',
  UNIQUE KEY uk_site_config_key (config_key)
) COMMENT='站点配置';

CREATE TABLE cms_media_asset (
  id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
  file_name VARCHAR(255) NOT NULL COMMENT '文件名',
  original_name VARCHAR(255) NOT NULL COMMENT '原始文件名',
  mime_type VARCHAR(120) NOT NULL COMMENT 'MIME类型',
  original_url VARCHAR(500) NOT NULL COMMENT '原始文件URL',
  file_size BIGINT NOT NULL DEFAULT 0 COMMENT '文件大小',
  group_name VARCHAR(80) NULL COMMENT '媒体分组',
  alt_text VARCHAR(255) NULL COMMENT '替代文本',
  sha256 VARCHAR(128) NULL COMMENT '文件哈希',
  reference_count INT NOT NULL DEFAULT 0 COMMENT '引用计数',
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  deleted TINYINT NOT NULL DEFAULT 0 COMMENT '逻辑删除',
  KEY idx_media_group (group_name),
  KEY idx_media_sha256 (sha256)
) COMMENT='媒体资产';

CREATE TABLE cms_media_variant (
  id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
  media_id BIGINT NOT NULL COMMENT '媒体ID',
  variant_type VARCHAR(32) NOT NULL COMMENT '变体类型: desktop/tablet/mobile/thumb',
  format VARCHAR(20) NOT NULL COMMENT '格式',
  width INT NOT NULL COMMENT '宽度',
  height INT NOT NULL COMMENT '高度',
  url VARCHAR(500) NOT NULL COMMENT '访问URL',
  file_size BIGINT NOT NULL DEFAULT 0 COMMENT '文件大小',
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  UNIQUE KEY uk_media_variant (media_id, variant_type),
  KEY idx_variant_media (media_id),
  CONSTRAINT fk_media_variant_asset FOREIGN KEY (media_id) REFERENCES cms_media_asset(id)
) COMMENT='媒体多尺寸变体';

CREATE TABLE cms_site_banner (
  id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
  title VARCHAR(160) NOT NULL COMMENT '标题',
  subtitle VARCHAR(255) NULL COMMENT '副标题',
  desktop_media_id BIGINT NULL COMMENT '桌面Banner媒体ID',
  mobile_media_id BIGINT NULL COMMENT '移动Banner媒体ID',
  link_url VARCHAR(500) NULL COMMENT '跳转URL',
  sort_order INT NOT NULL DEFAULT 0 COMMENT '排序',
  published TINYINT NOT NULL DEFAULT 0 COMMENT '是否发布',
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  deleted TINYINT NOT NULL DEFAULT 0 COMMENT '逻辑删除',
  KEY idx_banner_published_sort (published, sort_order)
) COMMENT='站点Banner';

CREATE TABLE cms_product_category (
  id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
  parent_id BIGINT NULL COMMENT '父分类ID',
  name VARCHAR(120) NOT NULL COMMENT '分类名称',
  slug VARCHAR(160) NOT NULL COMMENT 'URL标识',
  sort_order INT NOT NULL DEFAULT 0 COMMENT '排序',
  published TINYINT NOT NULL DEFAULT 0 COMMENT '是否发布',
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  deleted TINYINT NOT NULL DEFAULT 0 COMMENT '逻辑删除',
  UNIQUE KEY uk_product_category_slug (slug),
  KEY idx_product_category_parent (parent_id),
  KEY idx_product_category_published (published, sort_order)
) COMMENT='产品分类';

CREATE TABLE cms_product_param_template (
  id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
  name VARCHAR(120) NOT NULL COMMENT '模板名称',
  industry_type VARCHAR(80) NULL COMMENT '行业类型',
  enabled TINYINT NOT NULL DEFAULT 1 COMMENT '是否启用',
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  deleted TINYINT NOT NULL DEFAULT 0 COMMENT '逻辑删除'
) COMMENT='产品参数模板';

CREATE TABLE cms_product_param_template_field (
  id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
  template_id BIGINT NOT NULL COMMENT '模板ID',
  field_key VARCHAR(80) NOT NULL COMMENT '字段键',
  field_label VARCHAR(120) NOT NULL COMMENT '字段标签',
  unit VARCHAR(24) NULL COMMENT '单位:mm/kg/MPa',
  required TINYINT NOT NULL DEFAULT 0 COMMENT '是否必填',
  sort_order INT NOT NULL DEFAULT 0 COMMENT '排序',
  KEY idx_template_field (template_id, sort_order),
  CONSTRAINT fk_template_field_template FOREIGN KEY (template_id) REFERENCES cms_product_param_template(id)
) COMMENT='产品参数模板字段';

CREATE TABLE cms_product (
  id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
  category_id BIGINT NOT NULL COMMENT '分类ID',
  param_template_id BIGINT NULL COMMENT '参数模板ID',
  name VARCHAR(180) NOT NULL COMMENT '产品名称',
  slug VARCHAR(180) NOT NULL COMMENT 'URL标识',
  summary VARCHAR(500) NULL COMMENT '摘要',
  material VARCHAR(120) NULL COMMENT '材质',
  tolerance VARCHAR(80) NULL COMMENT '公差',
  surface_treatment VARCHAR(120) NULL COMMENT '表面处理',
  drawing_pdf_url VARCHAR(500) NULL COMMENT 'PDF图纸URL',
  drawing_dwg_url VARCHAR(500) NULL COMMENT 'DWG图纸URL',
  published TINYINT NOT NULL DEFAULT 0 COMMENT '是否发布',
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  deleted TINYINT NOT NULL DEFAULT 0 COMMENT '逻辑删除',
  UNIQUE KEY uk_product_slug (slug),
  KEY idx_product_category_published (category_id, published),
  FULLTEXT KEY ft_product_name_summary (name, summary)
) COMMENT='产品';

CREATE TABLE cms_product_image (
  id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
  product_id BIGINT NOT NULL COMMENT '产品ID',
  media_id BIGINT NOT NULL COMMENT '媒体ID',
  sort_order INT NOT NULL DEFAULT 0 COMMENT '排序',
  KEY idx_product_image (product_id, sort_order),
  CONSTRAINT fk_product_image_product FOREIGN KEY (product_id) REFERENCES cms_product(id),
  CONSTRAINT fk_product_image_media FOREIGN KEY (media_id) REFERENCES cms_media_asset(id)
) COMMENT='产品图片';

CREATE TABLE cms_product_custom_param (
  id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
  product_id BIGINT NOT NULL COMMENT '产品ID',
  param_key VARCHAR(80) NOT NULL COMMENT '参数键',
  param_label VARCHAR(120) NOT NULL COMMENT '参数标签',
  param_value VARCHAR(255) NOT NULL COMMENT '参数值',
  unit VARCHAR(24) NULL COMMENT '单位:mm/kg/MPa',
  sort_order INT NOT NULL DEFAULT 0 COMMENT '排序',
  KEY idx_product_param (product_id, sort_order),
  CONSTRAINT fk_custom_param_product FOREIGN KEY (product_id) REFERENCES cms_product(id)
) COMMENT='产品自定义参数';

CREATE TABLE cms_article_category (
  id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
  name VARCHAR(120) NOT NULL COMMENT '分类名称',
  slug VARCHAR(160) NOT NULL COMMENT 'URL标识',
  sort_order INT NOT NULL DEFAULT 0 COMMENT '排序',
  UNIQUE KEY uk_article_category_slug (slug)
) COMMENT='文章分类';

CREATE TABLE cms_article (
  id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
  category_id BIGINT NULL COMMENT '分类ID',
  title VARCHAR(200) NOT NULL COMMENT '标题',
  slug VARCHAR(180) NOT NULL COMMENT 'URL标识',
  summary VARCHAR(500) NULL COMMENT '摘要',
  content LONGTEXT NOT NULL COMMENT '正文',
  cover_media_id BIGINT NULL COMMENT '封面媒体ID',
  published TINYINT NOT NULL DEFAULT 0 COMMENT '是否发布',
  published_at DATETIME NULL COMMENT '发布时间',
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  deleted TINYINT NOT NULL DEFAULT 0 COMMENT '逻辑删除',
  UNIQUE KEY uk_article_slug (slug),
  KEY idx_article_published (published, published_at)
) COMMENT='文章';

CREATE TABLE cms_inquiry (
  id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
  company_name VARCHAR(160) NULL COMMENT '公司名称',
  contact_name VARCHAR(80) NOT NULL COMMENT '联系人',
  phone VARCHAR(40) NULL COMMENT '电话',
  email VARCHAR(120) NULL COMMENT '邮箱',
  status VARCHAR(40) NOT NULL DEFAULT 'NEW' COMMENT '状态',
  message TEXT NULL COMMENT '留言',
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  KEY idx_inquiry_status_created (status, created_at)
) COMMENT='询盘';

CREATE TABLE cms_inquiry_item (
  id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
  inquiry_id BIGINT NOT NULL COMMENT '询盘ID',
  product_id BIGINT NULL COMMENT '产品ID',
  quantity INT NULL COMMENT '数量',
  CONSTRAINT fk_inquiry_item_inquiry FOREIGN KEY (inquiry_id) REFERENCES cms_inquiry(id)
) COMMENT='询盘明细';

CREATE TABLE cms_admin_user (
  id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
  username VARCHAR(80) NOT NULL COMMENT '用户名',
  password_hash VARCHAR(255) NOT NULL COMMENT '密码哈希',
  display_name VARCHAR(120) NULL COMMENT '显示名',
  email VARCHAR(120) NULL COMMENT '邮箱',
  enabled TINYINT NOT NULL DEFAULT 1 COMMENT '是否启用',
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  deleted TINYINT NOT NULL DEFAULT 0 COMMENT '逻辑删除',
  UNIQUE KEY uk_admin_username (username)
) COMMENT='后台用户';

CREATE TABLE cms_role (
  id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
  code VARCHAR(80) NOT NULL COMMENT '角色编码',
  name VARCHAR(120) NOT NULL COMMENT '角色名称',
  UNIQUE KEY uk_role_code (code)
) COMMENT='角色';

CREATE TABLE cms_permission (
  id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
  code VARCHAR(120) NOT NULL COMMENT '权限编码',
  name VARCHAR(120) NOT NULL COMMENT '权限名称',
  UNIQUE KEY uk_permission_code (code)
) COMMENT='权限';

CREATE TABLE cms_admin_user_role (
  user_id BIGINT NOT NULL COMMENT '用户ID',
  role_id BIGINT NOT NULL COMMENT '角色ID',
  PRIMARY KEY (user_id, role_id)
) COMMENT='用户角色';

CREATE TABLE cms_role_permission (
  role_id BIGINT NOT NULL COMMENT '角色ID',
  permission_id BIGINT NOT NULL COMMENT '权限ID',
  PRIMARY KEY (role_id, permission_id)
) COMMENT='角色权限';

CREATE TABLE cms_operation_log (
  id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
  user_id BIGINT NULL COMMENT '用户ID',
  action VARCHAR(120) NOT NULL COMMENT '操作',
  resource VARCHAR(160) NULL COMMENT '资源',
  ip VARCHAR(64) NULL COMMENT 'IP',
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  KEY idx_operation_user_created (user_id, created_at)
) COMMENT='操作日志';

