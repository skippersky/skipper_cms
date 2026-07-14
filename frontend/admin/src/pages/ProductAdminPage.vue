<template>
  <h1>产品管理</h1>
  <el-card>
    <el-button type="primary">新增产品</el-button>
    <el-button>批量导入</el-button>
    <el-table :data="rows" style="width: 100%; margin-top: 16px">
      <el-table-column prop="name" label="产品名称" />
      <el-table-column prop="material" label="材质" />
      <el-table-column prop="tolerance" label="公差" />
      <el-table-column prop="treatment" label="表面处理" />
    </el-table>
  </el-card>
</template>

<script setup lang="ts">
const rows = [
  { name: 'CNC 精密连接件', material: 'SUS304', tolerance: '±0.01mm', treatment: '钝化' },
  { name: '冲压五金支架', material: 'SPCC', tolerance: '±0.05mm', treatment: '电泳' },
]
</script>

