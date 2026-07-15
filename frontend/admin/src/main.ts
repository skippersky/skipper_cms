import { createApp } from 'vue'
import { createRouter, createWebHistory } from 'vue-router'
import ElementPlus from 'element-plus'
import 'element-plus/dist/index.css'
import App from './App.vue'

const routes = [
  { path: '/login', component: () => import('./pages/LoginPage.vue'), meta: { public: true } },
  { path: '/', component: () => import('./pages/DashboardPage.vue') },
  { path: '/products', component: () => import('./pages/ProductAdminPage.vue') },
  { path: '/inquiries', component: () => import('./pages/InquiryAdminPage.vue') },
  { path: '/media', component: () => import('./pages/MediaAdminPage.vue') },
  { path: '/system', component: () => import('./pages/SystemAdminPage.vue') },
]

const router = createRouter({ history: createWebHistory(), routes })

async function validateToken(token: string) {
  try {
    const response = await fetch('/api/admin/auth/profile', {
      headers: { Authorization: `Bearer ${token}` },
    })
    const payload = await response.json()
    return response.ok && payload.code === 0
  } catch {
    return false
  }
}

router.beforeEach(async (to) => {
  const token = localStorage.getItem('cms_admin_token')
  if (!to.meta.public && !token) {
    return { path: '/login', query: { redirect: to.fullPath } }
  }
  if (!to.meta.public && token && !(await validateToken(token))) {
    localStorage.removeItem('cms_admin_token')
    localStorage.removeItem('cms_admin_username')
    return { path: '/login', query: { redirect: to.fullPath } }
  }
  if (to.path === '/login' && token) {
    return '/'
  }
  return true
})

createApp(App).use(router).use(ElementPlus).mount('#app')
