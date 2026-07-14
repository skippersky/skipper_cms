<script setup lang="ts">
import { SlidersHorizontal, X } from 'lucide-vue-next'
import { ref } from 'vue'

const drawerOpen = ref(false)
const products = [
  { name: 'CNC 精密连接件', material: 'SUS304', tolerance: '±0.01mm', treatment: '钝化' },
  { name: '冲压五金支架', material: 'SPCC', tolerance: '±0.05mm', treatment: '电泳' },
  { name: '铝合金散热结构件', material: '6061-T6', tolerance: '±0.02mm', treatment: '阳极氧化' },
]
</script>

<template>
  <main>
    <section class="section product-head">
      <div class="container">
        <h1>产品展示</h1>
        <button class="filter-button tap-target" type="button" @click="drawerOpen = true">
          <SlidersHorizontal :size="20" /> 筛选
        </button>
      </div>
    </section>
    <section class="section">
      <div class="container product-layout">
        <aside class="desktop-filter">
          <strong>分类筛选</strong>
          <button>精密 CNC</button>
          <button>冲压件</button>
          <button>表面处理件</button>
        </aside>
        <div class="product-list">
          <article v-for="product in products" :key="product.name" class="product-card">
            <h2>{{ product.name }}</h2>
            <div class="table-scroll">
              <table>
                <tbody>
                  <tr><th>材质</th><td>{{ product.material }}</td></tr>
                  <tr><th>公差</th><td>{{ product.tolerance }}</td></tr>
                  <tr><th>表面处理</th><td>{{ product.treatment }}</td></tr>
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
        <button>精密 CNC</button>
        <button>冲压件</button>
        <button>表面处理件</button>
      </div>
    </Transition>
    <a class="inquiry-fab tap-target" href="/contact">立即询盘</a>
  </main>
</template>

<style scoped lang="scss">
@use "../../styles/tokens" as *;

/* MOBILE-FIRST */
.product-head {
  background: $mobile-panel;
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
  border: 1px solid rgba(255, 255, 255, 0.16);
  color: $color-text;
  background: $mobile-panel;
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
  padding: 18px;
  border: 1px solid rgba(255, 255, 255, 0.1);
  background: $mobile-panel;
}

.product-card h2 {
  margin: 0 0 14px;
  font-size: 22px;
}

.table-scroll {
  overflow-x: auto;
}

table {
  min-width: 460px;
  width: 100%;
  border-collapse: collapse;
}

th,
td {
  min-height: 44px;
  padding: 12px;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
  text-align: left;
}

th {
  color: $color-text-muted;
}

.filter-drawer {
  position: fixed;
  inset: auto 0 0;
  z-index: 30;
  display: grid;
  gap: 12px;
  padding: 20px 16px 28px;
  border-top: 1px solid rgba(255, 255, 255, 0.14);
  background: $mobile-panel;
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
  border-color: $color-accent;
  background: $color-accent;
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
    background: $color-panel;
  }

  .product-list {
    grid-template-columns: repeat(2, 1fr);
  }
}
</style>

