import Link from 'next/link';
import type { Passage } from '@/app/lib/corpus';

export function PassageCard({ passage, compact = false }: { passage: Passage; compact?: boolean }) {
  return (
    <article className={`passage-card${compact ? ' passage-compact' : ''}`}>
      <Link className="passage-ref" href={`/gita/${passage.chapter}/${passage.verse}`}>
        <span>{passage.chapter}.{passage.verse}</span>
        <span>{passage.speaker}</span>
      </Link>
      <p className="passage-devanagari" lang="sa-Deva">{passage.representations.devanagari}</p>
      {!compact && <p className="passage-iast" lang="sa-Latn">{passage.representations.iast}</p>}
      <p className="passage-english">{passage.representations.english}</p>
      <Link className="text-link" href={`/gita/${passage.chapter}/${passage.verse}`} aria-label={`Open Bhagavad Gita ${passage.chapter}.${passage.verse}`}>
        Open passage <span aria-hidden="true">→</span>
      </Link>
    </article>
  );
}
