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
const directorTitle = '\u9500\u552e\u603b\u76d1\u4e13\u7ebf'
const directorAriaLabel = '\u62e8\u6253\u603b\u7ecf\u7406\u4e13\u7ebf 136 5239 7982'
const directorNote = '\u5de5\u4f5c\u65e5 9:00-18:00 \u00b7 \u5b98\u65b9\u8ba4\u8bc1'
const officialNote = '\u4ee5\u4e0a\u901a\u9053\u5747\u4e3a\u4f01\u4e1a\u5b98\u65b9\u8ba4\u8bc1\u8054\u7cfb\u65b9\u5f0f\uff0c\u8bf7\u653e\u5fc3\u8054\u7edc'
const copiedText = '\u53f7\u7801\u5df2\u590d\u5236'
const contactRequiredText = '\u8bf7\u586b\u5199\u8054\u7cfb\u4eba'
const phoneOrEmailRequiredText = '\u8bf7\u81f3\u5c11\u586b\u5199\u7535\u8bdd\u6216\u90ae\u7bb1'
const inquirySuccessText = '\u7559\u8a00\u5df2\u63d0\u4ea4\uff0c\u6211\u4eec\u4f1a\u5c3d\u5feb\u4e0e\u60a8\u8054\u7cfb'
const inquiryErrorText = '\u63d0\u4ea4\u5931\u8d25\uff0c\u8bf7\u7a0d\u540e\u518d\u8bd5'
const submittingText = '\u63d0\u4ea4\u4e2d...'
const qrAltSuffix = '\u4f01\u4e1a\u5fae\u4fe1\u4e8c\u7ef4\u7801'
const presaleContacts = [
  { label: '\u534e\u5357\u533a\u552e\u524d\u987e\u95ee', qr: '/wechat-service-qr.png' },
  { label: '\u534e\u4e1c\u533a\u552e\u524d\u987e\u95ee', qr: '/wechat-service-qr.png' },
  { label: '\u6280\u672f\u65b9\u6848\u652f\u6301', qr: '/wechat-service-qr.png' },
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
    feedback.value = contactRequiredText
    return
  }
  if (!form.phone.trim() && !form.email.trim()) {
    feedbackType.value = 'error'
    feedback.value = phoneOrEmailRequiredText
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
    feedback.value = inquirySuccessText
  } catch (error) {
    feedbackType.value = 'error'
    feedback.value = error instanceof Error ? error.message : inquiryErrorText
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
          <h2>{{ directorTitle }}</h2>
          <a
            class="director-phone"
            :href="`tel:${directorPhone}`"
            :aria-label="directorAriaLabel"
            @click.prevent="copyDirectorPhone"
          >
            <span>{{ directorPhoneLabel }}</span>
            <Phone :size="20" color="#2563eb" stroke-width="2.2" aria-hidden="true" />
          </a>
          <p>{{ directorNote }}</p>
        </div>

        <div class="presale-qr-grid">
          <article v-for="item in presaleContacts" :key="item.label" class="presale-card" role="figure">
            <img :src="item.qr" :alt="`${item.label}${qrAltSuffix}`" width="140" height="140" loading="lazy" />
            <p>{{ item.label }}</p>
          </article>
        </div>

        <p class="official-note">{{ officialNote }}</p>

        <Transition name="toast">
          <div v-if="phoneCopied" class="copy-toast" role="status">{{ copiedText }}</div>
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
            {{ submitting ? submittingText : t.contact.submit }}
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
  background:
    radial-gradient(circle at 88% 0%, rgba(34, 199, 216, 0.16), transparent 30%),
    linear-gradient(135deg, #f8fafc, #e5ebf1);
}

.map,
.contact-form {
  border: 1px solid $color-line;
  background:
    linear-gradient(145deg, rgba(255, 255, 255, 0.94), rgba(226, 232, 240, 0.78)),
    #ffffff;
  box-shadow: $shadow-metal;
  border-radius: 16px;
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
  border: 1px solid rgba(100, 116, 139, 0.2);
  border-radius: 16px;
  background:
    linear-gradient(135deg, rgba(255, 255, 255, 0.96), rgba(226, 232, 240, 0.82)),
    #f8fafc;
  box-shadow: $shadow-metal;
}

.contact-channel-panel::before {
  position: absolute;
  inset: 0;
  content: "";
  border-radius: inherit;
  background:
    linear-gradient(90deg, rgba(255, 255, 255, 0.56), transparent 34%, rgba(34, 199, 216, 0.08)),
    repeating-linear-gradient(90deg, rgba(100, 116, 139, 0.08) 0 1px, transparent 1px 28px);
  pointer-events: none;
}

.director-hotline,
.presale-qr-grid,
.official-note {
  position: relative;
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
  border: 1px solid rgba(100, 116, 139, 0.16);
  border-radius: 12px;
  background:
    linear-gradient(145deg, rgba(255, 255, 255, 0.96), rgba(241, 245, 249, 0.9)),
    #ffffff;
  box-shadow: 0 1px 3px rgba(15, 23, 42, 0.06);
  transition: transform 0.25s cubic-bezier(0.4, 0, 0.2, 1),
    box-shadow 0.25s cubic-bezier(0.4, 0, 0.2, 1),
    border-color 0.25s cubic-bezier(0.4, 0, 0.2, 1);
}

.presale-card:hover,
.presale-card:focus-within {
  border-color: rgba(37, 99, 235, 0.28);
  box-shadow: 0 4px 12px rgba(15, 23, 42, 0.08);
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
    linear-gradient(180deg, rgba(255, 255, 255, 0.08), rgba(15, 23, 42, 0.26)),
    url("/contact-map.webp") center / cover no-repeat;
}

.map-address {
  display: grid;
  gap: 8px;
  max-width: 680px;
  padding: 16px;
  border: 1px solid rgba(255, 255, 255, 0.72);
  background: rgba(255, 255, 255, 0.88);
  box-shadow: 0 16px 40px rgba(15, 23, 42, 0.16);
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
  background: #f8fafc;
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
  border: 1px solid rgba(37, 99, 235, 0.28);
  color: #ffffff;
  background: linear-gradient(135deg, $color-accent-deep, $color-accent);
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
  background: rgba(34, 197, 94, 0.14);
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
