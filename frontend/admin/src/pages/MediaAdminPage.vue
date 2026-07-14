<template>
  <h1>媒体库</h1>
  <el-card>
    <el-upload drag action="/api/admin/media/upload" name="file">
      <p>上传图片后生成 desktop / tablet / mobile / thumb 版本</p>
    </el-upload>
  </el-card>
</template>

