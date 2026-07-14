package com.skipper.cms.cms.admin.controller;

import com.skipper.cms.cms.shared.entity.Product;
import com.skipper.cms.cms.shared.mapper.ProductMapper;
import com.skipper.cms.cms.shared.response.ApiResponse;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.web.bind.annotation.*;
import com.skipper.cms.cms.shared.event.ContentChangedEvent;

import java.util.List;

@RestController
@RequestMapping("/api/admin/products")
public class AdminProductController {
    private final ProductMapper productMapper;
    private final ApplicationEventPublisher eventPublisher;

    public AdminProductController(ProductMapper productMapper, ApplicationEventPublisher eventPublisher) {
        this.productMapper = productMapper;
        this.eventPublisher = eventPublisher;
    }

    @GetMapping
    public ApiResponse<List<Product>> list() {
        return ApiResponse.ok(productMapper.selectList(null));
    }

    @PostMapping
    public ApiResponse<Long> create(@RequestBody Product product) {
        productMapper.insert(product);
        eventPublisher.publishEvent(new ContentChangedEvent("product", product.getId()));
        return ApiResponse.ok(product.getId());
    }

    @PutMapping("/{id}")
    public ApiResponse<Void> update(@PathVariable Long id, @RequestBody Product product) {
        product.setId(id);
        productMapper.updateById(product);
        eventPublisher.publishEvent(new ContentChangedEvent("product", id));
        return ApiResponse.ok();
    }
}

