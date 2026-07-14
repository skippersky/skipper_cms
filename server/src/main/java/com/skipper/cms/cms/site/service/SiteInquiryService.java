package com.skipper.cms.cms.site.service;

import com.skipper.cms.cms.shared.entity.Inquiry;
import com.skipper.cms.cms.shared.mapper.InquiryMapper;
import com.skipper.cms.cms.site.dto.SiteInquiryRequest;
import org.springframework.stereotype.Service;

@Service
public class SiteInquiryService {
    private final InquiryMapper inquiryMapper;

    public SiteInquiryService(InquiryMapper inquiryMapper) {
        this.inquiryMapper = inquiryMapper;
    }

    public Long create(SiteInquiryRequest request) {
        Inquiry inquiry = new Inquiry();
        inquiry.setCompanyName(request.companyName());
        inquiry.setContactName(request.contactName());
        inquiry.setPhone(request.phone());
        inquiry.setEmail(request.email());
        inquiry.setMessage(request.message());
        inquiry.setStatus("NEW");
        inquiryMapper.insert(inquiry);
        return inquiry.getId();
    }
}

