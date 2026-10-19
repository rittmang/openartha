import assert from 'node:assert/strict';
import { createHash } from 'node:crypto';
import { readFile } from 'node:fs/promises';
import test from 'node:test';
import { buildPassageSearchIndex, searchPassages, findSearchTerm, findSearchTerms } from '../app/lib/search.ts';

const root = new URL('../', import.meta.url);
const corpus = JSON.parse(await readFile(new URL('corpus/gita/gita.json', root), 'utf8'));
const index = JSON.parse(await readFile(new URL('corpus/gita/search-index.json', root), 'utf8'));

test('the shipped search index is bound to every current passage and normalized representation', () => {
  assert.equal(index.corpusVersion, corpus.corpusVersion);
  assert.equal(index.passageDigest, createHash('sha256').update(JSON.stringify(corpus.verses.map(({ canonicalRef, checksum, speaker }) => ({ canonicalRef, checksum, speaker })))).digest('hex'));
  assert.deepEqual(index.passages, buildPassageSearchIndex(corpus.verses));
});

test('precomputed search preserves complete results and evidence across multilingual queries', () => {
  for (const q of ['yoga', 'sankhya', 'sāṅkhya', 'धर्म', 'कर्तव्य', 'sacred plain', '2.47', 'Arjuna', '" OR * --', 'yoga\u0304', 'zzzznohit123']) {
    assert.deepEqual(searchPassages(corpus.verses, q, index.passages), searchPassages(corpus.verses, q), q);
  }
});

test('sparse Unicode offsets preserve original spans across expansion, deletion, and combining marks', () => {
  const text = 'x ﬁ a\u0301 क़ y';
  assert.deepEqual(findSearchTerm(text, 'fi'), [{ start: 2, end: 3, exact: true }]);
  assert.deepEqual(findSearchTerm(text, 'a'), [{ start: 4, end: 5, exact: true }]);
  assert.deepEqual(findSearchTerm(text, 'क़'), [{ start: 7, end: 8, exact: true }]);
  assert.deepEqual(findSearchTerm(text, 'y'), [{ start: 9, end: 10, exact: true }]);
  assert.deepEqual(findSearchTerm('x\u0301y', 'xy'), [{ start: 0, end: 3, exact: true }]);
  assert.deepEqual(findSearchTerm(text, ''), []);
  assert.deepEqual(findSearchTerms(text, ['fi', 'y']), [findSearchTerm(text, 'fi'), findSearchTerm(text, 'y')]);
});
