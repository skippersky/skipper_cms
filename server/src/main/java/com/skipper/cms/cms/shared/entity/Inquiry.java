package com.skipper.cms.cms.shared.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
@TableName("cms_inquiry")
public class Inquiry {
    @TableId
    private Long id;
    private String companyName;
    private String contactName;
    private String phone;
    private String email;
    private String status;
    private String message;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}

