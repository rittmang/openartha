import { createHash } from 'node:crypto';
import { readFile, writeFile } from 'node:fs/promises';

// Compile the characters that require sparse original-offset corrections using
// the repository-pinned Node Unicode tables; runtime search avoids a JS loop per character.
const ranges = [];
let start = -1;
let previous = -1;
for (let point = 0; point <= 0x10ffff; point++) {
  const char = String.fromCodePoint(point);
  const normalized = char.normalize('NFKD').replace(/[\u0300-\u036f]/g, '').toLowerCase();
  if (char.length === normalized.length) continue;
  if (start < 0) start = point;
  else if (point !== previous + 1) { ranges.push([start, previous]); start = point; }
  previous = point;
}
if (start >= 0) ranges.push([start, previous]);
const code = (point) => `\\u{${point.toString(16)}}`;
await writeFile(new URL('../app/lib/search-normalization.json', import.meta.url), JSON.stringify({ pattern: `[${ranges.map(([a, b]) => a === b ? code(a) : `${code(a)}-${code(b)}`).join('')}]` }) + '\n');
const { buildPassageSearchIndex } = await import('../app/lib/search.ts');

const corpus = JSON.parse(await readFile(new URL('../corpus/gita/gita.json', import.meta.url), 'utf8'));
const digest = createHash('sha256').update(JSON.stringify(corpus.verses.map(({ canonicalRef, checksum, speaker }) => ({ canonicalRef, checksum, speaker })))).digest('hex');
const index = { corpusVersion: corpus.corpusVersion, passageDigest: digest, passages: buildPassageSearchIndex(corpus.verses) };
await writeFile(new URL('../corpus/gita/search-index.json', import.meta.url), JSON.stringify(index) + '\n');
console.log(`Built normalized search index for ${corpus.verses.length} passages.`);
