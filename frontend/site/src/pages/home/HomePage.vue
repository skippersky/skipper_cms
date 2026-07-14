<script setup lang="ts">
import { onMounted, ref } from 'vue'
import ResponsiveImage from '../../components/ResponsiveImage.vue'
import { getHomePage, type HomePage } from '../../services/site-api'

const page = ref<HomePage | null>(null)

onMounted(async () => {
  try {
    page.value = await getHomePage()
  } catch {
    page.value = {
      hero: { title: '精密五金制造', subtitle: '可靠、稳定、可追溯的工业五金供应链', banners: [] },
      metrics: [
        { label: '加工精度', value: '±0.01mm' },
        { label: '交付准时率', value: '98.6%' },
        { label: '合作客户', value: '320+' },
      ],
      products: [],
      news: [],
      partners: ['ABB', 'Bosch', 'Siemens', 'Midea'],
    }
  }
})
</script>

<template>
  <main v-if="page">
    <section class="hero">
      <div class="container hero-grid">
        <div class="hero-copy">
          <p class="eyebrow">INDUSTRIAL HARDWARE</p>
          <h1>{{ page.hero.title }}</h1>
          <p class="lead">{{ page.hero.subtitle }}</p>
          <router-link class="primary-action tap-target" to="/products">查看产品</router-link>
        </div>
        <div class="hero-media">
          <ResponsiveImage :media="page.hero.banners[0]" fallback="/factory-placeholder.webp" alt="五金工厂车间" />
        </div>
      </div>
    </section>

    <section class="section metrics">
      <div class="container metric-grid">
        <div v-for="item in page.metrics" :key="item.label" class="metric-card">
          <strong>{{ item.value }}</strong>
          <span>{{ item.label }}</span>
        </div>
      </div>
    </section>

    <section class="section products">
      <div class="container">
        <div class="section-head">
          <h2>核心产品</h2>
          <router-link class="text-link tap-target" to="/products">全部产品</router-link>
        </div>
        <div class="product-grid">
          <article v-for="product in page.products" :key="product.id" class="product-card">
            <ResponsiveImage :media="product.cover" fallback="/product-placeholder.webp" :alt="product.name" />
            <div>
              <h3>{{ product.name }}</h3>
              <p>{{ product.summary }}</p>
              <dl>
                <div><dt>材质</dt><dd>{{ product.material }}</dd></div>
                <div><dt>公差</dt><dd>{{ product.tolerance }}</dd></div>
              </dl>
            </div>
          </article>
        </div>
      </div>
    </section>

    <section class="section partners">
      <div class="container partner-grid">
        <span v-for="partner in page.partners" :key="partner">{{ partner }}</span>
      </div>
    </section>
  </main>
</template>

<style scoped lang="scss">
@use "../../styles/tokens" as *;

/* MOBILE-FIRST */
.hero {
  min-height: 50vh;
  padding: 48px 0 32px;
  background: linear-gradient(180deg, $mobile-panel, $mobile-bg);
}

.hero-grid {
  display: grid;
  gap: 28px;
}

.eyebrow {
  color: $color-accent;
  font-family: $font-data;
  font-size: 14px;
}

h1 {
  margin: 0;
  font-family: $font-title;
  font-size: clamp(38px, 14vw, 62px);
  line-height: 1;
  letter-spacing: 0;
}

.lead {
  color: $color-text-muted;
  line-height: 1.7;
}

.primary-action,
.text-link {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  padding: 0 18px;
  border: 1px solid $color-accent;
  color: $color-text;
  background: $color-accent;
  font-weight: 800;
}

.hero-media {
  overflow: hidden;
  border: 1px solid rgba(255, 255, 255, 0.1);
  background: $mobile-panel;
}

.hero-media img {
  width: 100%;
  aspect-ratio: 4 / 3;
  object-fit: cover;
}

.metric-grid,
.product-grid,
.partner-grid {
  display: grid;
  gap: 14px;
}

.metric-card,
.product-card,
.partner-grid span {
  border: 1px solid rgba(255, 255, 255, 0.1);
  background: $mobile-panel;
}

.metric-card {
  padding: 18px;
}

.metric-card strong {
  display: block;
  font-family: $font-data;
  font-size: 28px;
  color: $color-accent;
}

.metric-card span {
  color: $color-text-muted;
}

.section-head {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 16px;
}

.product-card {
  overflow: hidden;
}

.product-card > div {
  padding: 16px;
}

.product-card h3 {
  margin: 0 0 8px;
}

.product-card p {
  color: $color-text-muted;
  line-height: 1.6;
}

dl {
  display: grid;
  gap: 8px;
  margin: 0;
}

dl div {
  display: flex;
  justify-content: space-between;
  gap: 16px;
  font-family: $font-data;
}

dt {
  color: $color-text-muted;
}

dd {
  margin: 0;
}

.partner-grid {
  grid-template-columns: repeat(2, 1fr);
}

.partner-grid span {
  min-height: 64px;
  display: grid;
  place-items: center;
  color: $color-text-muted;
  font-family: $font-data;
}

@media (min-width: $breakpoint-md) {
  .metric-grid,
  .product-grid {
    grid-template-columns: repeat(2, 1fr);
  }

  .partner-grid {
    grid-template-columns: repeat(4, 1fr);
  }
}

@media (min-width: $breakpoint-lg) {
  .hero {
    min-height: calc(100vh - 76px);
    padding: 96px 0 72px;
    background: linear-gradient(110deg, $color-bg 0%, $color-panel 68%, $color-accent-deep 100%);
  }

  .hero-grid {
    grid-template-columns: 0.9fr 1.1fr;
    align-items: center;
  }

  .product-grid {
    grid-template-columns: repeat(3, 1fr);
  }
}
</style>

