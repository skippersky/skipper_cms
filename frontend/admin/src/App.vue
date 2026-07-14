<template>
  <el-container class="admin-shell">
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
</style>
