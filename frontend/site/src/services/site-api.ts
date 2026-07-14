export interface ApiResponse<T> {
  code: number
  message: string
  data: T
}

export interface MediaVariant {
  url: string
  width: number
  height: number
  format: string
}

export interface ResponsiveMedia {
  id: number
  alt: string
  originalUrl: string
  variants: Record<'mobile' | 'tablet' | 'desktop' | 'thumb', MediaVariant>
}

export interface ProductCard {
  id: number
  name: string
  slug: string
  summary: string
  material: string
  tolerance: string
  cover?: ResponsiveMedia
}

export interface HomePage {
  hero: {
    title: string
    subtitle: string
    banners: ResponsiveMedia[]
  }
  metrics: Array<{ label: string; value: string }>
  products: ProductCard[]
  news: Array<{ title: string; slug: string; summary: string }>
  partners: string[]
}

export async function getHomePage(): Promise<HomePage> {
  const response = await fetch('/api/site/home')
  const payload = (await response.json()) as ApiResponse<HomePage>
  return payload.data
}

