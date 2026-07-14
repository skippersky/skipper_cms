package com.skipper.cms.cms.site.dto;

public record SiteInquiryRequest(
        String companyName,
        String contactName,
        String phone,
        String email,
        String message,
        Long productId,
        Integer quantity
) {
}

