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
// gen-record-build.mjs):
//   1. Write ALL examples' `top` as bindings into one scratch Elm APPLICATION
//      (source-dirs = real library sources) — the compile-verified corpus.
//   2. Write a scratch elm-review CONFIG whose single rule is `PreferBarrel.rule`.
//   3. Run `elm-review --report=json` (NOT --fix). Apply the rename edits ourselves
//      in one pass (each `M3e.<Comp>.view`/`.<setter>` / `M3e.Value.<token>` node
//      → its flat `M3e.<name>` barrel export). We SKIP the rule's zero-width
//      `import M3e` insertions — imports are regenerated from references here.
//   4. Recover each binding, compile-verify the whole barrelised set, and keep an
//      output only if it COMPILES (the barrel is a faithful re-export, so it
//      always should); otherwise fall back to the original Standard `top`.
//
// `PreferBarrel` deliberately leaves `M3e.<Comp>.child` / `.children` / `.name` /
// `M3e.<Comp>.value` qualified (those names are NOT in the barrel), so a barrelised
// button top reads `M3e.button [ M3e.variant M3e.filled ] [ M3e.Button.child (…) ]`.

import { readFileSync, writeFileSync, mkdirSync, rmSync, existsSync } from "node:fs";
import { execFileSync } from "node:child_process";
import { dirname, resolve } from "node:path";
import { fileURLToPath } from "node:url";
import { verifyExamples } from "./verify-examples.mjs";

const HERE = dirname(fileURLToPath(import.meta.url));
// docs/scripts/examples-gen/gen-barrel.mjs -> elm-m3e root is three up.
const REPO = resolve(HERE, "..", "..", "..");
const LIB_SRC = `${REPO}/packages/m3e/src`;
const KIT_SRC = `${REPO}/packages/m3e-kit/src`;
const ELM_BIN = `${REPO}/docs/node_modules/.bin/elm`;
const REVIEW_BIN = `${REPO}/docs/node_modules/.bin/elm-review`;

const RICH = resolve(REPO, "config/examples.rich.json");
const BARREL = resolve(REPO, "config/examples.barrel.json");

const TARGET = "/tmp/barrel-target";
const CFG = "/tmp/barrel-cfg";

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

function writeConfig() {
  rmSync(CFG, { recursive: true, force: true });
  mkdirSync(resolve(CFG, "src"), { recursive: true });
  execFileSync("cp", ["-R", `${REPO}/review/src/.`, resolve(CFG, "src")]);
  writeFileSync(resolve(CFG, "elm.json"), JSON.stringify({
    type: "application",
    // The codegen-aware rules now live in the jackhp95/elm-review-cem package;
    // pull them in via source-dir until it is a published dependency.
    "source-directories": ["src", `${REPO}/packages/m3e/src`, `${REPO}/../elm-review-cem/src`],
    "elm-version": "0.19.1",
    dependencies: reviewElm.dependencies,
    "test-dependencies": reviewElm["test-dependencies"],
  }, null, 4) + "\n");
  writeFileSync(resolve(CFG, "src", "ReviewConfig.elm"),
`module ReviewConfig exposing (config)

import Cem.PreferBarrel
import M3e.Review.Facts
import Review.Rule exposing (Rule)
import Set


config : List Rule
config =
    [ Cem.PreferBarrel.ruleWith (Set.fromList M3e.Review.Facts.reExposedValueTokens) M3e.Review.Facts.facts ]
`);
}

function runReviewJson() {
  try {
    const out = execFileSync(REVIEW_BIN, [
      TARGET, "--config", CFG, "--compiler", ELM_BIN, "--report=json",
    ], { encoding: "utf8", stdio: ["ignore", "pipe", "pipe"], maxBuffer: 256 * 1024 * 1024 });
    return JSON.parse(out); // no errors
  } catch (err) {
    const s = (err.stdout || "").toString();
    try {
      return JSON.parse(s);
    } catch {
      throw new Error(
        `elm-review did not return JSON:\n` +
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

// Apply the report's rename edits in one pass. Every PreferBarrel fix is a plain
// `M3e.<name>` node replacement plus a zero-width `import M3e` insertion. We keep
// the renames and DROP the import insertions (imports are regenerated from
// references in the scratch verify app). Renames never overlap (distinct
// references), but we defensively drop any that would.
function applyEdits(text, jsonReport) {
  const lineStarts = computeLineStarts(text);
  const edits = [];
  for (const fileErr of jsonReport.errors || []) {
    for (const problem of fileErr.errors || []) {
      for (const f of problem.fix || []) {
        const s = offsetOf(lineStarts, f.range.start);
        const e = offsetOf(lineStarts, f.range.end);
        if (e <= s) continue; // zero-width import insertion — skip
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

  const items = [];
  for (const module of Object.keys(rich)) {
    rich[module].forEach((ex, idx) => {
      // A degraded example may have a null top (no strict M3e surface): nothing
      // to barrel-rewrite, so leave its sidecar entry null (already the default).
      if (ex.top == null) return;
      items.push({ module, idx, name: bindingName(module, idx), code: ex.top });
    });
  }

  writeConfig();
  const text = writeTarget(items);
  const json = runReviewJson();
  const barreledByName = parseBindings(applyEdits(text, json));

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
}

main();
