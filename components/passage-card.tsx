import type { Passage, PassageSearchResult, SearchHit } from '@/app/lib/corpus';
import { HighlightedExcerpt as SearchHighlightedExcerpt } from '@/components/highlighted-excerpt';

function HighlightedExcerpt({ hit }: { hit: SearchHit }) {
  return <SearchHighlightedExcerpt text={hit.text} ranges={hit.ranges} maximumLength={180} />;
}

export function PassageCard({ passage, compact = false, match }: { passage: Passage; compact?: boolean; match?: PassageSearchResult<Passage> }) {
  return (
    <article className={`passage-card${compact ? ' passage-compact' : ''}`}>
      <a className="passage-ref" href={`/gita/${passage.chapter}/${passage.verse}`}>
        <span>{passage.chapter}.{passage.verse}</span>
        <span>{passage.speaker}</span>
      </a>
      {match?.hits.slice(0, 2).map((hit) => (
        <div className="match-evidence" key={hit.field}>
          <div><span>Matched in {hit.label}</span><span>{match.kind === 'exact' ? 'Exact word' : 'Compound form'}</span></div>
          <p lang={hit.field === 'devanagari' ? 'sa-Deva' : hit.field === 'iast' ? 'sa-Latn' : undefined}>
            <HighlightedExcerpt hit={hit} />
          </p>
        </div>
      ))}
      <p className="passage-devanagari" lang="sa-Deva">{passage.representations.devanagari}</p>
      {!compact && <p className="passage-iast" lang="sa-Latn">{passage.representations.iast}</p>}
      <p className="passage-english">{passage.representations.english}</p>
      <a className="text-link" href={`/gita/${passage.chapter}/${passage.verse}`} aria-label={`Open Bhagavad Gita ${passage.chapter}.${passage.verse}`}>
        Read verse <span aria-hidden="true">→</span>
      </a>
    </article>
  );
}
