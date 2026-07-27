// Rule round-trip verification (report-first — NOT wired into build:assets or CI).
//
// Proves how close `Cem.PreferBarrel` (per-component -> barrel) and
// `Cem.PreferSpecificSlot` (barrel -> per-component) are to being TRUE INVERSES,
// over the real docs example corpus. For every example's Standard `top`:
//
//   1. BARRELISE it (run PreferBarrel), compile-verify.
//   2. SPECIALISE the barrel form (run PreferSpecificSlot), compile-verify.
//   3. Compare specialise(barrelise(top)) to the original `top`, modulo
//      elm-format, at the expression level (imports are regenerated, so they're
//      not part of the comparison — same as gen-barrel.mjs).
//
// A clean round trip means the two rules composed back to identity. Mismatches
// are categorized (deliberate asymmetries vs. candidate rule bugs) and a few
// samples are surfaced. Writes docs/data/rule-roundtrip-report.json + a console
// summary. Report-first: it never fails the build; run it on demand with
// `npm run verify:rule-roundtrip`.
//
// The scratch-app / edit-application machinery is shared with gen-barrel.mjs and
// gen-record-build.mjs via lib/scratch-harness.mjs.

import { readFileSync, writeFileSync } from "node:fs";
import { execFileSync } from "node:child_process";
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
const REPO = resolve(HERE, "..", "..", "..");
const SRC_DIRS = [`${REPO}/src`, `${REPO}/docs/kit`];
const ELM_BIN = `${REPO}/docs/node_modules/.bin/elm`;
const REVIEW_BIN = `${REPO}/docs/node_modules/.bin/elm-review`;
const ELM_FORMAT = `${REPO}/docs/node_modules/.bin/elm-format`;

const RICH = resolve(REPO, "config/examples.rich.json");
const REPORT = resolve(REPO, "docs/data/rule-roundtrip-report.json");

const reviewElm = JSON.parse(readFileSync(`${REPO}/review/elm.json`, "utf8"));

// Normalize an expression modulo elm-format (wrap as `s =`, format, unwrap).
function fmt(code) {
  const wrapped = "module F exposing (s)\n\n\ns =\n" + code.split("\n").map((l) => "    " + l).join("\n") + "\n";
  try {
    const out = execFileSync(ELM_FORMAT, ["--stdin"], { input: wrapped, encoding: "utf8", stdio: ["pipe", "pipe", "ignore"] });
    const marker = "\ns =\n";
    const i = out.indexOf(marker);
    if (i < 0) return null;
    return out.slice(i + marker.length).replace(/\s+$/, "").split("\n").map((l) => (l.startsWith("    ") ? l.slice(4) : l)).join("\n");
  } catch {
    return null;
  }
}

// Run one rule over the given { name -> code } items; return { name -> rewritten code }.
// `imports` are the ReviewConfig import lines; `ruleExpr` the single rule expression.
function runRule(items, imports, ruleExpr) {
  const cfgDir = mkScratchDir("rt-cfg");
  const targetDir = mkScratchDir("rt-target");
  writeReviewConfig(cfgDir, {
    reviewSrcDir: `${REPO}/review/src`,
    reviewElm,
    extraSourceDirs: [`${REPO}/src`, `${REPO}/../elm-review-cem/src`],
    reviewConfigElm: `module ReviewConfig exposing (config)

${imports.join("\n")}
import Review.Rule exposing (Rule)


config : List Rule
config =
    [ ${ruleExpr} ]
`,
  });
  const text = writeCorpusApp(targetDir, items, SRC_DIRS);
  const json = runReviewJson(REVIEW_BIN, cfgDir, targetDir, ELM_BIN);
  return parseBindings(applyEditsPartial(text, json));
}

// Heuristic categorization of a round-trip mismatch cause.
function categorize(original, roundtripped) {
  const has = (s, re) => re.test(s);
  // The barrel specialise vocabulary for slots differs from the per-component one.
  if (has(roundtripped, /\bM3e\.\w*[sS]lot\w+/) || has(roundtripped, /\bM3e\.\w+SlotDefault\b/)) return "slot-vocabulary";
  if (has(roundtripped, /\bM3e\.value\b/) || has(roundtripped, /\bM3e\.name\b/)) return "scalar-value-name";
  return "other";
}

