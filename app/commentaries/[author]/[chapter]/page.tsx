import type { Metadata } from 'next';
import { notFound } from 'next/navigation';
import { chapterTitles, getPassage } from '@/app/lib/corpus';
import { commentaryAuthors, getAuthorChapterCommentaries } from '@/app/lib/commentaries';
import { Breadcrumbs } from '@/components/breadcrumbs';

type Props = { params: Promise<{ author: string; chapter: string }> };

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  const values = await params;
  const author = commentaryAuthors.find((item) => item.id === values.author && item.publicFields.length);
  const title = chapterTitles[Number(values.chapter) - 1];
  return author && title ? { title: `${author.displayName} on Chapter ${values.chapter}`, description: `${author.displayName}'s Sanskrit commentary on ${title[0]}.` } : {};
}

export default async function CommentaryChapterPage({ params }: Props) {
  const values = await params;
  const chapter = Number(values.chapter);
  const author = commentaryAuthors.find((item) => item.id === values.author && item.publicFields.length);
  if (!author || !Number.isInteger(chapter) || chapter < 1 || chapter > 18) notFound();
  const commentaries = await getAuthorChapterCommentaries(author.id, chapter);
  const [title, subtitle] = chapterTitles[chapter - 1];
  return (
    <main className="shell page-shell commentary-chapter-page">
      <Breadcrumbs items={[{ label: 'Commentaries', href: '/commentaries' }, { label: author.displayName, href: `/commentaries/${author.id}` }, { label: `Chapter ${chapter}` }]} />
      <header className="page-header chapter-header"><div className="chapter-kicker">{author.displayName} · Chapter {String(chapter).padStart(2, '0')}</div><h1>{title}</h1><p>{subtitle}</p><span>{commentaries.length} aligned units</span></header>
      {commentaries.length ? <div className="commentary-reading-list">{commentaries.map((commentary) => {
        const passage = getPassage(commentary.chapter, commentary.verse);
        return <article key={commentary.id} id={`verse-${commentary.verse}`}><div className="commentary-reading-ref"><a href={`/gita/${chapter}/${commentary.verse}`}>{chapter}.{commentary.verse}</a><span>{passage?.speaker}</span></div>{passage ? <p className="commentary-root" lang="sa-Deva">{passage.representations.devanagari}</p> : null}<p className="commentary-reading-text" lang="sa-Deva">{commentary.content}</p><a className="text-link" href={`/gita/${chapter}/${commentary.verse}#commentaries`}>Compare this verse →</a></article>;
      })}</div> : <div className="empty-state"><p>The commentary database is unavailable for this chapter.</p></div>}
      <nav className="chapter-navigation" aria-label="Commentary chapter navigation">{chapter > 1 ? <a href={`/commentaries/${author.id}/${chapter - 1}`}>← Chapter {chapter - 1}</a> : <span />}{chapter < 18 ? <a href={`/commentaries/${author.id}/${chapter + 1}`}>Chapter {chapter + 1} →</a> : <a href={`/commentaries/${author.id}`}>All chapters</a>}</nav>
    </main>
  );
}
