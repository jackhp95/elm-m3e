// Build the component reference (`docs/data/reference.json`) from native
// `elm make --docs docs.json` output.
//
// Why: the previous heuristic scanned Elm source with regex (fragile to
// multi-line signatures, comment placement quirks, and silently glossed over
// missing doc comments). `elm make --docs` is the elm compiler's own pipeline:
// it enforces a doc comment on every exposed value and produces type signatures
// it actually type-checked. Single source of truth; same artifact Phase 8
// (package-readiness) needs anyway.
//
// How: the library can't be a real package today (it vendors its `Cem.M3e.*`
// atoms instead of depending on them), so this script sets up a scratch package
// project at /tmp/m3e-docs-gen with symlinks to `src/M3e` (the library) and
// `vendor/elm-m3e/Cem` (the atoms, kept in source-dirs but NOT exposed), runs
// `elm make --docs` there, then maps the produced `docs.json` to the existing
// `reference.json` schema consumed by Route.Reference and Route.Components.Name_.
// `M3e.Internal` is the unexposed escape-hatch and is excluded from the docs.

import fs from "fs";
import path from "path";
import { execSync } from "child_process";
import { fileURLToPath } from "url";

const here = path.dirname(fileURLToPath(import.meta.url));
const REPO = path.resolve(here, "../..");
const SRC_M3E = path.resolve(REPO, "packages/m3e/src/M3e");
const OUT = path.resolve(here, "../data/reference.json");
const ELM_BIN = path.resolve(REPO, "docs/node_modules/.bin/elm");

const SCRATCH = "/tmp/m3e-docs-gen";

// Modules that exist in src/M3e but are NOT part of the *component* reference:
// the IR primitives + escape-hatch (documented in the architecture guide, not
// the per-component catalogue).
const NOT_EXPOSED = new Set([
  "M3e.Internal",
  "M3e.Node",
  "M3e.Label",
  "M3e.Element",
  // Token-enum + IR infra, not per-component reference material (the Styles
  // pages cover tokens); their generated form omits per-value doc comments.
  "M3e.Value",
  "M3e.Content",
  "M3e.Attr",
]);

// 1. Build a fresh scratch package project (idempotent).
function setupScratch() {
  fs.rmSync(SCRATCH, { recursive: true, force: true });
  fs.mkdirSync(path.join(SCRATCH, "src"), { recursive: true });
  fs.symlinkSync(SRC_M3E, path.join(SCRATCH, "src/M3e"));
  // The middle/bottom layers live under `M3e.Cem.*` / `M3e.Cem.Html.*`, i.e.
  // inside the `M3e` symlink already — they stay in source-dirs but out of
  // `exposed-modules` (escape-hatch, not the component API).

  const exposed = fs
    .readdirSync(SRC_M3E)
    .filter((f) => f.endsWith(".elm"))
    .map((f) => "M3e." + f.replace(/\.elm$/, ""))
    .filter((m) => !NOT_EXPOSED.has(m))
    .sort();

  const elmJson = {
    type: "package",
    name: "jackhp95/elm-m3e",
    summary: "Material 3 Expressive — typed Elm builders over @m3e/web.",
    license: "BSD-3-Clause",
    version: "1.0.0",
    "exposed-modules": exposed,
    "elm-version": "0.19.0 <= v < 0.20.0",
    dependencies: {
      "elm/core": "1.0.0 <= v < 2.0.0",
      "elm/html": "1.0.0 <= v < 2.0.0",
      "elm/json": "1.0.0 <= v < 2.0.0",
      "elm/virtual-dom": "1.0.0 <= v < 2.0.0",
    },
    "test-dependencies": {},
  };
  fs.writeFileSync(path.join(SCRATCH, "elm.json"), JSON.stringify(elmJson, null, 2));
}

