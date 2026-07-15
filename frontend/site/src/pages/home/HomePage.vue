<script setup lang="ts">
import ResponsiveImage from '../../components/ResponsiveImage.vue'
import { t } from '../../i18n'
</script>

<template>
  <main>
    <section class="hero">
      <div class="container hero-grid">
        <div class="hero-copy">
          <p class="eyebrow">{{ t.hero.eyebrow }}</p>
          <h1>{{ t.hero.title }}</h1>
          <p class="lead">{{ t.hero.subtitle }}</p>
          <a class="primary-action tap-target" href="https://huenghang.1688.com/" target="_blank" rel="noopener">{{ t.cta1688 }}</a>
        </div>
        <div class="hero-media">
          <div class="heat-sink-visual" aria-hidden="true">
            <span v-for="index in 11" :key="index"></span>
          </div>
          <ResponsiveImage fallback="/factory-placeholder.webp" alt="HengZhan heat sink manufacturing" />
        </div>
      </div>
    </section>

    <section class="section metrics">
      <div class="container metric-grid">
        <div v-for="item in t.metrics" :key="item.label" class="metric-card">
          <strong>{{ item.value }}</strong>
          <span>{{ item.label }}</span>
        </div>
      </div>
    </section>

    <section class="section about">
      <div class="container about-grid">
        <div>
          <p class="eyebrow">{{ t.about.eyebrow }}</p>
          <h2>{{ t.about.title }}</h2>
        </div>
        <div class="about-copy">
          <p>{{ t.about.p1 }}</p>
          <p>{{ t.about.p2 }}</p>
          <p>{{ t.about.p3 }}</p>
          <a class="text-link tap-target" href="https://huenghang.1688.com/" target="_blank" rel="noopener">{{ t.viewFactory }}</a>
        </div>
      </div>
    </section>

    <section class="section products">
      <div class="container">
        <div class="section-head">
          <h2>{{ t.productTitle }}</h2>
          <router-link class="text-link tap-target" to="/products">{{ t.allProducts }}</router-link>
        </div>
        <div class="product-grid">
          <article v-for="product in t.products" :key="product.name" class="product-card">
            <ResponsiveImage fallback="/product-placeholder.webp" :alt="product.name" />
            <div>
              <h3>{{ product.name }}</h3>
              <p>{{ product.summary }}</p>
              <dl>
                <div><dt>{{ t.productLabels.material }}</dt><dd>{{ product.material }}</dd></div>
                <div><dt>{{ t.productLabels.method }}</dt><dd>{{ product.method }}</dd></div>
              </dl>
            </div>
          </article>
        </div>
      </div>
    </section>

    <section class="section why">
      <div class="container">
        <div class="section-head">
          <h2>{{ t.whyTitle }}</h2>
        </div>
        <div class="why-grid">
          <article v-for="item in t.why" :key="item.title">
            <strong>{{ item.title }}</strong>
            <p>{{ item.text }}</p>
          </article>
        </div>
      </div>
    </section>

    <section class="section partners">
      <div class="container partner-grid">
        <span v-for="partner in t.partners" :key="partner">{{ partner }}</span>
      </div>
    </section>
  </main>
</template>

<style scoped lang="scss">
@use "../../styles/tokens" as *;

