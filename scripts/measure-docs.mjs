#!/usr/bin/env node
// measure-docs.mjs — WS7 / FIX 2: real per-package docs-size gate.
//
// For each package P in a packages.json family, assembles a measurement dir:
//   - package-type elm.json exposing ONLY P's modules
//   - src/ contains P's modules + all transitive dep modules (vendored)
// Runs `elm make --docs docs.json` and reports the real byte count.
// Asserts all packages <= DOCS_LIMIT (700,000 bytes). Fails loud if over.
//
// Usage:
//   node scripts/measure-docs.mjs \
//       --packages=packages.json \
//       --split-out=dist-packages \
//       --elm=<path-to-elm-binary> \
//       [--dep-src=<pkg-name>=<src-dir> ...]  \
//       [--skip=<pkg-name> ...]               \
//       [--no-assert]
//
//   --packages=<path>      packages.json describing the family (default: packages.json)
//   --split-out=<dir>      dir containing per-package split output (default: dist-packages)
//   --elm=<path>           path to elm 0.19.1 binary (auto-detected if omitted)
//   --dep-src=N=P          map package name N to local src dir P (for unpublished deps)
//                          e.g. --dep-src=jackhp95/markup-core=/path/to/markup/src
//   --skip=<pkg>           skip measurement for a package (comma-separated or repeated)
//   --no-assert            report only; do not exit 1 on violations
//
// Wire into npm test / CI:
//   In elm-m3e/package.json:   "measure-docs": "node scripts/measure-docs.mjs ..."
//   In elm-cem (for markup):   "measure-docs": "node ../elm-m3e/scripts/measure-docs.mjs --packages=markup/packages.json ..."
//
// The review-facts packages are SKIPPED by default because they depend on
// jackhp95/elm-review-cem which is not published; pass --skip=... to override.

import { execFileSync, spawnSync } from "node:child_process";
import fs from "node:fs";
import os from "node:os";
import path from "node:path";
import { fileURLToPath } from "node:url";

const here = path.dirname(fileURLToPath(import.meta.url));
const repoRoot = path.resolve(here, "..");

const DOCS_LIMIT = 700_000;

// ── Parse flags ──────────────────────────────────────────────────────────────
const rawArgs = process.argv.slice(2);

function argVal(prefix) {
  const a = rawArgs.find(x => x.startsWith(prefix));
  return a ? a.slice(prefix.length) : null;
}

const packagesArg = argVal("--packages=") ?? "packages.json";
const splitOutArg = argVal("--split-out=") ?? "dist-packages";
const noAssert = rawArgs.includes("--no-assert");

// --dep-src=<pkg-name>=<path> (may be repeated)
const depSrcMap = {}; // pkg name -> src dir
for (const a of rawArgs) {
  if (a.startsWith("--dep-src=")) {
    const val = a.slice("--dep-src=".length);
    const eq = val.indexOf("=");
    if (eq > 0) {
      const pkgName = val.slice(0, eq);
      const srcDir = path.resolve(repoRoot, val.slice(eq + 1));
      depSrcMap[pkgName] = srcDir;
    }
  }
}

// --skip=<pkg> (comma-separated or repeated)
const skipSet = new Set();
for (const a of rawArgs) {
  if (a.startsWith("--skip=")) {
    for (const s of a.slice("--skip=".length).split(",")) {
      if (s.trim()) skipSet.add(s.trim());
    }
  }
}

// Locate elm binary
function findElm() {
  const explicit = argVal("--elm=");
  if (explicit) return path.resolve(repoRoot, explicit);
  // Well-known locations
  const candidates = [
    path.join(repoRoot, "node_modules", ".bin", "elm"),
    "/Users/jack/Documents/code/elm-m3e/node_modules/.bin/elm",
    path.join(here, "../../elm-m3e/node_modules/.bin/elm"),
  ];
  for (const c of candidates) {
    if (fs.existsSync(c)) return c;
  }
  return null;
}

const elmBin = findElm();
if (!elmBin) {
  console.error("measure-docs: cannot find elm binary; pass --elm=<path>");
  process.exit(1);
}

// ── Load packages.json ───────────────────────────────────────────────────────
const packagesPath = path.resolve(repoRoot, packagesArg);
let pkgsSpec;
try {
  pkgsSpec = JSON.parse(fs.readFileSync(packagesPath, "utf8"));
} catch (e) {
  console.error(`measure-docs: cannot read ${packagesPath}: ${e.message}`);
  process.exit(1);
}

