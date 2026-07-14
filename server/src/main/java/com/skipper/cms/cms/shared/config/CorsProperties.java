package com.skipper.cms.cms.shared.config;

import org.springframework.boot.context.properties.ConfigurationProperties;

@ConfigurationProperties(prefix = "cms.cors")
public record CorsProperties(String allowedOrigins) {
}

