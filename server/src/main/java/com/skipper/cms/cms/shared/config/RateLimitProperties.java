package com.skipper.cms.cms.shared.config;

import org.springframework.boot.context.properties.ConfigurationProperties;

@ConfigurationProperties(prefix = "cms.rate-limit")
public record RateLimitProperties(int siteCapacity, int siteRefillPerSecond) {
}

