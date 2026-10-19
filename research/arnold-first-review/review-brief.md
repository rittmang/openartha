User explicitly requests the first independent review of Sir Edwin Arnold's Bhagavad Gita alignment using Gemini 3.8 Flash through OpenCode. You are that reviewer, running as openrouter/google/gemini-3.8-flash through the OpenCode provider. Repository: /Users/ritomgupta/Desktop/Others/agentic-gita. Read AGENTS.md. Do not use a browser, push, deploy, modify app/corpus code, or delegate further. Work only on the assigned chapter review output files under research/arnold-first-review/reviews/.

The source is Project Gutenberg #2388, The Song Celestial, 1900 digitized edition. A different model (gpt-6.1-sol) manually aligned it to the standard 700-reference Sanskrit canon. It currently has 684 nonempty records, 16 claimed source omissions, and four shared two-verse spans. These are claims to evaluate, not approvals to inherit. Chapter 13 has 34 canonical verses; Arjuna's alternate opening is paratext, and Krishna's field/knower statement is canonical 13.1.

Read research/arnold-first-review/input-manifest.json and every assigned input file inputs/chapter-NN.json. Each contains the entire Arnold chapter with local line numbers, all translator notes, paratext, canonical Sanskrit and IAST, proposed per-verse text and exact source spans, and three independently verse-numbered English witnesses. Witnesses may contain placeholders, duplicated or erroneous translations (notably Sivananda 18.45 is wrong), so prioritize Sanskrit, source context, and agreement of the other witnesses. Source marker anomalies are preserved (chapter VIII repeats FN14 for the gap explained by note15; chapter X uses lowercase l in FNl6; chapter XVI note33 claims ten omitted shlokas but the standard chapter leaves only two). Do not silently repair Arnold's translation or treat a historical translation disagreement as an app alignment failure.

Assess EACH assigned canonical reference semantically, including every claimed omission and shared range. Look for neighboring-verse contamination, misplaced clauses, wrongly cut lists, incomplete/incorrect shared ranges, accidentally dropped lines, and shifted numbering. Distinguish source abridgment/interpretation from our mapping mistakes. An actual source omission can be VERIFIED if correctly identified; never invent missing translation. For findings give exact source line/anchor suggestions and affected canonical references. Judge whether an alignment is usable as supplied, not whether the source is a perfect literal Sanskrit translation. Do not merely check counts or rely on prior labels. Include specific notes per verse rather than boilerplate.

Create one valid JSON file per assigned chapter: research/arnold-first-review/reviews/chapter-NN.json. Schema:
{
 "schemaVersion":1,
 "reviewerModel":"google/gemini-3.8-flash",
 "providerModel":"openrouter/google/gemini-3.8-flash",
 "transport":"opencode",
 "reviewedCommit":"COPY from input manifest",
 "sourceSha256":"COPY from input manifest",
 "chapter":NUMBER,
 "inputSha256":"COPY that chapter hash from input manifest",
 "reviews":[
  {"canonicalRef":"gita.C.V","alignmentFingerprint":"COPY from that input record",
   "status":"verified" OR "needs-correction" OR "uncertain",
   "confidence":NUMBER 0 through 1 (your actual self-assessed alignment confidence, not a calibrated probability),
   "notes":"Specific semantic/source reasoning, concise",
   "suggestedCorrection":null OR {"affectedRefs":["gita.C.V"],"sourceBoundarySuggestion":"Exact local line number and anchor, or explicit omission/shared-span correction","reason":"Why current assignment is wrong"}}
 ],
 "chapterFindings":["Any cross-verse concerns or source limitations"]
}
Every assigned reference must appear exactly once in order. Never mark unreviewed records verified. Write the real findings even if most/all are correct. Validate JSON and coverage after writing. In your final response summarize assessed count, status totals, substantive findings, and output paths. Do not make commits.
