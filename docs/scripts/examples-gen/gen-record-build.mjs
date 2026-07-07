// Generate the ④ Record (`M3e.Record.*`) and ⑤ Build (`M3e.Build.*`) surface
// code for every Usage example, BY RUNNING the existing D6 elm-review translator
// rules (`TranslateToRecord` / `TranslateToBuild`) over each example's `top`
// (Standard `M3e.*`) code. NO new HTML->Elm converter is written here — this is a
// thin harness around the real rules.
//
// Mechanism (per surface):
//   1. Write ALL examples' `top` code as bindings into one scratch Elm
//      APPLICATION (`/tmp/d6-target`, source-dirs = real library sources) — the
//      same pattern verify-examples.mjs uses. The `top` bindings all compile
//      (they are the compile-verified corpus), which elm-review requires.
//   2. Write a scratch elm-review CONFIG (`/tmp/d6-cfg-<surface>`) whose single
//      rule is `TranslateTo<Surface>.rule M3e.Review.Facts.facts`. (We copy
//      review/src into the config's src and overwrite ReviewConfig.elm; pointing
//      source-directories straight at review/src collides with its own
//      ReviewConfig and runs the FULL rule set.)
//   3. Run `elm-review --report=json` (NOT --fix). The JSON report carries each
//      error's `fix` as explicit {range,string} edits. We apply the target-surface
//      CONVERSION edits and SKIP the whole-node Seam-escape edits ourselves in ONE
//      pass — a PARTIAL conversion (see applyEdits): convert whatever converts,
//      leave every un-converted node as its original Standard source.
//
//      Why not `--fix-all-without-prompt`: for a node the rule can't cleanly
//      convert it emits a whole-node `Seam.fromHtml (M3e.Cem.Html.* ...)` escape
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
//
// EMPIRICAL RESULT (2026-07-06, partial-conversion pass over the 82-example corpus):
//   record: 33 converted (4 full + 29 partial mixed trees), 49 fell back to top
//   build:  22 converted (4 full + 18 partial mixed trees), 60 fell back to top
// (Up from 17/17 under the previous outermost-edit selection, which discarded
// convertible inner children whenever the outer container escaped.)
//   * The corpus is composite/gallery-oriented — every action-bearing element
//     (BreadcrumbItem, NavItem, a Button inside a ButtonGroup, ...) is NESTED
//     inside a container (`M3e.AppBar.view`, `M3e.ButtonGroup.view`, ...) that has
//     no convertible content/action record. We now leave that container as
//     Standard `M3e.*` source and convert only the action-bearing children, so a
//     composite becomes a MIXED tree:
//       `M3e.ButtonGroup.view [ … ] (M3e.ButtonGroup.children [ M3e.Record.Button.view {…} … ])`.
//   * A partial only ships if the whole mixed binding type-checks. Some don't and
//     correctly fall back: e.g. Divider#1 build has Build-converted buttons
//     (Html-surface) beside a Standard `M3e.Divider.view` (Element) inside one
//     `Native.nav` list — the list can't hold both types, so it's rejected to
//     null and the example keeps its 4 tabs.
//   * Display-only composites (a gallery/nav with no action-bearing child) yield
//     no conversion edit at all → still fall back to `top` → 4 tabs. Expected.

import { readFileSync, writeFileSync, mkdirSync, rmSync, existsSync } from "node:fs";
import { execFileSync } from "node:child_process";
import { dirname, resolve } from "node:path";
import { fileURLToPath } from "node:url";
import { verifyExamples } from "./verify-examples.mjs";

const HERE = dirname(fileURLToPath(import.meta.url));
// docs/scripts/examples-gen/gen-record-build.mjs -> elm-m3e root is three up.
const REPO = resolve(HERE, "..", "..", "..");
const LIB_SRC = `${REPO}/packages/m3e/src`;
const KIT_SRC = `${REPO}/packages/m3e-kit/src`;
const ELM_BIN = `${REPO}/docs/node_modules/.bin/elm`;
const REVIEW_BIN = `${REPO}/docs/node_modules/.bin/elm-review`;

const RICH = resolve(REPO, "config/examples.rich.json");
const OUT = resolve(REPO, "config/examples.surfaces.json");

const TARGET = "/tmp/d6-target";
const CFG = { record: "/tmp/d6-cfg-record", build: "/tmp/d6-cfg-build" };
const RULE = { record: "Cem.TranslateToRecord", build: "Cem.TranslateToBuild" };
const TOKEN = { record: "M3e.Record.", build: "M3e.Build." };

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

