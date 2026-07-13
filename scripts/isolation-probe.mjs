#!/usr/bin/env node
// isolation-probe.mjs — WS7 / FIX 3: real-family isolation probe.
//
// For each package P in a packages.json family, proves isolation:
//   - elm make compiles P's exposed modules seeing ONLY P's src + P's dep-closure src
//   - No cross-package leakage is possible (if it were, elm make would fail
//     because the leaked module's dependencies wouldn't be visible)
//
// Uses an application-type elm.json with source-directories (no registry needed).
//
// Usage:
//   node scripts/isolation-probe.mjs \
//       --packages=packages.json \
//       --split-out=dist-packages \
//       --elm=<path-to-elm-binary> \
//       [--dep-src=<pkg-name>=<src-dir> ...] \
//       [--skip=<pkg-name> ...]
//
// Wire into npm test / CI:
//   "isolation-probe": "node scripts/isolation-probe.mjs ..."
//
// The review-facts packages are SKIPPED (they depend on jackhp95/elm-review-cem).
//
// This script is intentionally separate from measure-docs.mjs because:
//   - It uses an APP elm.json (faster, no registry resolution)
//   - It cleanly separates "can this package compile in isolation" from "how big are its docs"

import { spawnSync } from "node:child_process";
import fs from "node:fs";
import os from "node:os";
import path from "node:path";
import { fileURLToPath } from "node:url";

const here = path.dirname(fileURLToPath(import.meta.url));
const repoRoot = path.resolve(here, "..");

// ── Parse flags ──────────────────────────────────────────────────────────────
const rawArgs = process.argv.slice(2);

function argVal(prefix) {
  const a = rawArgs.find(x => x.startsWith(prefix));
  return a ? a.slice(prefix.length) : null;
}

const packagesArg = argVal("--packages=") ?? "packages.json";
const splitOutArg = argVal("--split-out=") ?? "dist-packages";

const depSrcMap = {};
for (const a of rawArgs) {
  if (a.startsWith("--dep-src=")) {
    const val = a.slice("--dep-src=".length);
    const eq = val.indexOf("=");
    if (eq > 0) {
      depSrcMap[val.slice(0, eq)] = path.resolve(repoRoot, val.slice(eq + 1));
    }
  }
}

const skipSet = new Set();
for (const a of rawArgs) {
  if (a.startsWith("--skip=")) {
    for (const s of a.slice("--skip=".length).split(",")) {
      if (s.trim()) skipSet.add(s.trim());
    }
  }
}

function findElm() {
  const explicit = argVal("--elm=");
  if (explicit) return path.resolve(repoRoot, explicit);
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
  console.error("isolation-probe: cannot find elm binary; pass --elm=<path>");
  process.exit(1);
}

// ── Load packages.json ───────────────────────────────────────────────────────
const packagesPath = path.resolve(repoRoot, packagesArg);
let pkgsSpec;
try {
  pkgsSpec = JSON.parse(fs.readFileSync(packagesPath, "utf8"));
} catch (e) {
  console.error(`isolation-probe: cannot read ${packagesPath}: ${e.message}`);
  process.exit(1);
}

const packages = pkgsSpec.packages || [];
const splitOutDir = path.resolve(repoRoot, splitOutArg);

// Build family src map (pkg name → src dir in split-out)
const familySrcMap = {};
for (const pkg of packages) {
  const shortName = pkg.name.split("/")[1];
  const pkgSrc = path.join(splitOutDir, shortName, "src");
  if (fs.existsSync(pkgSrc)) familySrcMap[pkg.name] = pkgSrc;
}

const allSrcMap = { ...familySrcMap, ...depSrcMap };

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

// ── Probe each package ────────────────────────────────────────────────────────
const tmpBase = fs.mkdtempSync(path.join(os.tmpdir(), "elm-isolation-probe-"));

console.log(`isolation-probe: elm = ${elmBin}`);
console.log(`isolation-probe: packages = ${packagesPath}`);
console.log(`isolation-probe: split-out = ${splitOutDir}`);
console.log();

const results = [];
let anyFail = false;

