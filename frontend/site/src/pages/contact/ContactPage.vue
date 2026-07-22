<script setup lang="ts">
import { CircleParking, Clock, MapPin, Phone } from 'lucide-vue-next'
import { computed, reactive, ref } from 'vue'
import { currentLocale, t, type Locale } from '../../i18n'
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
const addressCopied = ref(false)
const navModalOpen = ref(false)
let phoneToastTimer: number | undefined
let addressToastTimer: number | undefined

const directorPhone = '13652397982'
const directorPhoneLabel = '136 5239 7982'
const factoryAddress = '\u4e2d\u56fd\u5e7f\u4e1c\u7701\u4e1c\u839e\u5e02\u9ec4\u6c5f\u9547\u5408\u8def\u6751\u521b\u4e1a\u4e09\u8def11\u53f7\u8299\u5149\u79d1\u6280\u56edB\u5ea71\u697c'
const presaleContacts = [
  { key: 'south', qr: '/wechat-service-qr.png' },
  { key: 'east', qr: '/wechat-presale-east-qr.png' },
  { key: 'technical', qr: '/wechat-service-qr.png' },
] as const

const contactChannelCopy = {
  zh: {
    directorTitle: '\u9500\u552e\u603b\u76d1\u4e13\u7ebf',
    directorAriaLabel: '\u62e8\u6253\u603b\u7ecf\u7406\u4e13\u7ebf 136 5239 7982',
    directorNote: '\u5de5\u4f5c\u65e5 9:00-18:00 \u00b7 \u5b98\u65b9\u8ba4\u8bc1',
    officialNote: '\u4ee5\u4e0a\u901a\u9053\u5747\u4e3a\u4f01\u4e1a\u5b98\u65b9\u8ba4\u8bc1\u8054\u7cfb\u65b9\u5f0f\uff0c\u8bf7\u653e\u5fc3\u8054\u7edc',
    copiedText: '\u53f7\u7801\u5df2\u590d\u5236',
    contactRequiredText: '\u8bf7\u586b\u5199\u8054\u7cfb\u4eba',
    phoneOrEmailRequiredText: '\u8bf7\u81f3\u5c11\u586b\u5199\u7535\u8bdd\u6216\u90ae\u7bb1',
    inquirySuccessText: '\u7559\u8a00\u5df2\u63d0\u4ea4\uff0c\u6211\u4eec\u4f1a\u5c3d\u5feb\u4e0e\u60a8\u8054\u7cfb',
    inquiryErrorText: '\u63d0\u4ea4\u5931\u8d25\uff0c\u8bf7\u7a0d\u540e\u518d\u8bd5',
    submittingText: '\u63d0\u4ea4\u4e2d...',
    visitTitle: '\u5230\u8bbf\u6052\u5c55\u4e94\u91d1',
    navButton: '\u4e00\u952e\u5bfc\u822a\u81f3\u5382\u533a',
    navAriaLabel: '\u6253\u5f00\u5730\u56fe\u5bfc\u822a\u81f3\u6052\u5c55\u4e94\u91d1\u5382\u533a',
    navModalTitle: '\u9009\u62e9\u5730\u56fe\u5bfc\u822a',
    amap: '\u9ad8\u5fb7\u5730\u56fe',
    baiduMap: '\u767e\u5ea6\u5730\u56fe',
    copyAddress: '\u590d\u5236\u8be6\u7ec6\u5730\u5740',
    addressCopiedText: '\u5730\u5740\u5df2\u590d\u5236',
    factoryPhotoAlt: '\u6052\u5c55\u4e94\u91d1\u5382\u533a\u5b9e\u666f',
    visitTips: [
      '\u5efa\u8bae\u5de5\u4f5c\u65e5 9:00-18:00 \u63d0\u524d\u9884\u7ea6\u5230\u8bbf',
      '\u5382\u533a\u5468\u8fb9\u53ef\u4e34\u65f6\u505c\u8f66\uff0c\u8bf7\u914d\u5408\u56ed\u533a\u767b\u8bb0',
      '\u6765\u8bbf\u524d\u53ef\u81f4\u7535\u786e\u8ba4\u6837\u54c1\u6216\u56fe\u7eb8\u6c9f\u901a\u5b89\u6392',
    ],
    departmentHeaders: ['\u90e8\u95e8', '\u76f4\u62e8\u5206\u673a'],
    departments: [
      ['\u9500\u552e\u54a8\u8be2', '801'],
      ['\u6280\u672f\u5bf9\u63a5', '802'],
      ['\u6837\u54c1\u8ddf\u8fdb', '803'],
    ],
    qrAltSuffix: '\u4f01\u4e1a\u5fae\u4fe1\u4e8c\u7ef4\u7801',
    labels: {
      south: '\u534e\u5357\u533a\u552e\u524d\u987e\u95ee',
      east: '\u534e\u4e1c\u533a\u552e\u524d\u987e\u95ee',
      technical: '\u6280\u672f\u65b9\u6848\u652f\u6301',
    },
  },
  en: {
    directorTitle: 'Sales Director Hotline',
    directorAriaLabel: 'Call general manager hotline 136 5239 7982',
    directorNote: 'Weekdays 9:00-18:00 · Officially verified',
    officialNote: 'All channels above are officially verified company contacts. Please feel free to reach out.',
    copiedText: 'Number copied',
    contactRequiredText: 'Please enter a contact name',
    phoneOrEmailRequiredText: 'Please enter at least a phone number or email',
    inquirySuccessText: 'Inquiry submitted. We will contact you soon.',
    inquiryErrorText: 'Submission failed. Please try again later.',
    submittingText: 'Submitting...',
    visitTitle: 'Visit HengZhan Hardware',
    navButton: 'Navigate to Factory',
    navAriaLabel: 'Open map navigation to HengZhan Hardware factory',
    navModalTitle: 'Choose a map service',
    amap: 'Amap',
    baiduMap: 'Baidu Map',
    copyAddress: 'Copy full address',
    addressCopiedText: 'Address copied',
    factoryPhotoAlt: 'HengZhan Hardware factory view',
    visitTips: [
      'Visits are recommended on weekdays from 9:00 to 18:00 with advance confirmation.',
      'Temporary parking is available nearby. Please follow park registration rules.',
      'Please call before visiting to confirm sample or drawing review arrangements.',
    ],
    departmentHeaders: ['Department', 'Direct Extension'],
    departments: [
      ['Sales Consultation', '801'],
      ['Technical Liaison', '802'],
      ['Sample Follow-up', '803'],
    ],
    qrAltSuffix: ' enterprise WeCom QR code',
    labels: {
      south: 'South China Pre-sales Consultant',
      east: 'East China Pre-sales Consultant',
      technical: 'Technical Solution Support',
    },
  },
  hi: {
    directorTitle: 'Sales Director Hotline',
    directorAriaLabel: 'Call general manager hotline 136 5239 7982',
    directorNote: 'Weekdays 9:00-18:00 · Officially verified',
    officialNote: 'All channels above are officially verified company contacts. Please feel free to reach out.',
    copiedText: 'Number copied',
    contactRequiredText: 'Please enter a contact name',
    phoneOrEmailRequiredText: 'Please enter at least a phone number or email',
    inquirySuccessText: 'Inquiry submitted. We will contact you soon.',
    inquiryErrorText: 'Submission failed. Please try again later.',
    submittingText: 'Submitting...',
    visitTitle: 'Visit HengZhan Hardware',
    navButton: 'Navigate to Factory',
    navAriaLabel: 'Open map navigation to HengZhan Hardware factory',
    navModalTitle: 'Choose a map service',
    amap: 'Amap',
    baiduMap: 'Baidu Map',
    copyAddress: 'Copy full address',
    addressCopiedText: 'Address copied',
    factoryPhotoAlt: 'HengZhan Hardware factory view',
    visitTips: [
      'Visits are recommended on weekdays from 9:00 to 18:00 with advance confirmation.',
      'Temporary parking is available nearby. Please follow park registration rules.',
      'Please call before visiting to confirm sample or drawing review arrangements.',
    ],
    departmentHeaders: ['Department', 'Direct Extension'],
    departments: [
      ['Sales Consultation', '801'],
      ['Technical Liaison', '802'],
      ['Sample Follow-up', '803'],
    ],
    qrAltSuffix: ' enterprise WeCom QR code',
    labels: {
      south: 'South China Pre-sales Consultant',
      east: 'East China Pre-sales Consultant',
      technical: 'Technical Solution Support',
    },
  },
  de: {
    directorTitle: 'Direktleitung Vertriebsleitung',
    directorAriaLabel: 'Direktleitung 136 5239 7982 anrufen',
    directorNote: 'Werktags 9:00-18:00 · Offiziell verifiziert',
    officialNote: 'Alle oben genannten Kanäle sind offiziell verifizierte Unternehmenskontakte.',
    copiedText: 'Nummer kopiert',
    contactRequiredText: 'Bitte geben Sie eine Kontaktperson ein',
    phoneOrEmailRequiredText: 'Bitte geben Sie mindestens Telefon oder E-Mail ein',
    inquirySuccessText: 'Anfrage gesendet. Wir melden uns zeitnah.',
    inquiryErrorText: 'Senden fehlgeschlagen. Bitte versuchen Sie es später erneut.',
    submittingText: 'Wird gesendet...',
    visitTitle: 'Besuch bei HengZhan Hardware',
    navButton: 'Zur Fabrik navigieren',
    navAriaLabel: 'Kartennavigation zur HengZhan Hardware Fabrik öffnen',
    navModalTitle: 'Kartendienst auswählen',
    amap: 'Amap',
    baiduMap: 'Baidu Map',
    copyAddress: 'Vollständige Adresse kopieren',
    addressCopiedText: 'Adresse kopiert',
    factoryPhotoAlt: 'HengZhan Hardware Fabrikansicht',
    visitTips: [
      'Besuche werden werktags von 9:00 bis 18:00 nach vorheriger Bestätigung empfohlen.',
      'Kurzzeitparken ist in der Nähe möglich. Bitte folgen Sie der Registrierung im Park.',
      'Bitte rufen Sie vor dem Besuch an, um Muster- oder Zeichnungsabstimmungen zu bestätigen.',
    ],
    departmentHeaders: ['Abteilung', 'Direktwahl'],
    departments: [
      ['Vertriebsberatung', '801'],
      ['Technische Abstimmung', '802'],
      ['Musterverfolgung', '803'],
    ],
    qrAltSuffix: ' Unternehmens-WeCom-QR-Code',
    labels: {
      south: 'Pre-Sales-Beratung Südchina',
      east: 'Pre-Sales-Beratung Ostchina',
      technical: 'Technische Lösungsunterstützung',
    },
  },
} as const

