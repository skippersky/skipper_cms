CREATE TABLE cms_site_config (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  config_key VARCHAR(120) NOT NULL,
  config_value JSON NOT NULL,
  enabled TINYINT NOT NULL DEFAULT 1,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted TINYINT NOT NULL DEFAULT 0,
  UNIQUE KEY uk_site_config_key (config_key)
) COMMENT='site config';

CREATE TABLE cms_media_asset (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  file_name VARCHAR(255) NOT NULL,
  original_name VARCHAR(255) NOT NULL,
  mime_type VARCHAR(120) NOT NULL,
  original_url VARCHAR(500) NOT NULL,
  file_size BIGINT NOT NULL DEFAULT 0,
  group_name VARCHAR(80) NULL,
  alt_text VARCHAR(255) NULL,
  sha256 VARCHAR(128) NULL,
  reference_count INT NOT NULL DEFAULT 0,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted TINYINT NOT NULL DEFAULT 0,
  KEY idx_media_group (group_name),
  KEY idx_media_sha256 (sha256)
) COMMENT='media asset';

CREATE TABLE cms_media_variant (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  media_id BIGINT NOT NULL,
  variant_type VARCHAR(32) NOT NULL,
  format VARCHAR(20) NOT NULL,
  width INT NOT NULL,
  height INT NOT NULL,
  url VARCHAR(500) NOT NULL,
  file_size BIGINT NOT NULL DEFAULT 0,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY uk_media_variant (media_id, variant_type),
  KEY idx_variant_media (media_id),
  CONSTRAINT fk_media_variant_asset FOREIGN KEY (media_id) REFERENCES cms_media_asset(id)
) COMMENT='media variant';

CREATE TABLE cms_site_banner (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  title VARCHAR(160) NOT NULL,
  subtitle VARCHAR(255) NULL,
  desktop_media_id BIGINT NULL,
  mobile_media_id BIGINT NULL,
  link_url VARCHAR(500) NULL,
  sort_order INT NOT NULL DEFAULT 0,
  published TINYINT NOT NULL DEFAULT 0,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted TINYINT NOT NULL DEFAULT 0,
  KEY idx_banner_published_sort (published, sort_order)
) COMMENT='site banner';

CREATE TABLE cms_product_category (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  parent_id BIGINT NULL,
  name VARCHAR(120) NOT NULL,
  slug VARCHAR(160) NOT NULL,
  sort_order INT NOT NULL DEFAULT 0,
  published TINYINT NOT NULL DEFAULT 0,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted TINYINT NOT NULL DEFAULT 0,
  UNIQUE KEY uk_product_category_slug (slug),
  KEY idx_product_category_parent (parent_id),
  KEY idx_product_category_published (published, sort_order)
) COMMENT='product category';

CREATE TABLE cms_product_param_template (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(120) NOT NULL,
  industry_type VARCHAR(80) NULL,
  enabled TINYINT NOT NULL DEFAULT 1,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted TINYINT NOT NULL DEFAULT 0
) COMMENT='product param template';

CREATE TABLE cms_product_param_template_field (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  template_id BIGINT NOT NULL,
  field_key VARCHAR(80) NOT NULL,
  field_label VARCHAR(120) NOT NULL,
  unit VARCHAR(24) NULL,
  required TINYINT NOT NULL DEFAULT 0,
  sort_order INT NOT NULL DEFAULT 0,
  KEY idx_template_field (template_id, sort_order),
  CONSTRAINT fk_template_field_template FOREIGN KEY (template_id) REFERENCES cms_product_param_template(id)
) COMMENT='product param template field';

CREATE TABLE cms_product (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  category_id BIGINT NOT NULL,
  param_template_id BIGINT NULL,
  name VARCHAR(180) NOT NULL,
  slug VARCHAR(180) NOT NULL,
  summary VARCHAR(500) NULL,
  material VARCHAR(120) NULL,
  tolerance VARCHAR(80) NULL,
  surface_treatment VARCHAR(120) NULL,
  drawing_pdf_url VARCHAR(500) NULL,
  drawing_dwg_url VARCHAR(500) NULL,
  published TINYINT NOT NULL DEFAULT 0,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted TINYINT NOT NULL DEFAULT 0,
  UNIQUE KEY uk_product_slug (slug),
  KEY idx_product_category_published (category_id, published),
  FULLTEXT KEY ft_product_name_summary (name, summary)
) COMMENT='product';

