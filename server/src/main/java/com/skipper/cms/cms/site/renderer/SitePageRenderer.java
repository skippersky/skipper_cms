package com.skipper.cms.cms.site.renderer;

public interface SitePageRenderer<T> {
    String pagePath();

    T render(String lang);
}

