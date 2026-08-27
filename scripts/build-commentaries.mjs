import { createHash } from 'node:crypto';
import { execFileSync } from 'node:child_process';
import { existsSync, readdirSync } from 'node:fs';
import { mkdir, readFile, unlink, writeFile } from 'node:fs/promises';
import path from 'node:path';

const root = process.cwd();
const registryDir = path.join(root, 'corpus', 'gita-commentaries');
const sourceManifest = JSON.parse(await readFile(path.join(registryDir, 'source.json'), 'utf8'));
const authors = JSON.parse(await readFile(path.join(registryDir, 'authors.json'), 'utf8'));
const publicDir = path.join(root, 'public', 'data', sourceManifest.corpusVersion);
const sourceArgument = process.argv.find((argument) => argument.startsWith('--source-dir='));
const cacheSourceDir = path.join(root, '.cache', 'commentaries', 'vedicscriptures-bhagavad-gita');
const sourceDir = sourceArgument ? path.resolve(sourceArgument.slice('--source-dir='.length)) : cacheSourceDir;
const slokDir = path.join(sourceDir, 'slok');

function sha256(value) {
  return createHash('sha256').update(value).digest('hex');
}

function normalizeDisplay(value) {
  return value.normalize('NFC').replace(/\u00a0/g, ' ').replace(/[ \t]+/g, ' ').replace(/\s*\n\s*/g, '\n').trim();
}

function escapeXml(value) {
  return value.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');
}

function sql(value) {
  if (value === null || value === undefined) return 'NULL';
  if (typeof value === 'number') return String(value);
  return `'${String(value).replaceAll("'", "''")}'`;
}

function chunksByBytes(value, maximumBytes = 24_000) {
  const chunks = [];
  let current = '';
  let bytes = 0;
  for (const character of value) {
    const size = Buffer.byteLength(character);
    if (current && bytes + size > maximumBytes) {
      chunks.push(current);
      current = '';
      bytes = 0;
    }
    current += character;
    bytes += size;
  }
  if (current || !chunks.length) chunks.push(current);
  return chunks;
}

function batchedInsert(table, columns, rows, maximumBytes = 80_000) {
  const statements = [];
  let values = [];
  let bytes = 0;
  const prefix = `INSERT INTO ${table} (${columns.join(',')}) VALUES\n`;
  for (const row of rows) {
    const encoded = `(${row.map(sql).join(',')})`;
    if (values.length && bytes + Buffer.byteLength(encoded) > maximumBytes) {
      statements.push(`${prefix}${values.join(',\n')};`);
      values = [];
      bytes = 0;
    }
    values.push(encoded);
    bytes += Buffer.byteLength(encoded) + 2;
  }
  if (values.length) statements.push(`${prefix}${values.join(',\n')};`);
  return statements;
}

if (!existsSync(slokDir)) {
  await mkdir(path.dirname(cacheSourceDir), { recursive: true });
  execFileSync('git', ['clone', '--filter=blob:none', sourceManifest.source.repository, cacheSourceDir], { stdio: 'inherit' });
}

const currentCommit = execFileSync('git', ['rev-parse', 'HEAD'], { cwd: sourceDir, encoding: 'utf8' }).trim();
if (currentCommit !== sourceManifest.source.commit) {
  execFileSync('git', ['fetch', '--depth=1', 'origin', sourceManifest.source.commit], { cwd: sourceDir, stdio: 'inherit' });
  execFileSync('git', ['checkout', '--detach', sourceManifest.source.commit], { cwd: sourceDir, stdio: 'inherit' });
}
const pinnedCommit = execFileSync('git', ['rev-parse', 'HEAD'], { cwd: sourceDir, encoding: 'utf8' }).trim();
if (pinnedCommit !== sourceManifest.source.commit) throw new Error(`Expected source commit ${sourceManifest.source.commit}, found ${pinnedCommit}`);

const files = readdirSync(slokDir).filter((file) => file.endsWith('.json')).sort((left, right) => left.localeCompare(right, 'en', { numeric: true }));
if (files.length !== sourceManifest.source.expectedSourceUnits) throw new Error(`Expected 719 source JSON files, found ${files.length}`);

const sourceRows = [];
for (const file of files) {
  const raw = await readFile(path.join(slokDir, file), 'utf8');
  const record = JSON.parse(raw);
  sourceRows.push({ file, raw, record, checksum: sha256(raw) });
}

const observedCounts = Array.from({ length: 18 }, (_, index) => sourceRows.filter(({ record }) => record.chapter === index + 1).length);
if (JSON.stringify(observedCounts) !== JSON.stringify(sourceManifest.source.expectedChapterCounts)) {
  throw new Error(`Source chapter counts differ: ${JSON.stringify(observedCounts)}`);
}

