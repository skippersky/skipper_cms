import { createApp } from 'vue'
import { createRouter, createWebHistory } from 'vue-router'
import ElementPlus from 'element-plus'
import 'element-plus/dist/index.css'
import App from './App.vue'

const routes = [
  { path: '/', component: () => import('./pages/DashboardPage.vue') },
  { path: '/products', component: () => import('./pages/ProductAdminPage.vue') },
  { path: '/inquiries', component: () => import('./pages/InquiryAdminPage.vue') },
  { path: '/media', component: () => import('./pages/MediaAdminPage.vue') },
  { path: '/system', component: () => import('./pages/SystemAdminPage.vue') },
]

createApp(App).use(createRouter({ history: createWebHistory(), routes })).use(ElementPlus).mount('#app')

