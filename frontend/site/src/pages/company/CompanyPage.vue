<script setup lang="ts">
import { t } from '../../i18n'
</script>

<template>
  <main>
    <section class="section company-hero">
      <div class="container">
        <p class="eyebrow">ABOUT HENGZHAN</p>
        <h1>{{ t.company.title }}</h1>
        <p class="lead">{{ t.company.lead }}</p>
      </div>
    </section>
    <section class="section">
      <div class="container story">
        <p>{{ t.company.story1 }}</p>
        <p>{{ t.company.story2 }}</p>
      </div>
    </section>
    <section class="section">
      <div class="container timeline">
        <article v-for="item in t.company.timeline" :key="item">
          {{ item }}
        </article>
      </div>
    </section>
  </main>
</template>

<style scoped lang="scss">
@use "../../styles/tokens" as *;

/* MOBILE-FIRST */
.company-hero {
  border-bottom: 1px solid $color-line;
  background: linear-gradient(135deg, #f7fcff, #f2fff8);
}

.eyebrow {
  color: $color-accent-deep;
  font-family: $font-data;
  font-weight: 800;
}

h1 {
  max-width: 760px;
  margin: 0;
  font-size: clamp(34px, 10vw, 56px);
  line-height: 1.08;
  letter-spacing: 0;
}

.lead,
.story {
  max-width: 860px;
  color: $color-text-muted;
  line-height: 1.8;
}

.lead strong {
  color: $color-accent-deep;
  font-family: $font-data;
}

.story {
  padding: 22px;
  border: 1px solid $color-line;
  background: rgba(255, 255, 255, 0.88);
  box-shadow: 0 16px 40px rgba(47, 91, 109, 0.08);
  border-radius: 18px;
}

.timeline {
  display: grid;
  gap: 14px;
}

.timeline article {
  min-height: 96px;
  padding: 20px;
  border-left: 4px solid $color-accent;
  border-top: 1px solid $color-line;
  background: #ffffff;
  box-shadow: 0 14px 34px rgba(47, 91, 109, 0.08);
  border-radius: 18px;
}

@media (min-width: $breakpoint-lg) {
  .timeline {
    grid-template-columns: repeat(4, 1fr);
  }

  .timeline article {
    border-left: 0;
    border-top: 4px solid $color-accent;
  }
}
</style>
