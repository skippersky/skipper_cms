package com.skipper.cms.cms.shared.service;

import com.skipper.cms.cms.shared.config.UploadProperties;
import com.skipper.cms.cms.shared.media.MediaVariantDto;
import com.skipper.cms.cms.shared.media.ResponsiveMediaDto;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.Map;
import java.util.concurrent.atomic.AtomicLong;

@Service
public class MediaService {
    private final UploadProperties uploadProperties;
    private final AtomicLong demoIds = new AtomicLong(1000);

    public MediaService(UploadProperties uploadProperties) {
        this.uploadProperties = uploadProperties;
    }

    public ResponsiveMediaDto upload(MultipartFile file, String group) {
        // EXTENSION_POINT: 接入 Thumbnailator 生成 desktop/tablet/mobile/thumb WebP 文件并写入媒体库
        String safeName = file.getOriginalFilename() == null ? "upload" : file.getOriginalFilename();
        String baseUrl = uploadProperties.publicPrefix() + "/" + safeName;
        return new ResponsiveMediaDto(
                demoIds.incrementAndGet(),
                safeName,
                baseUrl,
                Map.of(
                        "mobile", new MediaVariantDto(baseUrl, 750, 520, "webp"),
                        "tablet", new MediaVariantDto(baseUrl, 1024, 720, "webp"),
                        "desktop", new MediaVariantDto(baseUrl, 1600, 900, "webp"),
                        "thumb", new MediaVariantDto(baseUrl, 320, 220, "webp")
                )
        );
    }
}

