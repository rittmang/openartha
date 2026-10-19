import { createHash } from 'node:crypto';
import { execFileSync } from 'node:child_process';
import { existsSync, readdirSync } from 'node:fs';
import { mkdir, readFile, writeFile } from 'node:fs/promises';
import path from 'node:path';
import { commentaryReviewReleaseSql } from './lib/commentary-review-release.mjs';

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
function addUnit({ author, edition, sourceRow, passageId, unitType, alignmentRelation, content, idSuffix = '' }) {
  const { chapter, verse: sourceVerse } = sourceRow.record;
  units.push({
    id: `${edition.id}:source:${chapter}.${sourceVerse}${idSuffix}`,
    editionId: edition.id,
    authorId: author.id,
    authorName: author.displayName,
    fieldCode: edition.fieldCode,
    language: edition.language,
    script: edition.script,
    contentType: edition.contentType,
    sourceChapter: chapter,
    sourceVerse,
    canonicalRef: passageId,
    unitType,
    alignmentRelation: passageId ? alignmentRelation : null,
    alignmentStatus: passageId ? 'machine-validated; human review pending' : 'paratext-preserved',
    sourceLocator: `${sourceRow.file}#/${author.sourceKey}/${edition.fieldCode}`,
    rawChecksum: sha256(content.raw),
    displayChecksum: sha256(content.display),
    content: content.display,
  });
}

for (const author of authors) {
  for (const fieldCode of author.publicFields) {
    const edition = editions.find((item) => item.authorId === author.id && item.fieldCode === fieldCode);
    for (const sourceRow of sourceRows) {
      const { chapter, verse: sourceVerse } = sourceRow.record;
      const rawContent = sourceRow.record[author.sourceKey]?.[fieldCode];
      if (typeof rawContent !== 'string') {
        if (author.id === 'prabhupada') continue;
        throw new Error(`${sourceRow.file} is missing ${author.sourceKey}.${fieldCode}`);
      }
      const content = { raw: rawContent, display: normalizeDisplay(rawContent) };

      if (author.id === 'prabhupada') {
        if (chapter === 13 && sourceVerse === 1) {
          addUnit({ author, edition, sourceRow, passageId: null, unitType: 'recensional-prelude', alignmentRelation: null, content });
          continue;
        }
        const canonicalVerse = chapter === 13 ? sourceVerse - 1 : chapter === 1 && sourceVerse >= 37 ? sourceVerse + 1 : sourceVerse;
        addUnit({
          author,
          edition,
          sourceRow,
          passageId: `gita.${chapter}.${canonicalVerse}`,
          unitType: 'passage-commentary',
          alignmentRelation: chapter === 13 ? 'source-number-minus-one' : chapter === 1 && sourceVerse >= 37 ? 'source-number-plus-one' : 'same-number',
          content,
        });
        if (chapter === 1 && sourceVerse === 36) {
          addUnit({
            author,
            edition,
            sourceRow,
            passageId: 'gita.1.37',
            unitType: 'passage-commentary',
            alignmentRelation: 'source-unit-spans-next-canonical-verse',
            content,
            idSuffix: ':canonical:1.37',
          });
        }
        continue;
      }

      const isPrelude = chapter === 13 && sourceVerse === 1;
      const isColophon = sourceVerse === sourceManifest.source.expectedChapterCounts[chapter - 1];
      const canonicalVerse = chapter === 13 ? sourceVerse - 1 : sourceVerse;
      const unitType = isPrelude ? 'recensional-prelude' : isColophon ? 'chapter-colophon' : 'passage-commentary';
      const passageId = unitType === 'passage-commentary' ? `gita.${chapter}.${canonicalVerse}` : null;
      addUnit({ author, edition, sourceRow, passageId, unitType, alignmentRelation: chapter === 13 ? 'source-number-minus-one' : 'same-number', content });
    }
  }
}

const alignedUnits = units.filter((unit) => unit.canonicalRef);
const paratextUnits = units.filter((unit) => !unit.canonicalRef);
const expectedPublicEditions = authors.reduce((count, author) => count + author.publicFields.length, 0);
if (alignedUnits.length !== expectedPublicEditions * 700) throw new Error(`Expected ${expectedPublicEditions * 700} aligned units, found ${alignedUnits.length}`);
const expectedParatextUnits = (expectedPublicEditions - 2) * 19 + 2;
if (paratextUnits.length !== expectedParatextUnits) throw new Error(`Expected ${expectedParatextUnits} paratext units, found ${paratextUnits.length}`);

await Promise.all([mkdir(publicDir, { recursive: true }), mkdir(registryDir, { recursive: true })]);