const packages = pkgsSpec.packages || [];
const splitOutDir = path.resolve(repoRoot, splitOutArg);

// ── Build reverse dep map for family-internal packages ───────────────────────
// familySrcMap: pkg name -> src dir (from dist-packages)
const familySrcMap = {};
for (const pkg of packages) {
  const shortName = pkg.name.split("/")[1];
  const pkgSrc = path.join(splitOutDir, shortName, "src");
  if (fs.existsSync(pkgSrc)) {
    familySrcMap[pkg.name] = pkgSrc;
  }
}

// Merge depSrcMap (explicit --dep-src) into the source resolution
const allSrcMap = { ...familySrcMap, ...depSrcMap };

// ── Transitive dep closure ───────────────────────────────────────────────────
function transitiveDepNames(pkgName, visited = new Set()) {
  if (visited.has(pkgName)) return visited;
  visited.add(pkgName);
  const pkg = packages.find(p => p.name === pkgName);
  if (!pkg) return visited;
  for (const dep of Object.keys(pkg.deps || {})) {
    transitiveDepNames(dep, visited);
  }
  return visited;
}

// ── Measure each package ─────────────────────────────────────────────────────
const results = [];
const tmpBase = fs.mkdtempSync(path.join(os.tmpdir(), "elm-docs-measure-"));

console.log(`measure-docs: elm = ${elmBin}`);
console.log(`measure-docs: packages = ${packagesPath}`);
console.log(`measure-docs: split-out = ${splitOutDir}`);
console.log(`measure-docs: DOCS_LIMIT = ${DOCS_LIMIT.toLocaleString()} bytes`);
console.log();

for (const pkg of packages) {
  const shortName = pkg.name.split("/")[1];

  // Skip review-facts and any explicitly skipped packages
  const isReviewFacts = /review/i.test(pkg.name);
  if (isReviewFacts || skipSet.has(pkg.name) || skipSet.has(shortName)) {
    console.log(`measure-docs: SKIP ${pkg.name} (review-facts or --skip)`);
    results.push({ name: pkg.name, shortName, bytes: null, status: "skip" });
    continue;
  }

  const pkgSrc = path.join(splitOutDir, shortName, "src");
  if (!fs.existsSync(pkgSrc)) {
    console.error(`measure-docs: WARN — ${shortName} not found in split-out (${pkgSrc}); skipping`);
    results.push({ name: pkg.name, shortName, bytes: null, status: "missing" });
    continue;
  }

  // ── Build measurement dir ───────────────────────────────────────────────
  const mDir = path.join(tmpBase, shortName);
  const mSrc = path.join(mDir, "src");
  fs.mkdirSync(mSrc, { recursive: true });

  // Copy this package's modules into src/
  copyDir(pkgSrc, mSrc);

  // Copy all transitive dep modules into src/ (family-internal + --dep-src)
  const allDeps = transitiveDepNames(pkg.name);
  allDeps.delete(pkg.name); // exclude self

  for (const depName of allDeps) {
    const depSrc = allSrcMap[depName];
    if (!depSrc) {
      // External published dep (elm/core etc.) — available from Elm registry cache
      // No vendoring needed; elm resolves from ~/.elm
      continue;
    }
    if (!fs.existsSync(depSrc)) {
      console.error(`measure-docs: WARN — dep src dir not found: ${depSrc} for ${depName}`);
      continue;
    }
    copyDir(depSrc, mSrc);
  }

  // Get exposed modules from the split elm.json (non-Internal, non-Review)
  const pkgElmJsonPath = path.join(splitOutDir, shortName, "elm.json");
  let exposedModules = [];
  if (fs.existsSync(pkgElmJsonPath)) {
    try {
      const ej = JSON.parse(fs.readFileSync(pkgElmJsonPath, "utf8"));
      exposedModules = ej["exposed-modules"] || [];
    } catch { /* fall through */ }
  }
  if (exposedModules.length === 0) {
    // Derive from src/ files
    exposedModules = walkElmModules(pkgSrc).sort();
  }

  // Build the external-only deps object (strip family-internal + --dep-src entries)
  const externalDeps = {};
  for (const [depName, depRange] of Object.entries(pkg.deps || {})) {
    if (!allSrcMap[depName]) {
      // Not vendored → must be a published external dep
      externalDeps[depName] = depRange;
    }
  }
  // elm/core always needed
  if (!externalDeps["elm/core"]) externalDeps["elm/core"] = "1.0.0 <= v < 2.0.0";

  // Emit package-type elm.json
  const measureElmJson = {
    type: "package",
    name: pkg.name,
    summary: pkg.summary || shortName,
    license: "BSD-3-Clause",
    version: pkg.version || "1.0.0",
    "exposed-modules": exposedModules.sort(),
    "elm-version": pkg.elmVersion || "0.19.0 <= v < 0.20.0",
    dependencies: externalDeps,
    "test-dependencies": {}
  };
  fs.writeFileSync(path.join(mDir, "elm.json"), JSON.stringify(measureElmJson, null, 4) + "\n");

  // ── Run elm make --docs docs.json ─────────────────────────────────────────
  const docsPath = path.join(mDir, "docs.json");
  const r = spawnSync(elmBin, ["make", "--docs", docsPath, "--output=/dev/null"], {
    cwd: mDir,
    encoding: "utf8",
    stdio: "pipe"
  });

  if (r.status !== 0) {
    console.error(`measure-docs: FAIL — elm make --docs failed for ${shortName}`);
    if (r.stderr) console.error(r.stderr.slice(0, 3000));
    results.push({ name: pkg.name, shortName, bytes: null, status: "elm-fail" });
    continue;
  }

  if (!fs.existsSync(docsPath)) {
    console.error(`measure-docs: FAIL — docs.json not produced for ${shortName}`);
    results.push({ name: pkg.name, shortName, bytes: null, status: "no-docs" });
    continue;
  }

  const bytes = fs.statSync(docsPath).size;
  const pct = ((bytes / DOCS_LIMIT) * 100).toFixed(1);
  const over = bytes > DOCS_LIMIT;
  const flag = over ? "OVER LIMIT" : (bytes > DOCS_LIMIT * 0.9 ? "tight" : "ok");

  console.log(`  ${shortName.padEnd(22)} ${bytes.toLocaleString().padStart(10)} B  (${pct}% of limit)  ${flag}`);
  results.push({ name: pkg.name, shortName, bytes, status: over ? "over" : "ok" });
}

