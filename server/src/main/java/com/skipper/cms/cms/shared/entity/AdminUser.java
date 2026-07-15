package com.skipper.cms.cms.shared.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@TableName("cms_admin_user")
public class AdminUser extends BaseEntity {
    private String username;
    private String passwordHash;
    private String displayName;
    private String email;
    private Integer enabled;
}