const rightsManifest = {
  corpusVersion: sourceManifest.corpusVersion,
  codeLicense: 'MIT',
  projectMetadataLicense: 'CC BY 4.0',
  sourceDatasetLicense: sourceManifest.source.license,
  sourceDatasetLicenseUrl: sourceManifest.source.licenseUrl,
  notice: 'All translation and commentary fields supplied by the pinned dataset snapshot are redistributed under its repository-wide GPL-3.0 license. Application code and original project metadata retain their separately stated licenses.',
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
  exceptions: [{ authorId: 'prabhupada', status: 'explicitly-aligned', note: 'Chapter 1 source unit 1.36 spans canonical 1.36–1.37 and later source units shift forward one; Chapter 13 source 13.1 is preserved as a recensional prelude and 13.2–13.35 align to canonical 13.1–13.34.' }],
};

await writeFile(path.join(publicDir, 'rights.json'), `${JSON.stringify(rightsManifest, null, 2)}\n`, 'utf8');
await writeFile(path.join(publicDir, 'alignment-report.json'), `${JSON.stringify(alignmentReport, null, 2)}\n`, 'utf8');
await writeFile(path.join(registryDir, 'rights.json'), `${JSON.stringify(rightsManifest, null, 2)}\n`, 'utf8');
await writeFile(path.join(registryDir, 'alignment-report.json'), `${JSON.stringify(alignmentReport, null, 2)}\n`, 'utf8');
await writeFile(path.join(registryDir, 'staging-report.json'), `${JSON.stringify(stagingReport, null, 2)}\n`, 'utf8');

const exportFiles = [];
for (const language of ['en', 'hi', 'sa']) {
  const languageUnits = alignedUnits.filter((unit) => unit.language === language);
  const jsonlName = `commentaries-${language}.jsonl`;
  const teiName = `commentaries-${language}.xml`;
  const jsonl = languageUnits.map((unit) => JSON.stringify({
    id: unit.id,
    canonicalRef: unit.canonicalRef,
    authorId: unit.authorId,
    author: unit.authorName,
    editionId: unit.editionId,
    language: unit.language,
    script: unit.script,
    contentType: unit.contentType,
    sourceLocator: unit.sourceLocator,
    alignmentRelation: unit.alignmentRelation,
    alignmentStatus: unit.alignmentStatus,
    checksum: unit.displayChecksum,
    content: unit.content,
  })).join('\n') + '\n';
  const tei = [
    '<?xml version="1.0" encoding="UTF-8"?>',
    '<TEI xmlns="http://www.tei-c.org/ns/1.0">',
    `  <teiHeader><fileDesc><titleStmt><title>OpenArtha Bhagavad Gita ${language} translation and commentary corpus</title></titleStmt><publicationStmt><p>GPL-3.0 research preview; see rights.json.</p></publicationStmt><sourceDesc><p>VedicScriptures Bhagavad Gita dataset, pinned Git commit.</p></sourceDesc></fileDesc></teiHeader>`,
    '  <text><body>',
    ...languageUnits.map((unit) => `    <div type="${escapeXml(unit.contentType)}" xml:id="${escapeXml(unit.id.replace(/[:.]/g, '-'))}" corresp="urn:${unit.canonicalRef}"><head>${escapeXml(unit.authorName)}</head><p xml:lang="${unit.language}-${unit.script}">${escapeXml(unit.content)}</p></div>`),
    '  </body></text>',
    '</TEI>',
    '',
  ].join('\n');
  await writeFile(path.join(publicDir, jsonlName), jsonl, 'utf8');
  await writeFile(path.join(publicDir, teiName), tei, 'utf8');
  exportFiles.push(jsonlName, teiName);
}
const licenseName = 'LICENSE-GPL-3.0.txt';
await writeFile(path.join(publicDir, licenseName), await readFile(path.join(sourceDir, 'LICENSE')));
exportFiles.push('rights.json', 'alignment-report.json', licenseName);
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

// Published seed migrations are immutable. This patch release changes metadata only.
const migrationTag = '0045_commentary_review_metadata_v021';
const drizzleDir = path.join(root, 'drizzle');
await writeFile(path.join(drizzleDir, `${migrationTag}.sql`), commentaryReviewReleaseSql(sourceManifest));
const journalPath = path.join(drizzleDir, 'meta', '_journal.json');
const journal = JSON.parse(await readFile(journalPath, 'utf8'));
if (!journal.entries.some((entry) => entry.tag === migrationTag)) {
  journal.entries.push({ idx: journal.entries.length, version: '6', when: Math.max(...journal.entries.map((entry) => entry.when)) + 1, tag: migrationTag, breakpoints: true });
  await writeFile(journalPath, JSON.stringify(journal, null, 2) + '\n');
}
console.log(JSON.stringify({ corpusVersion: sourceManifest.corpusVersion, sourceCommit: pinnedCommit, authors: authors.length, publicEditions: expectedPublicEditions, alignedUnits: alignedUnits.length, paratextUnits: paratextUnits.length, migrationTag, exports: manifestFiles }, null, 2));
