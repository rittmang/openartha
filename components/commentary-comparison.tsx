import type { Commentary } from '@/app/lib/commentaries';

export function CommentaryComparison({ commentaries, selectedIds }: { commentaries: Commentary[]; selectedIds: string[] }) {
  const selected = selectedIds.flatMap((id) => commentaries.find((commentary) => commentary.authorId === id) ?? []).slice(0, 3);
  return (
    <section className="commentary-panel" id="commentaries" aria-labelledby="commentaries-title">
      <div className="commentary-heading">
        <div><span className="eyebrow">Classical witnesses</span><h2 id="commentaries-title">Compare commentary</h2></div>
        <p>{commentaries.length} Sanskrit commentaries are aligned to this verse. Choose up to three; the root verse and Telang witness stay above them.</p>
      </div>
      <form className="comparison-form" method="get">
        {[0, 1, 2].map((slot) => (
          <label key={slot}>Witness {slot + 1}<select name="compare" defaultValue={selected[slot]?.authorId ?? ''}><option value="">None</option>{commentaries.map((commentary) => <option key={commentary.authorId} value={commentary.authorId}>{commentary.author}</option>)}</select></label>
        ))}
        <button className="button button-secondary" type="submit">Update comparison</button>
      </form>
      <div className={`commentary-comparison commentary-columns-${Math.max(selected.length, 1)}`}>
        {selected.map((commentary) => (
          <article key={commentary.id} className="commentary-card">
            <div className="commentary-card-heading"><div><span>Sanskrit commentary</span><h3>{commentary.author}</h3></div><a href={`/commentaries/${commentary.authorId}/${commentary.chapter}`}>Read chapter →</a></div>
            <p lang="sa-Deva">{commentary.content}</p>
            <dl><div><dt>Alignment</dt><dd>{commentary.alignmentStatus}</dd></div><div><dt>Checksum</dt><dd><code>{commentary.checksum.slice(0, 12)}…</code></dd></div></dl>
          </article>
        ))}
      </div>
      {!selected.length ? <p className="empty-state">Choose one or more witnesses to compare.</p> : null}
      <p className="commentary-rights-note">Classical Sanskrit source texts are public domain. These digital transcriptions come from the pinned VedicScriptures dataset under GPL-3.0 and await independent alignment review.</p>
    </section>
  );
}
