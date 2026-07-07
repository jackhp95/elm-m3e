#!/usr/bin/env node
// Guards the docs drawer against dead links. Every slug the drawer links to
// (Shared.elm `componentList`) must have a pre-rendered page, i.e. must exist
// as a slug in reference.json. Also warns about example-bearing pages that the
// drawer never links to, so silent nav gaps surface.
import { readFileSync } from "node:fs";
import { fileURLToPath } from "node:url";
import { dirname, resolve } from "node:path";

const HERE = dirname(fileURLToPath(import.meta.url));
const DOCS = resolve(HERE, "..");

const reference = JSON.parse(readFileSync(resolve(DOCS, "data/reference.json"), "utf8"));
const examples = JSON.parse(readFileSync(resolve(DOCS, "data/examples.json"), "utf8"));
const shared = readFileSync(resolve(DOCS, "app/Shared.elm"), "utf8");

const pageSlugs = new Set(reference.map((c) => c.slug));
const exampleSlugs = new Set(Object.keys(examples));

// Isolate the `componentList = [ ... ]` literal, then pull the first string of
// each (slug, label, category) tuple.
const start = shared.indexOf("componentList =");
if (start === -1) {
  console.error("check-nav: could not find `componentList =` in Shared.elm");
  process.exit(1);
}
const end = shared.indexOf("\n    ]", start);
if (end === -1) {
  console.error("check-nav: could not find end of componentList literal");
  process.exit(1);
}
const block = shared.slice(start, end);
const navSlugs = [...block.matchAll(/\(\s*"([^"]+)"\s*,/g)].map((m) => m[1]);

if (navSlugs.length === 0) {
  console.error("check-nav: parsed 0 slugs from componentList — parser or file changed");
  process.exit(1);
}

const dead = navSlugs.filter((s) => !pageSlugs.has(s));
const missingFromNav = [...exampleSlugs].filter((s) => !navSlugs.includes(s));

if (missingFromNav.length) {
  console.warn(
    `check-nav: WARNING — ${missingFromNav.length} example-bearing page(s) not in nav: ` +
      missingFromNav.sort().join(", ")
  );
}

if (dead.length) {
  console.error(
    `check-nav: FAIL — ${dead.length} drawer link(s) point at non-existent pages: ` +
      dead.sort().join(", ")
  );
  process.exit(1);
}

console.log(`check-nav: OK — ${navSlugs.length} drawer links all resolve.`);
