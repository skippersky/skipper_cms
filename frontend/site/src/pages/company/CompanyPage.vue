<template>
  <main>
    <section class="section company-hero">
      <div class="container">
        <p class="eyebrow">ABOUT SKIPPER</p>
        <h1>从工艺稳定性到批量交付能力</h1>
      </div>
    </section>
    <section class="section">
      <div class="container timeline">
        <article v-for="item in ['2008 创立精密加工车间', '2015 引入自动化检测', '2021 建成多工艺产线', '2026 数字化质量追溯']" :key="item">
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
  background: $mobile-panel;
}

.eyebrow {
  color: $color-accent;
  font-family: $font-data;
}

h1 {
  max-width: 760px;
  margin: 0;
  font-size: clamp(34px, 10vw, 56px);
  line-height: 1.08;
  letter-spacing: 0;
}

.timeline {
  display: grid;
  gap: 14px;
}

.timeline article {
  min-height: 88px;
  padding: 20px;
  border-left: 3px solid $color-accent;
  background: $mobile-panel;
}

@media (min-width: $breakpoint-lg) {
  .timeline {
    grid-template-columns: repeat(4, 1fr);
  }

  .timeline article {
    border-left: 0;
    border-top: 3px solid $color-accent;
  }
}
</style>

