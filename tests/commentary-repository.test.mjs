import assert from 'node:assert/strict';
import { createHash } from 'node:crypto';
import { readFile } from 'node:fs/promises';
import { DatabaseSync } from 'node:sqlite';
import test from 'node:test';
import { getPassageReadingRows, getAuthorChapterReadingRows, searchReadingRows, toCommentary } from '../app/lib/commentary-repository.ts';
import { commentaryReviewReleaseSql } from '../scripts/lib/commentary-review-release.mjs';
import { commentaryReviewSummary } from '../app/lib/commentary-review.ts';

const root = new URL('../', import.meta.url);
const canonical = JSON.parse(await readFile(new URL('corpus/gita/gita.json', root), 'utf8'));
const translation = JSON.parse(await readFile(new URL('corpus/gita-translations/edwin-arnold/translation.json', root), 'utf8'));
const schema = await readFile(new URL('drizzle/0002_commentary_schema.sql', root), 'utf8');
const seed = await readFile(new URL('drizzle/0044_review_edwin_arnold_v100.sql', root), 'utf8');
const sha256 = (text) => createHash('sha256').update(text).digest('hex');

function fixture(t) {
  const sqlite = new DatabaseSync(':memory:');
  t.after(() => sqlite.close());
  sqlite.exec('PRAGMA foreign_keys=ON; CREATE TABLE passages(id TEXT PRIMARY KEY, chapter INTEGER NOT NULL, verse INTEGER NOT NULL);');
  const passage = sqlite.prepare('INSERT INTO passages VALUES (?, ?, ?)');
  for (const record of canonical.verses) passage.run(record.canonicalRef, record.chapter, record.verse);
  sqlite.exec(schema);
  sqlite.exec(seed);
  sqlite.exec(`
    INSERT INTO commentary_sources VALUES ('control', 'Control source', 'https://example.org', 'pinned', 'GPL-3.0', 'https://example.org/license', 'control-v1');
    INSERT INTO commentary_authors VALUES ('control', 'control', 'Control author', '["et"]', '["et"]', 'full-text-allowed', 'GPL-3.0');
    INSERT INTO commentary_editions VALUES ('control-et', 'control', 'control', 'et', 'en', 'Latn', 'translation', 1, 'full-text-allowed', 'control-v1');
  `);
  function addControl(verse, chunks, sourceVerse = verse) {
    const id = `control-${verse}`;
    const content = chunks.join('');
    sqlite.prepare('INSERT INTO commentary_units VALUES (?, ?, ?, 1, ?, ?, ?, ?, ?, ?, ?)').run(id, 'control-et', `gita.1.${verse}`, sourceVerse, 'passage-commentary', 'same-number', 'pending', `control:1.${sourceVerse}`, sha256(content), sha256(content));
    // Insertion order intentionally differs from reading order.
    for (let index = chunks.length - 1; index >= 0; index--) {
      sqlite.prepare('INSERT INTO commentary_unit_chunks VALUES (?, ?, ?)').run(id, index, chunks[index]);
      sqlite.prepare('INSERT INTO commentary_fts VALUES (?, ?, ?, ?, ?, ?)').run(id, 'Control author', `gita.1.${verse}`, 'en', 'translation', chunks[index]);
    }
    return { id, content };
  }
  const db = {
    prepare(sql) {
      return {
        bind(...args) {
          return { async all() { return { results: sqlite.prepare(sql).all(...args) }; } };
        },
      };
    },
  };
  return { sqlite, db, addControl };
}

test('all 700 Arnold records use the shared chapter query and retain their exact D1 text and provenance', async (t) => {
  const { db, addControl } = fixture(t);
  addControl(1, ['Another author uses the same query.']);
  const metadata = new Map(translation.verses.map((record) => [record.id, record]));
  const actual = [];
  for (let chapter = 1; chapter <= 18; chapter++) {
    const rows = await getAuthorChapterReadingRows(db, 'edwin-arnold', chapter);
    assert.deepEqual(rows.map((row) => row.verse), rows.map((row) => row.verse).sort((a, b) => a - b));
    actual.push(...rows.map((row) => toCommentary(row, metadata.get(row.id))));
  }
  assert.equal(actual.length, 700);
  for (let index = 0; index < actual.length; index++) {
    const expected = translation.verses[index];
    const record = actual[index];
    for (const key of ['id', 'canonicalRef', 'content', 'checksum', 'rawChecksum', 'alignmentStatus', 'alignmentRelation', 'alignment', 'firstReview', 'sourceChecksum', 'sourceCommit', 'rights']) assert.deepEqual(record[key], expected[key], `${key}: ${expected.id}`);
  }
  const passage = await getPassageReadingRows(db, 1, 1);
  assert.deepEqual(passage.map((row) => row.author_id), ['control', 'edwin-arnold']);
  assert.equal(passage.filter((row) => row.author_id === 'edwin-arnold').length, 1);
});

test('chapter queries order every author by numeric canonical verse even when source numbering differs', async (t) => {
  const { db, addControl } = fixture(t);
  addControl(10, ['Ten'], 2);
  addControl(2, ['Two'], 10);
  addControl(1, ['One']);
  const rows = await getAuthorChapterReadingRows(db, 'control', 1);
  assert.deepEqual(rows.map((row) => row.verse), [1, 2, 10]);
  assert.deepEqual(rows.map((row) => row.content), ['One', 'Two', 'Ten']);
});

