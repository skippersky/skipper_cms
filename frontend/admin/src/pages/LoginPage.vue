<script setup lang="ts">
import { ref } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'

const route = useRoute()
const router = useRouter()
const username = ref('hengzhanwujin')
const password = ref('')
const loading = ref(false)

async function login() {
  loading.value = true
  try {
    const response = await fetch('/api/admin/auth/login', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ username: username.value, password: password.value }),
    })
    const payload = await response.json()
    if (!response.ok || payload.code !== 0) {
      throw new Error(payload.message || '登录失败')
    }
    localStorage.setItem('cms_admin_token', payload.data.token)
    localStorage.setItem('cms_admin_username', payload.data.username)
    router.push((route.query.redirect as string) || '/')
  } catch (error) {
    ElMessage.error(error instanceof Error ? error.message : '登录失败')
  } finally {
    loading.value = false
  }
}
</script>

<template>
  <main class="login-page">
    <section class="login-panel">
      <p class="eyebrow">HENGZHAN CMS</p>
      <h1>后台登录</h1>
      <el-form label-position="top" @submit.prevent="login">
        <el-form-item label="账号">
          <el-input v-model="username" autocomplete="username" />
        </el-form-item>
        <el-form-item label="密码">
          <el-input v-model="password" type="password" autocomplete="current-password" show-password @keyup.enter="login" />
        </el-form-item>
        <el-button type="primary" :loading="loading" class="login-button" @click="login">登录</el-button>
      </el-form>
    </section>
  </main>
</template>

<style scoped>
.login-page {
  min-height: 100vh;
  display: grid;
  place-items: center;
  background: #111827;
}

.login-panel {
  width: min( calc(100% - 32px), 420px);
  padding: 32px;
  background: #fff;
  border: 1px solid #e5e7eb;
}

.eyebrow {
  margin: 0 0 8px;
  color: #e94560;
  font-weight: 800;
}

h1 {
  margin: 0 0 24px;
}

.login-button {
  width: 100%;
}
</style>