const fieldMetadata = {
  ht: { language: 'hi', script: 'Deva', contentType: 'translation' },
  hc: { language: 'hi', script: 'Deva', contentType: 'commentary' },
  et: { language: 'en', script: 'Latn', contentType: 'translation' },
  ec: { language: 'en', script: 'Latn', contentType: 'commentary' },
  sc: { language: 'sa', script: 'Deva', contentType: 'commentary' },
};

const editions = authors.flatMap((author) => author.availableFields.map((fieldCode) => ({
  id: `${author.id}-${fieldCode}`,
  authorId: author.id,
  fieldCode,
  ...fieldMetadata[fieldCode],
  publicText: author.publicFields.includes(fieldCode),
  rightsStatus: author.publicFields.includes(fieldCode) ? 'full-text-allowed' : author.rightsStatus === 'blocked' ? 'blocked' : 'source-link-only',
})));

const stagingReport = {
  corpusVersion: sourceManifest.corpusVersion,
  sourceCommit: sourceManifest.source.commit,
  status: 'source fields inventoried; public-text policy applied separately',
  sourceUnits: sourceRows.length,
  authors: authors.length,
  editions: editions.map((edition) => {
    const author = authors.find((item) => item.id === edition.authorId);
    const records = sourceRows.flatMap((sourceRow) => {
      const content = sourceRow.record[author.sourceKey]?.[edition.fieldCode];
      return typeof content === 'string' ? [{ locator: `${sourceRow.file}#/${author.sourceKey}/${edition.fieldCode}`, content }] : [];
    });
    return {
      editionId: edition.id,
      authorId: edition.authorId,
      author: author.displayName,
      fieldCode: edition.fieldCode,
      language: edition.language,
      contentType: edition.contentType,
      sourceRecordsPresent: records.length,
      sourceBytes: records.reduce((total, record) => total + Buffer.byteLength(record.content), 0),
      aggregateChecksum: sha256(records.map((record) => `${record.locator}:${sha256(record.content)}`).join('\n')),
      publicText: edition.publicText,
      publicStatus: edition.rightsStatus,
    };
  }),
};

const units = [];
for (const author of authors) {
  for (const fieldCode of author.publicFields) {
    const edition = editions.find((item) => item.authorId === author.id && item.fieldCode === fieldCode);
    for (const sourceRow of sourceRows) {
      const { chapter, verse: sourceVerse } = sourceRow.record;
      const rawContent = sourceRow.record[author.sourceKey]?.[fieldCode];
      if (typeof rawContent !== 'string') throw new Error(`${sourceRow.file} is missing ${author.sourceKey}.${fieldCode}`);
      const isPrelude = chapter === 13 && sourceVerse === 1;
      const isColophon = sourceVerse === sourceManifest.source.expectedChapterCounts[chapter - 1];
      const canonicalVerse = chapter === 13 ? sourceVerse - 1 : sourceVerse;
      const unitType = isPrelude ? 'recensional-prelude' : isColophon ? 'chapter-colophon' : 'passage-commentary';
      const passageId = unitType === 'passage-commentary' ? `gita.${chapter}.${canonicalVerse}` : null;
      const content = normalizeDisplay(rawContent);
      units.push({
        id: `${edition.id}:source:${chapter}.${sourceVerse}`,
        editionId: edition.id,
        authorId: author.id,
        authorName: author.displayName,
        fieldCode,
        language: edition.language,
        script: edition.script,
        contentType: edition.contentType,
        sourceChapter: chapter,
        sourceVerse,
        canonicalRef: passageId,
        unitType,
        alignmentRelation: passageId ? (chapter === 13 ? 'source-number-minus-one' : 'same-number') : null,
        alignmentStatus: passageId ? 'machine-validated; human review pending' : 'paratext-preserved',
        sourceLocator: `${sourceRow.file}#/${author.sourceKey}/${fieldCode}`,
        rawChecksum: sha256(rawContent),
        displayChecksum: sha256(content),
        content,
      });
    }
  }
}

const alignedUnits = units.filter((unit) => unit.canonicalRef);
const paratextUnits = units.filter((unit) => !unit.canonicalRef);
const expectedPublicEditions = authors.reduce((count, author) => count + author.publicFields.length, 0);
if (alignedUnits.length !== expectedPublicEditions * 700) throw new Error(`Expected ${expectedPublicEditions * 700} aligned units, found ${alignedUnits.length}`);
if (paratextUnits.length !== expectedPublicEditions * 19) throw new Error(`Expected ${expectedPublicEditions * 19} paratext units, found ${paratextUnits.length}`);

await Promise.all([mkdir(publicDir, { recursive: true }), mkdir(registryDir, { recursive: true })]);

