import { createApp } from 'vue'
import { createRouter, createWebHistory } from 'vue-router'
import App from './App.vue'
import HomePage from './pages/home/HomePage.vue'
import ProductsPage from './pages/products/ProductsPage.vue'
import CompanyPage from './pages/company/CompanyPage.vue'
import ContactPage from './pages/contact/ContactPage.vue'
import './styles/global.scss'

const router = createRouter({
  history: createWebHistory(),
  routes: [
    { path: '/', component: HomePage },
    { path: '/company', component: CompanyPage },
    { path: '/products', component: ProductsPage },
    { path: '/contact', component: ContactPage },
  ],
})

createApp(App).use(router).mount('#app')

