import type { ChapterTranslationSearchResult } from '@/app/lib/translations';
import { HighlightedExcerpt } from '@/components/highlighted-excerpt';

export function TranslationSearchCard({ result }: { result: ChapterTranslationSearchResult }) {
  const href = `/gita/translations/${result.translationId}/${result.chapter.chapter}`;
  return (
    <article className="passage-card passage-compact">
      <a className="passage-ref" href={href}><span>Chapter {result.chapter.chapter}</span><span>{result.translator}</span></a>
      <div className="match-evidence">
        <div><span>English translation · chapter</span><span>{result.kind === 'exact' ? 'Exact word' : 'Compound form'}</span></div>
        <p lang="en"><HighlightedExcerpt text={result.chapter.text} ranges={result.ranges} /></p>
      </div>
      <p className="alignment-note">Chapter-level translation. Verse alignment has not been verified.</p>
      <a className="text-link" href={href}>Read the chapter →</a>
    </article>
  );
}
