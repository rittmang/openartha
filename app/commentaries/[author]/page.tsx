import type { Metadata } from 'next';
import { notFound } from 'next/navigation';
import { chapterTitles, corpus } from '@/app/lib/corpus';
import { commentaryAuthors, commentaryFieldLabels } from '@/app/lib/commentaries';
import { Breadcrumbs } from '@/components/breadcrumbs';

type Props = { params: Promise<{ author: string }> };

function describeFields(fields: string[]) {
  const labels = fields.map((field) => commentaryFieldLabels[field].toLowerCase());
  if (labels.length < 2) return labels[0] ?? 'reading';
  return `${labels.slice(0, -1).join(', ')} and ${labels.at(-1)}`;
}

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  const values = await params;
  const author = commentaryAuthors.find((item) => item.id === values.author && item.publicFields.length);
  return author ? { title: `${author.displayName} on the Gita`, description: `Read ${author.displayName}’s supplied ${describeFields(author.publicFields)} on the Bhagavad Gita, organized across all 18 chapters.`, alternates: { canonical: `/gita/commentaries/${author.id}` } } : {};
}

export default async function CommentaryAuthorPage({ params }: Props) {
  const values = await params;
  const author = commentaryAuthors.find((item) => item.id === values.author && item.publicFields.length);
  if (!author) notFound();
  return (
    <main className="shell page-shell prose-page">
      <Breadcrumbs items={[{ label: 'Gita commentaries', href: '/gita/commentaries' }, { label: author.displayName }]} />
      <header className="page-header"><div className="eyebrow">{author.publicFields.map((field) => commentaryFieldLabels[field]).join(' · ')}</div><h1>{author.displayName}</h1><p>Read {author.displayName}’s {describeFields(author.publicFields)} beside the Sanskrit verse, with its source and review status kept in view.</p></header>
      <section aria-labelledby="author-chapters-title"><div className="section-heading"><h2 id="author-chapters-title">Chapters</h2><span>18 chapters</span></div><ol className="chapter-grid">{chapterTitles.map(([title, subtitle], index) => <li key={title}><a href={`/gita/commentaries/${author.id}/${index + 1}`}><span className="chapter-number">{String(index + 1).padStart(2, '0')}</span><span className="chapter-name"><strong>{title}</strong><span>{subtitle}</span></span><span className="chapter-count">{corpus.chapterCounts[index] * author.publicFields.length} records</span><span aria-hidden="true">↗</span></a></li>)}</ol></section>
      <section className="author-rights"><span className="eyebrow">Rights and status</span><p>{author.rightsNote}</p></section>
    </main>
  );
}
