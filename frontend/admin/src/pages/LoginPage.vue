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
      <div class="brand-mark" aria-hidden="true"></div>
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
  background:
    linear-gradient(90deg, rgba(47, 155, 179, 0.05) 1px, transparent 1px),
    linear-gradient(180deg, rgba(102, 207, 160, 0.05) 1px, transparent 1px),
    linear-gradient(135deg, #eef7fb, #f5fff8);
  background-size: 34px 34px, 34px 34px, auto;
}

.login-panel {
  width: min(calc(100% - 32px), 430px);
  padding: 34px;
  background: rgba(255, 255, 255, 0.94);
  border: 1px solid #c8e2e7;
  box-shadow: 0 24px 60px rgba(47, 91, 109, 0.12);
}

.brand-mark {
  width: 44px;
  height: 44px;
  margin-bottom: 18px;
  border: 1px solid rgba(47, 155, 179, 0.34);
  background: repeating-linear-gradient(90deg, #d7e7eb 0 4px, #ffffff 4px 8px);
}

.eyebrow {
  margin: 0 0 8px;
  color: #2f9bb3;
  font-weight: 900;
}

h1 {
  margin: 0 0 24px;
  color: #173142;
}

.login-button {
  width: 100%;
}
</style>
