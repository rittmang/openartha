import assert from 'node:assert/strict';
import { createHash } from 'node:crypto';

const sha256 = (value) => createHash('sha256').update(value).digest('hex');

export function alignArnoldTranslation(parsed, alignment, canonical, metadata) {
  assert.equal(alignment.sourceSha256, metadata.source.sha256, 'Alignment must identify the exact source snapshot');
  assert.equal(alignment.canonicalCorpusVersion, canonical.corpusVersion, 'Alignment must identify the canonical edition');
  assert.deepEqual(alignment.chapters.map((chapter) => chapter.chapter), canonical.chapterCounts.map((_, index) => index + 1));
  const verses = [];
  const groups = [];
  const paratext = [];
  for (const mapping of alignment.chapters) {
    const source = parsed.chapters[mapping.chapter - 1];
    const lines = source.text.split('\n');
    const starts = lines.map((_, index) => lines.slice(0, index).reduce((size, line) => size + line.length + 1, 0));
    function offset(position) {
      const [line, anchor] = Array.isArray(position) ? position : [position];
      assert.ok(Number.isInteger(line) && line > 0 && line <= lines.length, `Invalid source line in chapter ${mapping.chapter}: ${line}`);
      if (anchor === undefined) return starts[line - 1];
      const column = lines[line - 1].indexOf(anchor);
      assert.ok(column >= 0, `Missing anchor in chapter ${mapping.chapter}, line ${line}: ${anchor}`);
      assert.equal(lines[line - 1].indexOf(anchor, column + 1), -1, `Ambiguous anchor: ${anchor}`);
      return starts[line - 1] + column;
    }
    const colophonLine = lines.findIndex((line) => /HERE END(?:ETH|S)/.test(line));
    assert.ok(colophonLine > 0, 'Source colophon must be preserved');
    const bodyEnd = starts[colophonLine];
    const exclusions = (mapping.paratext ?? []).map((item) => ({ type: item.type, start: offset(item.from), end: offset(item.to) }));
    const lineAt = (position) => source.sourceLocator.lineStart + source.text.slice(0, position).split('\n').length - 1;
    function sourceSpan(start, end) {
      assert.ok(end > start, 'Source spans must be nonempty');
      return { start, end, lineStart: lineAt(start), lineEnd: lineAt(end - 1), checksum: sha256(source.text.slice(start, end)) };
    }
    const coverage = new Uint8Array(source.text.length);
    function claim(start, end) {
      for (let index = start; index < end; index++) {
        assert.equal(coverage[index], 0, `Overlapping source character at ${mapping.chapter}:${index}`);
        coverage[index] = 1;
      }
    }
    for (const item of [...exclusions, { type: 'chapter-colophon', start: bodyEnd, end: source.text.length }]) {
      claim(item.start, item.end);
      const content = source.text.slice(item.start, item.end).trim();
      paratext.push({ chapter: mapping.chapter, type: item.type, text: content, checksum: sha256(content), sourceSpan: sourceSpan(item.start, item.end) });
    }
    const seenVerses = [];
    const positions = mapping.segments.map(([, position]) => position === null ? null : offset(position));
    for (const [index, [range, position, note]] of mapping.segments.entries()) {
      const [first, last = first] = range.split('-').map(Number);
      assert.ok(first >= 1 && last >= first && last <= canonical.chapterCounts[mapping.chapter - 1], `Invalid canonical range ${mapping.chapter}.${range}`);
      const references = Array.from({ length: last - first + 1 }, (_, n) => `gita.${mapping.chapter}.${first + n}`);
      const spans = [];
      if (position !== null) {
        const start = positions[index];
        const end = positions.slice(index + 1).find((value) => value !== null) ?? bodyEnd;
        assert.ok(start < end && end <= bodyEnd, `Unordered boundary at ${mapping.chapter}.${range}`);
        let cursor = start;
        for (const exclusion of exclusions.filter((item) => item.end > start && item.start < end).sort((a, b) => a.start - b.start)) {
          if (exclusion.start > cursor) spans.push(sourceSpan(cursor, exclusion.start));
          cursor = Math.max(cursor, exclusion.end);
        }
        if (cursor < end) spans.push(sourceSpan(cursor, end));
        for (const span of spans) claim(span.start, span.end);
      } else assert.ok(note, 'Every omission requires a source-specific explanation');
      const rawContent = spans.map((span) => source.text.slice(span.start, span.end)).join('');
      const content = rawContent.trim();
      if (position !== null) assert.ok(content, `Empty rendering at ${mapping.chapter}.${range}`);
      const relation = position === null ? 'source-omission' : first === last ? 'semantic-verse-alignment' : 'shared-source-span';
      const group = { id: `arnold.${mapping.chapter}.${range}`, chapter: mapping.chapter, references, relation, sourceSpans: spans, note: note ?? null };
      groups.push(group);
      for (let verse = first; verse <= last; verse++) {
        seenVerses.push(verse);
        verses.push({
          id: `edwin-arnold-et:gita.${mapping.chapter}.${verse}`,
          canonicalRef: `gita.${mapping.chapter}.${verse}`,
          chapter: mapping.chapter,
          verse,
          authorId: metadata.id,
          author: metadata.translator,
          editionId: 'edwin-arnold-et',
          fieldCode: 'et',
          language: 'en',
          script: 'Latn',
          contentType: 'translation',
          content,
          sourceLocator: spans.length ? `pg2388.txt:${spans.map((span) => `L${span.lineStart}–L${span.lineEnd}`).join(',')}` : `pg2388.txt:${source.sourceHeading}:source-omission`,
          sourceUrl: metadata.source.catalogUrl,
          sourceCommit: '',
          sourceChecksum: metadata.source.sha256,
          rights: metadata.source.rights,
          alignmentStatus: alignment.review.status,
          alignmentRelation: relation,
          alignment: { ...group, review: alignment.review },
          rawChecksum: sha256(rawContent),
          checksum: sha256(content),
          corpusVersion: metadata.corpusVersion,
        });
      }
    }
    assert.deepEqual(seenVerses, Array.from({ length: canonical.chapterCounts[mapping.chapter - 1] }, (_, index) => index + 1), `Every verse in chapter ${mapping.chapter} must occur exactly once, in order`);
    assert.ok(coverage.every(Boolean), `Unaccounted source characters in chapter ${mapping.chapter}`);
  }
  assert.equal(verses.length, 700);
  return { verses, groups, paratext };
}
