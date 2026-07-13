// Generate the ④ Record (`M3e.Record.*`) and ⑤ Build (`M3e.Build.*`) surface
// code for every Usage example, BY RUNNING the existing surface elm-review translator
// rules (`TranslateToRecord` / `TranslateToBuild`) over each example's `top`
// (Standard `M3e.*`) code. NO new HTML->Elm converter is written here — this is a
// thin harness around the real rules, built on lib/scratch-harness.mjs.
//
// Mechanism (per surface):
//   1. Write ALL examples' `top` code as bindings into one scratch Elm
//      APPLICATION (a fresh tmpdir, source-dirs = real library sources) — the
//      same pattern verify-examples.mjs uses. The `top` bindings all compile
//      (they are the compile-verified corpus), which elm-review requires.
//   2. Write a scratch elm-review CONFIG (a per-surface tmpdir) whose single
//      rule is `TranslateTo<Surface>.rule M3e.Review.Facts.facts`. (We copy
//      review/src into the config's src and overwrite ReviewConfig.elm; pointing
//      source-directories straight at review/src collides with its own
//      ReviewConfig and runs the FULL rule set.)
//   3. Run `elm-review --report=json` (NOT --fix). The JSON report carries each
//      error's `fix` as explicit {range,string} edits. We apply the target-surface
//      CONVERSION edits and SKIP the whole-node Seam-escape edits ourselves in ONE
//      pass — a PARTIAL conversion: convert whatever converts, leave every
//      un-converted node as its original Standard source.
//
//      Why not `--fix-all-without-prompt`: for a node the rule can't cleanly
//      convert it emits a whole-node `Seam.fromHtml (M3e.Raw.* ...)` escape
//      — an Html-surface call the SAME rule re-triggers on, wrapping it again on
//      every fixpoint iteration → unbounded growth → node stack overflow. A
//      single report-driven pass sidesteps the fixpoint entirely.
//   4. Recover each binding's rewritten code, compile-verify the whole set, and
//      keep an output only if it COMPILES and actually reaches the target surface
//      (contains `M3e.Record.` / `M3e.Build.`). Everything else (identity, or a
//      mixed tree that doesn't type-check) FALLS BACK to the `top` code so the
//      tab is never broken (the UI then hides the Record/Build tab).
//
// Output: config/examples.surfaces.json = { "<Module>": [ { record, build }, ... ] }
// aligned index-for-index with config/examples.rich.json. build-examples-data.mjs
// would merge these into docs/data/examples.json (with the elm-format pass).

import { readFileSync, writeFileSync } from "node:fs";
import { dirname, resolve } from "node:path";
import { fileURLToPath } from "node:url";
import {
  mkScratchDir,
  writeCorpusApp,
  writeReviewConfig,
  runReviewJson,
  applyEditsPartial,
  parseBindings,
  bindingName,
} from "./lib/scratch-harness.mjs";
import { compilingNames } from "./verify-examples.mjs";

const HERE = dirname(fileURLToPath(import.meta.url));
// docs/scripts/examples-gen/gen-record-build.mjs -> elm-m3e root is three up.
const REPO = resolve(HERE, "..", "..", "..");
const SRC_DIRS = [`${REPO}/src`, `${REPO}/docs/kit`];
const ELM_BIN = `${REPO}/docs/node_modules/.bin/elm`;
const REVIEW_BIN = `${REPO}/docs/node_modules/.bin/elm-review`;

const RICH = resolve(REPO, "config/examples.rich.json");
const OUT = resolve(REPO, "config/examples.surfaces.json");

const RULE = { record: "Cem.TranslateToRecord", build: "Cem.TranslateToBuild" };
const TOKEN = { record: "M3e.Record.", build: "M3e.Build." };

const reviewElm = JSON.parse(readFileSync(`${REPO}/review/elm.json`, "utf8"));

