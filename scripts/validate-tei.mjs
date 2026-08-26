import { mkdir, writeFile } from 'node:fs/promises';
import { spawnSync } from 'node:child_process';
import path from 'node:path';

const schemaUrl = 'https://tei-c.org/release/xml/tei/custom/schema/relaxng/tei_all.rng';
const cacheDir = path.join(process.cwd(), '.cache', 'tei');
const schemaPath = path.join(cacheDir, 'tei_all.rng');
await mkdir(cacheDir, { recursive: true });
const response = await fetch(schemaUrl);
if (!response.ok) throw new Error(`Could not fetch the TEI P5 Relax NG schema: ${response.status}`);
await writeFile(schemaPath, await response.text(), 'utf8');

const result = spawnSync('xmllint', ['--noout', '--relaxng', schemaPath, 'corpus/gita/tei/gita.xml'], { encoding: 'utf8', stdio: 'pipe' });
if (result.error?.code === 'ENOENT') throw new Error('xmllint is required for TEI P5 schema validation');
if (result.status !== 0) throw new Error(result.stderr || 'TEI P5 validation failed');
process.stdout.write(result.stdout || 'TEI P5 Relax NG validation passed.\n');
