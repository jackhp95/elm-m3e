#!/usr/bin/env node
// Re-vendor the unpublished foundation Elm source (HtmlIr.* + TypedHtml.*) into
// docs/vendor/elm-foundation, which is a committed source-directory in docs/elm.json.
//
// WHY THIS EXISTS
//   The docs app imports M3e.* (from ../src), which depends on HtmlIr.*, and the
//   Examples/Guide routes also import TypedHtml.Attributes / TypedHtml.Aria. Both
//   HtmlIr and TypedHtml are UNPUBLISHED sibling repos, so they can't be package
//   deps yet. Netlify clones only elm-m3e, so the old `../../elm-*/src` source-dirs
//   didn't exist on CI. We vendor a committed copy instead; CI compiles against it.
//
// WHEN TO RUN
//   After changing HtmlIr or TypedHtml in the sibling repos, run:
//     pnpm run build:vendor
//   then commit the refreshed docs/vendor/elm-foundation. The COMMITTED copy is
//   what CI uses — this script is a local-dev sync convenience, never run on CI.
//
// The sibling repos are expected next to elm-m3e (../../ from docs/):
//   ../../elm-html-intermediate-representation
//   ../../elm-typed-html
// Override with env vars HTMLIR_SRC / TYPEDHTML_SRC if they live elsewhere.

import { cpSync, rmSync, mkdirSync, existsSync, readdirSync, statSync } from "node:fs";
import { join, dirname, resolve } from "node:path";
import { fileURLToPath } from "node:url";

const here = dirname(fileURLToPath(import.meta.url)); // docs/scripts
const docsDir = resolve(here, "..");
const vendorDir = join(docsDir, "vendor", "elm-foundation");

const htmlIrSrc =
  process.env.HTMLIR_SRC ??
  resolve(docsDir, "..", "..", "elm-html-intermediate-representation", "src");
const typedHtmlSrc =
  process.env.TYPEDHTML_SRC ?? resolve(docsDir, "..", "..", "elm-typed-html", "src");

function fail(msg) {
  console.error(`vendor-foundation: ${msg}`);
  process.exit(1);
}

for (const [label, dir] of [
  ["HtmlIr", htmlIrSrc],
  ["TypedHtml", typedHtmlSrc],
]) {
  if (!existsSync(dir)) {
    fail(
      `${label} source not found at ${dir}\n` +
        `  Clone the sibling repo next to elm-m3e, or set ${label === "HtmlIr" ? "HTMLIR_SRC" : "TYPEDHTML_SRC"}.`,
    );
  }
}

// Fresh module trees every run so deletions upstream propagate, but keep the
// hand-authored VENDORED_FROM.txt marker that also lives in this dir.
mkdirSync(vendorDir, { recursive: true });
for (const stale of ["HtmlIr", "TypedHtml", "TypedHtml.elm"]) {
  rmSync(join(vendorDir, stale), { recursive: true, force: true });
}

// HtmlIr: whole HtmlIr/ package tree.
cpSync(join(htmlIrSrc, "HtmlIr"), join(vendorDir, "HtmlIr"), { recursive: true });

// TypedHtml: the top-level module + the TypedHtml/ tree, but EXCLUDE
// TypedHtml/Review/* — those are elm-review rule facts that import Cem.Facts
// (an elm-review-only module the docs don't depend on) and are unexposed +
// unimported, so vendoring them would add an unresolvable import to a compiled
// source-directory.
cpSync(join(typedHtmlSrc, "TypedHtml.elm"), join(vendorDir, "TypedHtml.elm"));
cpSync(join(typedHtmlSrc, "TypedHtml"), join(vendorDir, "TypedHtml"), {
  recursive: true,
  filter: (src) => {
    const rel = src.slice(join(typedHtmlSrc, "TypedHtml").length);
    return !rel.startsWith("/Review");
  },
});

function countElm(dir) {
  let n = 0;
  for (const entry of readdirSync(dir)) {
    const p = join(dir, entry);
    if (statSync(p).isDirectory()) n += countElm(p);
    else if (entry.endsWith(".elm")) n += 1;
  }
  return n;
}

console.log(
  `vendor-foundation: refreshed ${vendorDir}\n` +
    `  from HtmlIr:    ${htmlIrSrc}\n` +
    `  from TypedHtml: ${typedHtmlSrc}\n` +
    `  ${countElm(vendorDir)} .elm modules vendored.`,
);
