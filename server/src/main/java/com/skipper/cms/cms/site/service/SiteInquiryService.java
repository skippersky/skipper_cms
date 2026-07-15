package com.skipper.cms.cms.site.service;

import com.skipper.cms.cms.shared.entity.Inquiry;
import com.skipper.cms.cms.shared.exception.BizException;
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
        if (request == null || isBlank(request.contactName())) {
            throw new BizException(400, "请填写联系人");
        }
        if (isBlank(request.phone()) && isBlank(request.email())) {
            throw new BizException(400, "请至少填写电话或邮箱");
        }
        Inquiry inquiry = new Inquiry();
        inquiry.setCompanyName(trimToNull(request.companyName()));
        inquiry.setContactName(request.contactName().trim());
        inquiry.setPhone(trimToNull(request.phone()));
        inquiry.setEmail(trimToNull(request.email()));
        inquiry.setMessage(trimToNull(request.message()));
        inquiry.setStatus("NEW");
        inquiryMapper.insert(inquiry);
        return inquiry.getId();
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }

    private String trimToNull(String value) {
        if (isBlank(value)) {
            return null;
        }
        return value.trim();
    }
}
