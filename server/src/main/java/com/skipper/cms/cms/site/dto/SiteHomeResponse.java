package com.skipper.cms.cms.site.dto;

import java.util.List;

public record SiteHomeResponse(
        Hero hero,
        List<Metric> metrics,
        List<SiteProductCardResponse> products,
        List<News> news,
        List<String> partners
) {
    public record Hero(String title, String subtitle, List<SiteMediaResponse> banners) {
    }

    public record Metric(String label, String value) {
    }

    public record News(String title, String slug, String summary) {
    }
}

