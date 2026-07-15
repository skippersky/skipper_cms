package com.skipper.cms.cms.admin.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.skipper.cms.cms.shared.entity.AdminUser;
import com.skipper.cms.cms.shared.mapper.AdminUserMapper;
import org.springframework.boot.CommandLineRunner;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

@Component
public class AdminUserBootstrap implements CommandLineRunner {
    private static final String DEFAULT_USERNAME = "hengzhanwujin";
    private static final String DEFAULT_PASSWORD = "skipper2026";

    private final AdminUserMapper adminUserMapper;
    private final PasswordEncoder passwordEncoder;
    private final JdbcTemplate jdbcTemplate;

    public AdminUserBootstrap(AdminUserMapper adminUserMapper, PasswordEncoder passwordEncoder, JdbcTemplate jdbcTemplate) {
        this.adminUserMapper = adminUserMapper;
        this.passwordEncoder = passwordEncoder;
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public void run(String... args) {
        ensureAdminUserTable();

        Long count = adminUserMapper.selectCount(new LambdaQueryWrapper<AdminUser>()
                .eq(AdminUser::getUsername, DEFAULT_USERNAME));
        if (count != null && count > 0) {
            return;
        }

        AdminUser user = new AdminUser();
        user.setUsername(DEFAULT_USERNAME);
        user.setPasswordHash(passwordEncoder.encode(DEFAULT_PASSWORD));
        user.setDisplayName("Hengzhan Admin");
        user.setEnabled(1);
        adminUserMapper.insert(user);
    }

    private void ensureAdminUserTable() {
        jdbcTemplate.execute("""
                CREATE TABLE IF NOT EXISTS cms_admin_user (
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
                ) COMMENT='admin user'
                """);
    }
}

