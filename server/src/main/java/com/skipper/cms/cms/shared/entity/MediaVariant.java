package com.skipper.cms.cms.shared.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
@TableName("cms_media_variant")
public class MediaVariant {
    @TableId
    private Long id;
    private Long mediaId;
    private String variantType;
    private String format;
    private Integer width;
    private Integer height;
    private String url;
    private Long fileSize;
    private LocalDateTime createdAt;
}

