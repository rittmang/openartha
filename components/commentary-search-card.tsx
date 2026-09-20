import { commentaryDescriptor, commentaryLang, type CommentarySearchResult } from '@/app/lib/commentaries';
import { HighlightedExcerpt } from '@/components/highlighted-excerpt';

export function CommentarySearchCard({ result }: { result: CommentarySearchResult }) {
  return (
    <article className="passage-card passage-compact commentary-search-card">
      <a className="passage-ref" href={`/gita/${result.chapter}/${result.verse}#commentaries`}>
        <span>{result.chapter}.{result.verse}</span>
        <span>{result.author}</span>
      </a>
      <div className="match-evidence">
        <div><span>{commentaryDescriptor(result)}</span><span>{result.kind === 'exact' ? 'Exact word' : 'Compound form'}</span></div>
        <p lang={commentaryLang(result)}><HighlightedExcerpt text={result.content} ranges={result.ranges} /></p>
      </div>
      <dl className="search-result-meta">
        <div><dt>Witness</dt><dd>{result.author} · {commentaryDescriptor(result)}</dd></div>
        <div><dt>Status</dt><dd>First review (google/gemini-3.8-flash) · second review pending</dd></div>
      </dl>
      <a className="text-link" href={`/gita/${result.chapter}/${result.verse}#commentaries`}>
        Read in context <span aria-hidden="true">→</span>
      </a>
    </article>
  );
}
