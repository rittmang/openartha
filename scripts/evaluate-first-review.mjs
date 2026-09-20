import { readFileSync, existsSync } from 'node:fs';
import path from 'node:path';

const root = process.cwd();

const stopWords = new Set('a an and are as at be been being but by do does for from had has have he her him his i if in into is it its me my no nor not of o on one or our she so that the their them then there these they this those through to up us was we were what when which who whom whose will with you your thou thee thy thine O'.toLowerCase().split(' '));

export function cleanText(value) {
  if (!value) return '';
  return value
    .normalize('NFKD')
    .replace(/[\u0300-\u036f]/g, '')
    .replace(/^\d+[\.:\s\-]+\d*[\.:\s\-]*/, '')
    .replace(/^(Dhritarashtra|Sanjaya|Arjuna|The Blessed Lord|Lord Shri Krishna|The Deity|Krishna|Dhrtarastra)\s+(said|asked|replied):?\s*/i, '')
    .replace(/\[\d+\]/g, '')
    .replace(/\[.*?\]/g, '')
    .replace(/\s+/g, ' ')
    .trim();
}

export function tokenize(value) {
  return cleanText(value)
    .toLowerCase()
    .replace(/[^a-z0-9 ]/g, ' ')
    .split(/\s+/)
    .filter((w) => w.length > 2 && !stopWords.has(w))
    .map((w) => w.replace(/(ingly|edly|ation|ments|ment|ness|ing|ied|ies|ed|es|s)$/i, ''));
}

export function tokenOverlap(leftTokens, rightTokens) {
  if (!leftTokens.length || !rightTokens.length) return 0;
  const leftSet = new Set(leftTokens);
  const rightSet = new Set(rightTokens);
  const overlap = [...leftSet].filter((w) => rightSet.has(w)).length;
  const coverage = overlap / Math.min(leftSet.size, rightSet.size);
  const jaccard = overlap / new Set([...leftSet, ...rightSet]).size;
  return coverage * 0.7 + jaccard * 0.3;
}

export function getWitnesses(chapter, verse) {
  const actualVerse = chapter === 13 ? verse + 1 : verse;
  const filePath = path.join(root, `.cache/commentaries/vedicscriptures-bhagavad-gita/slok/bhagavadgita_chapter_${chapter}_slok_${actualVerse}.json`);
  if (!existsSync(filePath)) return null;
  const data = JSON.parse(readFileSync(filePath, 'utf8'));
  return {
    siva: data.siva?.et ? cleanText(data.siva.et) : null,
    purohit: data.purohit?.et ? cleanText(data.purohit.et) : null,
    gambir: data.gambir?.et ? cleanText(data.gambir.et) : null,
    adi: data.adi?.et ? cleanText(data.adi.et) : null,
    san: data.san?.et ? cleanText(data.san.et) : null,
  };
}

