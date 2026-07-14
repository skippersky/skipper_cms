<template>
  <main>
    <section class="section contact-head">
      <div class="container">
        <h1>联系我们</h1>
      </div>
    </section>
    <section class="section">
      <div class="container contact-grid">
        <div class="map">MAP</div>
        <form class="contact-form">
          <input type="text" placeholder="公司名称" />
          <input type="text" placeholder="联系人" />
          <input type="tel" placeholder="联系电话" />
          <input type="email" placeholder="邮箱" />
          <textarea placeholder="需求描述"></textarea>
          <button class="tap-target" type="button">提交留言</button>
          <a class="tel tap-target" href="tel:+8600000000000">一键拨打</a>
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

.contact-grid {
  display: grid;
  gap: 18px;
}

.map {
  min-height: 260px;
  display: grid;
  place-items: center;
  color: $color-text-muted;
  font-family: $font-data;
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

