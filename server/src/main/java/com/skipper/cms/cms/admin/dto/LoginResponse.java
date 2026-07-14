package com.skipper.cms.cms.admin.dto;

import java.util.List;

public record LoginResponse(String token, String username, List<String> permissions) {
}

