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
      hero: {
        title: '20余年深耕散热器行业的源头工厂',
        subtitle: '深圳市恒展五金科技有限公司，2012年成立，专注铝型材散热器及各类电子散热产品生产加工，是阿里巴巴诚信14年金牌商家。',
        banners: [],
      },
      metrics: [
        { label: '行业深耕', value: '20余年' },
        { label: '成立时间', value: '2012年' },
        { label: '诚信通商家', value: '14年' },
        { label: '生产加工', value: '十余年' },
      ],
      products: [],
      news: [],
      partners: ['铝型材散热器', '电脑散热器', '电子散热片', 'CPU风冷散热器'],
    }
  }
})
</script>

<template>
  <main v-if="page">
    <section class="hero">
      <div class="container hero-grid">
        <div class="hero-copy">
          <p class="eyebrow">HENGZHAN HEATSINK FACTORY</p>
          <h1>{{ page.hero.title }}</h1>
          <p class="lead">{{ page.hero.subtitle }}</p>
          <a class="primary-action tap-target" href="https://huenghang.1688.com/" target="_blank" rel="noopener">1688在线验厂</a>
        </div>
        <div class="hero-media">
          <ResponsiveImage :media="page.hero.banners[0]" fallback="/factory-placeholder.webp" alt="恒展五金散热器生产加工现场" />
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

    <section class="section about">
      <div class="container about-grid">
        <div>
          <p class="eyebrow">ABOUT HENGZHAN</p>
          <h2>把老客户愿意复购的稳定性，做进每一批散热产品</h2>
        </div>
        <div class="about-copy">
          <p>深圳市恒展五金科技有限公司成立于<strong>2012年</strong>，长期专注铝型材散热器、电子散热片及各类设备散热产品的生产加工。公司深耕散热器行业<strong>20余年</strong>，以源头工厂身份服务B端采购、工程开发与供应链配套需求。</p>
          <p>对于采购商和工程师而言，散热产品不只看样品，更看批量交付时的尺寸一致性、加工稳定性与沟通效率。恒展五金依托<strong>十余年生产加工经验</strong>，围绕来图加工、结构适配、批量生产与持续供货积累了大量老客户口碑。</p>
          <p>同时，公司是阿里巴巴诚信<strong>14年</strong>金牌商家，采购方可通过1688店铺进一步核验工厂信息、沟通需求并快速拿样。</p>
          <a class="text-link tap-target" href="https://huenghang.1688.com/" target="_blank" rel="noopener">查看14年金牌工厂实拍</a>
        </div>
      </div>
    </section>

    <section class="section products">
      <div class="container">
        <div class="section-head">
          <h2>产品中心</h2>
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
                <div><dt>加工方式</dt><dd>{{ product.tolerance }}</dd></div>
              </dl>
            </div>
          </article>
        </div>
      </div>
    </section>

    <section class="section why">
      <div class="container">
        <div class="section-head">
          <h2>为什么选择我们</h2>
        </div>
        <div class="why-grid">
          <article>
            <strong>源头工厂，沟通更直接</strong>
            <p>围绕铝型材散热器及电子散热产品生产加工，减少中间沟通损耗，更适合工程打样与批量采购衔接。</p>
          </article>
          <article>
            <strong>14年诚信通记录可核验</strong>
            <p>通过1688店铺沉淀长期经营记录，让采购方在下单前多一层可验证的信任依据。</p>
          </article>
          <article>
            <strong>实体地址清晰可追溯</strong>
            <p>工厂地址位于中国广东省东莞市黄江镇合路村创业三路11号芙光科技园B座1楼。</p>
          </article>
          <article>
            <strong>老客户口碑验证</strong>
            <p>长期服务复购客户，靠稳定加工、务实沟通和持续供货建立合作基础。</p>
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
  font-size: clamp(36px, 13vw, 62px);
  line-height: 1;
  letter-spacing: 0;
}

h2 {
  margin: 0;
  font-size: clamp(26px, 8vw, 42px);
  line-height: 1.15;
  letter-spacing: 0;
}

.lead,
.about-copy,
.product-card p,
.why-grid p {
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

.hero-media,
.metric-card,
.product-card,
.why-grid article,
.partner-grid span {
  border: 1px solid rgba(255, 255, 255, 0.1);
  background: $mobile-panel;
}

.hero-media {
  overflow: hidden;
}

.hero-media img {
  width: 100%;
  aspect-ratio: 4 / 3;
  object-fit: cover;
}

.metric-card,
.why-grid article {
  padding: 18px;
}

.metric-card strong {
  display: block;
  font-family: $font-data;
  font-size: 28px;
  color: $color-accent;
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
  color: $color-text-muted;
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
    background: linear-gradient(110deg, $color-bg 0%, $color-panel 68%, $color-accent-deep 100%);
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
