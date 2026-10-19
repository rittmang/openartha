import { execFileSync } from 'node:child_process';
import assert from 'node:assert/strict';
import { existsSync } from 'node:fs';
import { mkdir, readFile, writeFile } from 'node:fs/promises';
import { fileURLToPath } from 'node:url';
import path from 'node:path';
import { arnoldAlignmentProposal, arnoldAlignmentFingerprint, sha256 } from './lib/arnold-review.mjs';

const root = fileURLToPath(new URL('../', import.meta.url));
const outputDirectory = path.join(root, 'research/arnold-first-review');
assert.ok(!existsSync(path.join(outputDirectory, 'input-manifest.json')), 'Pinned review inputs already exist. Preserve them and prepare a separate directory for any new review round.');
const translation = JSON.parse(await readFile(path.join(root, 'corpus/gita-translations/edwin-arnold/translation.json'), 'utf8'));
const canonical = JSON.parse(await readFile(path.join(root, 'corpus/gita/gita.json'), 'utf8'));
const witnesses = (await readFile(path.join(root, 'public/data/gita-commentaries-0.2.0/commentaries-en.jsonl'), 'utf8')).trim().split('\n').map((line) => JSON.parse(line));
const selected = new Set(['swami-sivananda', 'purohit-swami', 'swami-gambirananda']);
const reviewedCommit = execFileSync('git', ['rev-parse', 'HEAD'], { cwd: root, encoding: 'utf8' }).trim();
const directory = path.join(root, 'research/arnold-first-review/inputs');
await mkdir(directory, { recursive: true });
const chapters = [];
for (const chapter of translation.chapters) {
  const records = translation.verses.filter((verse) => verse.chapter === chapter.chapter).map((verse) => {
    const passage = canonical.verses.find((item) => item.canonicalRef === verse.canonicalRef);
    const proposal = arnoldAlignmentProposal(verse);
    return {
      canonicalRef: verse.canonicalRef,
      alignmentFingerprint: arnoldAlignmentFingerprint(verse),
      sanskrit: passage.representations.devanagari,
      iast: passage.representations.iast,
      speaker: passage.speaker,
      arnold: proposal,
      witnesses: witnesses.filter((item) => item.canonicalRef === verse.canonicalRef && item.contentType === 'translation' && selected.has(item.authorId)).map((item) => ({ author: item.author, text: item.content })),
    };
  });
  const input = {
    schemaVersion: 1,
    workId: 'gita',
    translationId: 'edwin-arnold',
    chapter: chapter.chapter,
    reviewedCommit,
    sourceSha256: translation.source.sha256,
    canonicalCorpusVersion: canonical.corpusVersion,
    numbering: 'Standard 700-verse canon; Chapter 13 has 34 verses and excludes Arjuna\'s alternate opening question.',
    sourceChapterWithLineNumbers: chapter.text.split('\n').map((line, index) => `${index + 1}: ${line}`).join('\n'),
    translatorNotes: translation.notes,
    paratext: translation.paratext.filter((item) => item.chapter === chapter.chapter),
    records,
  };
  const name = `chapter-${String(chapter.chapter).padStart(2, '0')}.json`;
  const body = JSON.stringify(input, null, 2) + '\n';
  await writeFile(path.join(directory, name), body);
  chapters.push({ chapter: chapter.chapter, records: records.length, path: `inputs/${name}`, sha256: sha256(body) });
}
const manifest = { schemaVersion: 1, translationId: 'edwin-arnold', reviewerModel: 'google/gemini-3.8-flash', providerModel: 'openrouter/google/gemini-3.8-flash', transport: 'opencode', reviewedCommit, sourceSha256: translation.source.sha256, canonicalPassages: chapters.reduce((count, chapter) => count + chapter.records, 0), chapters };
await writeFile(path.join(root, 'research/arnold-first-review/input-manifest.json'), JSON.stringify(manifest, null, 2) + '\n');
console.log(`Prepared ${manifest.canonicalPassages} verse review inputs across ${chapters.length} chapters at ${reviewedCommit}.`);
