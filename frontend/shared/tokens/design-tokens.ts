export const breakpoints = {
  sm: 640,
  md: 768,
  lg: 1024,
  xl: 1280,
  '2xl': 1536,
} as const

export const touch = {
  minTarget: 44,
  mobileInputHeight: 48,
  mobileBodyFontSize: 16,
  minReadableFontSize: 14,
} as const

export const colors = {
  bg: '#1a1a2e',
  panel: '#16213e',
  accent: '#e94560',
  accentDeep: '#0f3460',
  text: '#e0e0e0',
  textMuted: '#a0a0a0',
  mobileBg: '#181828',
  mobilePanel: '#151f38',
} as const

export const motion = {
  fast: 200,
  normal: 260,
  easing: 'linear',
} as const

