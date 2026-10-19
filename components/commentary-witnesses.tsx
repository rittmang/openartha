import { commentaryReviewSummary, commentaryDescriptor, commentaryLang, type Commentary } from '@/app/lib/commentaries';

const contentTypeOrder: Record<string, number> = { translation: 0, commentary: 1 };
const languageOrder: Record<string, number> = { en: 0, hi: 1, sa: 2 };

export function CommentaryWitnesses({ commentaries }: { commentaries: Commentary[] }) {
  const readings = [...commentaries].sort((left, right) =>
    (contentTypeOrder[left.contentType] ?? 2) - (contentTypeOrder[right.contentType] ?? 2)
    || (languageOrder[left.language] ?? 3) - (languageOrder[right.language] ?? 3)
    || left.author.localeCompare(right.author),
  );

  return (
    <section className="commentary-panel" id="commentaries" aria-labelledby="commentaries-title">
      <div className="commentary-heading">
        <div><span className="eyebrow">Interpretations</span><h2 id="commentaries-title">Compare translations and commentaries</h2></div>
        <p>All {readings.length} available readings are aligned to this verse. Translations appear first, followed by commentaries; each keeps its author and source trail.</p>
      </div>
      <div className="witness-list">
        {readings.map((commentary) => (
          <article key={commentary.id} className={`witness-reading witness-reading-${commentary.contentType}`}>
            <div className="detail-section-title witness-section-title">
              <h3>{commentaryDescriptor(commentary)}</h3>
              <span>{commentary.author}</span>
            </div>
            <p className={commentary.content ? 'witness-text' : 'alignment-note'} lang={commentaryLang(commentary)}>{commentary.content || 'This verse is omitted in this translation.'}</p>
            <div className="witness-meta">
              <p>{commentaryReviewSummary(commentary)} SHA-256 <code>{commentary.checksum.slice(0, 12)}…</code></p>
              <a href={`/gita/commentaries/${commentary.authorId}/${commentary.chapter}`}>Read more from {commentary.author} →</a>
            </div>
          </article>
        ))}
      </div>
      <p className="commentary-rights-note">Each reading retains its source-specific rights and alignment review record. <a href="/sources">Sources and rights →</a></p>
    </section>
  );
}