function reviewConfigFor(surface) {
  return `module ReviewConfig exposing (config)

import Review.Rule exposing (Rule)
import ${RULE[surface]}
import M3e.Review.Facts


config : List Rule
config =
    [ ${RULE[surface]}.rule M3e.Review.Facts.facts ]
`;
}

function main() {
  const rich = JSON.parse(readFileSync(RICH, "utf8"));

  // Flatten every example to a binding keyed by (module, idx).
  const items = [];
  for (const module of Object.keys(rich)) {
    rich[module].forEach((ex, idx) => {
      // A degraded example may have a null top (no strict M3e surface): there is
      // no source to translate to Record/Build, so its entry stays {} (default).
      if (ex.top == null) return;
      items.push({ module, idx, name: bindingName(module, idx), code: ex.top });
    });
  }

  const result = {}; // module -> [ { record, build } ]
  for (const module of Object.keys(rich)) result[module] = rich[module].map(() => ({}));

  const stats = {};
  for (const surface of ["record", "build"]) {
    const cfgDir = mkScratchDir(`d6-cfg-${surface}`);
    const targetDir = mkScratchDir("d6-target");
    writeReviewConfig(cfgDir, {
      reviewSrcDir: `${REPO}/review/src`,
      reviewElm,
      // The codegen-aware translator rules now live in the jackhp95/elm-review-cem
      // package; pull them in via source-dir until it is a published dependency.
      extraSourceDirs: [`${REPO}/src`, `${REPO}/../elm-review-cem/src`],
      reviewConfigElm: reviewConfigFor(surface),
    });
    const text = writeCorpusApp(targetDir, items, SRC_DIRS);
    const json = runReviewJson(REVIEW_BIN, cfgDir, targetDir, ELM_BIN, { label: surface });
    // Apply only the real target-surface CONVERSION edits; SKIP the whole-node
    // Seam-escape fallbacks (their replacement never reaches the target surface),
    // leaving every un-converted node exactly as it was (valid Standard `M3e.*`).
    // (Empirically the two classes are disjoint: no edit both reaches the target
    // surface and is a Seam escape, so filtering on the target token alone cleanly
    // selects conversions.)
    const token = TOKEN[surface];
    const fixedByName = parseBindings(
      applyEditsPartial(text, json, { skip: (f) => !f.string.includes(token) }),
    );

    // Candidate = code that reached the target surface (partial conversions
    // included — a mixed Standard/target tree still counts). Otherwise the rule
    // produced pure Seam residue (or identity) — fall back to top.
    const candidates = {};
    for (const it of items) {
      const code = fixedByName[it.name];
      if (code && code.includes(TOKEN[surface])) candidates[it.name] = code;
    }
    const ok = compilingNames(candidates);

    let converted = 0, partial = 0, fallback = 0;
    for (const it of items) {
      const code = candidates[it.name];
      const accept = code && ok.has(it.name);
      const use = accept ? code : rich[it.module][it.idx].top;
      if (accept) {
        converted++;
        // Partial = compiles + has a target ref but ALSO retains a Standard
        // 2-segment `M3e.<Comp>.view` container/node (mixed tree).
        if (/\bM3e\.[A-Z][A-Za-z0-9_]*\.view\b/.test(code)) partial++;
      } else {
        fallback++;
      }
      result[it.module][it.idx][surface] = use;
    }
    stats[surface] = { converted, partial, fallback };
  }

  writeFileSync(OUT, JSON.stringify(result, null, 2) + "\n");
  const total = items.length;
  console.log(`wrote ${OUT} — ${total} examples`);
  for (const s of ["record", "build"]) {
    const full = stats[s].converted - stats[s].partial;
    console.log(
      `  ${s}: ${stats[s].converted} converted (compiled + reached ${TOKEN[s]}*) ` +
        `= ${full} full + ${stats[s].partial} partial (mixed Standard/target tree), ` +
        `${stats[s].fallback} fell back to top`,
    );
  }
}

main();
