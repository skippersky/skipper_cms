<script setup lang="ts">
import { t } from '../../i18n'
</script>

<template>
  <main>
    <section class="section contact-head">
      <div class="container">
        <h1>{{ t.contact.title }}</h1>
        <p class="lead">{{ t.contact.lead }}</p>
      </div>
    </section>
    <section class="section">
      <div class="container contact-grid">
        <div class="map">
          <div class="map-address">
            <strong>{{ t.contact.addressTitle }}</strong>
            <span>{{ t.contact.address }}</span>
          </div>
        </div>
        <form class="contact-form">
          <input type="text" :placeholder="t.contact.company" />
          <input type="text" :placeholder="t.contact.name" />
          <input type="tel" :placeholder="t.contact.phone" />
          <input type="email" :placeholder="t.contact.email" />
          <textarea :placeholder="t.contact.message"></textarea>
          <button class="tap-target" type="button">{{ t.contact.submit }}</button>
          <a class="tel tap-target" href="https://huenghang.1688.com/" target="_blank" rel="noopener">{{ t.contact.sample }}</a>
        </form>
      </div>
    </section>
  </main>
</template>

<style scoped lang="scss">
@use "../../styles/tokens" as *;

/* MOBILE-FIRST */
.contact-head {
  border-bottom: 1px solid $color-line;
  background: linear-gradient(135deg, #f7fcff, #f2fff8);
}

.map,
.contact-form {
  border: 1px solid $color-line;
  background: #ffffff;
  box-shadow: 0 16px 40px rgba(47, 91, 109, 0.08);
  border-radius: 18px;
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
  position: relative;
  overflow: hidden;
  min-height: 260px;
  display: grid;
  align-items: end;
  padding: 24px;
  color: $color-text-muted;
  font-family: $font-data;
  background:
    linear-gradient(180deg, rgba(255, 255, 255, 0.08), rgba(15, 52, 96, 0.18)),
    url("/contact-map.webp") center / cover no-repeat;
}

.map-address {
  display: grid;
  gap: 8px;
  max-width: 680px;
  padding: 16px;
  border: 1px solid rgba(255, 255, 255, 0.72);
  background: rgba(255, 255, 255, 0.88);
  box-shadow: 0 16px 40px rgba(47, 91, 109, 0.16);
  backdrop-filter: blur(10px);
  border-radius: 14px;
}

.map-address strong {
  color: $color-accent-deep;
}

.contact-form {
  display: grid;
  gap: 12px;
  padding: 18px;
}

input,
textarea {
  width: 100%;
  border: 1px solid $color-line;
  color: $color-text;
  background: #f8fcfd;
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
  border: 1px solid #48b98b;
  color: #0f2f28;
  background: linear-gradient(180deg, #8ee5bc, $color-accent);
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
