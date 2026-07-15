<script setup lang="ts">
import { Menu, X } from 'lucide-vue-next'
import { onBeforeUnmount, ref, watch } from 'vue'

const open = ref(false)

watch(open, (value) => {
  document.body.classList.toggle('nav-locked', value)
})

onBeforeUnmount(() => {
  document.body.classList.remove('nav-locked')
})
</script>

<template>
  <header class="site-header">
    <router-link class="brand tap-target" to="/" @click="open = false">
      <span class="brand-mark"></span>
      <span>恒展五金科技</span>
    </router-link>
    <button class="nav-toggle" type="button" aria-label="打开导航" @click="open = !open">
      <X v-if="open" :size="22" />
      <Menu v-else :size="22" />
    </button>
    <nav class="desktop-nav">
      <router-link to="/">首页</router-link>
      <router-link to="/company">关于我们</router-link>
      <router-link to="/products">产品中心</router-link>
      <router-link to="/contact">联系我们</router-link>
    </nav>
  </header>
  <Transition name="drawer">
    <nav v-if="open" class="mobile-nav" @click="open = false">
      <router-link to="/">首页</router-link>
      <router-link to="/company">关于我们</router-link>
      <router-link to="/products">产品中心</router-link>
      <router-link to="/contact">联系我们</router-link>
    </nav>
  </Transition>
  <router-view />
</template>

<style scoped lang="scss">
@use "./styles/tokens" as *;

/* MOBILE-FIRST */
.site-header {
  position: sticky;
  top: 0;
  z-index: 20;
  display: flex;
  align-items: center;
  justify-content: space-between;
  min-height: 64px;
  padding: 0 16px;
  border-bottom: 1px solid $color-line;
  background: rgba(255, 255, 255, 0.92);
  backdrop-filter: blur(14px);
  box-shadow: 0 10px 28px rgba(47, 91, 109, 0.08);
}

.brand {
  display: inline-flex;
  align-items: center;
  gap: 10px;
  color: $color-text;
  font-family: $font-title;
  font-weight: 900;
}

.brand-mark {
  width: 30px;
  height: 30px;
  border: 1px solid rgba(47, 155, 179, 0.34);
  background:
    repeating-linear-gradient(90deg, #d7e7eb 0 3px, #ffffff 3px 6px),
    linear-gradient(135deg, $color-accent-deep, $color-accent);
  box-shadow: inset 0 0 0 4px rgba(102, 207, 160, 0.18);
}

.nav-toggle {
  display: inline-grid;
  place-items: center;
  border: 1px solid $color-line;
  color: $color-text;
  background: #ffffff;
}

.desktop-nav {
  display: none;
}

.mobile-nav {
  position: fixed;
  inset: 64px 0 0;
  z-index: 19;
  display: grid;
  align-content: start;
  gap: 6px;
  padding: 24px 16px;
  background: rgba(246, 252, 252, 0.98);
}

.mobile-nav a {
  min-height: $touch-target-min;
  display: flex;
  align-items: center;
  border-bottom: 1px solid $color-line;
  color: $color-text;
  font-size: 20px;
  font-weight: 800;
}

.drawer-enter-active,
.drawer-leave-active {
  transition: transform $motion-mechanical-normal $motion-easing-linear;
}

.drawer-enter-from,
.drawer-leave-to {
  transform: translateX(100%);
}

@media (min-width: $breakpoint-lg) {
  .site-header {
    min-height: 76px;
    padding: 0 48px;
  }

  .nav-toggle {
    display: none;
  }

  .desktop-nav {
    display: flex;
    gap: 28px;
    font-weight: 800;
    color: $color-text-muted;
  }

  .desktop-nav a:hover,
  .desktop-nav a:focus,
  .desktop-nav a.router-link-active {
    color: $color-accent-deep;
  }
}
</style>
