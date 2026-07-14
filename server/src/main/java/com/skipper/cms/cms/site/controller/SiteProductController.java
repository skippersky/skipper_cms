package com.skipper.cms.cms.site.controller;

import com.skipper.cms.cms.shared.response.ApiResponse;
import com.skipper.cms.cms.site.dto.SiteHomeResponse;
import com.skipper.cms.cms.site.dto.SiteProductCardResponse;
import com.skipper.cms.cms.site.renderer.HomePageRenderer;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/site/products")
public class SiteProductController {
    private final HomePageRenderer renderer;

    public SiteProductController(HomePageRenderer renderer) {
        this.renderer = renderer;
    }

    @GetMapping
    public ApiResponse<List<SiteProductCardResponse>> list() {
        return ApiResponse.ok(renderer.render("zh-CN").products());
    }

    @GetMapping("/{slug}")
    public ApiResponse<SiteProductCardResponse> detail(@PathVariable String slug) {
        SiteHomeResponse home = renderer.render("zh-CN");
        return ApiResponse.ok(home.products().stream()
                .filter(product -> product.slug().equals(slug))
                .findFirst()
                .orElse(home.products().get(0)));
    }
}

