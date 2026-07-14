<template>
  <main>
    <section class="section contact-head">
      <div class="container">
        <h1>联系我们</h1>
        <p class="lead">工厂地址：中国广东省东莞市黄江镇合路村创业三路11号芙光科技园B座1楼</p>
      </div>
    </section>
    <section class="section">
      <div class="container contact-grid">
        <div class="map">
          <strong>实体工厂地址</strong>
          <span>中国广东省东莞市黄江镇合路村创业三路11号芙光科技园B座1楼</span>
        </div>
        <form class="contact-form">
          <input type="text" placeholder="公司名称" />
          <input type="text" placeholder="联系人" />
          <input type="tel" placeholder="联系电话" />
          <input type="email" placeholder="邮箱" />
          <textarea placeholder="请描述散热产品类型、图纸、数量或交付需求"></textarea>
          <button class="tap-target" type="button">提交留言</button>
          <a class="tel tap-target" href="https://huenghang.1688.com/" target="_blank" rel="noopener">1688在线验厂 / 快速拿样</a>
        </form>
      </div>
    </section>
  </main>
</template>

<style scoped lang="scss">
@use "../../styles/tokens" as *;

/* MOBILE-FIRST */
.contact-head,
.map,
.contact-form {
  background: $mobile-panel;
}

h1 {
  margin: 0;
  font-size: clamp(34px, 12vw, 54px);
  letter-spacing: 0;
}

.lead {
  max-width: 760px;
  color: $color-text-muted;
  line-height: 1.7;
}

.contact-grid {
  display: grid;
  gap: 18px;
}

.map {
  min-height: 260px;
  display: grid;
  align-content: center;
  gap: 12px;
  padding: 24px;
  color: $color-text-muted;
  font-family: $font-data;
}

.map strong {
  color: $color-text;
}

.contact-form {
  display: grid;
  gap: 12px;
  padding: 18px;
}

input,
textarea {
  width: 100%;
  border: 1px solid rgba(255, 255, 255, 0.14);
  color: $color-text;
  background: rgba(255, 255, 255, 0.04);
  padding: 0 14px;
}

textarea {
  min-height: 120px;
  padding-top: 12px;
}

button,
.tel {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  border: 1px solid $color-accent;
  color: $color-text;
  background: $color-accent;
  font-weight: 800;
}

@media (min-width: $breakpoint-lg) {
  .contact-grid {
    grid-template-columns: 1fr 420px;
  }

  .map {
    min-height: 520px;
  }
}
</style>