test('database edits are returned instead of being replaced by pinned translation JSON', async (t) => {
  const { sqlite, db } = fixture(t);
  const original = translation.verses[0];
  const revised = 'A changed database record that has not received model review.';
  sqlite.prepare('UPDATE commentary_unit_chunks SET content = ? WHERE unit_id = ?').run(revised, original.id);
  sqlite.prepare('UPDATE commentary_units SET display_checksum = ?, alignment_status = ? WHERE id = ?').run(sha256(revised), 'pending', original.id);
  const [row] = await getPassageReadingRows(db, 1, 1);
  const record = toCommentary(row, original);
  assert.equal(record.content, revised);
  assert.equal(record.checksum, sha256(revised));
  assert.equal(record.alignmentStatus, 'pending');
  assert.equal(record.firstReview, undefined);
  assert.equal(record.alignment, undefined);
});

test('stale identity, source, version, checksum, or review state cannot inherit supplemental provenance', async (t) => {
  const { db } = fixture(t);
  const [row] = await getPassageReadingRows(db, 1, 1);
  const expected = translation.verses[0];
  assert.deepEqual(toCommentary(row, expected).firstReview, expected.firstReview);
  for (const [key, value] of Object.entries({ id: 'other', canonicalRef: 'gita.1.2', editionId: 'other', checksum: 'changed', corpusVersion: 'other', alignmentStatus: 'pending', sourceChecksum: 'other' })) {
    const record = toCommentary(row, { ...expected, [key]: value });
    assert.equal(record.content, row.content);
    assert.equal(record.firstReview, undefined, key);
    assert.equal(record.alignment, undefined, key);
  }
});

test('shared FTS search deduplicates chunk hits and reconstructs the complete stored text', async (t) => {
  const { db, addControl } = fixture(t);
  const expected = addControl(2, ['needle at the start.\n', 'needle in the middle.\n', 'needle at the end.']);
  const rows = await searchReadingRows(db, '"needle"*', 10);
  assert.equal(rows.length, 1);
  assert.equal(rows[0].id, expected.id);
  const record = toCommentary(rows[0]);
  assert.equal(record.content, expected.content);
  assert.equal(record.checksum, sha256(record.content));
  assert.deepEqual(await searchReadingRows(db, '"no-such-word"', 10), []);
});

test('Arnold is found through the same FTS index and full-record lookup as other authors', async (t) => {
  const { db, addControl } = fixture(t);
  addControl(1, ['A separate author also writes of right deeds.']);
  const rows = await searchReadingRows(db, '"right"* AND "deeds"*', 100);
  assert.ok(rows.some((row) => row.author_id === 'control'));
  const row = rows.find((row) => row.canonical_ref === 'gita.2.47' && row.author_id === 'edwin-arnold');
  assert.ok(row);
  const expected = translation.verses.find((record) => record.id === row.id);
  const record = toCommentary(row, expected);
  assert.equal(record.content, expected.content);
  assert.deepEqual(record.firstReview, expected.firstReview);
});

test('publication visibility applies to Arnold and other authors across all retrieval methods', async (t) => {
  const { sqlite, db, addControl } = fixture(t);
  addControl(1, ['Ranged thus for battle, a control text.']);
  sqlite.exec('UPDATE commentary_editions SET public_text = 0');
  assert.deepEqual(await getPassageReadingRows(db, 1, 1), []);
  for (const author of ['control', 'edwin-arnold']) assert.deepEqual(await getAuthorChapterReadingRows(db, author, 1), []);
  assert.deepEqual(await searchReadingRows(db, '"battle"*', 100), []);
});

test('the review patch is scoped, repeatable, and preserves all text and Arnold review evidence', async (t) => {
  const { sqlite, db, addControl } = fixture(t);
  const source = JSON.parse(await readFile(new URL('corpus/gita-commentaries/source.json', root), 'utf8'));
  sqlite.prepare('INSERT INTO commentary_sources VALUES (?, ?, ?, ?, ?, ?, ?)').run(source.source.id, 'Pinned import', source.source.repository, source.source.commit, 'GPL-3.0', source.source.licenseUrl, 'gita-commentaries-0.2.0');
  sqlite.prepare("UPDATE commentary_editions SET source_id = ?, corpus_version = 'gita-commentaries-0.2.0' WHERE id = 'control-et'").run(source.source.id);
  const expected = addControl(1, ['Text remains unchanged.']);
  const sql = commentaryReviewReleaseSql(source);
  sqlite.exec(sql);
  sqlite.exec(sql);
  const rows = await getPassageReadingRows(db, 1, 1);
  const imported = toCommentary(rows.find((row) => row.id === expected.id));
  assert.equal(imported.corpusVersion, 'gita-commentaries-0.2.1');
  assert.equal(imported.alignmentStatus, 'machine-validated; human review pending');
  assert.equal(imported.content, expected.content);
  assert.equal(imported.checksum, sha256(expected.content));
  assert.equal(commentaryReviewSummary(imported), 'Machine-validated alignment; human review pending.');
  const row = rows.find((row) => row.author_id === 'edwin-arnold');
  const reviewed = toCommentary(row, translation.verses[0]);
  assert.deepEqual(reviewed.firstReview, translation.verses[0].firstReview);
  assert.match(commentaryReviewSummary(reviewed), /First model review verified/);
  sqlite.prepare('UPDATE commentary_sources SET commit_sha = ? WHERE id = ?').run('another-source', source.source.id);
  sqlite.exec("UPDATE commentary_units SET alignment_status = 'control-state' WHERE edition_id = 'control-et'");
  sqlite.exec(sql);
  assert.equal(sqlite.prepare('SELECT alignment_status FROM commentary_units WHERE id = ?').get(expected.id).alignment_status, 'control-state');
});
