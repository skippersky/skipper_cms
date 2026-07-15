<script setup lang="ts">
import { SlidersHorizontal, X } from 'lucide-vue-next'
import { ref } from 'vue'

const drawerOpen = ref(false)
const products = [
  { name: '工业设备散热', products: 'LED散热器、服务器散热器、液压一体散热器', method: '按图加工', value: '面向连续运行设备的稳定散热需求，重视结构强度、导热效率与批量一致性。' },
  { name: '消费电子散热', products: '电脑散热器、电子散热片、CPU风冷散热器、PC风扇', method: '批量加工', value: '适配整机装配、工程打样和批量采购，帮助客户平衡散热性能与装配效率。' },
  { name: '精密医疗/美容散热', products: '美容仪散热产品、医疗设备散热产品', method: '来图定制', value: '关注结构适配、外观一致性与长期供货稳定性，适合设备类产品配套。' },
]
</script>

<template>
  <main>
    <section class="section product-head">
      <div class="container">
        <h1>产品中心</h1>
        <button class="filter-button tap-target" type="button" @click="drawerOpen = true">
          <SlidersHorizontal :size="20" /> 筛选
        </button>
      </div>
    </section>
    <section class="section">
      <div class="container product-layout">
        <aside class="desktop-filter">
          <strong>分类筛选</strong>
          <button>工业设备散热</button>
          <button>消费电子散热</button>
          <button>医疗/美容散热</button>
        </aside>
        <div class="product-list">
          <article v-for="product in products" :key="product.name" class="product-card">
            <h2>{{ product.name }}</h2>
            <p>{{ product.value }}</p>
            <div class="table-scroll">
              <table>
                <tbody>
                  <tr><th>覆盖产品</th><td>{{ product.products }}</td></tr>
                  <tr><th>合作方式</th><td>{{ product.method }}</td></tr>
                  <tr><th>采购价值</th><td>{{ product.value }}</td></tr>
                </tbody>
              </table>
            </div>
          </article>
        </div>
      </div>
    </section>
    <Transition name="drawer">
      <div v-if="drawerOpen" class="filter-drawer">
        <button class="close tap-target" type="button" aria-label="关闭筛选" @click="drawerOpen = false">
          <X :size="20" />
        </button>
        <strong>分类筛选</strong>
        <button>工业设备散热</button>
        <button>消费电子散热</button>
        <button>医疗/美容散热</button>
      </div>
    </Transition>
    <a class="inquiry-fab tap-target" href="https://huenghang.1688.com/" target="_blank" rel="noopener">1688快速拿样</a>
  </main>
</template>

<style scoped lang="scss">
@use "../../styles/tokens" as *;

/* MOBILE-FIRST */
.product-head {
  border-bottom: 1px solid $color-line;
  background: linear-gradient(135deg, #f7fcff, #f2fff8);
}

h1 {
  margin: 0 0 18px;
  font-size: clamp(34px, 12vw, 54px);
  letter-spacing: 0;
}

.filter-button,
.desktop-filter button,
.filter-drawer button,
.inquiry-fab {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  border: 1px solid $color-line;
  color: $color-text;
  background: #ffffff;
  font: inherit;
}

.desktop-filter {
  display: none;
}

.product-list {
  display: grid;
  gap: 16px;
}

.product-card {
  position: relative;
  overflow: hidden;
  padding: 20px;
  border: 1px solid $color-line;
  background: #ffffff;
  box-shadow: 0 16px 40px rgba(47, 91, 109, 0.08);
}

.product-card::before {
  position: absolute;
  inset: 0 auto 0 0;
  width: 7px;
  content: "";
  background: repeating-linear-gradient(180deg, $color-accent-deep 0 8px, $color-accent 8px 16px);
}

.product-card h2 {
  margin: 0 0 14px;
  font-size: 22px;
}

.product-card p {
  color: $color-text-muted;
  line-height: 1.7;
}

.table-scroll {
  overflow-x: auto;
}

table {
  min-width: 520px;
  width: 100%;
  border-collapse: collapse;
}

th,
td {
  min-height: 44px;
  padding: 12px;
  border-bottom: 1px solid $color-line;
  text-align: left;
}

th {
  color: $color-accent-deep;
}

.filter-drawer {
  position: fixed;
  inset: auto 0 0;
  z-index: 30;
  display: grid;
  gap: 12px;
  padding: 20px 16px 28px;
  border-top: 1px solid $color-line;
  background: #ffffff;
  box-shadow: 0 -18px 44px rgba(47, 91, 109, 0.12);
}

.close {
  justify-self: end;
}

.inquiry-fab {
  position: fixed;
  right: 16px;
  bottom: 16px;
  z-index: 25;
  padding: 0 18px;
  border-color: #48b98b;
  background: linear-gradient(180deg, #8ee5bc, $color-accent);
  font-weight: 800;
}

.drawer-enter-active,
.drawer-leave-active {
  transition: transform $motion-mechanical-normal $motion-easing-linear;
}

.drawer-enter-from,
.drawer-leave-to {
  transform: translateY(100%);
}

@media (min-width: $breakpoint-lg) {
  .filter-button,
  .filter-drawer,
  .inquiry-fab {
    display: none;
  }

  .product-layout {
    display: grid;
    grid-template-columns: 260px 1fr;
    gap: 24px;
  }

  .desktop-filter {
    position: sticky;
    top: 96px;
    display: grid;
    align-content: start;
    gap: 12px;
    height: fit-content;
    padding: 18px;
    border: 1px solid $color-line;
    background: #ffffff;
    box-shadow: 0 16px 40px rgba(47, 91, 109, 0.08);
  }

  .product-list {
    grid-template-columns: repeat(2, 1fr);
  }
}
</style>
