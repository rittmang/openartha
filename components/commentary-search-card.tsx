import type { CommentarySearchResult } from '@/app/lib/commentaries';
import { HighlightedExcerpt } from '@/components/highlighted-excerpt';

export function CommentarySearchCard({ result }: { result: CommentarySearchResult }) {
  return (
    <article className="passage-card passage-compact commentary-search-card">
      <a className="passage-ref" href={`/gita/${result.chapter}/${result.verse}#commentaries`}>
        <span>{result.chapter}.{result.verse}</span>
        <span>{result.author}</span>
      </a>
      <div className="match-evidence">
        <div><span>Commentary · Sanskrit</span><span>{result.kind === 'exact' ? 'Exact word' : 'Compound form'}</span></div>
        <p lang="sa-Deva"><HighlightedExcerpt text={result.content} ranges={result.ranges} /></p>
      </div>
      <dl className="search-result-meta">
        <div><dt>Witness</dt><dd>{result.author}</dd></div>
        <div><dt>Status</dt><dd>Machine-aligned · review pending</dd></div>
      </dl>
      <a className="text-link" href={`/gita/${result.chapter}/${result.verse}#commentaries`}>
        Open with commentary <span aria-hidden="true">→</span>
      </a>
    </article>
  );
}
