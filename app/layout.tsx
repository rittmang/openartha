import type { Metadata } from 'next';
import './globals.css';

export const metadata: Metadata = {
  metadataBase: new URL(process.env.NEXT_PUBLIC_SITE_URL ?? 'https://gita.rittmang.xyz'),
  title: {
    default: 'Agentic Gita — Read and verify the Bhagavad Gita',
    template: '%s · Agentic Gita',
  },
  description:
    'Read all 700 verses of the Bhagavad Gita in Devanagari, IAST, and English. Check the source and review status of every verse.',
  alternates: { canonical: '/' },
  openGraph: {
    type: 'website',
    title: 'Agentic Gita',
    description: 'Read the Bhagavad Gita and check the evidence behind every verse.',
    images: [{ url: '/og.png', width: 1200, height: 630, alt: 'Agentic Gita — Read the Gita and see the evidence' }],
  },
  twitter: {
    card: 'summary_large_image',
    title: 'Agentic Gita',
    description: 'Read the Bhagavad Gita and check the evidence behind every verse.',
    images: ['/og.png'],
  },
  robots: { index: true, follow: true },
};

export default function RootLayout({ children }: Readonly<{ children: React.ReactNode }>) {
  return (
    <html lang="en">
      <body>
        <a className="skip-link" href="#content">Skip to content</a>
        <header className="site-header">
          <div className="shell nav-wrap">
            <a className="brand" href="/" aria-label="Agentic Gita home">
              <span className="brand-mark" aria-hidden="true">अ</span>
              <span>Agentic Gita</span>
            </a>
            <nav aria-label="Primary navigation">
              <a href="/gita">Read the Gita</a>
              <a href="/commentaries">Commentaries</a>
              <a href="/data">Downloads</a>
              <a href="/sources">Sources</a>
              <a href="/methodology">How it works</a>
            </nav>
          </div>
        </header>
        <div id="content">{children}</div>
        <footer className="site-footer">
          <div className="shell footer-grid">
            <span>Agentic Gita</span>
            <span>Read the text. Compare its interpreters. Check every source.</span>
          </div>
        </footer>
      </body>
    </html>
  );
}
