package com.skipper.cms.cms.admin.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.skipper.cms.cms.shared.entity.AdminUser;
import com.skipper.cms.cms.shared.mapper.AdminUserMapper;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

@Component
public class AdminUserBootstrap implements CommandLineRunner {
    private static final String DEFAULT_USERNAME = "hengzhanwujin";
    private static final String DEFAULT_PASSWORD = "skipper2026";

    private final AdminUserMapper adminUserMapper;
    private final PasswordEncoder passwordEncoder;

    public AdminUserBootstrap(AdminUserMapper adminUserMapper, PasswordEncoder passwordEncoder) {
        this.adminUserMapper = adminUserMapper;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    public void run(String... args) {
        Long count = adminUserMapper.selectCount(new LambdaQueryWrapper<AdminUser>()
                .eq(AdminUser::getUsername, DEFAULT_USERNAME));
        if (count != null && count > 0) {
            return;
        }

        AdminUser user = new AdminUser();
        user.setUsername(DEFAULT_USERNAME);
        user.setPasswordHash(passwordEncoder.encode(DEFAULT_PASSWORD));
        user.setDisplayName("恒展五金管理员");
        user.setEnabled(1);
        adminUserMapper.insert(user);
    }
}

