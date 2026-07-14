package com.skipper.cms.cms.shared.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@TableName("cms_product_custom_param")
public class ProductCustomParam {
    @TableId
    private Long id;
    private Long productId;
    private String paramKey;
    private String paramLabel;
    private String paramValue;
    private String unit;
    private Integer sortOrder;
}