/* MOBILE-FIRST */
.hero {
  min-height: 58vh;
  padding: 56px 0 40px;
  background:
    radial-gradient(circle at 80% 10%, rgba(102, 207, 160, 0.22), transparent 30%),
    linear-gradient(135deg, #f7fcff 0%, #edf8fb 52%, #f6fff7 100%);
  border-bottom: 1px solid $color-line;
}

.hero-grid,
.metric-grid,
.product-grid,
.partner-grid,
.about-grid,
.why-grid {
  display: grid;
  gap: 14px;
}

.hero-grid {
  gap: 30px;
}

.eyebrow {
  color: $color-accent-deep;
  font-family: $font-data;
  font-size: 14px;
  font-weight: 800;
}

h1 {
  margin: 0;
  max-width: 760px;
  font-family: $font-title;
  font-size: clamp(36px, 13vw, 62px);
  line-height: 1.02;
  letter-spacing: 0;
}

h2 {
  margin: 0;
  font-size: clamp(26px, 8vw, 42px);
  line-height: 1.16;
  letter-spacing: 0;
}

.lead,
.about-copy,
.product-card p,
.why-grid p {
  color: $color-text-muted;
  line-height: 1.75;
}

.primary-action,
.text-link {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: fit-content;
  padding: 0 20px;
  border: 1px solid #48b98b;
  color: #0f2f28;
  background: linear-gradient(180deg, #8ee5bc, $color-accent);
  box-shadow: 0 10px 24px rgba(102, 207, 160, 0.24);
  font-weight: 800;
}

.text-link {
  background: #ffffff;
  color: $color-accent-deep;
  border-color: $color-line;
  box-shadow: none;
}

.hero-media,
.metric-card,
.product-card,
.why-grid article,
.partner-grid span {
  border: 1px solid $color-line;
  background: rgba(255, 255, 255, 0.86);
  box-shadow: 0 16px 40px rgba(47, 91, 109, 0.08);
  backdrop-filter: blur(14px);
}

.hero-media {
  position: relative;
  overflow: hidden;
  min-height: 280px;
  border-radius: 24px;
  background:
    linear-gradient(145deg, rgba(255, 255, 255, 0.92), rgba(226, 242, 246, 0.9)),
    repeating-linear-gradient(90deg, rgba(47, 155, 179, 0.12) 0 1px, transparent 1px 20px);
}

.hero-media picture {
  display: none;
}

.heat-sink-visual {
  position: absolute;
  inset: 20px;
  display: flex;
  align-items: end;
  justify-content: center;
  gap: clamp(8px, 2vw, 18px);
  padding: 18px;
}

.heat-sink-visual::before {
  position: absolute;
  right: 10%;
  bottom: 10%;
  width: 42%;
  height: 16%;
  content: "";
  border: 1px solid rgba(47, 155, 179, 0.28);
  background: linear-gradient(180deg, #e7f3f6, #cddfe4);
  box-shadow: inset 0 1px 0 #fff;
}

.heat-sink-visual span {
  width: clamp(10px, 2vw, 22px);
  height: clamp(130px, 32vw, 230px);
  border: 1px solid rgba(47, 155, 179, 0.24);
  background: linear-gradient(90deg, #c9dde2, #ffffff 44%, #b8d4da);
  box-shadow: inset 1px 0 0 rgba(255, 255, 255, 0.86), 8px 18px 24px rgba(47, 91, 109, 0.08);
}

.metric-card,
.why-grid article {
  padding: 18px;
}

.metric-card {
  background:
    linear-gradient(145deg, rgba(255, 255, 255, 0.96), rgba(242, 255, 248, 0.86)),
    #ffffff;
}

.metric-card strong {
  display: block;
  font-family: $font-data;
  font-size: 28px;
  color: $color-accent-deep;
}

.metric-card span,
dt {
  color: $color-text-muted;
}

.about-copy strong,
.why-grid strong {
  color: $color-text;
}

.section-head {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 16px;
  margin-bottom: 18px;
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
  padding: 12px;
  color: $color-accent-deep;
  font-family: $font-data;
  text-align: center;
}

@media (min-width: $breakpoint-md) {
  .metric-grid,
  .product-grid,
  .why-grid {
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
  }

  .hero-grid {
    grid-template-columns: 0.9fr 1.1fr;
    align-items: center;
  }

  .about-grid {
    grid-template-columns: 0.85fr 1.15fr;
    gap: 42px;
  }

  .product-grid {
    grid-template-columns: repeat(3, 1fr);
  }
}
</style>
