package com.skipper.cms.cms.shared.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@TableName("cms_product_category")
public class ProductCategory extends BaseEntity {
    private Long parentId;
    private String name;
    private String slug;
    private Integer sortOrder;
    private Integer published;
}

