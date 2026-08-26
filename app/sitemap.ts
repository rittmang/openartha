import type { MetadataRoute } from 'next';
import { corpus } from '@/app/lib/corpus';

export default function sitemap(): MetadataRoute.Sitemap {
  const base = process.env.NEXT_PUBLIC_SITE_URL ?? 'https://gita.rittmang.xyz';
  const staticRoutes = ['', '/gita', '/sources', '/data', '/methodology'];
  return [
    ...staticRoutes.map((route) => ({ url: `${base}${route}`, changeFrequency: 'monthly' as const, priority: route === '' ? 1 : .8 })),
    ...Array.from({ length: 18 }, (_, index) => ({ url: `${base}/gita/${index + 1}`, changeFrequency: 'monthly' as const, priority: .7 })),
    ...corpus.verses.map((passage) => ({ url: `${base}/gita/${passage.chapter}/${passage.verse}`, changeFrequency: 'yearly' as const, priority: .6 })),
  ];
}
