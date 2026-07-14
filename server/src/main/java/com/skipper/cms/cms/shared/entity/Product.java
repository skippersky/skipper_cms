package com.skipper.cms.cms.shared.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@TableName("cms_product")
public class Product extends BaseEntity {
    private Long categoryId;
    private Long paramTemplateId;
    private String name;
    private String slug;
    private String summary;
    private String material;
    private String tolerance;
    private String surfaceTreatment;
    private String drawingPdfUrl;
    private String drawingDwgUrl;
    private Integer published;
}

