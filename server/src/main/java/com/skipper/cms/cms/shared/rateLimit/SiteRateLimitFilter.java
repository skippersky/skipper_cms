package com.skipper.cms.cms.shared.rateLimit;

import com.skipper.cms.cms.shared.config.RateLimitProperties;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.time.Instant;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Component
public class SiteRateLimitFilter extends OncePerRequestFilter {
    private final RateLimitProperties properties;
    private final Map<String, Bucket> buckets = new ConcurrentHashMap<>();

    public SiteRateLimitFilter(RateLimitProperties properties) {
        this.properties = properties;
    }

    @Override
    protected boolean shouldNotFilter(HttpServletRequest request) {
        return !request.getRequestURI().startsWith("/api/site/");
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException {
        String ip = request.getRemoteAddr();
        Bucket bucket = buckets.computeIfAbsent(ip, ignored -> new Bucket(properties.siteCapacity()));
        if (!bucket.tryConsume(properties.siteCapacity(), properties.siteRefillPerSecond())) {
            response.setStatus(429);
            response.setContentType("application/json;charset=UTF-8");
            response.getWriter().write("{\"code\":429,\"message\":\"请求过于频繁\",\"data\":null}");
            return;
        }
        filterChain.doFilter(request, response);
    }

    private static final class Bucket {
        private int tokens;
        private long lastRefillEpochSecond;

        private Bucket(int tokens) {
            this.tokens = tokens;
            this.lastRefillEpochSecond = Instant.now().getEpochSecond();
        }

        private synchronized boolean tryConsume(int capacity, int refillPerSecond) {
            long now = Instant.now().getEpochSecond();
            long delta = Math.max(0, now - lastRefillEpochSecond);
            if (delta > 0) {
                tokens = Math.min(capacity, tokens + (int) delta * refillPerSecond);
                lastRefillEpochSecond = now;
            }
            if (tokens <= 0) {
                return false;
            }
            tokens--;
            return true;
        }
    }
}

