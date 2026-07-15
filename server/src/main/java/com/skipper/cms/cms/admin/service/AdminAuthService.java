package com.skipper.cms.cms.admin.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.skipper.cms.cms.admin.dto.LoginRequest;
import com.skipper.cms.cms.admin.dto.LoginResponse;
import com.skipper.cms.cms.admin.security.JwtService;
import com.skipper.cms.cms.shared.entity.AdminUser;
import com.skipper.cms.cms.shared.exception.BizException;
import com.skipper.cms.cms.shared.mapper.AdminUserMapper;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AdminAuthService {
    private final AdminUserMapper adminUserMapper;
    private final PasswordEncoder passwordEncoder;
    private final JwtService jwtService;

    public AdminAuthService(AdminUserMapper adminUserMapper, PasswordEncoder passwordEncoder, JwtService jwtService) {
        this.adminUserMapper = adminUserMapper;
        this.passwordEncoder = passwordEncoder;
        this.jwtService = jwtService;
    }

    public LoginResponse login(LoginRequest request) {
        if (request.username() == null || request.username().isBlank()
                || request.password() == null || request.password().isBlank()) {
            throw new BizException(401, "Invalid username or password");
        }

        AdminUser user = adminUserMapper.selectOne(new LambdaQueryWrapper<AdminUser>()
                .eq(AdminUser::getUsername, request.username())
                .last("LIMIT 1"));
        if (user == null || user.getEnabled() == null || user.getEnabled() != 1) {
            throw new BizException(401, "Invalid username or password");
        }
        if (!passwordEncoder.matches(request.password(), user.getPasswordHash())) {
            throw new BizException(401, "Invalid username or password");
        }

        List<String> permissions = List.of("cms:all");
        String token = jwtService.createToken(user.getUsername(), permissions);
        return new LoginResponse(token, user.getUsername(), permissions);
    }
}

