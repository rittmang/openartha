import assert from 'node:assert/strict';
import { readFile } from 'node:fs/promises';
import test from 'node:test';

const root = new URL('../', import.meta.url);

test('local commands use the repository-pinned pnpm and Node.js runtimes', async () => {
  const packageJson = JSON.parse(await readFile(new URL('package.json', root), 'utf8'));
  const workspace = await readFile(new URL('pnpm-workspace.yaml', root), 'utf8');

  assert.equal(packageJson.packageManager, 'pnpm@10.34.5');
  assert.match(workspace, /^useNodeVersion: 24\.19\.0$/m);
  assert.match(packageJson.engines.node, /^>=22\.13\.0$/);
});
