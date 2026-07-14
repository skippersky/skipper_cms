<template>
  <h1>留言管理</h1>
  <el-card>
    <el-button>导出 Excel</el-button>
    <el-table :data="rows" style="width: 100%; margin-top: 16px">
      <el-table-column prop="company" label="公司" />
      <el-table-column prop="contact" label="联系人" />
      <el-table-column prop="status" label="状态" />
    </el-table>
  </el-card>
</template>

<script setup lang="ts">
const rows = [{ company: '示例客户', contact: '王先生', status: 'NEW' }]
</script>

