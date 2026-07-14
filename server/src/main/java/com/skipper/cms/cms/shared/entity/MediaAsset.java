package com.skipper.cms.cms.shared.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@TableName("cms_media_asset")
public class MediaAsset extends BaseEntity {
    private String fileName;
    private String originalName;
    private String mimeType;
    private String originalUrl;
    private Long fileSize;
    private String groupName;
    private String altText;
    private String sha256;
    private Integer referenceCount;
}

