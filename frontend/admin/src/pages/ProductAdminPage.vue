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
  { name: '铝型材散热器', material: '铝型材', tolerance: '按图加工', treatment: '面向工业设备散热' },
  { name: 'CPU风冷散热器', material: '铝型材', tolerance: '批量加工', treatment: '面向消费电子散热' },
]
</script>
