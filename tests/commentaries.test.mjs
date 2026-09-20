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

test('verse pages render every supplied witness sequentially without comparison controls', async () => {
  const page = await readFile(new URL('app/gita/[chapter]/[verse]/page.tsx', root), 'utf8');
  const witnesses = await readFile(new URL('components/commentary-witnesses.tsx', root), 'utf8');

  assert.match(page, /<CommentaryWitnesses commentaries=\{commentaries\} \/>/);
  assert.doesNotMatch(page, /searchParams|selectedEditions|compare/);
  assert.match(witnesses, /readings\.map/);
  assert.doesNotMatch(witnesses, /<form|<select|selectedIds|comparison/);
});