const rightsManifest = {
  corpusVersion: sourceManifest.corpusVersion,
  codeLicense: 'MIT',
  projectMetadataLicense: 'CC BY 4.0',
  sourceDatasetLicense: sourceManifest.source.license,
  sourceDatasetLicenseUrl: sourceManifest.source.licenseUrl,
  notice: 'The public text subset contains classical Sanskrit works. Their underlying texts are public domain; the digital transcriptions are redistributed under GPL-3.0. Modern translations and commentaries are metadata-only.',
  authors: authors.map(({ id, displayName, availableFields, publicFields, rightsStatus, rightsNote }) => ({ id, displayName, availableFields, publicFields, rightsStatus, rightsNote })),
};

const alignmentReport = {
  corpusVersion: sourceManifest.corpusVersion,
  sourceCommit: sourceManifest.source.commit,
  sourceFiles: sourceRows.length,
  sourceFilesDigest: sha256(sourceRows.map((row) => `${row.file}:${row.checksum}`).join('\n')),
  publicEditions: expectedPublicEditions,
  alignedCommentaryUnits: alignedUnits.length,
  paratextUnits: paratextUnits.length,
  canonicalPassages: new Set(alignedUnits.map((unit) => unit.canonicalRef)).size,
  chapterColophons: paratextUnits.filter((unit) => unit.unitType === 'chapter-colophon').length,
  chapter13AlternateOpenings: paratextUnits.filter((unit) => unit.unitType === 'recensional-prelude').length,
  status: 'machine-validated; human review pending',
  exceptions: [{ authorId: 'prabhupada', status: 'blocked', note: 'Known edition-specific numbering shift; public text is excluded until separately aligned and rights-cleared.' }],
};

const jsonl = alignedUnits.map((unit) => JSON.stringify({
  id: unit.id,
  canonicalRef: unit.canonicalRef,
  authorId: unit.authorId,
  author: unit.authorName,
  language: unit.language,
  script: unit.script,
  contentType: unit.contentType,
  sourceLocator: unit.sourceLocator,
  alignmentStatus: unit.alignmentStatus,
  checksum: unit.displayChecksum,
  content: unit.content,
})).join('\n') + '\n';

const tei = [
  '<?xml version="1.0" encoding="UTF-8"?>',
  '<TEI xmlns="http://www.tei-c.org/ns/1.0">',
  '  <teiHeader><fileDesc><titleStmt><title>Agentic Gita classical Sanskrit commentary corpus</title></titleStmt><publicationStmt><p>Research preview; see rights.json.</p></publicationStmt><sourceDesc><p>VedicScriptures Bhagavad Gita dataset, pinned Git commit.</p></sourceDesc></fileDesc></teiHeader>',
  '  <text><body>',
  ...alignedUnits.map((unit) => `    <div type="commentary" xml:id="${escapeXml(unit.id.replace(/[:.]/g, '-'))}" corresp="urn:${unit.canonicalRef}"><head>${escapeXml(unit.authorName)}</head><p xml:lang="sa-Deva">${escapeXml(unit.content)}</p></div>`),
  '  </body></text>',
  '</TEI>',
  '',
].join('\n');

await writeFile(path.join(publicDir, 'commentaries.jsonl'), jsonl, 'utf8');
await writeFile(path.join(publicDir, 'commentaries.xml'), tei, 'utf8');
await writeFile(path.join(publicDir, 'rights.json'), `${JSON.stringify(rightsManifest, null, 2)}\n`, 'utf8');
await writeFile(path.join(publicDir, 'alignment-report.json'), `${JSON.stringify(alignmentReport, null, 2)}\n`, 'utf8');
await writeFile(path.join(registryDir, 'rights.json'), `${JSON.stringify(rightsManifest, null, 2)}\n`, 'utf8');
await writeFile(path.join(registryDir, 'alignment-report.json'), `${JSON.stringify(alignmentReport, null, 2)}\n`, 'utf8');
await writeFile(path.join(registryDir, 'staging-report.json'), `${JSON.stringify(stagingReport, null, 2)}\n`, 'utf8');

const exportFiles = ['commentaries.jsonl', 'commentaries.xml', 'rights.json', 'alignment-report.json'];
const manifestFiles = [];
for (const name of exportFiles) {
  const body = await readFile(path.join(publicDir, name));
  manifestFiles.push({ name, bytes: body.byteLength, sha256: sha256(body) });
}
const releaseManifest = {
  corpusVersion: sourceManifest.corpusVersion,
  canonicalCorpusVersion: sourceManifest.canonicalCorpusVersion,
  status: sourceManifest.status,
  sourceCommit: sourceManifest.source.commit,
  authors: authors.length,
  editions: editions.length,
  publicEditions: expectedPublicEditions,
  canonicalPassages: 700,
  commentaryRecords: alignedUnits.length,
  files: manifestFiles,
};
await writeFile(path.join(publicDir, 'manifest.json'), `${JSON.stringify(releaseManifest, null, 2)}\n`, 'utf8');
await writeFile(path.join(publicDir, 'checksums.sha256'), `${manifestFiles.map((file) => `${file.sha256}  ${file.name}`).join('\n')}\n`, 'utf8');

