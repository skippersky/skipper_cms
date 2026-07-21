<script setup lang="ts">
import { Phone } from 'lucide-vue-next'
import { ref } from 'vue'

const activePanel = ref<'phone' | 'wechat' | null>(null)
const copied = ref(false)
let copyTimer: number | undefined
const phoneLabel = '\u8054\u7cfb\u7535\u8bdd'
const wechatLabel = '\u4f01\u4e1a\u5ba2\u670d'
const quickContactLabel = '\u5feb\u901f\u8054\u7cfb'
const qrLabel = '\u4f01\u4e1a\u5ba2\u670d\u4e8c\u7ef4\u7801'
const phoneNumber = '13652397982'
const formattedPhone = '136 5239 7982'

function togglePanel(panel: 'phone' | 'wechat') {
  activePanel.value = activePanel.value === panel ? null : panel
}

async function copyPhone() {
  try {
    await navigator.clipboard.writeText(phoneNumber)
    copied.value = true
    window.clearTimeout(copyTimer)
    copyTimer = window.setTimeout(() => {
      copied.value = false
    }, 1500)
  } catch {
    window.location.href = `tel:${phoneNumber}`
  }
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
        class="float-button phone-button tap-target"
        :href="`tel:${phoneNumber}`"
        role="button"
        :aria-label="`${phoneLabel} ${formattedPhone}`"
        @click="togglePanel('phone')"
        @focus="activePanel = 'phone'"
        @blur="activePanel = null"
      >
        <span class="phone-icon">
          <Phone :size="34" stroke-width="2.4" />
        </span>
      </a>
      <div class="float-panel phone-panel" role="status" :aria-label="`${phoneLabel} ${formattedPhone}`">
        <span class="panel-icon">
          <Phone :size="22" stroke-width="2.3" />
        </span>
        <span class="phone-meta">
          <span class="phone-title">{{ phoneLabel }}</span>
          <button class="phone-number" type="button" :aria-label="`${phoneLabel} ${formattedPhone}`" @click="copyPhone">
            <span>{{ formattedPhone }}</span>
            <span class="copy-mark" :class="{ show: copied }">✓</span>
          </button>
        </span>
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
        role="button"
        :aria-label="qrLabel"
        @click="togglePanel('wechat')"
        @focus="activePanel = 'wechat'"
        @blur="activePanel = null"
      >
        <img src="/wechat-service-icon.png" alt="" aria-hidden="true" />
        <span class="float-label">{{ wechatLabel }}</span>
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
  top: 50%;
  z-index: 18;
  display: grid;
  gap: 14px;
  pointer-events: none;
  transform: translateY(-50%);
}

.float-item {
  position: relative;
  pointer-events: auto;
}

.float-button {
  display: grid;
  place-items: center;
  gap: 8px;
  width: 112px;
  min-height: 112px;
  padding: 12px 10px;
  border: 1px solid rgba(47, 155, 179, 0.22);
  border-radius: 28px;
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

.phone-button {
  border-radius: 999px;
}

.phone-icon {
  display: grid;
  place-items: center;
  width: 72px;
  height: 72px;
  border-radius: 999px;
  color: #ffffff;
  background: linear-gradient(180deg, #66cfa0, #2f9bb3);
  box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.38), 0 10px 24px rgba(47, 155, 179, 0.22);
}

.float-button img {
  width: 56px;
  height: 56px;
  object-fit: contain;
}

.float-label {
  color: #183d48;
  font-size: 15px;
  font-weight: 800;
  line-height: 1.2;
}

.float-panel {
  position: absolute;
  right: calc(100% + 10px);
  bottom: 50%;
  visibility: hidden;
  opacity: 0;
  transform: translate(18px, 50%);
  transition: opacity 250ms cubic-bezier(0.4, 0, 0.2, 1),
    transform 250ms cubic-bezier(0.4, 0, 0.2, 1),
    visibility 250ms cubic-bezier(0.4, 0, 0.2, 1);
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
  border-radius: 8px;
  background: #ffffff;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
  backdrop-filter: blur(16px);
}

.phone-panel {
  display: grid;
  grid-template-columns: 42px 1fr;
  align-items: center;
  gap: 12px;
  min-width: 210px;
  padding: 12px 14px;
  white-space: nowrap;
}

.panel-icon {
  display: grid;
  place-items: center;
  width: 42px;
  height: 42px;
  border-radius: 999px;
  color: #ffffff;
  background: linear-gradient(180deg, #66cfa0, #2f9bb3);
}

.phone-meta {
  display: grid;
  gap: 4px;
}

.phone-title {
  color: #666666;
  font-size: 12px;
  font-weight: 700;
  line-height: 1;
}

.phone-number {
  position: relative;
  display: inline-flex;
  align-items: center;
  gap: 8px;
  min-height: 28px;
  padding: 0;
  border: 0;
  color: #333333;
  background: transparent;
  font-family: "DIN", "Roboto Mono", monospace;
  font-size: 16px;
  font-weight: 500;
  cursor: pointer;
}

.copy-mark {
  display: inline-grid;
  place-items: center;
  width: 20px;
  height: 20px;
  border-radius: 999px;
  color: #ffffff;
  background: #66cfa0;
  opacity: 0;
  transform: scale(0.72);
  transition: opacity 160ms cubic-bezier(0.4, 0, 0.2, 1),
    transform 160ms cubic-bezier(0.4, 0, 0.2, 1);
}

.copy-mark.show {
  opacity: 1;
  transform: scale(1);
}

.qr-panel {
  width: min(228px, calc(100vw - 152px));
  padding: 12px;
}

.qr-panel img {
  width: 100%;
  aspect-ratio: 1;
  object-fit: contain;
  border-radius: 10px;
}

@media (min-width: $breakpoint-md) {
  .floating-contact {
    right: 28px;
  }

  .float-button {
    width: 128px;
    min-height: 128px;
  }

  .phone-icon {
    width: 82px;
    height: 82px;
  }

  .qr-panel {
    width: 260px;
  }
}
</style>
