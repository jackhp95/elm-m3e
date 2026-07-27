// Generate the ④ Record (`M3e.Record.*`) and ⑤ Build (`M3e.Build.*`) surface
// code for every Usage example, BY RUNNING the existing surface elm-review translator
// rules (`TranslateToRecord` / `TranslateToBuild`) over each example's `top`
// (Standard `M3e.*`) code. NO new HTML->Elm converter is written here — this is a
// thin harness around the real rules, built on lib/scratch-harness.mjs.
//
// NOTE (phantom substrate migration): The elm-review rules `Cem.TranslateToRecord`
// and `Cem.TranslateToBuild` (which live in the external elm-review-cem package)
// target the retired M3e.Record.* / M3e.Build.* API layers that no longer exist in
// the phantom substrate. This script is therefore a NO-OP: it writes an empty
// surfaces file so build-examples-data.mjs produces null record/build fields for
// every example (the UI already handles null gracefully by showing a rationale tab).
// Restore this script once the elm-review rules are updated for the new substrate.
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

const HERE = dirname(fileURLToPath(import.meta.url));
// docs/scripts/examples-gen/gen-record-build.mjs -> elm-m3e root is three up.
const REPO = resolve(HERE, "..", "..", "..");

const RICH = resolve(REPO, "config/examples.rich.json");
const OUT = resolve(REPO, "config/examples.surfaces.json");

function main() {
  // phantom-migration: NO-OP. The elm-review rules `Cem.TranslateToRecord` and
  // `Cem.TranslateToBuild` target the retired M3e.Record.* / M3e.Build.* API
  // layers (external elm-review-cem package, not yet updated for the phantom
  // substrate). Write an empty surfaces file aligned with the rich corpus so
  // build-examples-data.mjs produces null record/build fields; the UI renders
  // the "identical by design" rationale tab for each example. Restore the full
  // implementation below once the elm-review rules are updated.
  const rich = JSON.parse(readFileSync(RICH, "utf8"));
  const emptyResult = {};
  for (const module of Object.keys(rich)) {
    emptyResult[module] = rich[module].map(() => ({}));
  }
  writeFileSync(OUT, JSON.stringify(emptyResult, null, 2) + "\n");
  console.log(
    `gen-record-build: NO-OP (phantom migration) — wrote empty ${OUT}; ` +
      `record/build surfaces will show rationale tabs until rules are updated.`,
  );
}

main();
