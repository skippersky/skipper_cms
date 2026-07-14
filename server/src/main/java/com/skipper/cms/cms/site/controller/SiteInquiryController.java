package com.skipper.cms.cms.site.controller;

import com.skipper.cms.cms.shared.response.ApiResponse;
import com.skipper.cms.cms.site.dto.SiteInquiryRequest;
import com.skipper.cms.cms.site.service.SiteInquiryService;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/site/inquiries")
public class SiteInquiryController {
    private final SiteInquiryService inquiryService;

    public SiteInquiryController(SiteInquiryService inquiryService) {
        this.inquiryService = inquiryService;
    }

    @PostMapping
    public ApiResponse<Long> create(@RequestBody SiteInquiryRequest request) {
        return ApiResponse.ok(inquiryService.create(request));
    }
}

