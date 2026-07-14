package com.skipper.cms.cms.shared.cache;

import org.springframework.context.event.EventListener;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;
import com.skipper.cms.cms.shared.event.ContentChangedEvent;

import java.time.Duration;
import java.util.Set;

@Service
public class SiteCacheService {
    private static final String SITE_PAGE_PREFIX = "site:page:";
    private final StringRedisTemplate redisTemplate;

    public SiteCacheService(StringRedisTemplate redisTemplate) {
        this.redisTemplate = redisTemplate;
    }

    public String getPage(String path, String lang) {
        return redisTemplate.opsForValue().get(pageKey(path, lang));
    }

    public void putPage(String path, String lang, String payload) {
        redisTemplate.opsForValue().set(pageKey(path, lang), payload, Duration.ofHours(1));
    }

    @EventListener
    public void onContentChanged(ContentChangedEvent event) {
        // EXTENSION_POINT: 精准按内容类型失效关联页面缓存
        Set<String> keys = redisTemplate.keys(SITE_PAGE_PREFIX + "*");
        if (keys != null && !keys.isEmpty()) {
            redisTemplate.delete(keys);
        }
    }

    private String pageKey(String path, String lang) {
        return SITE_PAGE_PREFIX + path + ":" + lang;
    }
}

