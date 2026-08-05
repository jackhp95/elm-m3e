#!/usr/bin/env node
// check-gates — asserts that no check can be silently switched off.
//
// Why this exists: `check` was once `run-p "check:!(review)"`, which excluded
// elm-review from every gate. A commit then destroyed `review/src/ReviewConfig.elm`
// — removing every import and the `config` definition — and `npm run gate` still
// reported exit 0, because the config was never compiled. Fifteen real errors,
// including an accessibility defect in a live docs sample, sat invisible behind a
// green gate.
//
// A gate that can quietly drop one of its checks is worse than no gate: it produces
// confident false assurance. This script makes every omission declare itself.
//
// Rules enforced:
//   1. Every `check:*` / `test:*` script must be reachable from `gate`.
//   2. No `run-p`/`run-s` pattern may use a `!(…)` glob exclusion.
//   3. No gate-reachable command may pass a `--skip-*` flag.
//
// Any of these may be waived, but only by an entry in gate-waivers.json carrying a
// reason — so the omission is greppable, reviewable, and survives in git history.

import { readFileSync, existsSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

const root = join(dirname(fileURLToPath(import.meta.url)), "..");
const pkg = JSON.parse(readFileSync(join(root, "package.json"), "utf8"));
const scripts = pkg.scripts ?? {};

const waiverPath = join(root, "scripts", "gate-waivers.json");
const waivers = existsSync(waiverPath)
  ? JSON.parse(readFileSync(waiverPath, "utf8"))
  : {};

const problems = [];
const waived = [];

/** Script names a `run-p`/`run-s` invocation expands to. */
function expand(command) {
  const out = new Set();
  for (const raw of command.match(/"[^"]+"|\S+/g) ?? []) {
    const pat = raw.replace(/^"|"$/g, "");
    if (!/^[a-z]/i.test(pat)) continue; // flags, not patterns
    if (pat.includes("!(")) continue; // exclusions handled separately
    if (pat.includes("*")) {
      const re = new RegExp("^" + pat.replace(/[.+?^${}()|[\]\\]/g, "\\$&").replace(/\*/g, ".*") + "$");
      for (const name of Object.keys(scripts)) if (re.test(name)) out.add(name);
    } else if (scripts[pat]) {
      out.add(pat);
    }
  }
  return out;
}

/** Everything `gate` transitively runs. */
function reachable(entry) {
  const seen = new Set();
  const walk = (name) => {
    if (seen.has(name) || !scripts[name]) return;
    seen.add(name);
    const cmd = scripts[name];
    if (/\brun-[ps]\b/.test(cmd)) for (const child of expand(cmd)) walk(child);
  };
  walk(entry);
  return seen;
}

function check(id, message) {
  if (waivers[id]) {
    if (!String(waivers[id]).trim()) problems.push(`${id} — waiver present but has no reason`);
    else waived.push(`${id} — waived: ${waivers[id]}`);
    return;
  }
  problems.push(message);
}

if (!scripts.gate) {
  problems.push("no `gate` script — nothing to verify");
} else {
  const run = reachable("gate");

  // 1. every check:*/test:* is actually reached
  for (const name of Object.keys(scripts)) {
    if (!/^(check|test):/.test(name)) continue;
    if (run.has(name)) continue;
    check(name, `\`${name}\` is never run by \`gate\` — it is defined but unreachable`);
  }

  // 2. no glob exclusions
  for (const [name, cmd] of Object.entries(scripts)) {
    if (!/\brun-[ps]\b/.test(cmd) || !cmd.includes("!(")) continue;
    const excluded = cmd.match(/!\(([^)]*)\)/)?.[1] ?? "?";
    check(
      `${name}#exclusion`,
      `\`${name}\` uses a glob exclusion \`!(${excluded})\` — the excluded check silently never runs`
    );
  }

  // 3. no --skip-* inside anything the gate runs
  for (const name of run) {
    const skip = scripts[name]?.match(/--skip-[a-z-]+/g);
    if (!skip) continue;
    check(`${name}#${skip[0]}`, `\`${name}\` passes \`${skip.join(" ")}\` — that stage never runs in the gate`);
  }
}

for (const w of waived) console.log(`check-gates: ${w}`);

if (problems.length) {
  console.error("check-gates: FAIL — a gate can silently skip work:\n");
  for (const p of problems) console.error(`  - ${p}`);
  console.error(
    "\nEither wire the check into `gate`, or add an entry to scripts/gate-waivers.json\n" +
      "keyed by the id above with a reason string explaining why it is safe to skip."
  );
  process.exit(1);
}

console.log(
  `check-gates: OK — every check:*/test:* is reachable from \`gate\`` +
    (waived.length ? `, ${waived.length} declared waiver(s)` : "") +
    "."
);
