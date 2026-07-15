<script setup lang="ts">
import { computed } from 'vue'
import { useRoute, useRouter } from 'vue-router'

const route = useRoute()
const router = useRouter()
const isLogin = computed(() => route.path === '/login')
const username = computed(() => localStorage.getItem('cms_admin_username') || '管理员')

function logout() {
  localStorage.removeItem('cms_admin_token')
  localStorage.removeItem('cms_admin_username')
  router.push('/login')
}
</script>

<template>
  <router-view v-if="isLogin" />
  <el-container v-else class="admin-shell">
    <el-aside width="236px">
      <div class="brand">恒展五金 CMS</div>
      <el-menu router default-active="/">
        <el-menu-item index="/">仪表盘</el-menu-item>
        <el-menu-item index="/products">产品管理</el-menu-item>
        <el-menu-item index="/inquiries">留言管理</el-menu-item>
        <el-menu-item index="/media">媒体库</el-menu-item>
        <el-menu-item index="/system">系统管理</el-menu-item>
      </el-menu>
    </el-aside>
    <el-main>
      <div class="topbar">
        <span>{{ username }}</span>
        <el-button size="small" @click="logout">退出登录</el-button>
      </div>
      <router-view />
    </el-main>
  </el-container>
</template>

<style scoped lang="scss">
.admin-shell {
  min-height: 100vh;
}

.brand {
  height: 64px;
  display: flex;
  align-items: center;
  padding: 0 20px;
  font-weight: 800;
}

.el-aside {
  border-right: 1px solid var(--el-border-color);
}

.topbar {
  display: flex;
  justify-content: flex-end;
  align-items: center;
  gap: 12px;
  margin-bottom: 16px;
}
</style>
