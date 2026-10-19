import { readFile } from 'node:fs/promises';
const chapter = Number(process.argv[2]);
if (!Number.isInteger(chapter) || chapter < 1 || chapter > 18) throw new Error('Provide a chapter number (1–18)');
const translation = JSON.parse(await readFile(new URL('../corpus/gita-translations/edwin-arnold/translation.json', import.meta.url), 'utf8'));
const root = JSON.parse(await readFile(new URL('../corpus/gita/gita.json', import.meta.url), 'utf8'));
const witnesses = (await readFile(new URL('../public/data/gita-commentaries-0.2.0/commentaries-en.jsonl', import.meta.url), 'utf8')).trim().split('\n').map((line) => JSON.parse(line));
const verses = root.verses.filter((verse) => verse.chapter === chapter);
process.stdout.write(translation.chapters[chapter - 1].text.split('\n').map((line, i) => `${i + 1} ${line}`).join('\n') + '\n\nCANONICAL VERSES\n');
for (const verse of verses) {
  const witness = witnesses.find((item) => item.authorId === 'swami-sivananda' && item.canonicalRef === verse.canonicalRef);
  process.stdout.write(`${verse.chapter}.${verse.verse} ${(witness?.content ?? verse.representations.english).replace(/\s+/g, ' ')}\n`);
}
