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
// The scratch-app / edit-application machinery mirrors gen-barrel.mjs (kept
// self-contained so this dev tool never perturbs the build-critical barrel gen).

import { readFileSync, writeFileSync, mkdirSync, rmSync, existsSync } from "node:fs";
import { execFileSync } from "node:child_process";
import { dirname, resolve } from "node:path";
import { fileURLToPath } from "node:url";
import { verifyExamples } from "./verify-examples.mjs";

const HERE = dirname(fileURLToPath(import.meta.url));
const REPO = resolve(HERE, "..", "..", "..");
const LIB_SRC = `${REPO}/packages/m3e/src`;
const KIT_SRC = `${REPO}/packages/m3e-kit/src`;
const ELM_BIN = `${REPO}/docs/node_modules/.bin/elm`;
const REVIEW_BIN = `${REPO}/docs/node_modules/.bin/elm-review`;
const ELM_FORMAT = `${REPO}/docs/node_modules/.bin/elm-format`;

const RICH = resolve(REPO, "config/examples.rich.json");
const REPORT = resolve(REPO, "docs/data/rule-roundtrip-report.json");

const TARGET = "/tmp/rt-target";
const CFG = "/tmp/rt-cfg";

const reviewElm = JSON.parse(readFileSync(`${REPO}/review/elm.json`, "utf8"));
const DIRECT = { "elm/core": "1.0.5", "elm/html": "1.0.1", "elm/json": "1.1.4", "elm/virtual-dom": "1.0.5" };
const INDIRECT = { "elm/time": "1.0.0" };

const STDLIB = new Set(["Html", "Json", "VirtualDom", "Basics", "Dict", "Set", "List", "Maybe", "Result", "String", "Char", "Tuple", "Array"]);

function referencedModules(code) {
  const mods = new Set();
  const re = /\b([A-Z][A-Za-z0-9_]*(?:\.[A-Z][A-Za-z0-9_]*)*)\.[a-z]/g;
  let m;
  while ((m = re.exec(code)) !== null) mods.add(m[1]);
  return mods;
}
function moduleResolves(mod) {
  const rel = mod.replace(/\./g, "/") + ".elm";
  return STDLIB.has(mod.split(".")[0]) || existsSync(resolve(LIB_SRC, rel)) || existsSync(resolve(KIT_SRC, rel));
}
function bindingName(module, idx) {
  return `e_${module.replace(/\./g, "_")}_${idx}`;
}

// One binding per item.code; imports regenerated from references. Returns text.
function writeTarget(items) {
  rmSync(TARGET, { recursive: true, force: true });
  mkdirSync(resolve(TARGET, "src"), { recursive: true });
  writeFileSync(resolve(TARGET, "elm.json"), JSON.stringify({
    type: "application",
    "source-directories": [LIB_SRC, KIT_SRC, "src"],
    "elm-version": "0.19.1",
    dependencies: { direct: DIRECT, indirect: INDIRECT },
    "test-dependencies": { direct: {}, indirect: {} },
  }, null, 4) + "\n");

  const imports = new Set();
  for (const it of items)
    for (const mod of referencedModules(it.code))
      if (moduleResolves(mod)) imports.add(mod);

  const lines = ["module Verify exposing (..)", ""];
  for (const mod of [...imports].sort()) lines.push(`import ${mod}`);
  lines.push("");
  for (const it of items) {
    lines.push(`${it.name} =`);
    lines.push(it.code.split("\n").map((l) => "    " + l).join("\n"));
    lines.push("");
  }
  const text = lines.join("\n") + "\n";
  writeFileSync(resolve(TARGET, "src", "Verify.elm"), text);
  return text;
}

// Scratch review config with a single rule. `ruleConfig` is the Elm expression
// list body (imports handled by the caller-provided `imports` lines).
function writeConfig(imports, ruleExpr) {
  rmSync(CFG, { recursive: true, force: true });
  mkdirSync(resolve(CFG, "src"), { recursive: true });
  execFileSync("cp", ["-R", `${REPO}/review/src/.`, resolve(CFG, "src")]);
  writeFileSync(resolve(CFG, "elm.json"), JSON.stringify({
    type: "application",
    "source-directories": ["src", `${REPO}/packages/m3e/src`, `${REPO}/../elm-review-cem/src`],
    "elm-version": "0.19.1",
    dependencies: reviewElm.dependencies,
    "test-dependencies": reviewElm["test-dependencies"],
  }, null, 4) + "\n");
  writeFileSync(resolve(CFG, "src", "ReviewConfig.elm"),
`module ReviewConfig exposing (config)

${imports.join("\n")}
import Review.Rule exposing (Rule)


config : List Rule
config =
    [ ${ruleExpr} ]
`);
}

