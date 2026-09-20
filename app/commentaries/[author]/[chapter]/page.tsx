import type { Metadata } from 'next';
import { notFound } from 'next/navigation';
import { chapterTitles, getPassage } from '@/app/lib/corpus';
import { commentaryAuthors, commentaryDescriptor, commentaryLang, getAuthorChapterCommentaries, type Commentary } from '@/app/lib/commentaries';
import { Breadcrumbs } from '@/components/breadcrumbs';

type Props = { params: Promise<{ author: string; chapter: string }> };

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  const values = await params;
  const author = commentaryAuthors.find((item) => item.id === values.author && item.publicFields.length);
  const title = chapterTitles[Number(values.chapter) - 1];
  return author && title ? { title: `${author.displayName} on Chapter ${values.chapter}`, description: `${author.displayName}'s supplied translations and commentaries on ${title[0]}.`, alternates: { canonical: `/gita/commentaries/${author.id}/${values.chapter}` } } : {};
}

export default async function CommentaryChapterPage({ params }: Props) {
  const values = await params;
  const chapter = Number(values.chapter);
  const author = commentaryAuthors.find((item) => item.id === values.author && item.publicFields.length);
  if (!author || !Number.isInteger(chapter) || chapter < 1 || chapter > 18) notFound();
  const commentaries = await getAuthorChapterCommentaries(author.id, chapter);
  const byVerse = new Map<number, Commentary[]>();
  for (const commentary of commentaries) byVerse.set(commentary.verse, [...(byVerse.get(commentary.verse) ?? []), commentary]);
  const [title, subtitle] = chapterTitles[chapter - 1];
  return (
    <main className="shell page-shell commentary-chapter-page">
      <Breadcrumbs items={[{ label: 'Gita commentaries', href: '/gita/commentaries' }, { label: author.displayName, href: `/gita/commentaries/${author.id}` }, { label: `Chapter ${chapter}` }]} />
      <header className="page-header chapter-header"><div className="chapter-kicker">{author.displayName} · Chapter {String(chapter).padStart(2, '0')}</div><h1>{title}</h1><p>{subtitle}</p><span>{commentaries.length} aligned readings</span></header>
      {commentaries.length ? <div className="commentary-reading-list">{[...byVerse.entries()].sort(([left], [right]) => left - right).map(([verse, records]) => {
        const passage = getPassage(chapter, verse);
        return <article key={verse} id={`verse-${verse}`}><div className="commentary-reading-ref"><a href={`/gita/${chapter}/${verse}`}>{chapter}.{verse}</a><span>{passage?.speaker}</span></div>{passage ? <p className="commentary-root" lang="sa-Deva">{passage.representations.devanagari}</p> : null}<div className="commentary-reading-witnesses">{records.map((commentary) => <section key={commentary.id}><span className="eyebrow">{commentaryDescriptor(commentary)}</span><p className="commentary-reading-text" lang={commentaryLang(commentary)}>{commentary.content}</p></section>)}</div><a className="text-link" href={`/gita/${chapter}/${verse}#commentaries`}>Compare every reading of this verse →</a></article>;
      })}</div> : <div className="empty-state"><p>Readings for this chapter are temporarily unavailable.</p></div>}
      <nav className="chapter-navigation" aria-label="Commentary chapter navigation">{chapter > 1 ? <a href={`/gita/commentaries/${author.id}/${chapter - 1}`}>← Chapter {chapter - 1}</a> : <span />}{chapter < 18 ? <a href={`/gita/commentaries/${author.id}/${chapter + 1}`}>Chapter {chapter + 1} →</a> : <a href={`/gita/commentaries/${author.id}`}>All chapters</a>}</nav>
    </main>
  );
}
