import type { Metadata } from 'next';
import { notFound } from 'next/navigation';
import { chapterTitles, corpus } from '@/app/lib/corpus';
import { commentaryAuthors } from '@/app/lib/commentaries';
import { Breadcrumbs } from '@/components/breadcrumbs';

type Props = { params: Promise<{ author: string }> };

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  const values = await params;
  const author = commentaryAuthors.find((item) => item.id === values.author && item.publicFields.length);
  return author ? { title: `${author.displayName} commentary`, description: `Read ${author.displayName}'s Sanskrit commentary on the Bhagavad Gita by chapter.` } : {};
}

export default async function CommentaryAuthorPage({ params }: Props) {
  const values = await params;
  const author = commentaryAuthors.find((item) => item.id === values.author && item.publicFields.length);
  if (!author) notFound();
  return (
    <main className="shell page-shell prose-page">
      <Breadcrumbs items={[{ label: 'Commentaries', href: '/commentaries' }, { label: author.displayName }]} />
      <header className="page-header"><div className="eyebrow">Classical Sanskrit witness</div><h1>{author.displayName}</h1><p>Read this commentary alongside the project’s fixed 700-verse canonical structure. The transcription is machine-aligned and awaits independent human review.</p></header>
      <section aria-labelledby="author-chapters-title"><div className="section-heading"><h2 id="author-chapters-title">Chapters</h2><span>18 chapters</span></div><ol className="chapter-grid">{chapterTitles.map(([title, subtitle], index) => <li key={title}><a href={`/commentaries/${author.id}/${index + 1}`}><span className="chapter-number">{String(index + 1).padStart(2, '0')}</span><span className="chapter-name"><strong>{title}</strong><span>{subtitle}</span></span><span className="chapter-count">{corpus.chapterCounts[index]} units</span><span aria-hidden="true">↗</span></a></li>)}</ol></section>
      <section className="author-rights"><span className="eyebrow">Rights and status</span><p>{author.rightsNote}</p></section>
    </main>
  );
}
