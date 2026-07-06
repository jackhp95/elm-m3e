// Extract the VERBATIM matraic example corpus from the upstream doc site.
//
// The library the docs cover is `@m3e/web` by matraic (github.com/matraic/m3e).
// Its open-source doc site ships one HTML page per component under
// `docs/components/<slug>.html`. Each page repeats, under a
//   <m3e-heading variant="headline" size="medium" level="2">Usage</m3e-heading>
// section, a run of:
//   <m3e-heading … level="3">Title</m3e-heading>   — the subsection title
//   <p>…</p>                                        — the description
//   <m3e-card class="showcase">…live markup…</m3e-card>   — RENDERED demo (ignored)
//   <m3e-card class="example"><pre>…escaped markup…</pre></m3e-card>  — SOURCE
// The `class="example"` <pre> holds the HTML-escaped verbatim example markup —
// linkedom's `textContent` decodes the entities for us. The `class="install"`
// card is an `import "@m3e/web/…"` line, not an example, and is skipped.
//
// This script walks each page in document order, pairing every `class="example"`
// card with its nearest preceding subsection heading (level 2 or 3; the level-1
// component name is ignored) and the nearest preceding <p> description. Cards
// whose decoded body is not HTML (e.g. a CSS density snippet or a JS import) are
// filtered out and logged — the downstream converter only speaks HTML.
//
// Output: config/examples.matraic.json — keyed by matraic page slug, matching
// the shape examples-to-elm.mjs consumes ({ slug -> [{ title, code, … }] }).
// The slug pascal-maps (via lib/naming.mjs) to the pipeline's module key, and
// the committed JSON means clean checkouts never need the upstream clone. To
// refresh from upstream:  git -C ../matraic-m3e pull && npm run build:examples-source
//
// The clone location is overridable with MATRAIC_DIR (default: sibling
// ../matraic-m3e of the elm-m3e repo root).

import { readFileSync, writeFileSync, existsSync, readdirSync } from "node:fs";
import { fileURLToPath } from "node:url";
import { dirname, resolve, basename } from "node:path";
import { parseHTML } from "linkedom";

const HERE = dirname(fileURLToPath(import.meta.url));
// docs/scripts/examples-gen/ -> elm-m3e root is three up.
const REPO_ROOT = resolve(HERE, "..", "..", "..");

const MATRAIC_DIR =
  process.env.MATRAIC_DIR || resolve(REPO_ROOT, "..", "matraic-m3e");
const COMPONENTS_DIR = resolve(MATRAIC_DIR, "docs", "components");
const OUT_PATH = resolve(REPO_ROOT, "config", "examples.matraic.json");

// Pages that are live demos / harnesses, not a component's own doc page.
const SKIP_SLUGS = new Set(["toc-example"]);

/** Collapse runs of whitespace in a plain-text description. */
function normText(s) {
  return s.replace(/\s+/g, " ").trim();
}

/**
 * Decode a `<pre slot="content">` body: linkedom's textContent already resolves
 * &lt;/&gt;/&quot;/&amp;. Strip the single leading newline the pretty-printed
 * source carries and any trailing whitespace; preserve interior indentation.
 */
function decodePre(pre) {
  return pre.textContent.replace(/^\n/, "").replace(/[ \t\r\n]+$/, "");
}

/** One page -> { slug, examples: [{title, description, code, source}], nonHtml: [...] }. */
function extractPage(file) {
  const slug = basename(file, ".html");
  const html = readFileSync(file, "utf8");
  const { document } = parseHTML(html);

  const examples = [];
  const nonHtml = [];
  const titleCounts = new Map();

  let title = "Usage";
  let description = "";

  // Document-order stream of the elements we care about. querySelectorAll
  // preserves document order, so a single pass tracks the "current" heading and
  // description that each example card falls under.
  const stream = document.querySelectorAll("m3e-heading, p, m3e-card");
  for (const el of stream) {
    const tag = el.tagName.toLowerCase();

    if (tag === "m3e-heading") {
      // Level-1 is the component name banner; sub-headings (2/3) are titles.
      const level = el.getAttribute("level");
      if (level === "1") continue;
      title = normText(el.textContent) || "Usage";
      description = ""; // a fresh heading resets the running description
      continue;
    }

    if (tag === "p") {
      description = normText(el.textContent);
      continue;
    }

    // m3e-card: only the class="example" cards are source; skip showcase/install.
    const cls = el.getAttribute("class") || "";
    if (!/\bexample\b/.test(cls)) continue;
    const pre = el.querySelector("pre");
    if (!pre) continue;

    const code = decodePre(pre);
    if (!code.trim().startsWith("<")) {
      // A CSS/JS snippet card (e.g. the density custom-property block) — not
      // convertible HTML. Record it so nothing is silently dropped.
      nonHtml.push({ title, snippet: code.slice(0, 60) });
      continue;
    }

    // Disambiguate repeated titles within a page (e.g. two example cards under
    // the same subsection) so downstream keys/anchors stay unique.
    const n = (titleCounts.get(title) || 0) + 1;
    titleCounts.set(title, n);
    const finalTitle = n === 1 ? title : `${title} (${n})`;

    examples.push({
      title: finalTitle,
      description,
      code,
      source: `matraic: docs/components/${slug}.html`,
    });
  }

  return { slug, examples, nonHtml };
}

function main() {
  if (!existsSync(COMPONENTS_DIR)) {
    console.error(
      `extract-matraic-examples: upstream clone not found at ${COMPONENTS_DIR}.\n` +
        "Clone github.com/matraic/m3e beside elm-m3e (or set MATRAIC_DIR), then re-run.\n" +
        "The committed config/examples.matraic.json is unchanged.",
    );
    process.exit(1);
  }

  const files = readdirSync(COMPONENTS_DIR)
    .filter((f) => f.endsWith(".html"))
    .filter((f) => !SKIP_SLUGS.has(basename(f, ".html")))
    .sort();

  const corpus = {};
  const emptyPages = [];
  let totalExamples = 0;
  let totalNonHtml = 0;

  for (const f of files) {
    const { slug, examples, nonHtml } = extractPage(resolve(COMPONENTS_DIR, f));
    totalNonHtml += nonHtml.length;
    if (examples.length === 0) {
      emptyPages.push(slug);
      if (nonHtml.length > 0) {
        console.warn(
          `  ${slug}: 0 HTML examples (${nonHtml.length} non-HTML card(s) only)`,
        );
      } else {
        console.warn(`  ${slug}: 0 example cards`);
      }
      continue;
    }
    corpus[slug] = examples;
    totalExamples += examples.length;
    for (const nh of nonHtml) {
      console.warn(
        `  ${slug}: skipped non-HTML example card under "${nh.title}": ${JSON.stringify(nh.snippet)}…`,
      );
    }
  }

  // Deterministic key order.
  const sorted = {};
  for (const k of Object.keys(corpus).sort()) sorted[k] = corpus[k];
  writeFileSync(OUT_PATH, JSON.stringify(sorted, null, 2) + "\n");

  console.log(
    `extract-matraic-examples: ${totalExamples} HTML examples across ` +
      `${Object.keys(sorted).length} pages ` +
      `(${totalNonHtml} non-HTML cards skipped; ` +
      `${emptyPages.length} page(s) with zero HTML examples: ` +
      `${emptyPages.join(", ") || "none"}).`,
  );
  console.log(`wrote ${OUT_PATH}`);
}

main();
