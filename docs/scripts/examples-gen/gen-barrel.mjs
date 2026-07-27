// Barrelise every Usage example's TOP (Standard `M3e.*`) code by RUNNING the
// opt-in `PreferBarrel` elm-review rule over it, then write the barrel-first
// result into a SEPARATE, index-aligned sidecar `config/examples.barrel.json`
//
// NOTE (phantom substrate migration): The `Cem.PreferBarrel` elm-review rule
// (external elm-review-cem package) has not yet been updated for the phantom
// substrate. This script is therefore a NO-OP: it writes an all-null barrel file
// so build-examples-data.mjs falls back to the Standard `top` for every example.
// Restore the full implementation once the rule is updated.
// (exactly like gen-record-build.mjs writes examples.surfaces.json). The rich
// file's `top` is LEFT UNTOUCHED so it stays the Standard source-of-truth that the
// ④ Record / ⑤ Build translators derive from — this step is therefore order- and
// re-run-independent. build-examples-data.mjs prefers the barrel `top` for the
// docs `top` field, falling back to the Standard `top` where barrelisation was
// rejected. Shape: { "<Module>": [ "<barrelTop>" | null, ... ] } (null = keep
// Standard). This step may run any time after build:examples-surfaces; it reads
// only `top` from the rich file.
//
// This is a thin report-driven harness around the real rule (same shape as
// gen-record-build.mjs), built on lib/scratch-harness.mjs:
//   1. Write ALL examples' `top` as bindings into one scratch Elm APPLICATION
//      (source-dirs = real library sources) — the compile-verified corpus.
//   2. Write a scratch elm-review CONFIG whose single rule is `PreferBarrel.rule`.
//   3. Run `elm-review --report=json` (NOT --fix). Apply the rename edits ourselves
//      in one pass (each `M3e.<Comp>.view`/`.<setter>` / `M3e.Token.<token>` node
//      → its flat `M3e.<name>` barrel export). We SKIP the rule's zero-width
//      `import M3e` insertions — imports are regenerated from references here.
//   4. Recover each binding, compile-verify the whole barrelised set, and keep an
//      output only if it COMPILES (the barrel is a faithful re-export, so it
//      always should); otherwise fall back to the original Standard `top`.
//
// `PreferBarrel` deliberately leaves `M3e.<Comp>.child` / `.children` / `.name` /
// `M3e.<Comp>.value` qualified (those names are NOT in the barrel), so a barrelised
// button top reads `M3e.button [ M3e.variant M3e.filled ] [ M3e.Button.child (…) ]`.

import { readFileSync, writeFileSync } from "node:fs";
import { dirname, resolve } from "node:path";
import { fileURLToPath } from "node:url";

const HERE = dirname(fileURLToPath(import.meta.url));
// docs/scripts/examples-gen/gen-barrel.mjs -> elm-m3e root is three up.
const REPO = resolve(HERE, "..", "..", "..");

const RICH = resolve(REPO, "config/examples.rich.json");
const BARREL = resolve(REPO, "config/examples.barrel.json");

const REVIEW_CONFIG = `module ReviewConfig exposing (config)

import Cem.PreferBarrel
import M3e.Review.Facts
import Review.Rule exposing (Rule)
import Set


config : List Rule
config =
    [ Cem.PreferBarrel.ruleWith (Set.fromList M3e.Review.Facts.reExposedValueTokens) M3e.Review.Facts.facts ]
`;

function main() {
  // phantom-migration: NO-OP. `Cem.PreferBarrel` (external elm-review-cem) has not
  // been updated for the phantom substrate. Write an all-null barrel file so
  // build-examples-data.mjs falls back to the Standard `top` for every example.
  const rich = JSON.parse(readFileSync(RICH, "utf8"));
  const out = {};
  for (const module of Object.keys(rich)) out[module] = rich[module].map(() => null);
  writeFileSync(BARREL, JSON.stringify(out, null, 2) + "\n");
  console.log(
    `gen-barrel: NO-OP (phantom migration) — wrote all-null ${BARREL}; ` +
      `Standard top used for every example until PreferBarrel rule is updated.`,
  );
}

main();
