package com.skipper.cms.cms.site.dto;

public record SiteProductCardResponse(
        Long id,
        String name,
        String slug,
        String summary,
        String material,
        String tolerance,
        SiteMediaResponse cover
) {
}

