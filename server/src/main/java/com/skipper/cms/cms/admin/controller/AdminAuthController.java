package com.skipper.cms.cms.admin.controller;

import com.skipper.cms.cms.admin.dto.LoginRequest;
import com.skipper.cms.cms.admin.dto.LoginResponse;
import com.skipper.cms.cms.admin.security.JwtService;
import com.skipper.cms.cms.admin.service.AdminAuthService;
import com.skipper.cms.cms.shared.response.ApiResponse;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/admin/auth")
public class AdminAuthController {
    private final JwtService jwtService;
    private final AdminAuthService adminAuthService;

    public AdminAuthController(JwtService jwtService, AdminAuthService adminAuthService) {
        this.jwtService = jwtService;
        this.adminAuthService = adminAuthService;
    }

    @PostMapping("/login")
    public ApiResponse<LoginResponse> login(@RequestBody LoginRequest request) {
        return ApiResponse.ok(adminAuthService.login(request));
    }

    @GetMapping("/profile")
    public ApiResponse<LoginResponse> profile(@RequestHeader("Authorization") String authorization) {
        return ApiResponse.ok(new LoginResponse(authorization.replace("Bearer ", ""), "admin", List.of("cms:all")));
    }
}
