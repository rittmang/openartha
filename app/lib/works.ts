import { corpus } from '@/app/lib/corpus';
import { commentarySource } from '@/app/lib/commentaries';

export type WorkRecord = {
  id: string;
  title: string;
  originalTitle: string;
  language: string;
  passageCount: number;
  route: string;
  apiRoot: string;
  currentCorpusVersion: string;
  currentCommentaryVersion: string;
};

export const works: WorkRecord[] = [{
  id: corpus.work.id,
  title: corpus.work.title,
  originalTitle: corpus.work.originalTitle,
  language: corpus.work.language,
  passageCount: corpus.work.passageCount,
  route: '/gita',
  apiRoot: '/api/v2/works/gita',
  currentCorpusVersion: corpus.corpusVersion,
  currentCommentaryVersion: commentarySource.corpusVersion,
}];

export function getWork(id: string) {
  return works.find((work) => work.id === id);
}
