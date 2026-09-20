import corpusJson from '@/corpus/gita/gita.json';
import { searchPassages } from '@/app/lib/search';
export type { CorpusSearchResults, PassageSearchResult, SearchHit, SearchMatchKind } from '@/app/lib/search';

export type Source = {
  id: string;
  title: string;
  contributor: string;
  year: number | null;
  url: string;
  transcriptionUrl?: string;
  rights: string;
  role: string;
};

export type Variant = {
  type: string;
  note: string;
  devanagari: string;
  iast: string;
};

export type Passage = {
  id: string;
  canonicalRef: string;
  workId: string;
  editionId: string;
  corpusVersion: string;
  chapter: number;
  verse: number;
  speaker: string | null;
  representations: {
    devanagari: string;
    iast: string;
    english: string;
  };
  translation: {
    translator: string;
    editionYear: number;
    status: string;
    alignmentConfidence: number;
  };
  variants: Variant[];
  provenance: Array<{ sourceId: string; locator: string; role: string }>;
  review: {
    transcription: string;
    firstHumanReview: string;
    secondHumanReview: string;
    releaseEligible: boolean;
    firstReviewConfidence?: number;
    firstReviewDate?: string;
    firstReviewNotes?: string;
  };
  checksum: string;
};

export type Corpus = {
  schemaVersion: number;
  corpusVersion: string;
  generatedAt: string;
  status: string;
  releaseEligible: boolean;
  releaseBlocker: string;
  chapterCounts: number[];
  work: {
    id: string;
    title: string;
    originalTitle: string;
    language: string;
    passageCount: number;
    edition: { id: string; title: string; status: string };
  };
  sources: Source[];
  verses: Passage[];
};

export const corpus = corpusJson as Corpus;

export const chapterTitles = [
  ['Arjuna Viṣāda Yoga', 'The Yoga of Arjuna’s Dejection'],
  ['Sāṅkhya Yoga', 'The Yoga of Knowledge'],
  ['Karma Yoga', 'The Yoga of Action'],
  ['Jñāna Karma Sannyāsa Yoga', 'Knowledge and the Renunciation of Action'],
  ['Karma Sannyāsa Yoga', 'The Yoga of Renunciation'],
  ['Dhyāna Yoga', 'The Yoga of Meditation'],
  ['Jñāna Vijñāna Yoga', 'Knowledge and Realization'],
  ['Akṣara Brahma Yoga', 'The Imperishable Absolute'],
  ['Rāja Vidyā Rāja Guhya Yoga', 'Royal Knowledge and the Royal Secret'],
  ['Vibhūti Yoga', 'Divine Manifestations'],
  ['Viśvarūpa Darśana Yoga', 'The Vision of the Universal Form'],
  ['Bhakti Yoga', 'The Yoga of Devotion'],
  ['Kṣetra Kṣetrajña Vibhāga Yoga', 'The Field and Its Knower'],
  ['Guṇatraya Vibhāga Yoga', 'The Three Qualities'],
  ['Puruṣottama Yoga', 'The Supreme Person'],
  ['Daivāsura Sampad Vibhāga Yoga', 'Divine and Demonic Qualities'],
  ['Śraddhātraya Vibhāga Yoga', 'The Three Kinds of Faith'],
  ['Mokṣa Sannyāsa Yoga', 'Liberation through Renunciation'],
] as const;

export function getPassage(chapter: number, verse: number) {
  return corpus.verses.find((passage) => passage.chapter === chapter && passage.verse === verse);
}

export function getChapter(chapter: number) {
  return corpus.verses.filter((passage) => passage.chapter === chapter);
}

export function getAdjacentPassages(passage: Passage) {
  const index = corpus.verses.findIndex((item) => item.id === passage.id);
  return {
    previous: index > 0 ? corpus.verses[index - 1] : null,
    next: index < corpus.verses.length - 1 ? corpus.verses[index + 1] : null,
  };
}

export function searchCorpusDetailed(query: string) {
  return searchPassages(corpus.verses, query);
}

export function searchCorpus(query: string, limit = 30) {
  return searchCorpusDetailed(query).results
    .slice(0, Math.max(1, Math.min(limit, 100)))
    .map((result) => result.passage);
}

export function publicPassage(passage: Passage) {
  return {
    canonicalRef: passage.canonicalRef,
    workId: passage.workId,
    work: passage.workId,
    edition: passage.editionId,
    corpusVersion: passage.corpusVersion,
    chapter: passage.chapter,
    verse: passage.verse,
    speaker: passage.speaker,
    representations: passage.representations,
    translation: passage.translation,
    variants: passage.variants,
    provenance: passage.provenance,
    review: passage.review,
    checksum: passage.checksum,
  };
}

export function passageAsMarkdown(passage: Passage) {
  return [
    `# Bhagavad Gita ${passage.chapter}.${passage.verse}`,
    '',
    `**Canonical reference:** \`${passage.canonicalRef}\`  `,
    `**Speaker:** ${passage.speaker ?? 'Not recorded'}  `,
    `**Corpus version:** ${passage.corpusVersion}`,
    '',
    '## Sanskrit (Devanagari)',
    '',
    passage.representations.devanagari,
    '',
    '## IAST',
    '',
    passage.representations.iast,
    '',
    `## English translation — ${passage.translation.translator}, ${passage.translation.editionYear}`,
    '',
    passage.representations.english,
    '',
    `Review status: ${passage.translation.status}.`,
    '',
    `SHA-256: \`${passage.checksum}\``,
    '',
  ].join('\n');
}