const channelCopy = computed(() => contactChannelCopy[currentLocale.value as Locale])

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

async function copyFactoryAddress() {
  try {
    await navigator.clipboard.writeText(factoryAddress)
    addressCopied.value = true
    window.clearTimeout(addressToastTimer)
    addressToastTimer = window.setTimeout(() => {
      addressCopied.value = false
    }, 1500)
  } catch {
    addressCopied.value = true
    window.clearTimeout(addressToastTimer)
    addressToastTimer = window.setTimeout(() => {
      addressCopied.value = false
    }, 1500)
  }
}

async function submitInquiry() {
  feedback.value = ''
  if (!form.contactName.trim()) {
    feedbackType.value = 'error'
    feedback.value = channelCopy.value.contactRequiredText
    return
  }
  if (!form.phone.trim() && !form.email.trim()) {
    feedbackType.value = 'error'
    feedback.value = channelCopy.value.phoneOrEmailRequiredText
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
    feedback.value = channelCopy.value.inquirySuccessText
  } catch (error) {
    feedbackType.value = 'error'
    feedback.value = error instanceof Error ? error.message : channelCopy.value.inquiryErrorText
  } finally {
    submitting.value = false
  }
}
</script>

<template>
  <main>
    <section class="section contact-head">
      <div class="container visit-panel">
        <div class="visit-info">
          <h1>{{ channelCopy.visitTitle }}</h1>
          <button
            class="nav-cta tap-target"
            type="button"
            :aria-label="channelCopy.navAriaLabel"
            @click="navModalOpen = true"
          >
            <MapPin :size="18" stroke-width="2.2" aria-hidden="true" />
            <span>{{ channelCopy.navButton }}</span>
          </button>

          <ul class="visit-tips">
            <li v-for="(item, index) in channelCopy.visitTips" :key="item">
              <Clock v-if="index === 0" :size="16" color="#3B82F6" stroke-width="2.2" aria-hidden="true" />
              <CircleParking v-else-if="index === 1" :size="16" color="#3B82F6" stroke-width="2.2" aria-hidden="true" />
              <Phone v-else :size="16" color="#3B82F6" stroke-width="2.2" aria-hidden="true" />
              <span>{{ item }}</span>
            </li>
          </ul>

          <table class="department-index">
            <thead>
              <tr>
                <th>{{ channelCopy.departmentHeaders[0] }}</th>
                <th>{{ channelCopy.departmentHeaders[1] }}</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="row in channelCopy.departments" :key="row[0]">
                <td>{{ row[0] }}</td>
                <td>{{ row[1] }}</td>
              </tr>
            </tbody>
          </table>
        </div>

        <div class="visit-map-card">
          <div class="visit-map" aria-label="HengZhan Hardware factory map">
            <img class="visit-map-image" src="/contact-map.webp" alt="" loading="lazy" aria-hidden="true" />
            <img class="factory-thumb" src="/factory-placeholder.webp" :alt="channelCopy.factoryPhotoAlt" width="80" height="60" loading="lazy" />
            <div class="visit-map-address">
              <strong>{{ t.contact.addressTitle }}</strong>
              <span>{{ t.contact.address }}</span>
            </div>
            <button class="copy-address" type="button" aria-live="polite" @click="copyFactoryAddress">
              {{ addressCopied ? channelCopy.addressCopiedText : channelCopy.copyAddress }}
            </button>
          </div>
        </div>
      </div>
    </section>

    <Transition name="modal-fade">
      <div v-if="navModalOpen" class="nav-modal-backdrop" @click.self="navModalOpen = false">
        <div class="nav-modal" role="dialog" aria-modal="true" :aria-label="channelCopy.navModalTitle">
          <h2>{{ channelCopy.navModalTitle }}</h2>
          <a
            class="nav-link"
            href="https://uri.amap.com/search?keyword=%E6%81%92%E5%B1%95%E4%BA%94%E9%87%91"
            target="_blank"
            rel="noopener noreferrer"
          >
            {{ channelCopy.amap }}
          </a>
          <a
            class="nav-link"
            href="https://map.baidu.com/search/%E6%81%92%E5%B1%95%E4%BA%94%E9%87%91"
            target="_blank"
            rel="noopener noreferrer"
          >
            {{ channelCopy.baiduMap }}
          </a>
          <button class="nav-close tap-target" type="button" @click="navModalOpen = false">OK</button>
        </div>
      </div>
    </Transition>

    <section class="section">
      <div class="container contact-channel-panel">
        <div class="director-hotline">
          <h2>{{ channelCopy.directorTitle }}</h2>
          <a
            class="director-phone"
            :href="`tel:${directorPhone}`"
            :aria-label="channelCopy.directorAriaLabel"
            @click.prevent="copyDirectorPhone"
          >
            <span>{{ directorPhoneLabel }}</span>
            <Phone :size="20" color="#2563eb" stroke-width="2.2" aria-hidden="true" />
          </a>
          <p>{{ channelCopy.directorNote }}</p>
        </div>

        <div class="presale-qr-grid">
          <article v-for="item in presaleContacts" :key="item.key" class="presale-card" role="figure">
            <img :src="item.qr" :alt="`${channelCopy.labels[item.key]}${channelCopy.qrAltSuffix}`" width="140" height="140" loading="lazy" />
            <p>{{ channelCopy.labels[item.key] }}</p>
          </article>
        </div>

        <p class="official-note">{{ channelCopy.officialNote }}</p>

        <Transition name="toast">
          <div v-if="phoneCopied" class="copy-toast" role="status">{{ channelCopy.copiedText }}</div>
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
            {{ submitting ? channelCopy.submittingText : t.contact.submit }}
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
  padding: 0;
  border-top: 1px solid #e5e7eb;
  border-bottom: 1px solid $color-line;
  background: #ffffff;
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

