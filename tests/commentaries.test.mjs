import assert from 'node:assert/strict';
import test from 'node:test';
import { readFile } from 'node:fs/promises';

const root = new URL('../', import.meta.url);
const authors = JSON.parse(await readFile(new URL('corpus/gita-commentaries/authors.json', root), 'utf8'));
const alignment = JSON.parse(await readFile(new URL('corpus/gita-commentaries/alignment-report.json', root), 'utf8'));

test('registers and publishes all authors from the GPL-3.0 source snapshot', () => {
  assert.equal(authors.length, 22);
  assert.equal(authors.filter((author) => author.publicFields.length).length, 22);
  assert.equal(authors.reduce((total, author) => total + author.publicFields.length, 0), 29);
  assert.deepEqual(authors.find((author) => author.id === 'prabhupada').publicFields, ['et', 'ec']);
});

test('aligns all 29 public fields without changing the 700-verse canon', () => {
  assert.equal(alignment.canonicalPassages, 700);
  assert.equal(alignment.alignedCommentaryUnits, 29 * 700);
  assert.equal(alignment.paratextUnits, 515);
});

test('the corrected release changes review labels while retaining every historic reading and checksum', async () => {
  const source = JSON.parse(await readFile(new URL('corpus/gita-commentaries/source.json', root), 'utf8'));
  assert.equal(source.corpusVersion, 'gita-commentaries-0.2.1');
  assert.equal(alignment.status, 'machine-validated; human review pending');
  for (const lang of ['en', 'hi', 'sa']) {
    const parse = (text) => text.trim().split('\n').map((line) => JSON.parse(line));
    const before = parse(await readFile(new URL(`public/data/gita-commentaries-0.2.0/commentaries-${lang}.jsonl`, root), 'utf8'));
    const after = parse(await readFile(new URL(`public/data/${source.corpusVersion}/commentaries-${lang}.jsonl`, root), 'utf8'));
    assert.equal(after.length, before.length);
    for (let index = 0; index < before.length; index++) {
      const { alignmentStatus: originalStatus, ...oldReading } = before[index];
      const { alignmentStatus, ...newReading } = after[index];
      assert.ok(originalStatus);
      assert.equal(alignmentStatus, 'machine-validated; human review pending');
      assert.deepEqual(newReading, oldReading);
    }
  }
});

test('verse pages render every supplied witness sequentially without comparison controls', async () => {
  const page = await readFile(new URL('app/gita/[chapter]/[verse]/page.tsx', root), 'utf8');
  const witnesses = await readFile(new URL('components/commentary-witnesses.tsx', root), 'utf8');

  assert.match(page, /<CommentaryWitnesses commentaries=\{commentaries\} \/>/);
  assert.doesNotMatch(page, /searchParams|selectedEditions|compare/);
  assert.match(witnesses, /readings\.map/);
  assert.doesNotMatch(witnesses, /<form|<select|selectedIds|comparison/);
});
