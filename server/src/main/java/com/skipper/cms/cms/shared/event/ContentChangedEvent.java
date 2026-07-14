package com.skipper.cms.cms.shared.event;

public record ContentChangedEvent(String resourceType, Long resourceId) {
}