function runReviewJson() {
  try {
    const out = execFileSync(REVIEW_BIN, [
      TARGET, "--config", CFG, "--compiler", ELM_BIN, "--report=json",
    ], { encoding: "utf8", stdio: ["ignore", "pipe", "pipe"], maxBuffer: 256 * 1024 * 1024 });
    return JSON.parse(out);
  } catch (err) {
    const s = (err.stdout || "").toString();
    try {
      return JSON.parse(s);
    } catch {
      throw new Error(`elm-review did not return JSON:\n${s.slice(0, 800)}\nSTDERR:\n${(err.stderr || "").toString().slice(0, 800)}`);
    }
  }
}

function computeLineStarts(text) {
  const starts = [0];
  for (let i = 0; i < text.length; i++) if (text[i] === "\n") starts.push(i + 1);
  return starts;
}
function offsetOf(lineStarts, pos) {
  return lineStarts[pos.line - 1] + (pos.column - 1);
}

// Apply the report's node-replacement fixes; DROP zero-width import insertions
// (imports are regenerated from references in the scratch app).
function applyEdits(text, jsonReport) {
  const lineStarts = computeLineStarts(text);
  const edits = [];
  for (const fileErr of jsonReport.errors || []) {
    for (const problem of fileErr.errors || []) {
      for (const f of problem.fix || []) {
        const s = offsetOf(lineStarts, f.range.start);
        const e = offsetOf(lineStarts, f.range.end);
        if (e <= s) continue; // zero-width import insertion
        edits.push({ start: s, end: e, string: f.string });
      }
    }
  }
  edits.sort((a, b) => a.start - b.start || b.end - a.end);
  const kept = [];
  for (const ed of edits) {
    if (kept.some((k) => k.start < ed.end && ed.start < k.end)) continue;
    kept.push(ed);
  }
  kept.sort((a, b) => b.start - a.start);
  let out = text;
  for (const ed of kept) out = out.slice(0, ed.start) + ed.string + out.slice(ed.end);
  return out;
}

function parseBindings(src) {
  const lines = src.split("\n");
  const result = {};
  let cur = null, buf = [];
  for (const l of lines) {
    const m = /^([A-Za-z_][A-Za-z0-9_]*) =$/.exec(l);
    if (m) {
      if (cur) result[cur] = buf.join("\n").replace(/\s+$/, "");
      cur = m[1]; buf = [];
    } else if (cur) buf.push(l.startsWith("    ") ? l.slice(4) : l);
  }
  if (cur) result[cur] = buf.join("\n").replace(/\s+$/, "");
  return result;
}

// Set of binding names that compile (whole set compiled together).
function compilingNames(codeByName) {
  const shadow = { V: { examples: [] } };
  const order = [];
  for (const [name, code] of Object.entries(codeByName)) {
    shadow.V.examples.push({ title: name, code });
    order.push(name);
  }
  const { failures, fatal } = verifyExamples(shadow);
  if (fatal) throw new Error("verify fatal:\n" + fatal);
  const failed = new Set(failures.map((f) => order[f.idx]));
  return new Set(order.filter((n) => !failed.has(n)));
}

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
function runRule(items, imports, ruleExpr) {
  writeConfig(imports, ruleExpr);
  const text = writeTarget(items);
  const json = runReviewJson();
  return parseBindings(applyEdits(text, json));
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
    "slot-vocabulary-asymmetry (ALLOWLISTED): a barrelised slot round-trips to the component-specific BARREL name (e.g. M3e.AppBar.leading -> M3e.slotLeading -> M3e.appBarSlotLeading) rather than back to the per-component setter. The ENDPOINTS coincide in type: M3e.appBarSlotLeading IS M3e.AppBar.leading re-exported under a flat name (same phantom row, same output), so only the literal name differs. NOTE the intermediate generalized name (M3e.slotLeading / M3e.slotIcon) is NOT the same type — it points at M3e.Cem.Vocab with a distinct, narrower phantom (e.g. slotIcon accepts { icon } vs Button.icon's { icon, loadingIndicator }); that narrowing is likely why some examples can't barrelise at all. PreferSpecificSlot's slot-upgrade class targets the specific barrel name (its namesake behavior), not the per-component module. Everything else round-trips exactly.",
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
