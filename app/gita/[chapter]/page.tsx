import type { Metadata } from 'next';
import Link from 'next/link';
import { notFound } from 'next/navigation';
import { chapterTitles, corpus, getChapter } from '@/app/lib/corpus';
import { Breadcrumbs } from '@/components/breadcrumbs';
import { PassageCard } from '@/components/passage-card';

type Props = { params: Promise<{ chapter: string }> };

export function generateStaticParams() {
  return chapterTitles.map((_, index) => ({ chapter: String(index + 1) }));
}

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  const chapter = Number((await params).chapter);
  const title = chapterTitles[chapter - 1];
  if (!title) return {};
  return {
    title: `Chapter ${chapter}: ${title[0]}`,
    description: `${title[1]}. Read all ${corpus.chapterCounts[chapter - 1]} passages in Sanskrit, IAST, and the Telang English witness.`,
    alternates: { canonical: `/gita/${chapter}` },
    openGraph: { title: `Bhagavad Gita ${chapter} — ${title[0]}`, description: title[1], images: [] },
    twitter: { title: `Bhagavad Gita ${chapter} — ${title[0]}`, description: title[1], images: [] },
  };
}

export default async function ChapterPage({ params }: Props) {
  const chapter = Number((await params).chapter);
  if (!Number.isInteger(chapter) || chapter < 1 || chapter > 18) notFound();
  const passages = getChapter(chapter);
  const [sanskritTitle, englishTitle] = chapterTitles[chapter - 1];
  return (
    <main className="shell page-shell">
      <Breadcrumbs items={[{ label: 'Bhagavad Gita', href: '/gita' }, { label: `Chapter ${chapter}` }]} />
      <header className="page-header chapter-header">
        <div className="chapter-kicker">Chapter {String(chapter).padStart(2, '0')}</div>
        <h1>{sanskritTitle}</h1>
        <p>{englishTitle}</p>
        <span>{passages.length} verses</span>
      </header>
      <div className="passage-list chapter-passages">
        {passages.map((passage) => <PassageCard key={passage.id} passage={passage} />)}
      </div>
      <nav className="chapter-navigation" aria-label="Chapter navigation">
        {chapter > 1 ? <Link href={`/gita/${chapter - 1}`}>← Chapter {chapter - 1}</Link> : <span />}
        {chapter < 18 ? <Link href={`/gita/${chapter + 1}`}>Chapter {chapter + 1} →</Link> : <Link href="/gita">All chapters</Link>}
      </nav>
    </main>
  );
}