.visit-panel {
  display: grid;
  gap: 24px;
  width: min(100% - 32px, 1200px);
  max-width: 1200px;
  padding: 24px;
  background: #ffffff;
}

.visit-info {
  display: grid;
  align-content: start;
}

.visit-info h1 {
  margin: 0 0 24px;
  color: #111827;
  font-size: 1.5rem;
  font-weight: 700;
  line-height: 1.25;
  letter-spacing: 0;
}

.nav-cta {
  width: fit-content;
  display: inline-flex;
  align-items: center;
  gap: 8px;
  padding: 12px 24px;
  border: 0;
  border-radius: 6px;
  color: #ffffff;
  background: #1f2937;
  font-weight: 700;
  transition: background 0.25s cubic-bezier(0.4, 0, 0.2, 1),
    transform 0.25s cubic-bezier(0.4, 0, 0.2, 1);
}

.nav-cta:hover,
.nav-cta:focus {
  background: #374151;
}

.nav-cta:active {
  transform: translateY(1px);
}

.visit-tips {
  display: grid;
  gap: 12px;
  padding: 0;
  margin: 24px 0 0;
  list-style: none;
}

.visit-tips li {
  display: grid;
  grid-template-columns: 16px 1fr;
  align-items: start;
  gap: 10px;
  color: #374151;
  font-size: 0.875rem;
  line-height: 1.8;
}

