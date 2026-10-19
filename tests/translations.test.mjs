import assert from 'node:assert/strict';
import { createHash } from 'node:crypto';
import { readFile } from 'node:fs/promises';
import test from 'node:test';
import { parseGutenbergTranslation } from '../scripts/lib/parse-gutenberg-translation.mjs';
import { searchTranslationChapters } from '../app/lib/search.ts';

const corpusDir = new URL('../corpus/gita-translations/edwin-arnold/', import.meta.url);
const translation = JSON.parse(await readFile(new URL('translation.json', corpusDir), 'utf8'));
const sourceMetadata = JSON.parse(await readFile(new URL('source.json', corpusDir), 'utf8'));
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
  assert.deepEqual(metadata, sourceMetadata);
});

test('all 18 Arnold chapters match their exact source lines and preserve colophons', () => {
  assert.equal(translation.granularity, 'chapter');
  assert.match(translation.alignmentStatus, /verse alignment not verified/);
  assert.match(translation.reviewStatus, /independent textual review pending/);
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
  assert.equal(manifest.granularity, 'chapter');
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

test('Arnold chapter search finds source text with real highlight offsets and no verse assignments', () => {
  const results = searchTranslationChapters(translation.chapters, 'battle on the sacred plain');
  assert.equal(results.length, 1);
  assert.equal(results[0].chapter.chapter, 1);
  assert.equal(results[0].kind, 'exact');
  assert.equal('verse' in results[0].chapter, false);
  assert.equal(results[0].chapter.text.slice(results[0].ranges[0].start, results[0].ranges[0].end), 'battle');
  assert.deepEqual(searchTranslationChapters(translation.chapters, '   '), []);
  assert.deepEqual(searchTranslationChapters(translation.chapters, 'unfindablexyz'), []);
  assert.deepEqual(searchTranslationChapters(translation.chapters, 'battle battle'), searchTranslationChapters(translation.chapters, 'battle'));
});

test('chapter search distinguishes complete words from compound forms and requires every query term', () => {
  const chapters = [{ chapter: 1, text: 'Yoga is action.' }, { chapter: 2, text: 'A yogashastra.' }];
  assert.deepEqual(searchTranslationChapters(chapters, 'yoga').map((result) => result.kind), ['exact', 'compound']);
  assert.equal(searchTranslationChapters(chapters, 'yoga action').length, 1);
  assert.equal(searchTranslationChapters(chapters, 'yoga unknown').length, 0);
});
