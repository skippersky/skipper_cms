<template>
  <main>
    <section class="section company-hero">
      <div class="container">
        <p class="eyebrow">ABOUT HENGZHAN</p>
        <h1>深圳市恒展五金科技有限公司</h1>
        <p class="lead">成立于<strong>2012年</strong>，深耕散热器行业<strong>20余年</strong>，是阿里巴巴诚信<strong>14年</strong>金牌商家。</p>
      </div>
    </section>
    <section class="section">
      <div class="container story">
        <p>恒展五金长期专注铝型材散热器、电子散热片及各类设备散热产品生产加工。对B端采购商、工程师和供应链负责人来说，散热件不是一次性买卖，而是需要稳定打样、稳定量产、稳定沟通的长期配套。</p>
        <p>公司凭借十余年生产加工经验，在来图加工、结构适配、批量交付与持续供货中积累了老客户口碑。我们不做空泛承诺，而是把客户关心的工厂真实性、交付稳定性和产品适配沟通放在合作前面。</p>
      </div>
    </section>
    <section class="section">
      <div class="container timeline">
        <article v-for="item in ['2012年 公司成立', '十余年 铝型材散热器生产加工经验', '14年 阿里巴巴诚信金牌商家', '老客户口碑 长期复购验证稳定性']" :key="item">
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

.lead,
.story {
  max-width: 860px;
  color: $color-text-muted;
  line-height: 1.8;
}

.lead strong {
  color: $color-text;
  font-family: $font-data;
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
