import assert from 'node:assert/strict';
import { readFile } from 'node:fs/promises';
import test from 'node:test';

const root = new URL('../', import.meta.url);
const navigationFiles = [
  'app/page.tsx',
  'app/layout.tsx',
  'app/gita/page.tsx',
  'app/gita/[chapter]/page.tsx',
  'app/gita/[chapter]/[verse]/page.tsx',
  'components/breadcrumbs.tsx',
  'components/passage-card.tsx',
];

test('reader navigation uses native links that survive client-router failures', async () => {
  const sources = await Promise.all(
    navigationFiles.map((file) => readFile(new URL(file, root), 'utf8')),
  );

  for (const source of sources) {
    assert.doesNotMatch(source, /next\/link|<Link\b/);
  }

  assert.match(sources[0], /href="\/gita">Read the Gita<\/a>/);
});
