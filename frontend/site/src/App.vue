<script setup lang="ts">
import { Menu, X } from 'lucide-vue-next'
import { onBeforeUnmount, ref, watch } from 'vue'
import { currentLocale, languages, setLocale, t, type Locale } from './i18n'

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
      <img class="brand-logo" src="/hengzhan-logo.svg" alt="恒展五金科技 Logo" />
      <span>{{ t.brand }}</span>
    </router-link>
    <button class="nav-toggle" type="button" aria-label="打开导航" @click="open = !open">
      <X v-if="open" :size="22" />
      <Menu v-else :size="22" />
    </button>
    <nav class="desktop-nav">
      <router-link to="/">{{ t.nav.home }}</router-link>
      <router-link to="/company">{{ t.nav.company }}</router-link>
      <router-link to="/products">{{ t.nav.products }}</router-link>
      <router-link to="/contact">{{ t.nav.contact }}</router-link>
    </nav>
    <div class="language-switcher">
      <button
        v-for="language in languages"
        :key="language.value"
        class="lang-button"
        :class="{ active: currentLocale === language.value }"
        type="button"
        @click="setLocale(language.value as Locale)"
      >
        {{ language.label }}
      </button>
    </div>
  </header>
  <Transition name="drawer">
    <nav v-if="open" class="mobile-nav" @click="open = false">
      <router-link to="/">{{ t.nav.home }}</router-link>
      <router-link to="/company">{{ t.nav.company }}</router-link>
      <router-link to="/products">{{ t.nav.products }}</router-link>
      <router-link to="/contact">{{ t.nav.contact }}</router-link>
      <div class="mobile-lang">
        <button
          v-for="language in languages"
          :key="language.value"
          class="lang-button"
          :class="{ active: currentLocale === language.value }"
          type="button"
          @click.stop="setLocale(language.value as Locale)"
        >
          {{ language.label }}
        </button>
      </div>
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

.brand-logo {
  width: 34px;
  height: 34px;
  object-fit: contain;
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

.language-switcher {
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

.mobile-lang {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
  padding-top: 16px;
}

.lang-button {
  min-width: 44px;
  min-height: 36px;
  border: 1px solid $color-line;
  border-radius: 999px;
  color: $color-text-muted;
  background: rgba(255, 255, 255, 0.78);
  font-weight: 800;
  transition: color $motion-mechanical-fast $motion-easing-linear,
    background $motion-mechanical-fast $motion-easing-linear,
    box-shadow $motion-mechanical-fast $motion-easing-linear,
    transform $motion-mechanical-fast $motion-easing-linear;
}

.lang-button:hover,
.lang-button:focus,
.lang-button.active {
  color: #0f2f28;
  background: linear-gradient(180deg, #8ee5bc, $color-accent);
  box-shadow: 0 8px 20px rgba(102, 207, 160, 0.2);
  transform: translateY(-1px);
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
    position: relative;
    display: flex;
    gap: 28px;
    font-weight: 800;
    color: $color-text-muted;
  }

  .desktop-nav a {
    position: relative;
    padding: 8px 0;
    transition: color $motion-mechanical-fast $motion-easing-linear,
      transform $motion-mechanical-fast $motion-easing-linear;
  }

  .desktop-nav a::after {
    position: absolute;
    right: 0;
    bottom: 0;
    left: 0;
    height: 3px;
    content: "";
    border-radius: 999px;
    background: linear-gradient(90deg, $color-accent-deep, $color-accent);
    transform: scaleX(0);
    transform-origin: left;
    transition: transform $motion-mechanical-normal $motion-easing-linear;
  }

  .desktop-nav a:hover,
  .desktop-nav a:focus,
  .desktop-nav a.router-link-active {
    color: $color-accent-deep;
    transform: translateY(-1px);
  }

  .desktop-nav a:hover::after,
  .desktop-nav a:focus::after,
  .desktop-nav a.router-link-active::after {
    transform: scaleX(1);
  }

  .language-switcher {
    display: flex;
    gap: 6px;
  }
}
</style>
