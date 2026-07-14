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
        SiteMediaResponse media = demoMedia(1L, "深圳市恒展五金科技有限公司散热器生产加工现场");
        return new SiteHomeResponse(
                new SiteHomeResponse.Hero(
                        "20余年深耕散热器行业的源头工厂",
                        "深圳市恒展五金科技有限公司，2012年成立，专注铝型材散热器及各类电子散热产品生产加工，是阿里巴巴诚信14年金牌商家。",
                        List.of(media)
                ),
                List.of(
                        new SiteHomeResponse.Metric("行业深耕", "20余年"),
                        new SiteHomeResponse.Metric("成立时间", "2012年"),
                        new SiteHomeResponse.Metric("诚信通商家", "14年"),
                        new SiteHomeResponse.Metric("生产加工", "十余年")
                ),
                List.of(
                        new SiteProductCardResponse(1L, "工业设备散热", "industrial-cooling", "覆盖LED散热器、服务器散热器、液压一体散热器，面向连续运行设备的稳定散热需求。", "铝型材", "按图加工", media),
                        new SiteProductCardResponse(2L, "消费电子散热", "consumer-electronics-cooling", "覆盖电脑散热器、电子散热片、CPU风冷散热器、PC风扇，适配整机装配与批量采购。", "铝型材", "批量加工", media),
                        new SiteProductCardResponse(3L, "医疗美容设备散热", "medical-beauty-cooling", "覆盖美容仪散热产品、医疗设备散热产品，重视结构适配、外观一致性与长期供货稳定性。", "铝型材", "来图定制", media)
                ),
                List.of(
                        new SiteHomeResponse.News("2012年成立的散热器源头工厂", "about-hengzhan", "十余年生产加工经验沉淀在选材、加工、交付与复购口碑中。"),
                        new SiteHomeResponse.News("14年阿里诚信金牌商家", "alibaba-gold-supplier", "采购方可通过1688店铺在线核验工厂信息并快速沟通拿样。")
                ),
                List.of("铝型材散热器", "电脑散热器", "电子散热片", "CPU风冷散热器", "PC风扇", "LED散热器", "服务器散热器", "液压一体散热器", "美容仪散热产品", "医疗设备散热产品")
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
