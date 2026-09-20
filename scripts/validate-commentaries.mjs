import { createHash } from 'node:crypto';
import { execFileSync } from 'node:child_process';
import { readFile } from 'node:fs/promises';
import { readdirSync } from 'node:fs';
import path from 'node:path';

const root = process.cwd();
const sha256 = (value) => createHash('sha256').update(value).digest('hex');
const fail = (message) => { throw new Error(message); };

const authors = JSON.parse(await readFile(path.join(root, 'corpus', 'gita-commentaries', 'authors.json'), 'utf8'));
const source = JSON.parse(await readFile(path.join(root, 'corpus', 'gita-commentaries', 'source.json'), 'utf8'));
const dataDir = path.join(root, 'public', 'data', source.corpusVersion);
const manifest = JSON.parse(await readFile(path.join(dataDir, 'manifest.json'), 'utf8'));
const rights = JSON.parse(await readFile(path.join(dataDir, 'rights.json'), 'utf8'));
const alignment = JSON.parse(await readFile(path.join(dataDir, 'alignment-report.json'), 'utf8'));
const staging = JSON.parse(await readFile(path.join(root, 'corpus', 'gita-commentaries', 'staging-report.json'), 'utf8'));
const records = (await Promise.all(['en', 'hi', 'sa'].map(async (language) => {
  const body = await readFile(path.join(dataDir, `commentaries-${language}.jsonl`), 'utf8');
  return body.trim().split('\n').map((line) => JSON.parse(line));
}))).flat();

if (authors.length !== 22) fail(`Expected 22 authors, found ${authors.length}`);
const publicAuthors = authors.filter((author) => author.publicFields.length);
if (publicAuthors.length !== 22) fail(`Expected 22 public authors, found ${publicAuthors.length}`);
if (authors.reduce((total, author) => total + author.publicFields.length, 0) !== 29) fail('Expected all 29 source fields to be public');
if (records.length !== 20_300) fail(`Expected 20,300 public records, found ${records.length}`);
if (new Set(records.map((record) => record.id)).size !== records.length) fail('Commentary record IDs are not unique');
if (new Set(records.map((record) => record.canonicalRef)).size !== 700) fail('Commentary records do not cover exactly 700 canonical passages');

const publicIds = new Set(publicAuthors.map((author) => author.id));
for (const record of records) {
  if (!publicIds.has(record.authorId)) fail(`Unpublished author text leaked into exports: ${record.authorId}`);
  if (!['en', 'hi', 'sa'].includes(record.language) || !['translation', 'commentary'].includes(record.contentType)) fail(`Unexpected public field in ${record.id}`);
  if (record.content !== record.content.normalize('NFC')) fail(`Non-NFC content in ${record.id}`);
  if (sha256(record.content) !== record.checksum) fail(`Checksum mismatch in ${record.id}`);
}
for (const author of publicAuthors) {
  for (const fieldCode of author.publicFields) {
    const editionId = `${author.id}-${fieldCode}`;
    const count = records.filter((record) => record.editionId === editionId).length;
    if (count !== 700) fail(`${editionId} has ${count} records instead of 700`);
  }
}
if (alignment.sourceFiles !== 719 || alignment.alignedCommentaryUnits !== 20_300 || alignment.paratextUnits !== 515) fail('Alignment report counts are inconsistent');
if (alignment.chapterColophons !== 486 || alignment.chapter13AlternateOpenings !== 29) fail('Paratext counts are inconsistent');
if (rights.authors.length !== authors.length || source.source.commit !== manifest.sourceCommit) fail('Rights or source manifests are inconsistent');
if (rights.sourceDatasetLicense !== 'GPL-3.0' || manifest.publicEditions !== 29) fail('Complete-source licensing or edition manifest is inconsistent');
if (staging.authors !== 22 || staging.editions.length !== 29 || new Set(staging.editions.map((edition) => edition.language)).size !== 3) fail('Staging inventory does not cover all author fields and languages');

for (const file of manifest.files) {
  const body = await readFile(path.join(dataDir, file.name));
  if (body.byteLength !== file.bytes || sha256(body) !== file.sha256) fail(`Manifest mismatch for ${file.name}`);
  if (body.byteLength >= 25 * 1024 * 1024) fail(`${file.name} exceeds Cloudflare's 25 MiB asset limit`);
}

const migrationFiles = readdirSync(path.join(root, 'drizzle')).filter((file) => /^\d{4}_seed_commentaries_v020_\d+\.sql$/.test(file)).sort();
if (migrationFiles.length < 2) fail('Commentary seed must be split into multiple deployable migrations');
const migrations = await Promise.all(migrationFiles.map((file) => readFile(path.join(root, 'drizzle', file), 'utf8')));
const migration = migrations.join('\n');
const largestStatement = Math.max(...migrations.flatMap((body) => body.split('--> statement-breakpoint').map((statement) => Buffer.byteLength(statement))));
if (migrations.some((body) => Buffer.byteLength(body) > 3_100_000)) fail('A generated D1 migration exceeds the deployable part size');
if (largestStatement > 90_000) fail(`Generated D1 statement is too large: ${largestStatement} bytes`);
for (const author of authors) {
  for (const fieldCode of author.publicFields) {
    if (!migration.includes(`${author.id}-${fieldCode}:source:`)) fail(`Public edition text is absent from D1 seed: ${author.id}-${fieldCode}`);
  }
}

for (const language of ['en', 'hi', 'sa']) execFileSync('xmllint', ['--noout', path.join(dataDir, `commentaries-${language}.xml`)], { stdio: 'inherit' });
const license = await readFile(path.join(dataDir, 'LICENSE-GPL-3.0.txt'), 'utf8');
if (!license.includes('GNU GENERAL PUBLIC LICENSE')) fail('GPL-3.0 license copy is missing or invalid');
console.log(JSON.stringify({ authors: authors.length, publicAuthors: publicAuthors.length, editions: 29, records: records.length, canonicalPassages: 700, paratextUnits: alignment.paratextUnits, migrationParts: migrationFiles.length, largestD1StatementBytes: largestStatement, sourceCommit: source.source.commit }, null, 2));