.visit-tips svg {
  margin-top: 5px;
}

.department-index {
  width: 100%;
  margin-top: 32px;
  border-collapse: collapse;
}

.department-index th {
  color: #6b7280;
  font-size: 0.75rem;
  font-weight: 700;
  line-height: 2;
  text-align: left;
}

.department-index td {
  color: #1f2937;
  font-size: 0.875rem;
  line-height: 2;
}

.visit-map-card {
  min-height: 280px;
}

.visit-map {
  position: relative;
  overflow: hidden;
  min-height: 280px;
  height: 100%;
  display: grid;
  align-items: end;
  padding: 24px;
  border-radius: 12px;
  background: #f9fafb;
}

.visit-map::after {
  position: absolute;
  inset: 0;
  content: "";
  background: linear-gradient(180deg, rgba(255, 255, 255, 0.08), rgba(15, 23, 42, 0.26));
  pointer-events: none;
}

.visit-map-image {
  position: absolute;
  inset: 0;
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.factory-thumb {
  position: absolute;
  top: 12px;
  left: 12px;
  z-index: 1;
  width: 80px;
  height: 60px;
  border-radius: 4px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
  object-fit: cover;
}

.visit-map-address {
  position: relative;
  z-index: 1;
  display: grid;
  gap: 6px;
  max-width: min(560px, 100%);
  padding: 14px;
  border: 1px solid rgba(255, 255, 255, 0.72);
  border-radius: 10px;
  color: #1f2937;
  background: rgba(255, 255, 255, 0.88);
  box-shadow: 0 16px 40px rgba(15, 23, 42, 0.16);
  backdrop-filter: blur(10px);
  font-family: $font-data;
  line-height: 1.55;
}

.visit-map-address strong {
  color: $color-accent-deep;
}

.copy-address {
  position: absolute;
  right: 12px;
  bottom: 12px;
  z-index: 2;
  min-height: 32px;
  padding: 6px 12px;
  border: 1px solid rgba(229, 231, 235, 0.9);
  border-radius: 4px;
  color: #1f2937;
  background: rgba(255, 255, 255, 0.9);
  font-size: 0.75rem;
  font-weight: 700;
}

.nav-modal-backdrop {
  position: fixed;
  inset: 0;
  z-index: 40;
  display: grid;
  place-items: center;
  padding: 24px;
  background: rgba(15, 23, 42, 0.32);
}

.nav-modal {
  width: min(100%, 360px);
  display: grid;
  gap: 12px;
  padding: 22px;
  border-radius: 12px;
  background: #ffffff;
  box-shadow: 0 24px 80px rgba(15, 23, 42, 0.22);
}

.nav-modal h2 {
  margin: 0 0 4px;
  color: #111827;
  font-size: 1.125rem;
}

.nav-link,
.nav-close {
  min-height: 44px;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  border-radius: 6px;
  font-weight: 700;
}

.nav-link {
  border: 1px solid #e5e7eb;
  color: #1f2937;
  background: #f9fafb;
}

.nav-close {
  border: 0;
  color: #ffffff;
  background: #1f2937;
}

.modal-fade-enter-active,
.modal-fade-leave-active {
  transition: opacity 0.2s cubic-bezier(0.4, 0, 0.2, 1);
}

.modal-fade-enter-from,
.modal-fade-leave-to {
  opacity: 0;
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

@media (min-width: $breakpoint-md) {
  .visit-panel {
    grid-template-columns: minmax(0, 55fr) minmax(0, 45fr);
    align-items: stretch;
    gap: 32px;
    padding: 48px;
  }

  .visit-map-card,
  .visit-map {
    min-height: 320px;
  }
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
