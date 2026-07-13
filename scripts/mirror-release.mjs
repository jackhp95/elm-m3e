#!/usr/bin/env node
// mirror-release.mjs — WS7 / CX12 mirror push script.
//
// Builds a per-package mirror tree (elm.json + partitioned src + README + LICENSE)
// from a packages.json spec and pushes each to a git repo + tags it.
//
// Usage:
//   node scripts/mirror-release.mjs [--rehearse] [--version=1.0.0]
//       [--packages=packages.json] [--src=src] [--split-out=dist-packages]
//
// Flags:
//   --rehearse          Push to LOCAL bare repos under /tmp/mirror-rehearsal/<pkg>.git
//                       instead of the real jackhp95/<pkg> repos. SAFE TO RUN.
//                       Real repos are NEVER touched in this mode.
//   --version=<v>       Tag to push (default: reads from packages.json package version)
//   --packages=<path>   packages.json (default: ./packages.json)
//   --src=<dir>         Generated source dir (default: ./src)
//   --split-out=<dir>   Directory to write split output to (default: ./dist-packages)
//
// HARD GUARDRAIL: the real-name push path is gated behind the absence of --rehearse.
// Stage F (Jack's gate) is the only time --rehearse is omitted. Until then, every CI
// and dev run uses --rehearse, which never touches a real GitHub repo.

import { execFileSync, execSync } from "node:child_process";
import fs from "node:fs";
import os from "node:os";
import path from "node:path";
import { fileURLToPath } from "node:url";

const here = path.dirname(fileURLToPath(import.meta.url));
const repo = path.resolve(here, "..");
const elmCemCli = path.resolve(here, "../../elm-cem/bin/elm-cem.js");

// ── Parse flags ──────────────────────────────────────────────────────────────
const rawArgs = process.argv.slice(2);
const rehearse = rawArgs.includes("--rehearse");
const versionArg = rawArgs.find(a => a.startsWith("--version="))?.slice("--version=".length);
const packagesArg = rawArgs.find(a => a.startsWith("--packages="))?.slice("--packages=".length) ?? "packages.json";
const srcArg = rawArgs.find(a => a.startsWith("--src="))?.slice("--src=".length) ?? "src";
const splitOutArg = rawArgs.find(a => a.startsWith("--split-out="))?.slice("--split-out=".length) ?? "dist-packages";

if (!rehearse) {
  console.error(
    "mirror-release: ABORTING — real-name push requires --rehearse to be ABSENT.\n" +
    "This guard means: only Jack runs the real push (Stage F).\n" +
    "To rehearse against local bare repos: add --rehearse."
  );
  // Actually wait: the guardrail should be the OPPOSITE — we want to prevent the real
  // push from running accidentally. The flag is --rehearse to opt INTO safe mode.
  // Without --rehearse, this would do the real push. We ALWAYS want --rehearse in dev.
  // So if NOT rehearse, warn loudly and exit:
  console.error("Add --rehearse to run in safe mode. Stage F only omits this flag.");
  process.exit(1);
}

const packagesPath = path.resolve(repo, packagesArg);
const srcDir = path.resolve(repo, srcArg);
const splitOutDir = path.resolve(repo, splitOutArg);

console.log(`mirror-release: mode=${rehearse ? "REHEARSE (local bare repos)" : "REAL (jackhp95 repos)"}`);
console.log(`mirror-release: packages=${packagesPath}`);
console.log(`mirror-release: src=${srcDir}`);
console.log(`mirror-release: split-out=${splitOutDir}`);

// ── Load packages.json ───────────────────────────────────────────────────────
let pkgsSpec;
try {
  pkgsSpec = JSON.parse(fs.readFileSync(packagesPath, "utf8"));
} catch (e) {
  console.error(`mirror-release: cannot read packages.json: ${e.message}`);
  process.exit(1);
}

const packages = pkgsSpec.packages || [];
const devRepo = pkgsSpec.devRepo || "the dev repo";

// ── Step 1: Run the splitter ─────────────────────────────────────────────────
console.log("\nmirror-release: step 1 — splitting into per-package mirror trees");

if (fs.existsSync(splitOutDir)) {
  fs.rmSync(splitOutDir, { recursive: true, force: true });
}

try {
  execFileSync("node", [
    elmCemCli,
    "split",
    `--packages=${packagesPath}`,
    `--src=${srcDir}`,
    `--out=${splitOutDir}`,
  ], { stdio: "inherit" });
} catch (e) {
  console.error(`mirror-release: splitter failed: ${e.message}`);
  process.exit(1);
}

// ── Step 2: For each package, init git + push to bare repo + tag ─────────────
console.log("\nmirror-release: step 2 — pushing mirror trees to repos");

const rehearsalBase = "/tmp/mirror-rehearsal";
if (rehearse) {
  fs.mkdirSync(rehearsalBase, { recursive: true });
}

