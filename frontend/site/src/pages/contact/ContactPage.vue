<script setup lang="ts">
import { Phone } from 'lucide-vue-next'
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
const phoneCopied = ref(false)
let phoneToastTimer: number | undefined

const directorPhone = '13652397982'
const directorPhoneLabel = '136 5239 7982'
const presaleContacts = [
  { label: '华南区售前顾问', qr: '/wechat-service-qr.png' },
  { label: '华东区售前顾问', qr: '/wechat-service-qr.png' },
  { label: '技术方案支持', qr: '/wechat-service-qr.png' },
]

async function copyDirectorPhone() {
  try {
    await navigator.clipboard.writeText(directorPhone)
    phoneCopied.value = true
    window.clearTimeout(phoneToastTimer)
    phoneToastTimer = window.setTimeout(() => {
      phoneCopied.value = false
    }, 1500)
  } catch {
    window.location.href = `tel:${directorPhone}`
  }
}

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
      <div class="container contact-channel-panel">
        <div class="director-hotline">
          <h2>销售总监专线</h2>
          <a
            class="director-phone"
            :href="`tel:${directorPhone}`"
            aria-label="拨打总经理专线 136 5239 7982"
            @click.prevent="copyDirectorPhone"
          >
            <span>{{ directorPhoneLabel }}</span>
            <Phone :size="20" color="#3B82F6" stroke-width="2.2" aria-hidden="true" />
          </a>
          <p>工作日 9:00-18:00 · 官方认证</p>
        </div>

        <div class="presale-qr-grid">
          <article v-for="item in presaleContacts" :key="item.label" class="presale-card" role="figure">
            <img :src="item.qr" :alt="`${item.label}企业微信二维码`" width="140" height="140" loading="lazy" />
            <p>{{ item.label }}</p>
          </article>
        </div>

        <p class="official-note">以上通道均为企业官方认证联系方式，请放心联络</p>

        <Transition name="toast">
          <div v-if="phoneCopied" class="copy-toast" role="status">号码已复制</div>
        </Transition>
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

.contact-channel-panel {
  position: relative;
  display: grid;
  gap: 1.5rem;
  width: min(100% - 32px, 1200px);
  max-width: 1200px;
  margin-inline: auto;
  padding: 3rem;
  border-radius: 12px;
  background: #f9fafb;
}

.director-hotline {
  display: grid;
  align-content: center;
  gap: 0.75rem;
}

.director-hotline h2 {
  margin: 0;
  color: #111827;
  font-size: 1.25rem;
  font-weight: 600;
  line-height: 1.35;
}

.director-phone {
  display: inline-flex;
  align-items: center;
  gap: 0.625rem;
  width: fit-content;
  min-height: 3rem;
  color: #1f2937;
  font-family: "DIN", "Roboto Mono", monospace;
  font-size: 1.75rem;
  font-weight: 700;
  line-height: 1.2;
}

.director-phone:hover,
.director-phone:focus {
  color: #111827;
}

.director-hotline p,
.presale-card p,
.official-note {
  margin: 0;
}

.director-hotline p {
  color: #6b7280;
  font-size: 0.8125rem;
  line-height: 1.5;
}

.presale-qr-grid {
  display: grid;
  gap: 1.5rem;
}

.presale-card {
  display: grid;
  justify-items: center;
  gap: 1rem;
  padding: 1.5rem;
  border-radius: 8px;
  background: #ffffff;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.06);
  transition: transform 0.25s cubic-bezier(0.4, 0, 0.2, 1),
    box-shadow 0.25s cubic-bezier(0.4, 0, 0.2, 1);
}

.presale-card:hover,
.presale-card:focus-within {
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
  transform: translateY(-2px);
}

.presale-card img {
  width: 8.75rem;
  height: 8.75rem;
  border-radius: 8px;
  object-fit: contain;
}

.presale-card p {
  color: #374151;
  font-size: 0.875rem;
  font-weight: 500;
  line-height: 1.5;
  text-align: center;
}

.official-note {
  color: #9ca3af;
  font-size: 0.75rem;
  line-height: 1.5;
  margin-top: 0.5rem;
  text-align: center;
}

.copy-toast {
  position: fixed;
  left: 50%;
  bottom: 2rem;
  z-index: 30;
  min-height: 2.5rem;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  padding: 0 1rem;
  border-radius: 8px;
  color: #ffffff;
  background: #111827;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
  font-size: 0.875rem;
  font-weight: 600;
  transform: translateX(-50%);
}

.toast-enter-active,
.toast-leave-active {
  transition: opacity 0.25s cubic-bezier(0.4, 0, 0.2, 1),
    transform 0.25s cubic-bezier(0.4, 0, 0.2, 1);
}

.toast-enter-from,
.toast-leave-to {
  opacity: 0;
  transform: translate(-50%, 0.5rem);
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
  .contact-channel-panel {
    grid-template-columns: minmax(0, 40fr) minmax(0, 60fr);
    align-items: center;
  }

  .presale-qr-grid {
    grid-template-columns: repeat(3, minmax(0, 1fr));
  }

  .official-note {
    grid-column: 1 / -1;
    margin-top: 0.5rem;
  }

  .contact-grid {
    grid-template-columns: 1fr 420px;
  }

  .map {
    min-height: 520px;
  }
}
</style>
