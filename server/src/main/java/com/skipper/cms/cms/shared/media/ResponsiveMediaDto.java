package com.skipper.cms.cms.shared.media;

import java.util.Map;

public record ResponsiveMediaDto(
        Long id,
        String alt,
        String originalUrl,
        Map<String, MediaVariantDto> variants
) {
}

