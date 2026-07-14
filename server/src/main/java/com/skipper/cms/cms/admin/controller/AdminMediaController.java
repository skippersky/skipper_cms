package com.skipper.cms.cms.admin.controller;

import com.skipper.cms.cms.shared.media.ResponsiveMediaDto;
import com.skipper.cms.cms.shared.response.ApiResponse;
import com.skipper.cms.cms.shared.service.MediaService;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping("/api/admin/media")
public class AdminMediaController {
    private final MediaService mediaService;

    public AdminMediaController(MediaService mediaService) {
        this.mediaService = mediaService;
    }

    @PostMapping("/upload")
    public ApiResponse<ResponsiveMediaDto> upload(@RequestParam("file") MultipartFile file,
                                                  @RequestParam(value = "group", required = false) String group) {
        return ApiResponse.ok(mediaService.upload(file, group));
    }
}

