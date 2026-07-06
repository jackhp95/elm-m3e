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
import { execFileSync } from "child_process";

const here = path.dirname(fileURLToPath(import.meta.url));
const REPO = path.resolve(here, "../..");

const RICH = path.resolve(REPO, "config/examples.rich.json");
const SURFACES = path.resolve(REPO, "config/examples.surfaces.json");
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
  ProgressIndicator: "progress", // linear/circular fold into M3e.Progress
};

function readJson(p) {
  return JSON.parse(fs.readFileSync(p, "utf8"));
}

const ELM_FORMAT = path.resolve(here, "../node_modules/.bin/elm-format");

// The converter emits each example as ONE long unwrapped expression (a bare
// expr, or `[ e1\n    , e2\n    ]`), which reads as broken indentation and
// overflows. Run it through elm-format by wrapping it in a trivial declaration,
// formatting the module, then extracting + de-indenting the body. Falls back to
// the original string if elm-format is unavailable or the wrapped form doesn't
// parse (so a single odd example never breaks the build).
function tryFormat(code) {
  const wrapped =
    "module F exposing (s)\n\n\ns =\n" +
    code
      .split("\n")
      .map((l) => "    " + l)
      .join("\n") +
    "\n";
  try {
    const out = execFileSync(ELM_FORMAT, ["--stdin"], {
      input: wrapped,
      encoding: "utf8",
      stdio: ["pipe", "pipe", "ignore"],
    });
    const marker = "\ns =\n";
    const i = out.indexOf(marker);
    if (i < 0) return null;
    return out
      .slice(i + marker.length)
      .replace(/\s+$/, "")
      .split("\n")
      .map((l) => (l.startsWith("    ") ? l.slice(4) : l))
      .join("\n");
  } catch {
    return null;
  }
}

function formatElm(code) {
  if (!code || typeof code !== "string") return code;
  // elm-format never wraps by width, so a long single-line expression stays
  // long. Force a multi-line layout by inserting a newline before every `, `
  // and ` |> `; elm-format then re-indents it canonically. If the pre-broken
  // form doesn't parse (e.g. a `, ` inside a string literal), fall back to
  // formatting the original as-is, then to the raw string.
  const broken = code.replace(/, /g, "\n, ").replace(/ \|> /g, "\n|> ");
  return tryFormat(broken) ?? tryFormat(code) ?? code;
}

// The ④ Record / ⑤ Build surfaces (config/examples.surfaces.json) are produced
// by the D6 translator harness (gen-record-build.mjs), index-aligned with the
// rich file. For every example the harness emits either the TRANSLATED surface
// code (which contains an `M3e.Record.` / `M3e.Build.` reference) or a fallback
// COPY of the top code (when the example doesn't cleanly convert). We surface a
// tab only for a real translation: a fallback is stored as `null` here so the UI
// hides the tab rather than showing a hollow duplicate of the M3e tab.
function surfaceOrNull(code, token) {
  return code && typeof code === "string" && code.includes(token)
    ? formatElm(code)
    : null;
}

function main() {
  const rich = readJson(RICH);
  const surfaces = fs.existsSync(SURFACES) ? readJson(SURFACES) : {};
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

    const moduleSurfaces = surfaces[module] ?? [];
    out[slug] = {
      category,
      examples: rich[module].map((ex, idx) => {
        const surf = moduleSurfaces[idx] ?? {};
        return {
          title: ex.title,
          ...(ex.section ? { section: ex.section } : {}),
          html: ex.html,
          top: formatElm(ex.top),
          mid: formatElm(ex.mid),
          bottom: formatElm(ex.bottom),
          record: surfaceOrNull(surf.record, "M3e.Record."),
          build: surfaceOrNull(surf.build, "M3e.Build."),
        };
      }),
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