const sourceRecord = [sourceManifest.source.id, sourceManifest.source.title, sourceManifest.source.repository, sourceManifest.source.commit, sourceManifest.source.license, sourceManifest.source.licenseUrl, sourceManifest.corpusVersion];
const authorRows = authors.map((author) => [author.id, author.sourceKey, author.displayName, JSON.stringify(author.availableFields), JSON.stringify(author.publicFields), author.rightsStatus, author.rightsNote]);
const editionRows = editions.map((edition) => [edition.id, edition.authorId, sourceManifest.source.id, edition.fieldCode, edition.language, edition.script, edition.contentType, edition.publicText ? 1 : 0, edition.rightsStatus, sourceManifest.corpusVersion]);
const unitRows = units.map((unit) => [unit.id, unit.editionId, unit.canonicalRef, unit.sourceChapter, unit.sourceVerse, unit.unitType, unit.alignmentRelation, unit.alignmentStatus, unit.sourceLocator, unit.rawChecksum, unit.displayChecksum]);
const chunkRows = units.flatMap((unit) => chunksByBytes(unit.content).map((content, index) => [unit.id, index, content]));
const ftsRows = alignedUnits.flatMap((unit) => chunksByBytes(unit.content).map((content) => [unit.id, unit.authorName, unit.canonicalRef, unit.language, unit.contentType, content]));

const migrationStatements = [
  'PRAGMA foreign_keys=ON;',
  'DELETE FROM commentary_fts;',
  'DELETE FROM commentary_unit_chunks;',
  'DELETE FROM commentary_units;',
  'DELETE FROM commentary_editions;',
  'DELETE FROM commentary_authors;',
  'DELETE FROM commentary_sources;',
  ...batchedInsert('commentary_sources', ['id','title','repository_url','commit_sha','license','license_url','corpus_version'], [sourceRecord]),
  ...batchedInsert('commentary_authors', ['id','source_key','display_name','available_fields','public_fields','rights_status','rights_note'], authorRows),
  ...batchedInsert('commentary_editions', ['id','author_id','source_id','field_code','language','script','content_type','public_text','rights_status','corpus_version'], editionRows),
  ...batchedInsert('commentary_units', ['id','edition_id','passage_id','source_chapter','source_verse','unit_type','alignment_relation','alignment_status','source_locator','raw_checksum','display_checksum'], unitRows),
  ...batchedInsert('commentary_unit_chunks', ['unit_id','chunk_index','content'], chunkRows),
  ...batchedInsert('commentary_fts', ['unit_id','author','canonical_ref','language','content_type','content'], ftsRows),
];
const migrationParts = [];
let currentPart = [];
let currentPartBytes = 0;
for (const statement of migrationStatements) {
  const statementBytes = Buffer.byteLength(statement) + 30;
  if (currentPart.length && currentPartBytes + statementBytes > 3_000_000) {
    migrationParts.push(currentPart);
    currentPart = [];
    currentPartBytes = 0;
  }
  currentPart.push(statement);
  currentPartBytes += statementBytes;
}
if (currentPart.length) migrationParts.push(currentPart);

const drizzleDir = path.join(root, 'drizzle');
for (const file of readdirSync(drizzleDir)) {
  if (/^\d{4}_seed_commentaries(?:_\d+)?\.sql$/.test(file)) await unlink(path.join(drizzleDir, file));
}
const migrationFiles = [];
for (const [index, statements] of migrationParts.entries()) {
  const migrationNumber = String(index + 3).padStart(4, '0');
  const partNumber = String(index + 1).padStart(2, '0');
  const name = `${migrationNumber}_seed_commentaries_${partNumber}.sql`;
  const body = `${statements.join('\n--> statement-breakpoint\n')}\n`;
  await writeFile(path.join(drizzleDir, name), body, 'utf8');
  migrationFiles.push({ name, bytes: Buffer.byteLength(body) });
}

console.log(JSON.stringify({
  corpusVersion: sourceManifest.corpusVersion,
  sourceCommit: pinnedCommit,
  authors: authors.length,
  editions: editions.length,
  publicEditions: expectedPublicEditions,
  alignedUnits: alignedUnits.length,
  paratextUnits: paratextUnits.length,
  chunks: chunkRows.length,
  migrationFiles,
  exports: manifestFiles,
}, null, 2));
