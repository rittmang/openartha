import type { Metadata } from 'next';
import './globals.css';

export const metadata: Metadata = {
  metadataBase: new URL(process.env.NEXT_PUBLIC_SITE_URL ?? 'https://openartha.rittmang.xyz'),
  title: {
    default: 'OpenArtha — Find meaning. Follow it to the source.',
    template: '%s · OpenArtha',
  },
  description:
    'OpenArtha is an open, source-aware library for reading primary texts alongside translations, commentaries, and evidence. Begin with the Bhagavad Gita.',
  openGraph: {
    type: 'website',
    title: 'OpenArtha',
    description: 'Read primary texts, compare interpretations, and follow every reading to its source.',
    images: [{ url: '/og.png', width: 1200, height: 630, alt: 'OpenArtha — Find meaning. Follow it to the source.' }],
  },
  twitter: {
    card: 'summary_large_image',
    title: 'OpenArtha',
    description: 'Read primary texts, compare interpretations, and follow every reading to its source.',
    images: ['/og.png'],
  },
  icons: {
    icon: [{ url: '/favicon.svg', type: 'image/svg+xml' }],
    shortcut: '/favicon.svg',
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
            <a className="brand" href="/" aria-label="OpenArtha home">
              <svg className="brand-mark" viewBox="0 0 36 36" aria-hidden="true">
                <rect className="brand-mark-surface" x="0.75" y="0.75" width="34.5" height="34.5" rx="10.25" />
                <text className="brand-mark-letters" x="18" y="18.5" textAnchor="middle" dominantBaseline="middle">OA</text>
              </svg>
              <span className="brand-name">OpenArtha</span>
            </a>
            <nav aria-label="Primary navigation">
              <a href="/gita">Read the Gita</a>
              <a href="/gita/commentaries">Commentaries</a>
              <a href="/data">Open data</a>
              <a href="/sources">Sources</a>
              <a href="/methodology">How it works</a>
            </nav>
          </div>
        </header>
        <div id="content">{children}</div>
        <footer className="site-footer">
          <div className="shell footer-grid">
            <span>OpenArtha</span>
            <div className="footer-copy">
              <span>Find meaning. Follow it to the source.</span>
              <small>Artha (AR-tha) means meaning, purpose, or sense in Sanskrit.</small>
            </div>
          </div>
        </footer>
      </body>
    </html>
  );
}
