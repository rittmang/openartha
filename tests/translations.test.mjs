import assert from 'node:assert/strict';
import { createHash } from 'node:crypto';
import { readFile } from 'node:fs/promises';
import test from 'node:test';
import { DatabaseSync } from 'node:sqlite';
import { parseGutenbergTranslation } from '../scripts/lib/parse-gutenberg-translation.mjs';
import { alignArnoldTranslation } from '../scripts/lib/align-arnold-translation.mjs';
import { attachArnoldFirstReview } from '../scripts/lib/arnold-review.mjs';

const corpusDir = new URL('../corpus/gita-translations/edwin-arnold/', import.meta.url);
const translation = JSON.parse(await readFile(new URL('translation.json', corpusDir), 'utf8'));
const sourceMetadata = JSON.parse(await readFile(new URL('source.json', corpusDir), 'utf8'));
const alignment = JSON.parse(await readFile(new URL('alignment.json', corpusDir), 'utf8'));
const canonical = JSON.parse(await readFile(new URL('../corpus/gita/gita.json', import.meta.url), 'utf8'));
const raw = await readFile(new URL('source/pg2388.txt', corpusDir));
const text = raw.toString('utf8');
const sha256 = (value) => createHash('sha256').update(value).digest('hex');
const releaseDir = new URL(`../public/data/${translation.corpusVersion}/`, import.meta.url);

test('Arnold source retains its identity, original bytes, credits, and full license', async () => {
  assert.equal(translation.source.ebookNumber, 2388);
  assert.equal(translation.translator, 'Sir Edwin Arnold');
  assert.equal(translation.editionYear, 1900);
  assert.equal(translation.source.rights, 'Public domain in the USA');
  assert.equal(sha256(raw), translation.source.sha256);
  assert.deepEqual(await readFile(new URL('pg2388.txt', releaseDir)), raw);
  assert.match(text, /Produced by J\. C\. Byers/);
  assert.match(text, /FULL PROJECT GUTENBERG™ LICENSE/);
  assert.match(text, /Truslove, Hanson & Comba, Ltd\.[\s\S]*?1900/);
  const metadata = { ...translation };
  delete metadata.schemaVersion;
  delete metadata.chapters;
  delete metadata.notes;
  delete metadata.verses;
  delete metadata.paratext;
  delete metadata.firstReview;
  assert.deepEqual(metadata, sourceMetadata);
});

