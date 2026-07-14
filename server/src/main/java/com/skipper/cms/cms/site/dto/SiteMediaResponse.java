package com.skipper.cms.cms.site.dto;

import com.skipper.cms.cms.shared.media.MediaVariantDto;

import java.util.Map;

public record SiteMediaResponse(Long id, String alt, String originalUrl, Map<String, MediaVariantDto> variants) {
}

