package com.skipper.cms.cms.shared.config;

import org.springframework.boot.context.properties.ConfigurationProperties;

@ConfigurationProperties(prefix = "cms.jwt")
public record JwtProperties(String secret, long expirationMinutes) {
}