function main() {
  const rich = JSON.parse(readFileSync(RICH, "utf8"));

  const items = [];
  for (const module of Object.keys(rich)) {
    rich[module].forEach((ex, idx) => {
      if (ex.top == null) return;
      items.push({ module, idx, name: bindingName(module, idx), code: ex.top });
    });
  }

  // Pass 1: barrelise (per-component -> barrel).
  const barrelImports = ["import Cem.PreferBarrel", "import M3e.Review.Facts", "import Set"];
  const barrelExpr = "Cem.PreferBarrel.ruleWith (Set.fromList M3e.Review.Facts.reExposedValueTokens) M3e.Review.Facts.facts";
  const barrelByName = runRule(items, barrelImports, barrelExpr);
  const barrelCandidates = {};
  for (const it of items) barrelCandidates[it.name] = barrelByName[it.name] ?? it.code;
  const barrelOk = compilingNames(barrelCandidates);

  // A barrelised form that doesn't compile falls back to the Standard top (same
  // as gen-barrel.mjs) — that example simply isn't barrelised, so its round trip
  // is trivially identity. Track which examples actually barrelised.
  const barrelised = new Set();
  for (const it of items) {
    const code = barrelByName[it.name];
    if (code && barrelOk.has(it.name) && code !== it.code) {
      barrelised.add(it.name);
    } else {
      barrelCandidates[it.name] = it.code; // fallback to Standard
    }
  }

  // Pass 2: specialise (barrel -> per-component) over the barrelised forms.
  const barrelItems = items.map((it) => ({ ...it, code: barrelCandidates[it.name] }));
  const specImports = ["import Cem.PreferSpecificSlot", "import M3e.Review.Facts"];
  const specExpr = "Cem.PreferSpecificSlot.rule M3e.Review.Facts.facts";
  const specByName = runRule(barrelItems, specImports, specExpr);
  const specCandidates = {};
  for (const it of items) specCandidates[it.name] = specByName[it.name] ?? barrelCandidates[it.name];
  const specOk = compilingNames(specCandidates);

  // Round-trip is only meaningful over examples that actually BARRELISED. The
  // rest fall back to Standard (no transformation) — trivially identity.
  // Among barrelised examples, `slot-vocabulary` mismatches are an ALLOWLISTED,
  // documented asymmetry (see the report notes); anything else is unexpected.
  const stats = {
    total: items.length,
    barrelised: barrelised.size,
    notBarrelised: items.length - barrelised.size,
    clean: 0,
    slotVocabularyAsymmetry: 0,
    unexpectedMismatch: 0,
    specialiseCompileFail: 0,
    formatFail: 0,
  };
  const samples = [];
  const cells = [];

  for (const it of items) {
    if (!barrelised.has(it.name)) {
      cells.push({ module: it.module, idx: it.idx, status: "not-barrelised" });
      continue;
    }
    let status;
    if (!specOk.has(it.name)) {
      status = "specialise-compile-fail";
      stats.specialiseCompileFail++;
    } else {
      const a = fmt(it.code);
      const b = fmt(specCandidates[it.name]);
      if (a == null || b == null) {
        status = "format-fail";
        stats.formatFail++;
      } else if (a === b) {
        status = "clean";
        stats.clean++;
      } else if (categorize(it.code, specCandidates[it.name]) === "slot-vocabulary") {
        status = "slot-vocabulary-asymmetry";
        stats.slotVocabularyAsymmetry++;
        if (samples.length < 12) samples.push({ module: it.module, idx: it.idx, category: "slot-vocabulary", original: a, roundtripped: b });
      } else {
        status = "unexpected-mismatch";
        stats.unexpectedMismatch++;
        // Always surface unexpected mismatches — those are the ones to chase.
        samples.push({ module: it.module, idx: it.idx, category: "unexpected", original: a, roundtripped: b });
      }
    }
    cells.push({ module: it.module, idx: it.idx, status });
  }

  const notes = [
    "Round-trip = specialise(barrelise(top)) compared to the original Standard top, modulo elm-format, at the expression level (imports regenerated).",
    "notBarrelised: barrelisation didn't compile, so gen-barrel keeps the Standard top — round trip is trivially identity.",
    "slot-vocabulary-asymmetry (ALLOWLISTED): a barrelised slot round-trips to the component-specific BARREL name (e.g. M3e.AppBar.leading -> M3e.slotLeading -> M3e.appBarSlotLeading) rather than back to the per-component setter. The ENDPOINTS coincide in type: M3e.appBarSlotLeading IS M3e.AppBar.leading re-exported under a flat name (same phantom row, same output), so only the literal name differs. NOTE the intermediate generalized name (M3e.slotLeading / M3e.slotIcon) is NOT the same type — it points at M3e.Html.Shared with a distinct, narrower phantom (e.g. slotIcon accepts { icon } vs Button.icon's { icon, loadingIndicator }); that narrowing is likely why some examples can't barrelise at all. PreferSpecificSlot's slot-upgrade class targets the specific barrel name (its namesake behavior), not the per-component module. Everything else round-trips exactly.",
    "unexpectedMismatch: any mismatch NOT explained by the slot vocabulary — these are candidate rule bugs.",
  ];
  const report = { generatedAtNote: "stamp externally; Date.now() intentionally not embedded", notes, stats, samples, cells };
  writeFileSync(REPORT, JSON.stringify(report, null, 2) + "\n");

  const denom = stats.barrelised || 1;
  const pct = (n) => `${((100 * n) / denom).toFixed(1)}%`;
  console.log(`\nRule round-trip (specialise ∘ barrelise) over ${stats.total} examples:`);
  console.log(`  barrelised            ${stats.barrelised}  (round-trip denominator)`);
  console.log(`  not barrelised        ${stats.notBarrelised}  (fell back to Standard — trivially identity)`);
  console.log(`\n  Of the ${stats.barrelised} barrelised:`);
  console.log(`    clean round trip                ${stats.clean} (${pct(stats.clean)})`);
  console.log(`    slot-vocabulary asymmetry (OK)  ${stats.slotVocabularyAsymmetry} (${pct(stats.slotVocabularyAsymmetry)})`);
  console.log(`    UNEXPECTED mismatch             ${stats.unexpectedMismatch} (${pct(stats.unexpectedMismatch)})`);
  if (stats.specialiseCompileFail) console.log(`    specialise compile fail         ${stats.specialiseCompileFail}`);
  if (stats.formatFail) console.log(`    format fail                     ${stats.formatFail}`);
  const accounted = stats.clean + stats.slotVocabularyAsymmetry;
  console.log(`\n  => ${accounted}/${stats.barrelised} (${pct(accounted)}) round-trip cleanly OR via the one allowlisted slot asymmetry.`);
  console.log(`\nwrote ${REPORT}`);
}

main();
