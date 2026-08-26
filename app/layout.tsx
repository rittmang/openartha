import type { Metadata } from 'next';
import './globals.css';

export const metadata: Metadata = {
  metadataBase: new URL(process.env.NEXT_PUBLIC_SITE_URL ?? 'https://gita.rittmang.xyz'),
  title: {
    default: 'Agentic Gita — A versioned public corpus',
    template: '%s · Agentic Gita',
  },
  description:
    'A source-aware public edition of the Bhagavad Gita in Sanskrit, IAST, and English.',
  alternates: { canonical: '/' },
  openGraph: {
    type: 'website',
    title: 'Agentic Gita',
    description: 'A versioned public corpus of the Bhagavad Gita.',
    images: [{ url: '/og.png', width: 1200, height: 630, alt: 'Agentic Gita — A versioned public corpus of the Bhagavad Gita' }],
  },
  twitter: {
    card: 'summary_large_image',
    title: 'Agentic Gita',
    description: 'A versioned public corpus of the Bhagavad Gita.',
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
              <a href="/gita">Read</a>
              <a href="/data">Data</a>
              <a href="/sources">Sources</a>
              <a href="/methodology">Methodology</a>
            </nav>
          </div>
        </header>
        <div id="content">{children}</div>
        <footer className="site-footer">
          <div className="shell footer-grid">
            <span>Agentic Gita</span>
            <span>Text first. Sources visible. Corrections versioned.</span>
          </div>
        </footer>
      </body>
    </html>
  );
}
