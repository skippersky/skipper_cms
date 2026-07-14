package com.skipper.cms.cms.admin.controller;

import com.skipper.cms.cms.shared.entity.Inquiry;
import com.skipper.cms.cms.shared.mapper.InquiryMapper;
import com.skipper.cms.cms.shared.response.ApiResponse;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/admin/inquiries")
public class AdminInquiryController {
    private final InquiryMapper inquiryMapper;

    public AdminInquiryController(InquiryMapper inquiryMapper) {
        this.inquiryMapper = inquiryMapper;
    }

    @GetMapping
    public ApiResponse<List<Inquiry>> list() {
        return ApiResponse.ok(inquiryMapper.selectList(null));
    }

    @PutMapping("/{id}/status")
    public ApiResponse<Void> updateStatus(@PathVariable Long id, @RequestParam String status) {
        Inquiry inquiry = new Inquiry();
        inquiry.setId(id);
        inquiry.setStatus(status);
        inquiryMapper.updateById(inquiry);
        return ApiResponse.ok();
    }
}

