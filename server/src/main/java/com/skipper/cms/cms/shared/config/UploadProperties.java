package com.skipper.cms.cms.shared.config;

import org.springframework.boot.context.properties.ConfigurationProperties;

@ConfigurationProperties(prefix = "cms.upload")
public record UploadProperties(String rootPath, String publicPrefix) {
}

