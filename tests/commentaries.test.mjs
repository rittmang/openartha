import assert from 'node:assert/strict';
import test from 'node:test';
import { readFile } from 'node:fs/promises';

const root = new URL('../', import.meta.url);
const authors = JSON.parse(await readFile(new URL('corpus/gita-commentaries/authors.json', root), 'utf8'));
const alignment = JSON.parse(await readFile(new URL('corpus/gita-commentaries/alignment-report.json', root), 'utf8'));

test('registers all authors while publishing only rights-reviewed fields', () => {
  assert.equal(authors.length, 22);
  assert.equal(authors.filter((author) => author.publicFields.length).length, 13);
  assert.ok(authors.find((author) => author.id === 'prabhupada').publicFields.length === 0);
});

test('aligns 13 public witnesses without changing the 700-verse canon', () => {
  assert.equal(alignment.canonicalPassages, 700);
  assert.equal(alignment.alignedCommentaryUnits, 13 * 700);
  assert.equal(alignment.paratextUnits, 13 * 19);
});