// Write the scratch TARGET app: one binding per example `top`. Returns the file
// text (edits are applied against it by offset).
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

function writeConfig(surface) {
  const dir = CFG[surface];
  rmSync(dir, { recursive: true, force: true });
  mkdirSync(resolve(dir, "src"), { recursive: true });
  execFileSync("cp", ["-R", `${REPO}/review/src/.`, resolve(dir, "src")]);
  writeFileSync(resolve(dir, "elm.json"), JSON.stringify({
    type: "application",
    // The codegen-aware translator rules now live in the jackhp95/elm-review-cem
    // package; pull them in via source-dir until it is a published dependency.
    "source-directories": ["src", `${REPO}/packages/m3e/src`, `${REPO}/../elm-review-cem/src`],
    "elm-version": "0.19.1",
    dependencies: reviewElm.dependencies,
    "test-dependencies": reviewElm["test-dependencies"],
  }, null, 4) + "\n");
  writeFileSync(resolve(dir, "src", "ReviewConfig.elm"),
`module ReviewConfig exposing (config)

import Review.Rule exposing (Rule)
import ${RULE[surface]}
import M3e.Review.Facts


config : List Rule
config =
    [ ${RULE[surface]}.rule M3e.Review.Facts.facts ]
`);
}

function runReviewJson(surface) {
  try {
    const out = execFileSync(REVIEW_BIN, [
      TARGET, "--config", CFG[surface], "--compiler", ELM_BIN, "--report=json",
    ], { encoding: "utf8", stdio: ["ignore", "pipe", "pipe"], maxBuffer: 256 * 1024 * 1024 });
    return JSON.parse(out); // no errors
  } catch (err) {
    const s = (err.stdout || "").toString();
    try {
      return JSON.parse(s);
    } catch {
      throw new Error(
        `elm-review (${surface}) did not return JSON:\n` +
          s.slice(0, 800) + "\nSTDERR:\n" + (err.stderr || "").toString().slice(0, 800),
      );
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

// Apply the report's node-replacement edits in one pass, for PARTIAL conversion:
// apply the real target-surface CONVERSION edits and SKIP the whole-node
// Seam-escape fallbacks, leaving every un-converted node exactly as it was
// (valid Standard `M3e.*` source). This lets a composite (a container whose only
// convertible content is action-bearing children) become a MIXED tree —
// `M3e.Breadcrumb.view [ … ] [ M3e.Record.Button.view {…}, … ]` — instead of
// collapsing to a pure Seam residue that never type-checks.
//
//   * A CONVERSION edit's replacement references the target surface
//     (`M3e.Record.` for the record pass, `M3e.Build.` for the build pass). We
//     apply these.
//   * An ESCAPE edit's replacement is a whole-node Seam fallback (routes through
//     `Seam.fromHtml` / `Seam.slot` / `M3e.Cem.Html.`) and never reaches the
//     target surface. We DROP it — the node stays as its original Standard
//     source. (Empirically the two classes are disjoint: no edit both reaches
//     the target surface and is a Seam escape, so filtering on the target token
//     alone cleanly selects conversions.)
//
// Overlap: conversion edits are kept non-overlapping. Sorting outer-first
// (start asc, then end desc) and dropping any later edit that overlaps a kept
// one means, for the rare nested convertible call, we PREFER THE OUTER
// conversion and drop the inner (the outer fix already inlines the inner
// subtree). Zero-width import insertions are skipped (imports are regenerated
// from references in the verify scratch).
function applyEdits(text, jsonReport, surface) {
  const token = TOKEN[surface];
  const lineStarts = computeLineStarts(text);
  const edits = [];
  for (const fileErr of jsonReport.errors || []) {
    for (const problem of fileErr.errors || []) {
      for (const f of problem.fix || []) {
        const s = offsetOf(lineStarts, f.range.start);
        const e = offsetOf(lineStarts, f.range.end);
        if (e <= s) continue; // zero-width import insertion — skip
        if (!f.string.includes(token)) continue; // not a conversion — leave node as-is
        edits.push({ start: s, end: e, string: f.string });
      }
    }
  }
  edits.sort((a, b) => a.start - b.start || b.end - a.end);
  const kept = [];
  for (const ed of edits) {
    // Drop any conversion that overlaps an already-kept (outer) conversion.
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

// Compile-verify a { name -> code } map. Returns Set of names that compile.
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
    writeConfig(surface);
    const text = writeTarget(items);
    const json = runReviewJson(surface);
    const fixedByName = parseBindings(applyEdits(text, json, surface));

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