// ── Summary table ────────────────────────────────────────────────────────────
console.log();
console.log("── docs-size results ────────────────────────────────────────────");
let anyFail = false;
for (const r of results) {
  if (r.status === "skip") {
    console.log(`  SKIP  ${r.name}`);
  } else if (r.status === "ok" || r.status === "over") {
    const pct = ((r.bytes / DOCS_LIMIT) * 100).toFixed(1);
    const flag = r.status === "over" ? "OVER LIMIT" : "ok";
    console.log(`  ${flag.padEnd(12)} ${r.name.padEnd(35)} ${r.bytes.toLocaleString().padStart(10)} B  (${pct}%)`);
    if (r.status === "over") anyFail = true;
  } else {
    console.log(`  ${r.status.toUpperCase().padEnd(12)} ${r.name}`);
    if (r.status !== "skip" && r.status !== "missing") anyFail = true;
  }
}

console.log(`\nmeasure-docs: DOCS_LIMIT = ${DOCS_LIMIT.toLocaleString()} bytes`);

if (anyFail && !noAssert) {
  console.error("\nmeasure-docs: GATE FAIL — one or more packages exceed the docs-size limit.");
  process.exit(1);
} else if (!anyFail) {
  console.log("measure-docs: ALL MEASURED PACKAGES PASS docs-size gate.");
}

// Cleanup
fs.rmSync(tmpBase, { recursive: true, force: true });

// ── Helpers ───────────────────────────────────────────────────────────────────
function copyDir(src, dst) {
  if (!fs.existsSync(src)) return;
  for (const entry of fs.readdirSync(src, { withFileTypes: true })) {
    const srcFull = path.join(src, entry.name);
    const dstFull = path.join(dst, entry.name);
    if (entry.isDirectory()) {
      fs.mkdirSync(dstFull, { recursive: true });
      copyDir(srcFull, dstFull);
    } else {
      fs.copyFileSync(srcFull, dstFull);
    }
  }
}

function walkElmModules(dir, base = dir) {
  const result = [];
  if (!fs.existsSync(dir)) return result;
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    const full = path.join(dir, entry.name);
    if (entry.isDirectory()) {
      result.push(...walkElmModules(full, base));
    } else if (entry.name.endsWith(".elm")) {
      const rel = path.relative(base, full).replace(/\.elm$/, "").split(path.sep).join(".");
      if (!/(^|\.)Internal(\.|$)/.test(rel) && !/(^|\.)Review(\.|$)/.test(rel)) {
        result.push(rel);
      }
    }
  }
  return result;
}
