<script setup lang="ts">
import type { ResponsiveMedia } from '../services/site-api'

defineProps<{
  media?: ResponsiveMedia
  fallback: string
  alt: string
}>()
</script>

<template>
  <picture v-if="media">
    <source :srcset="media.variants.desktop.url" media="(min-width: 1024px)" type="image/webp" />
    <source :srcset="media.variants.tablet.url" media="(min-width: 768px)" type="image/webp" />
    <source :srcset="media.variants.mobile.url" type="image/webp" />
    <img :src="media.variants.mobile.url" :alt="media.alt || alt" loading="lazy" width="750" height="520" />
  </picture>
  <img v-else :src="fallback" :alt="alt" loading="lazy" width="750" height="520" />
</template>