// 2. Run `elm make --docs docs.json` in the scratch project. Any missing
//    doc-comment / unresolved @docs reference is a hard error here.
function buildDocsJson() {
  try {
    execSync(`${ELM_BIN} make --docs docs.json`, { cwd: SCRATCH, stdio: "pipe" });
  } catch (e) {
    process.stderr.write(e.stdout?.toString() || "");
    process.stderr.write(e.stderr?.toString() || "");
    throw new Error("elm make --docs failed in " + SCRATCH);
  }
  return JSON.parse(fs.readFileSync(path.join(SCRATCH, "docs.json"), "utf8"));
}

// 3. Extract the module overview prose: everything in `comment` before the
//    first `# <section>` header or `@docs` line. Collapse internal blank runs.
function overview(comment) {
  const lines = comment.replace(/\r\n/g, "\n").split("\n");
  const out = [];
  for (const raw of lines) {
    const l = raw.replace(/\s+$/, "");
    if (/^@docs\b/.test(l.trim())) break;
    if (/^#\s/.test(l)) break;
    out.push(l);
  }
  return out.join("\n").replace(/\n{3,}/g, "\n\n").trim();
}

// 4. Order members by their first appearance in the module comment's `@docs`
//    sections (docs.json sorts each array alphabetically, but the @docs order
//    is what the rendered page should reflect). Anything not referenced by
//    @docs falls to the end in alphabetical order.
function memberOrder(comment) {
  const names = [];
  for (const line of comment.split("\n")) {
    const m = line.match(/^@docs\s+(.+)$/);
    if (!m) continue;
    for (const tok of m[1].split(",")) {
      const n = tok.trim().split(/\s+/)[0];
      if (n) names.push(n);
    }
  }
  return names;
}

// 5. Build the per-module reference record. `kind`: type for unions and
//    aliases; value for everything else. Signature on values is the elm type
//    (multi-line collapsed to a single line by docs.json already).
function moduleEntry(mod) {
  const name = mod.name.replace(/^M3e\./, "");
  const slug = name.toLowerCase();
  const byName = new Map();
  for (const u of mod.unions || []) {
    byName.set(u.name, { name: u.name, kind: "type", signature: "", doc: (u.comment || "").trim() });
  }
  for (const a of mod.aliases || []) {
    byName.set(a.name, { name: a.name, kind: "type", signature: "", doc: (a.comment || "").trim() });
  }
  for (const v of mod.values || []) {
    byName.set(v.name, { name: v.name, kind: "value", signature: v.type || "", doc: (v.comment || "").trim() });
  }

  const ordered = memberOrder(mod.comment || "");
  const members = [];
  const seen = new Set();
  for (const n of ordered) {
    if (byName.has(n) && !seen.has(n)) {
      members.push(byName.get(n));
      seen.add(n);
    }
  }
  for (const n of [...byName.keys()].sort()) {
    if (!seen.has(n)) members.push(byName.get(n));
  }
  return { name, slug, overview: overview(mod.comment || ""), members };
}

// ----- run -----
// `elm make --docs` is strict and all-or-nothing: one exposed module with an
// incomplete generated `@docs` block fails the whole build. When that happens we
// keep the last-good `data/reference.json` (committed) rather than crash the dev
// server — regenerating cleanly is a generator-side @docs-completeness fix. If no
// prior reference exists, the failure is genuinely fatal.
setupScratch();
let modules;
try {
  modules = buildDocsJson();
} catch (e) {
  process.stderr.write((e.message || String(e)) + "\n");
  if (fs.existsSync(OUT)) {
    console.warn(
      `⚠ reference regeneration failed — keeping existing ${path.relative(REPO, OUT)}. ` +
        `Fix the generator's @docs output to refresh it.`
    );
    process.exit(0);
  }
  throw e;
}

const components = modules
  .filter((m) => /^M3e\./.test(m.name))
  .map(moduleEntry)
  .sort((a, b) => a.name.localeCompare(b.name));

fs.mkdirSync(path.dirname(OUT), { recursive: true });
fs.writeFileSync(OUT, JSON.stringify(components));
const totalMembers = components.reduce((n, c) => n + c.members.length, 0);
console.log(
  `reference (via elm make --docs): ${components.length} components, ${totalMembers} members -> data/reference.json`
);