test('all 18 Arnold chapters match their exact source lines and preserve colophons', () => {
  assert.equal(translation.granularity, 'verse');
  assert.match(translation.alignmentStatus, /Verse-aligned/);
  assert.match(translation.reviewStatus, translation.firstReview ? /second review pending/ : /independent review pending/);
  assert.deepEqual(translation.chapters.map((chapter) => chapter.chapter), Array.from({ length: 18 }, (_, index) => index + 1));
  assert.equal(new Set(translation.chapters.map((chapter) => chapter.id)).size, 18);
  const lines = text.replace(/^\uFEFF/, '').replace(/\r\n?/g, '\n').split('\n');
  for (const chapter of translation.chapters) {
    assert.equal(chapter.text, lines.slice(chapter.sourceLocator.lineStart - 1, chapter.sourceLocator.lineEnd).join('\n'));
    assert.equal(chapter.checksum, sha256(chapter.text));
    assert.match(chapter.text, /HERE END(?:ETH|S)/);
    assert.doesNotMatch(chapter.text, /START OF THE PROJECT|END OF THE PROJECT|\n\[FN#\d+\]/);
    assert.equal('verse' in chapter, false);
  }
  const parsed = parseGutenbergTranslation(text);
  assert.deepEqual(parsed.chapters, translation.chapters.map((record) => {
    const chapter = { ...record };
    delete chapter.id;
    delete chapter.checksum;
    return chapter;
  }));
  assert.deepEqual(parsed.notes, translation.notes);
  assert.match(translation.chapters[0].text, /Ranged thus for battle on the sacred plain/);
  assert.match(translation.chapters.at(-1).text, /Where this song comes of Arjun, and how with God he spake/);
});

test('all 37 translator notes and source marker anomalies remain intact', () => {
  assert.deepEqual(translation.notes.map((note) => note.number), Array.from({ length: 37 }, (_, index) => index + 1));
  assert.ok(translation.notes.every((note) => note.text.trim()));
  assert.match(translation.chapters[7].text, /\[FN#14\]/);
  assert.doesNotMatch(translation.chapters[7].text, /\[FN#15\]/);
  assert.match(translation.chapters[9].text, /\[FN#l6\]/);
  assert.match(translation.notes[14].text, /discarded ten lines/);
  assert.match(translation.notes[15].text, /change of metre/);
  assert.match(translation.notes[36].text, /omit the concluding shlokas/);
});

test('import rejects missing or reordered chapters and missing translator notes', () => {
  assert.throws(() => parseGutenbergTranslation(text.replace('CHAPTER XVIII\r', 'CHAPTER XIX\r')), /18 chapter headings/);
  assert.throws(() => parseGutenbergTranslation(text.replace('[FN#37]  I omit', '[FN#38]  I omit')), /37 translator notes/);
  assert.throws(() => parseGutenbergTranslation(text.replace('*** END OF THE PROJECT', '*** MISSING END OF THE PROJECT')), /text boundaries/);
});

test('Arnold download manifest and every published checksum match the files', async () => {
  const manifest = JSON.parse(await readFile(new URL('manifest.json', releaseDir), 'utf8'));
  assert.equal(manifest.granularity, 'verse');
  assert.equal(manifest.chapters, 18);
  assert.equal(manifest.translatorNotes, 37);
  assert.equal(manifest.sourceSha256, sha256(raw));
  assert.deepEqual(JSON.parse(await readFile(new URL('translation.json', releaseDir), 'utf8')), translation);
  for (const file of manifest.files) {
    const data = await readFile(new URL(file.name, releaseDir));
    assert.equal(file.bytes, data.byteLength);
    assert.equal(file.sha256, sha256(data));
  }
  const checksums = await readFile(new URL('checksums.sha256', releaseDir), 'utf8');
  for (const line of checksums.trim().split('\n')) {
    const [checksum, name] = line.split('  ');
    assert.equal(checksum, sha256(await readFile(new URL(name, releaseDir))));
  }
});

test('all 700 canonical verse records bind their exact source spans and actual review provenance', async () => {
  assert.deepEqual(translation.verses.map((verse) => verse.canonicalRef), canonical.verses.map((verse) => verse.canonicalRef));
  for (const verse of translation.verses) {
    const chapter = translation.chapters[verse.chapter - 1];
    const original = verse.alignment.sourceSpans.map((span) => {
      const value = chapter.text.slice(span.start, span.end);
      assert.equal(sha256(value), span.checksum);
      return value;
    }).join('');
    assert.equal(verse.content, original.trim(), verse.canonicalRef);
    assert.equal(verse.rawChecksum, sha256(original));
    assert.equal(verse.checksum, sha256(verse.content));
    assert.equal(verse.alignment.review.reviewerModel, 'gpt-6.1-sol');
    assert.equal(verse.alignment.review.status, 'model-aligned; independent review pending');
    assert.ok(verse.alignment.references.includes(verse.canonicalRef));
  }
  const jsonl = (await readFile(new URL('verses.jsonl', releaseDir), 'utf8')).trim().split('\n').map((line) => JSON.parse(line));
  assert.deepEqual(jsonl, translation.verses);
  const parsed = parseGutenbergTranslation(text);
  const aligned = alignArnoldTranslation(parsed, alignment, canonical, sourceMetadata);
  if (translation.firstReview) {
    const firstReview = JSON.parse(await readFile(new URL('../research/arnold-first-review/first-review.json', import.meta.url), 'utf8'));
    assert.deepEqual(attachArnoldFirstReview(aligned.verses, firstReview), translation.verses);
  } else assert.deepEqual(aligned.verses, translation.verses);
  assert.deepEqual(aligned.paratext, translation.paratext);
});

test('known semantic anchors fall on their canonical verses across every chapter', () => {
  const anchors = {
    '1.1': 'Ranged thus for battle', '1.47': 'Arjuna sank upon his chariot-seat',
    '2.20': 'Never the spirit was born', '2.47': 'Let right deeds be', '2.72': 'That is the state of Brahm',
    '3.8': 'Do thine allotted task', '3.35': 'His own task',
    '4.7': 'When Righteousness', '4.24': "All's then God", '4.33': 'Which Knowledge pays',
    '5.10': 'lotus-leaf', '6.19': 'lamp burns sheltered from the wind', '6.38': 'Like the vain cloud',
    '7.7': 'row of pearls', '8.1': 'Who is that BRAHMA', '8.22': 'And, Prince! by faith', '8.28': 'Richer than holy fruit',
    '9.26': 'A leaf, a flower, a fruit', '10.21': 'Vishnu of the Adityas', '10.33': 'Dwandwa',
    '11.32': 'Time who kills', '11.55': 'Who doeth all for Me',
    '12.13': 'Who hateth nought', '13.1': 'Is Kshetra', '13.2': 'I am Kshetrajna', '13.34': 'eye of wisdom',
    '14.27': 'perfect Felicity', '15.16': 'Being is twofold', '16.21': 'The Doors of Hell',
    '16.22': 'three gates of Narak', '17.22': 'The gift churlishly flung',
    '18.45': 'Whoso performeth', '18.66': 'Fly to Me alone', '18.78': 'O Archer-Prince',
  };
  for (const [reference, phrase] of Object.entries(anchors)) {
    assert.ok(translation.verses.find((verse) => verse.canonicalRef === `gita.${reference}`)?.content.includes(phrase), `${reference}: ${phrase}`);
  }
});

test('omissions, combined renderings, Chapter 13 prelude, and colophons remain explicit', () => {
  const omitted = ['1.43', '8.23', '8.24', '8.25', '8.26', '8.27', '13.4', '15.15', '16.23', '16.24', '17.23', '17.24', '17.25', '17.26', '17.27', '17.28'];
  assert.deepEqual(translation.verses.filter((verse) => !verse.content).map((verse) => verse.canonicalRef), omitted.map((ref) => `gita.${ref}`));
  for (const record of translation.verses.filter((verse) => !verse.content)) {
    assert.equal(record.alignmentRelation, 'source-omission');
    assert.ok(record.alignment.note);
    assert.deepEqual(record.alignment.sourceSpans, []);
  }
  const shared = translation.verses.filter((verse) => verse.alignmentRelation === 'shared-source-span');
  assert.equal(shared.length, 8);
  assert.equal(new Set(shared.map((verse) => verse.alignment.id)).size, 4);
  assert.equal(translation.paratext.filter((item) => item.type === 'chapter-colophon').length, 18);
  const prelude = translation.paratext.find((item) => item.type === 'recensional-prelude');
  assert.equal(prelude.chapter, 13);
  assert.match(prelude.text, /Arjuna/);
  assert.doesNotMatch(translation.verses.find((verse) => verse.canonicalRef === 'gita.13.1').content, /Now would I hear/);
});

test('alignment validation rejects a changed source, missing verse, and dropped source text', () => {
  const parsed = parseGutenbergTranslation(text);
  const changed = structuredClone(alignment);
  changed.sourceSha256 = 'untrusted';
  assert.throws(() => alignArnoldTranslation(parsed, changed, canonical, sourceMetadata), /exact source snapshot/);
  const missing = structuredClone(alignment);
  missing.chapters[0].segments.splice(1, 1);
  assert.throws(() => alignArnoldTranslation(parsed, missing, canonical, sourceMetadata), /Every verse/);
  const dropped = structuredClone(alignment);
  dropped.chapters[0].segments[0][1] = 2;
  assert.throws(() => alignArnoldTranslation(parsed, dropped, canonical, sourceMetadata), /Unaccounted source/);
});

test('D1 migration registers Arnold in the existing schema and FTS without changing other editions', async () => {
  const db = new DatabaseSync(':memory:');
  try {
    db.exec('PRAGMA foreign_keys=ON; CREATE TABLE passages(id TEXT PRIMARY KEY);');
    const passage = db.prepare('INSERT INTO passages (id) VALUES (?)');
    for (const verse of canonical.verses) passage.run(verse.canonicalRef);
    db.exec(await readFile(new URL('../drizzle/0002_commentary_schema.sql', import.meta.url), 'utf8'));
    db.exec("INSERT INTO commentary_sources VALUES ('control','Control source','https://example.org','pinned','Control rights','https://example.org/license','control-v1'); INSERT INTO commentary_authors VALUES ('control','control','Control author','[\"et\"]','[\"et\"]','full-text-allowed','Control rights'); INSERT INTO commentary_editions VALUES ('control-et','control','control','et','en','Latn','translation',1,'full-text-allowed','control-v1'); INSERT INTO commentary_units VALUES ('control-1','control-et','gita.1.1',1,1,'passage-commentary','same-number','pending','control','raw','display'); INSERT INTO commentary_unit_chunks VALUES ('control-1',0,'Unchanged control reading'); INSERT INTO commentary_fts VALUES ('control-1','Control author','gita.1.1','en','translation','Unchanged control reading');");
    const journal = JSON.parse(await readFile(new URL('../drizzle/meta/_journal.json', import.meta.url), 'utf8'));
    assert.equal(new Set(journal.entries.map((entry) => entry.tag.slice(0, 4))).size, journal.entries.length, 'Migration ordinals must be unique');
    const migrationTag = translation.firstReview ? '0044_review_edwin_arnold_v100' : '0043_seed_edwin_arnold_v100';
    assert.equal(journal.entries.at(-1).tag, migrationTag);
    db.exec(await readFile(new URL('../drizzle/0043_seed_edwin_arnold_v100.sql', import.meta.url), 'utf8'));
    const seed = await readFile(new URL(`../drizzle/${migrationTag}.sql`, import.meta.url), 'utf8');
    db.exec(seed);
    db.exec(seed);
    assert.equal(db.prepare("SELECT count(*) AS total FROM commentary_units WHERE edition_id = 'edwin-arnold-et' AND passage_id IS NOT NULL").get().total, 700);
    assert.equal(db.prepare("SELECT count(*) AS total FROM commentary_fts WHERE author = 'Sir Edwin Arnold'").get().total, 684);
    assert.equal(db.prepare("SELECT content FROM commentary_unit_chunks WHERE unit_id = 'control-1'").get().content, 'Unchanged control reading');
    assert.equal(db.prepare("SELECT count(*) AS total FROM commentary_fts WHERE author = 'Control author'").get().total, 1);
    assert.equal(db.prepare("SELECT license FROM commentary_sources WHERE id = 'gutenberg-2388'").get().license, 'Public domain in the USA');
    if (translation.firstReview) assert.match(db.prepare("SELECT rights_note FROM commentary_authors WHERE id = 'edwin-arnold'").get().rights_note, /Gemini 3\.8 Flash/);
    const lookup = db.prepare("SELECT content FROM commentary_unit_chunks WHERE unit_id = ?");
    const status = db.prepare('SELECT alignment_status FROM commentary_units WHERE id = ?');
    for (const verse of translation.verses) {
      assert.equal(lookup.get(verse.id).content, verse.content);
      assert.equal(status.get(verse.id).alignment_status, verse.alignmentStatus);
    }
    const hits = db.prepare("SELECT canonical_ref FROM commentary_fts WHERE commentary_fts MATCH ?").all('"right deeds"');
    assert.ok(hits.some((hit) => hit.canonical_ref === 'gita.2.47'));
    assert.deepEqual(db.prepare('PRAGMA foreign_key_check').all(), []);
  } finally { db.close(); }
});
