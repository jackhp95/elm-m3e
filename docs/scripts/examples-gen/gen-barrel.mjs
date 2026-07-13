// Barrelise every Usage example's TOP (Standard `M3e.*`) code by RUNNING the
// opt-in `PreferBarrel` elm-review rule over it, then write the barrel-first
// result into a SEPARATE, index-aligned sidecar `config/examples.barrel.json`
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
// docs/scripts/examples-gen/gen-barrel.mjs -> elm-m3e root is three up.
const REPO = resolve(HERE, "..", "..", "..");
const SRC_DIRS = [`${REPO}/src`, `${REPO}/docs/kit`];
const ELM_BIN = `${REPO}/docs/node_modules/.bin/elm`;
const REVIEW_BIN = `${REPO}/docs/node_modules/.bin/elm-review`;

const RICH = resolve(REPO, "config/examples.rich.json");
const BARREL = resolve(REPO, "config/examples.barrel.json");

const reviewElm = JSON.parse(readFileSync(`${REPO}/review/elm.json`, "utf8"));

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
  const rich = JSON.parse(readFileSync(RICH, "utf8"));

  const items = [];
  for (const module of Object.keys(rich)) {
    rich[module].forEach((ex, idx) => {
      // A degraded example may have a null top (no strict M3e surface): nothing
      // to barrel-rewrite, so leave its sidecar entry null (already the default).
      if (ex.top == null) return;
      items.push({ module, idx, name: bindingName(module, idx), code: ex.top });
    });
  }

  const cfgDir = mkScratchDir("barrel-cfg");
  const targetDir = mkScratchDir("barrel-target");
  writeReviewConfig(cfgDir, {
    reviewSrcDir: `${REPO}/review/src`,
    reviewElm,
    // The codegen-aware rules now live in the jackhp95/elm-review-cem package;
    // pull them in via source-dir until it is a published dependency.
    extraSourceDirs: [`${REPO}/src`, `${REPO}/../elm-review-cem/src`],
    reviewConfigElm: REVIEW_CONFIG,
  });
  const text = writeCorpusApp(targetDir, items, SRC_DIRS);
  const json = runReviewJson(REVIEW_BIN, cfgDir, targetDir, ELM_BIN);
  const barreledByName = parseBindings(applyEditsPartial(text, json));

  // Verify the WHOLE barrelised corpus compiles; keep a barrelised top only if it
  // compiles, otherwise fall back to the original Standard top (the barrel is a
  // faithful re-export, so a fallback would indicate a rule bug — none expected).
  const candidates = {};
  for (const it of items) candidates[it.name] = barreledByName[it.name] ?? it.code;
  const ok = compilingNames(candidates);

  // Sidecar aligned index-for-index with rich[module]: barrel top string, or null
  // to keep the Standard top (fallback, or already barrel-identical → no gain).
  const out = {};
  for (const module of Object.keys(rich)) out[module] = rich[module].map(() => null);

  let barreled = 0, unchanged = 0, fallback = 0;
  for (const it of items) {
    const code = barreledByName[it.name];
    const accept = code && ok.has(it.name);
    if (!accept) {
      fallback++;
      continue; // sidecar stays null → build-examples-data uses the Standard top
    }
    if (code === it.code) {
      unchanged++;
      continue; // no change from Standard → leave null
    }
    barreled++;
    out[it.module][it.idx] = code;
  }

  writeFileSync(BARREL, JSON.stringify(out, null, 2) + "\n");
  console.log(
    `wrote ${BARREL} — ${items.length} examples: ${barreled} barrelised, ` +
      `${unchanged} already barrel/no-op, ${fallback} fell back to Standard top`,
  );

  // An all-null barrel (zero barrelised results) over a non-empty corpus almost
  // always means the elm-review app failed to compile — PreferBarrel then emits
  // no fix edits, every example silently falls back to its Standard top, and the
  // barrel surface vanishes without any error. Fail loudly rather than pass a
  // hollow barrel down the pipeline.
  if (items.length > 0 && barreled === 0) {
    console.error(
      `\nFATAL: gen-barrel produced 0 barrelised examples from ${items.length} ` +
        `candidates (all-null). This usually means the elm-review app did not ` +
        `compile (no PreferBarrel fixes were emitted). Refusing to pass silently.`,
    );
    process.exit(1);
  }
}

main();
