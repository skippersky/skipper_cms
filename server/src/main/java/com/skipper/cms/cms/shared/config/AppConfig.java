package com.skipper.cms.cms.shared.config;

import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Configuration
@EnableConfigurationProperties({
        CorsProperties.class,
        JwtProperties.class,
        UploadProperties.class,
        RateLimitProperties.class
})
public class AppConfig {
}

