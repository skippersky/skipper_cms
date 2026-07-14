package com.skipper.cms.cms.site.renderer;

import com.skipper.cms.cms.shared.media.MediaVariantDto;
import com.skipper.cms.cms.site.dto.SiteHomeResponse;
import com.skipper.cms.cms.site.dto.SiteMediaResponse;
import com.skipper.cms.cms.site.dto.SiteProductCardResponse;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;

@Component
public class HomePageRenderer implements SitePageRenderer<SiteHomeResponse> {
    @Override
    public String pagePath() {
        return "home";
    }

    @Override
    public SiteHomeResponse render(String lang) {
        SiteMediaResponse media = demoMedia(1L, "精密五金加工车间");
        return new SiteHomeResponse(
                new SiteHomeResponse.Hero(
                        "精密五金制造",
                        "面向工业设备、汽车零部件与高端定制件的可靠供应链伙伴",
                        List.of(media)
                ),
                List.of(
                        new SiteHomeResponse.Metric("加工精度", "±0.01mm"),
                        new SiteHomeResponse.Metric("交付准时率", "98.6%"),
                        new SiteHomeResponse.Metric("合作客户", "320+"),
                        new SiteHomeResponse.Metric("质量体系", "ISO 9001")
                ),
                List.of(
                        new SiteProductCardResponse(1L, "CNC 精密连接件", "cnc-connector", "适用于高强度装配场景", "SUS304", "±0.01mm", media),
                        new SiteProductCardResponse(2L, "冲压五金支架", "stamping-bracket", "批量稳定生产，支持定制表面处理", "SPCC", "±0.05mm", media),
                        new SiteProductCardResponse(3L, "铝合金散热结构件", "aluminum-heat-sink", "轻量化结构与导热性能兼顾", "6061-T6", "±0.02mm", media)
                ),
                List.of(
                        new SiteHomeResponse.News("新产线完成自动化升级", "auto-line-upgrade", "提升多品类五金件批量交付稳定性。"),
                        new SiteHomeResponse.News("表面处理能力扩展", "surface-treatment", "新增阳极氧化、电泳与喷砂工艺组合。")
                ),
                List.of("ABB", "Bosch", "Siemens", "Midea", "Haier")
        );
    }

    private SiteMediaResponse demoMedia(Long id, String alt) {
        return new SiteMediaResponse(
                id,
                alt,
                "/uploads/demo/factory-desktop.webp",
                Map.of(
                        "mobile", new MediaVariantDto("/uploads/demo/factory-mobile.webp", 750, 520, "webp"),
                        "tablet", new MediaVariantDto("/uploads/demo/factory-tablet.webp", 1024, 720, "webp"),
                        "desktop", new MediaVariantDto("/uploads/demo/factory-desktop.webp", 1600, 900, "webp"),
                        "thumb", new MediaVariantDto("/uploads/demo/factory-thumb.webp", 320, 220, "webp")
                )
        );
    }
}