CREATE TABLE cms_product_image (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  product_id BIGINT NOT NULL,
  media_id BIGINT NOT NULL,
  sort_order INT NOT NULL DEFAULT 0,
  KEY idx_product_image (product_id, sort_order),
  CONSTRAINT fk_product_image_product FOREIGN KEY (product_id) REFERENCES cms_product(id),
  CONSTRAINT fk_product_image_media FOREIGN KEY (media_id) REFERENCES cms_media_asset(id)
) COMMENT='product image';

CREATE TABLE cms_product_custom_param (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  product_id BIGINT NOT NULL,
  param_key VARCHAR(80) NOT NULL,
  param_label VARCHAR(120) NOT NULL,
  param_value VARCHAR(255) NOT NULL,
  unit VARCHAR(24) NULL,
  sort_order INT NOT NULL DEFAULT 0,
  KEY idx_product_param (product_id, sort_order),
  CONSTRAINT fk_custom_param_product FOREIGN KEY (product_id) REFERENCES cms_product(id)
) COMMENT='product custom param';

CREATE TABLE cms_article_category (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(120) NOT NULL,
  slug VARCHAR(160) NOT NULL,
  sort_order INT NOT NULL DEFAULT 0,
  UNIQUE KEY uk_article_category_slug (slug)
) COMMENT='article category';

CREATE TABLE cms_article (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  category_id BIGINT NULL,
  title VARCHAR(200) NOT NULL,
  slug VARCHAR(180) NOT NULL,
  summary VARCHAR(500) NULL,
  content LONGTEXT NOT NULL,
  cover_media_id BIGINT NULL,
  published TINYINT NOT NULL DEFAULT 0,
  published_at DATETIME NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted TINYINT NOT NULL DEFAULT 0,
  UNIQUE KEY uk_article_slug (slug),
  KEY idx_article_published (published, published_at)
) COMMENT='article';

CREATE TABLE cms_inquiry (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  company_name VARCHAR(160) NULL,
  contact_name VARCHAR(80) NOT NULL,
  phone VARCHAR(40) NULL,
  email VARCHAR(120) NULL,
  status VARCHAR(40) NOT NULL DEFAULT 'NEW',
  message TEXT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY idx_inquiry_status_created (status, created_at)
) COMMENT='inquiry';

CREATE TABLE cms_inquiry_item (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  inquiry_id BIGINT NOT NULL,
  product_id BIGINT NULL,
  quantity INT NULL,
  CONSTRAINT fk_inquiry_item_inquiry FOREIGN KEY (inquiry_id) REFERENCES cms_inquiry(id)
) COMMENT='inquiry item';

CREATE TABLE cms_admin_user (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  username VARCHAR(80) NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  display_name VARCHAR(120) NULL,
  email VARCHAR(120) NULL,
  enabled TINYINT NOT NULL DEFAULT 1,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted TINYINT NOT NULL DEFAULT 0,
  UNIQUE KEY uk_admin_username (username)
) COMMENT='admin user';

CREATE TABLE cms_role (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  code VARCHAR(80) NOT NULL,
  name VARCHAR(120) NOT NULL,
  UNIQUE KEY uk_role_code (code)
) COMMENT='role';

CREATE TABLE cms_permission (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  code VARCHAR(120) NOT NULL,
  name VARCHAR(120) NOT NULL,
  UNIQUE KEY uk_permission_code (code)
) COMMENT='permission';

CREATE TABLE cms_admin_user_role (
  user_id BIGINT NOT NULL,
  role_id BIGINT NOT NULL,
  PRIMARY KEY (user_id, role_id)
) COMMENT='admin user role';

CREATE TABLE cms_role_permission (
  role_id BIGINT NOT NULL,
  permission_id BIGINT NOT NULL,
  PRIMARY KEY (role_id, permission_id)
) COMMENT='role permission';

CREATE TABLE cms_operation_log (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  user_id BIGINT NULL,
  action VARCHAR(120) NOT NULL,
  resource VARCHAR(160) NULL,
  ip VARCHAR(64) NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  KEY idx_operation_user_created (user_id, created_at)
) COMMENT='operation log';