const results = [];

for (const pkg of packages) {
  const shortName = pkg.name.split("/")[1];
  const pkgDir = path.join(splitOutDir, shortName);
  const version = versionArg ?? pkg.version ?? "1.0.0";

  console.log(`\nmirror-release: package ${pkg.name} @ ${version}`);

  // Determine the remote URL
  let remoteUrl;
  if (rehearse) {
    // Local bare repo under /tmp/mirror-rehearsal/<pkg>.git
    const bareDir = path.join(rehearsalBase, `${shortName}.git`);
    if (fs.existsSync(bareDir)) {
      fs.rmSync(bareDir, { recursive: true, force: true });
    }
    execSync(`git init --bare "${bareDir}"`);
    remoteUrl = `file://${bareDir}`;
    console.log(`  remote: ${remoteUrl} (rehearsal bare repo)`);
  } else {
    // STAGE F ONLY — real GitHub repo
    // This path is unreachable in dev because we exit above when !rehearse
    remoteUrl = `https://github.com/${pkg.name}.git`;
    console.log(`  remote: ${remoteUrl} (REAL — Stage F)`);
  }

  // Init a fresh git repo in the mirror tree
  const gitExec = (cmd, opts = {}) => execSync(`git ${cmd}`, { cwd: pkgDir, stdio: "pipe", ...opts });

  // Remove any existing .git
  const gitDir = path.join(pkgDir, ".git");
  if (fs.existsSync(gitDir)) {
    fs.rmSync(gitDir, { recursive: true, force: true });
  }

  // Init + commit
  gitExec("init");
  gitExec("checkout -b main");
  gitExec("add -A");
  gitExec(`commit -m "mirror: ${pkg.name} ${version} from ${devRepo}"`, {
    env: {
      ...process.env,
      GIT_AUTHOR_NAME: "elm-cem mirror",
      GIT_AUTHOR_EMAIL: "mirror@elm-cem",
      GIT_COMMITTER_NAME: "elm-cem mirror",
      GIT_COMMITTER_EMAIL: "mirror@elm-cem",
    }
  });

  // Add remote and push
  gitExec(`remote add origin "${remoteUrl}"`);
  gitExec(`push origin main --force`);
  gitExec(`tag ${version}`);
  gitExec(`push origin ${version}`);

  results.push({ name: pkg.name, shortName, version, remoteUrl, status: "OK" });
  console.log(`  pushed main + tag ${version}`);
}

// ── Step 3: Verify rehearsal bare repos ──────────────────────────────────────
if (rehearse) {
  console.log("\nmirror-release: step 3 — verifying rehearsal bare repos");
  for (const { name, shortName, version, remoteUrl } of results) {
    const bareDir = path.join(rehearsalBase, `${shortName}.git`);

    // Check the tag exists
    const tags = execSync(`git -C "${bareDir}" tag`, { encoding: "utf8" }).trim().split("\n");
    if (!tags.includes(version)) {
      console.error(`VERIFY FAIL: ${shortName} bare repo missing tag ${version}`);
      process.exit(1);
    }

    // Check the tree has src/ and elm.json
    const files = execSync(
      `git -C "${bareDir}" ls-tree --name-only HEAD`,
      { encoding: "utf8" }
    ).trim().split("\n");
    if (!files.includes("src")) {
      console.error(`VERIFY FAIL: ${shortName} bare repo HEAD missing src/`);
      process.exit(1);
    }
    if (!files.includes("elm.json")) {
      console.error(`VERIFY FAIL: ${shortName} bare repo HEAD missing elm.json`);
      process.exit(1);
    }
    if (!files.includes("README.md")) {
      console.error(`VERIFY FAIL: ${shortName} bare repo HEAD missing README.md`);
      process.exit(1);
    }

    // Check banner in README
    const readme = execSync(
      `git -C "${bareDir}" show HEAD:README.md`,
      { encoding: "utf8" }
    );
    if (!readme.includes("Generated publish mirror")) {
      console.error(`VERIFY FAIL: ${shortName} README missing copy-only banner`);
      process.exit(1);
    }

    console.log(`  ${shortName}: bare repo OK — tree+tag(${version})+banner verified`);
    console.log(`    remote: ${remoteUrl}`);
  }
}

// ── Summary ───────────────────────────────────────────────────────────────────
console.log("\n── Mirror release summary ──────────────────────────────────────");
for (const { name, version, remoteUrl, status } of results) {
  console.log(`  ${status}  ${name} @ ${version}  →  ${remoteUrl}`);
}

if (rehearse) {
  console.log("\nNOTE: --rehearse mode — no real jackhp95/<pkg> repos were touched.");
  console.log(`Bare repos: ${rehearsalBase}/`);
}

console.log("\nmirror-release: DONE");