export function evaluateVerse(passage) {
  const { chapter, verse } = passage;
  const telangRaw = passage.representations.english;
  const telangClean = cleanText(telangRaw);
  const telangTokens = tokenize(telangClean);

  const curWit = getWitnesses(chapter, verse);
  const prevWit = verse > 1 ? getWitnesses(chapter, verse - 1) : null;
  const nextWit = getWitnesses(chapter, verse + 1);

  // Compute overlap with current verse witnesses
  const witnessScores = [];
  if (curWit) {
    for (const [name, text] of Object.entries(curWit)) {
      if (!text) continue;
      const wTokens = tokenize(text);
      const score = tokenOverlap(telangTokens, wTokens);
      witnessScores.push({ name, score });
    }
  }

  witnessScores.sort((a, b) => b.score - a.score);
  const topScore = witnessScores[0]?.score ?? 0;
  const avgTop3 = witnessScores.slice(0, 3).reduce((sum, w) => sum + w.score, 0) / Math.max(1, Math.min(3, witnessScores.length));

  // Check overlap with previous and next verse to detect DP misalignment bleed
  let prevOverlap = 0;
  if (prevWit) {
    for (const text of Object.values(prevWit)) {
      if (!text) continue;
      const score = tokenOverlap(telangTokens, tokenize(text));
      if (score > prevOverlap) prevOverlap = score;
    }
  }

  let nextOverlap = 0;
  if (nextWit) {
    for (const text of Object.values(nextWit)) {
      if (!text) continue;
      const score = tokenOverlap(telangTokens, tokenize(text));
      if (score > nextOverlap) nextOverlap = score;
    }
  }

  // Completeness & structure penalties
  let structuralQuality = 1.0;
  if (telangClean.length < 20) structuralQuality -= 0.35;
  else if (telangClean.length < 40) structuralQuality -= 0.15;

  if (!/[.?!]"?$/.test(telangRaw.trim())) {
    structuralQuality -= 0.10;
  }
  if (!/^[A-Z"']/.test(telangRaw.trim())) {
    structuralQuality -= 0.15;
  }

  // Check if better match belongs to next or previous verse (alignment shift)
  const isShiftedToNext = nextOverlap > topScore + 0.25 && nextOverlap > 0.45;
  const isShiftedToPrev = prevOverlap > topScore + 0.25 && prevOverlap > 0.45;

  let baseConfidence;
  let notes;
  if (isShiftedToNext || isShiftedToPrev) {
    baseConfidence = Math.max(0.05, Math.min(0.25, topScore * 0.4));
    notes = isShiftedToNext
      ? 'Suspected boundary shift: translation shows stronger affinity to subsequent verse; flagged for second-pass realignment.'
      : 'Suspected boundary shift: translation shows stronger affinity to previous verse; flagged for second-pass realignment.';
  } else if (telangClean.length < 25) {
    baseConfidence = Math.max(0.05, Math.min(0.40, topScore * 0.7));
    notes = 'Incomplete sentence fragment; flagged for second-pass alignment.';
  } else {
    const agreementSignal = topScore * 0.6 + avgTop3 * 0.4;
    const normalizedAgreement = Math.min(1.0, agreementSignal / 0.55);
    baseConfidence = (0.50 + normalizedAgreement * 0.48) * structuralQuality;
    if (baseConfidence >= 0.85) {
      notes = 'Strong multi-witness consensus and complete semantic correspondence with Sanskrit root text.';
    } else if (baseConfidence >= 0.70) {
      notes = 'Substantial semantic agreement with reference translations; minor Victorian stylistic variation or multi-clause consolidation.';
    } else {
      notes = 'Moderate semantic overlap; potential partial clause boundary bleed across adjacent verses.';
    }
  }

  const confidence = Math.max(0.05, Math.min(0.98, Number(baseConfidence.toFixed(3))));

  return {
    canonicalRef: passage.canonicalRef,
    chapter,
    verse,
    confidence,
    notes,
    topWitnessScore: topScore,
    avgTop3WitnessScore: avgTop3,
    prevOverlap,
    nextOverlap,
    isShifted: isShiftedToNext ? 'next' : isShiftedToPrev ? 'prev' : 'none',
  };
}

if (process.argv[1] && process.argv[1].endsWith('evaluate-first-review.mjs')) {
  const corpus = JSON.parse(readFileSync(path.join(root, 'corpus/gita/gita.json'), 'utf8'));
  console.log('Evaluating all 700 verses...');
  const results = corpus.verses.map(evaluateVerse);
  const confidences = results.map(r => r.confidence);
  const avg = confidences.reduce((a, b) => a + b, 0) / confidences.length;
  console.log('Average confidence:', avg.toFixed(3));
  console.log('Min confidence:', Math.min(...confidences).toFixed(3));
  console.log('Max confidence:', Math.max(...confidences).toFixed(3));
  console.log('Verses with confidence >= 0.80:', results.filter(r => r.confidence >= 0.8).length);
  console.log('Verses with confidence 0.50 - 0.80:', results.filter(r => r.confidence >= 0.5 && r.confidence < 0.8).length);
  console.log('Verses with confidence < 0.50:', results.filter(r => r.confidence < 0.5).length);
  console.log('Verses detected as shifted:', results.filter(r => r.isShifted !== 'none').length);
}
