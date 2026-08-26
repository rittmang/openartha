import type { Passage, PassageSearchResult, SearchHit } from '@/app/lib/corpus';

function excerptForHit(hit: SearchHit, maximumLength = 180) {
  const firstRange = hit.ranges[0];
  if (!firstRange || hit.text.length <= maximumLength) {
    return { text: hit.text, ranges: hit.ranges, prefix: false, suffix: false };
  }

  let start = Math.max(0, firstRange.start - Math.floor(maximumLength * 0.38));
  let end = Math.min(hit.text.length, start + maximumLength);
  if (end === hit.text.length) start = Math.max(0, end - maximumLength);
  const firstSpace = hit.text.indexOf(' ', start);
  if (start > 0 && firstSpace > start && firstSpace < firstRange.start) start = firstSpace + 1;
  const lastSpace = hit.text.lastIndexOf(' ', end);
  if (end < hit.text.length && lastSpace > firstRange.end) end = lastSpace;

  return {
    text: hit.text.slice(start, end),
    ranges: hit.ranges
      .filter((range) => range.end > start && range.start < end)
      .map((range) => ({ start: Math.max(0, range.start - start), end: Math.min(end, range.end) - start })),
    prefix: start > 0,
    suffix: end < hit.text.length,
  };
}

function HighlightedExcerpt({ hit }: { hit: SearchHit }) {
  const excerpt = excerptForHit(hit);
  const content = [];
  let cursor = 0;
  for (const [index, range] of excerpt.ranges.entries()) {
    if (range.start > cursor) content.push(excerpt.text.slice(cursor, range.start));
    content.push(<mark key={`${range.start}-${range.end}-${index}`}>{excerpt.text.slice(range.start, range.end)}</mark>);
    cursor = range.end;
  }
  if (cursor < excerpt.text.length) content.push(excerpt.text.slice(cursor));

  return <>{excerpt.prefix ? '…' : ''}{content}{excerpt.suffix ? '…' : ''}</>;
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
        Open passage <span aria-hidden="true">→</span>
      </a>
    </article>
  );
}
