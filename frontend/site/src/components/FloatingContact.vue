<script setup lang="ts">
import { Phone } from 'lucide-vue-next'
import { ref } from 'vue'

const activePanel = ref<'phone' | 'wechat' | null>(null)
const phoneLabel = '\u8054\u7cfb\u7535\u8bdd'
const wechatLabel = '\u4f01\u4e1a\u5ba2\u670d'
const quickContactLabel = '\u5feb\u901f\u8054\u7cfb'
const qrLabel = '\u4f01\u4e1a\u5ba2\u670d\u4e8c\u7ef4\u7801'

function togglePanel(panel: 'phone' | 'wechat') {
  activePanel.value = activePanel.value === panel ? null : panel
}
</script>

<template>
  <aside class="floating-contact" :aria-label="quickContactLabel">
    <div
      class="float-item"
      :class="{ active: activePanel === 'phone' }"
      @mouseenter="activePanel = 'phone'"
      @mouseleave="activePanel = null"
    >
      <a
        class="float-button tap-target"
        href="tel:13652397982"
        :aria-label="`${phoneLabel} 13652397982`"
        @click="togglePanel('phone')"
        @focus="activePanel = 'phone'"
        @blur="activePanel = null"
      >
        <Phone :size="24" stroke-width="2.4" />
        <span>{{ phoneLabel }}</span>
      </a>
      <div class="float-panel phone-panel" role="status">
        <span>13652397982</span>
      </div>
    </div>

    <div
      class="float-item"
      :class="{ active: activePanel === 'wechat' }"
      @mouseenter="activePanel = 'wechat'"
      @mouseleave="activePanel = null"
    >
      <button
        class="float-button tap-target"
        type="button"
        :aria-label="qrLabel"
        @click="togglePanel('wechat')"
        @focus="activePanel = 'wechat'"
        @blur="activePanel = null"
      >
        <img src="/wechat-service-icon.png" alt="" aria-hidden="true" />
        <span>{{ wechatLabel }}</span>
      </button>
      <div class="float-panel qr-panel" role="status">
        <img src="/wechat-service-qr.png" :alt="qrLabel" />
      </div>
    </div>
  </aside>
</template>

<style scoped lang="scss">
@use "../styles/tokens" as *;

/* MOBILE-FIRST */
.floating-contact {
  position: fixed;
  right: 14px;
  bottom: 18px;
  z-index: 18;
  display: grid;
  gap: 10px;
  pointer-events: none;
}

.float-item {
  position: relative;
  pointer-events: auto;
}

.float-button {
  display: grid;
  place-items: center;
  gap: 4px;
  width: 64px;
  min-height: 64px;
  padding: 8px 6px;
  border: 1px solid rgba(47, 155, 179, 0.22);
  border-radius: 18px;
  color: #183d48;
  background: rgba(255, 255, 255, 0.92);
  box-shadow: 0 14px 36px rgba(47, 91, 109, 0.16), inset 0 1px 0 rgba(255, 255, 255, 0.78);
  backdrop-filter: blur(16px);
  cursor: pointer;
  transition: transform $motion-mechanical-normal $motion-easing-linear,
    box-shadow $motion-mechanical-normal $motion-easing-linear,
    border-color $motion-mechanical-normal $motion-easing-linear,
    background $motion-mechanical-normal $motion-easing-linear;
}

.float-button:hover,
.float-button:focus,
.float-item.active .float-button {
  border-color: rgba(102, 207, 160, 0.72);
  background: linear-gradient(180deg, rgba(255, 255, 255, 0.96), rgba(238, 255, 247, 0.94));
  box-shadow: 0 22px 54px rgba(47, 91, 109, 0.22), 0 8px 22px rgba(102, 207, 160, 0.16);
  transform: translateY(-2px);
}

.float-button:active {
  transform: translateY(0) scale(0.98);
}

.float-button img {
  width: 28px;
  height: 28px;
  object-fit: contain;
}

.float-button span {
  font-size: 12px;
  font-weight: 800;
  line-height: 1.2;
}

.float-panel {
  position: absolute;
  right: calc(100% + 10px);
  bottom: 50%;
  visibility: hidden;
  opacity: 0;
  transform: translate(8px, 50%);
  transition: opacity $motion-mechanical-fast $motion-easing-linear,
    transform $motion-mechanical-fast $motion-easing-linear,
    visibility $motion-mechanical-fast $motion-easing-linear;
}

.float-item:hover .float-panel,
.float-item:focus-within .float-panel,
.float-item.active .float-panel {
  visibility: visible;
  opacity: 1;
  transform: translate(0, 50%);
}

.phone-panel,
.qr-panel {
  border: 1px solid rgba(47, 155, 179, 0.18);
  border-radius: 18px;
  background: rgba(255, 255, 255, 0.96);
  box-shadow: 0 18px 46px rgba(47, 91, 109, 0.18);
  backdrop-filter: blur(16px);
}

.phone-panel {
  min-width: 148px;
  padding: 14px 16px;
  color: #183d48;
  font-family: $font-data;
  font-size: 16px;
  font-weight: 900;
  white-space: nowrap;
}

.qr-panel {
  width: 154px;
  padding: 10px;
}

.qr-panel img {
  width: 100%;
  aspect-ratio: 1;
  object-fit: contain;
  border-radius: 10px;
}

@media (min-width: $breakpoint-md) {
  .floating-contact {
    right: 22px;
    bottom: 96px;
  }

  .float-button {
    width: 72px;
    min-height: 72px;
  }
}
</style>
