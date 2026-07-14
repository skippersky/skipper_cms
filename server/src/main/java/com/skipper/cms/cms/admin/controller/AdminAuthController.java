package com.skipper.cms.cms.admin.controller;

import com.skipper.cms.cms.admin.dto.LoginRequest;
import com.skipper.cms.cms.admin.dto.LoginResponse;
import com.skipper.cms.cms.admin.security.JwtService;
import com.skipper.cms.cms.shared.response.ApiResponse;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/admin/auth")
public class AdminAuthController {
    private final JwtService jwtService;

    public AdminAuthController(JwtService jwtService) {
        this.jwtService = jwtService;
    }

    @PostMapping("/login")
    public ApiResponse<LoginResponse> login(@RequestBody LoginRequest request) {
        // EXTENSION_POINT: 替换为数据库用户校验与 BCrypt 密码验证
        String token = jwtService.createToken(request.username(), List.of("cms:all"));
        return ApiResponse.ok(new LoginResponse(token, request.username(), List.of("cms:all")));
    }

    @GetMapping("/profile")
    public ApiResponse<LoginResponse> profile(@RequestHeader("Authorization") String authorization) {
        return ApiResponse.ok(new LoginResponse(authorization.replace("Bearer ", ""), "admin", List.of("cms:all")));
    }
}

