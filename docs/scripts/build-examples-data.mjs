// Build the docs-site Usage data (`docs/data/examples.json`) from the rich
// converter output (`config/examples.rich.json`) + category taxonomy
// (`config/categories.json`).
//
// Output schema (consumed by Route.Components.Name_):
//   { "<slug>": { category, examples: [ { title, section?, html, top } ] } }
// keyed by component SLUG (lowercased module name, matching reference.json
// slugs and the /components/:slug route).
//
// The rich file is keyed by PascalCase module (e.g. "Button", "IconButton").
// A module's slug is its lowercased name. A handful of corpus family-names
// (matraic groupings like "Chips"/"Search") have no single Elm-module slug;
// those are WARNED about (not silently dropped) — they render no Usage section
// until an explicit alias is added. No silent caps.

import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";

const here = path.dirname(fileURLToPath(import.meta.url));
const REPO = path.resolve(here, "../..");

const RICH = path.resolve(REPO, "config/examples.rich.json");
const CATEGORIES = path.resolve(REPO, "config/categories.json");
const REFERENCE = path.resolve(here, "../data/reference.json");
const OUT = path.resolve(here, "../data/examples.json");

const DEFAULT_CATEGORY = "Layout & style";

// A few corpus family-names (matraic groupings) don't equal any single Elm
// module's slug. Map them to the representative reference slug their examples
// actually use (verified by the <m3e-*> tags in the example HTML).
const SLUG_ALIASES = {
  Chips: "chip", // <m3e-chip>
  Search: "searchbar", // <m3e-search-bar>
};

function readJson(p) {
  return JSON.parse(fs.readFileSync(p, "utf8"));
}

function main() {
  const rich = readJson(RICH);
  const categories = readJson(CATEGORIES);

  // Known route slugs (for a non-silent mismatch warning). reference.json may
  // not exist on a clean checkout; if so, skip validation rather than fail.
  let knownSlugs = null;
  if (fs.existsSync(REFERENCE)) {
    const ref = readJson(REFERENCE);
    const arr = Array.isArray(ref) ? ref : Object.values(ref);
    knownSlugs = new Set(arr.map((x) => x.slug));
  }

  const out = {};
  const unmatched = [];

  for (const module of Object.keys(rich).sort()) {
    const slug = SLUG_ALIASES[module] || module.toLowerCase();
    const category = categories[module] || DEFAULT_CATEGORY;

    if (knownSlugs && !knownSlugs.has(slug)) {
      unmatched.push(module);
      // Still emit it — harmless dead data — so nothing is silently lost.
    }

    out[slug] = {
      category,
      examples: rich[module].map((ex) => ({
        title: ex.title,
        ...(ex.section ? { section: ex.section } : {}),
        html: ex.html,
        top: ex.top,
        mid: ex.mid,
        bottom: ex.bottom,
      })),
    };
  }

  fs.writeFileSync(OUT, JSON.stringify(out, null, 2) + "\n");

  const total = Object.values(out).reduce((n, c) => n + c.examples.length, 0);
  console.log(
    `wrote ${OUT} — ${Object.keys(out).length} components, ${total} examples`,
  );
  if (unmatched.length) {
    console.warn(
      `warning: ${unmatched.length} module(s) have no matching route slug ` +
        `(no Usage section until aliased): ${unmatched.join(", ")}`,
    );
  }
}

main();
