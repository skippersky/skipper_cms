package com.skipper.cms.cms.site.controller;

import com.skipper.cms.cms.shared.response.ApiResponse;
import com.skipper.cms.cms.site.dto.SiteHomeResponse;
import com.skipper.cms.cms.site.renderer.HomePageRenderer;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/site")
public class SiteHomeController {
    private final HomePageRenderer homePageRenderer;

    public SiteHomeController(HomePageRenderer homePageRenderer) {
        this.homePageRenderer = homePageRenderer;
    }

    @GetMapping("/home")
    public ApiResponse<SiteHomeResponse> home(@RequestHeader(value = "Accept-Language", defaultValue = "zh-CN") String lang) {
        return ApiResponse.ok(homePageRenderer.render(lang));
    }
}