for (const pkg of packages) {
  const shortName = pkg.name.split("/")[1];

  // Skip review-facts and explicitly skipped packages
  if (/review/i.test(pkg.name) || skipSet.has(pkg.name) || skipSet.has(shortName)) {
    console.log(`isolation-probe: SKIP ${pkg.name}`);
    results.push({ name: pkg.name, status: "skip" });
    continue;
  }

  const pkgSrc = path.join(splitOutDir, shortName, "src");
  if (!fs.existsSync(pkgSrc)) {
    console.error(`isolation-probe: WARN — ${shortName} not found in split-out`);
    results.push({ name: pkg.name, status: "missing" });
    continue;
  }

  // Build source-directories list: this pkg + all transitive deps that have src
  const allDeps = transitiveDepNames(pkg.name);
  allDeps.delete(pkg.name);

  const sourceDirs = [pkgSrc];
  for (const depName of allDeps) {
    const depSrc = allSrcMap[depName];
    if (depSrc && fs.existsSync(depSrc)) {
      sourceDirs.push(depSrc);
    }
    // External deps without src (elm/core etc.) are handled by the deps section
  }

  // External deps (published packages)
  const externalDepsObj = {};
  for (const [depName, _] of Object.entries(pkg.deps || {})) {
    if (!allSrcMap[depName]) {
      // Not vendored — must be published. Use a version that's in elm-stuff
      externalDepsObj[depName] = "1.0.5"; // placeholder; actual version doesn't matter for app
    }
  }

  // Get exposed modules for this package
  const pkgElmJsonPath = path.join(splitOutDir, shortName, "elm.json");
  let exposedModules = [];
  if (fs.existsSync(pkgElmJsonPath)) {
    try {
      const ej = JSON.parse(fs.readFileSync(pkgElmJsonPath, "utf8"));
      exposedModules = ej["exposed-modules"] || [];
    } catch { /* fall through */ }
  }

  // For external deps (elm/core, elm/html, etc.) we need actual installed versions.
  // Pull them from the project's elm-stuff or a known test elm.json.
  const testElmJsonPath = path.join(repoRoot, "tests", "elm.json");
  let realExtDeps = { direct: {}, indirect: {} };
  if (fs.existsSync(testElmJsonPath)) {
    try {
      const tj = JSON.parse(fs.readFileSync(testElmJsonPath, "utf8"));
      realExtDeps = tj.dependencies || { direct: {}, indirect: {} };
    } catch { /* fall through */ }
  }
  // Merge: only keep external deps that this package actually needs
  const directDeps = {};
  const indirectDeps = { ...realExtDeps.indirect };
  for (const [depName, _] of Object.entries(pkg.deps || {})) {
    if (!allSrcMap[depName]) {
      // External dep — find in realExtDeps
      const ver = (realExtDeps.direct && realExtDeps.direct[depName]) ||
                  (realExtDeps.indirect && realExtDeps.indirect[depName]);
      if (ver) directDeps[depName] = ver;
    }
  }
  // Always need elm/core
  if (!directDeps["elm/core"]) {
    directDeps["elm/core"] = (realExtDeps.direct && realExtDeps.direct["elm/core"]) || "1.0.5";
  }

  // Create probe dir
  const probeDir = path.join(tmpBase, shortName);
  const probeSrc = path.join(probeDir, "src");
  fs.mkdirSync(probeSrc, { recursive: true });

  // Write Probe.elm importing all exposed modules
  const probeElm = [
    "module Probe exposing (x)",
    "",
    ...exposedModules.map(m => `import ${m}`),
    "",
    "x : Int",
    "x = 0",
    ""
  ].join("\n");
  fs.writeFileSync(path.join(probeSrc, "Probe.elm"), probeElm);

  // Write app-type elm.json
  const probeElmJson = {
    type: "application",
    "source-directories": [...sourceDirs, probeSrc],
    "elm-version": "0.19.1",
    dependencies: {
      direct: directDeps,
      indirect: indirectDeps
    },
    "test-dependencies": { direct: {}, indirect: {} }
  };
  fs.writeFileSync(path.join(probeDir, "elm.json"), JSON.stringify(probeElmJson, null, 2));

  // Run elm make
  const r = spawnSync(elmBin, ["make", "src/Probe.elm", "--output=/dev/null"], {
    cwd: probeDir,
    encoding: "utf8",
    stdio: "pipe"
  });

  if (r.status !== 0) {
    console.error(`isolation-probe: FAIL — ${shortName}`);
    if (r.stderr) console.error(r.stderr.slice(0, 3000));
    results.push({ name: pkg.name, status: "fail" });
    anyFail = true;
  } else {
    console.log(`isolation-probe: OK   — ${shortName} (${exposedModules.length} exposed modules, ${sourceDirs.length} src dirs)`);
    results.push({ name: pkg.name, status: "ok" });
  }
}

// Cleanup
fs.rmSync(tmpBase, { recursive: true, force: true });

// ── Summary ───────────────────────────────────────────────────────────────────
console.log();
console.log("── isolation-probe results ──────────────────────────────────────");
for (const r of results) {
  const status = r.status === "ok" ? "OK  " : r.status === "skip" ? "SKIP" : "FAIL";
  console.log(`  ${status}  ${r.name}`);
}

if (anyFail) {
  console.error("\nisolation-probe: GATE FAIL — one or more packages failed isolation probe.");
  process.exit(1);
} else {
  console.log("\nisolation-probe: ALL PROBES PASSED.");
}
