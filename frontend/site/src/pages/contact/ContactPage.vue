<script setup lang="ts">
import { reactive, ref } from 'vue'
import { t } from '../../i18n'
import { createInquiry } from '../../services/site-api'

const form = reactive({
  companyName: '',
  contactName: '',
  phone: '',
  email: '',
  message: '',
})

const submitting = ref(false)
const feedback = ref('')
const feedbackType = ref<'success' | 'error'>('success')

async function submitInquiry() {
  feedback.value = ''
  if (!form.contactName.trim()) {
    feedbackType.value = 'error'
    feedback.value = '请填写联系人'
    return
  }
  if (!form.phone.trim() && !form.email.trim()) {
    feedbackType.value = 'error'
    feedback.value = '请至少填写电话或邮箱'
    return
  }

  submitting.value = true
  try {
    await createInquiry({
      companyName: form.companyName.trim(),
      contactName: form.contactName.trim(),
      phone: form.phone.trim(),
      email: form.email.trim(),
      message: form.message.trim(),
    })
    form.companyName = ''
    form.contactName = ''
    form.phone = ''
    form.email = ''
    form.message = ''
    feedbackType.value = 'success'
    feedback.value = '留言已提交，我们会尽快与您联系'
  } catch (error) {
    feedbackType.value = 'error'
    feedback.value = error instanceof Error ? error.message : '提交失败，请稍后再试'
  } finally {
    submitting.value = false
  }
}
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
        <form class="contact-form" @submit.prevent="submitInquiry">
          <input v-model="form.companyName" type="text" :placeholder="t.contact.company" autocomplete="organization" />
          <input v-model="form.contactName" type="text" :placeholder="t.contact.name" autocomplete="name" required />
          <input v-model="form.phone" type="tel" :placeholder="t.contact.phone" autocomplete="tel" />
          <input v-model="form.email" type="email" :placeholder="t.contact.email" autocomplete="email" />
          <textarea v-model="form.message" :placeholder="t.contact.message"></textarea>
          <p v-if="feedback" class="form-feedback" :class="feedbackType">{{ feedback }}</p>
          <button class="tap-target" type="submit" :disabled="submitting">
            {{ submitting ? '提交中...' : t.contact.submit }}
          </button>
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

button:disabled {
  cursor: not-allowed;
  opacity: 0.68;
}

.form-feedback {
  margin: 0;
  padding: 10px 12px;
  border-radius: 10px;
  font-weight: 700;
  line-height: 1.5;
}

.form-feedback.success {
  color: #14533c;
  background: rgba(102, 207, 160, 0.18);
}

.form-feedback.error {
  color: #8f2638;
  background: rgba(233, 69, 96, 0.12);
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
