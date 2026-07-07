# Example Re-Sourcing (Stream B1) Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Source each docs example from matraic's complete `.showcase` markup instead of the trimmed `.example` `<pre>`, so live previews stop rendering hollow and we stop dropping brevity-trimmed examples.

**Architecture:** One focused change to the corpus extractor (`extract-matraic-examples.mjs`): group cards by heading section; a section with `.showcase` card(s) emits one complete example per showcase (extracting the inner `[slot="content"]` markup, dedented) and captures the section's `.example` `<pre>` as `brevitySource` (for Stream B2's fold defaults); a section with no showcase falls back to the current `<pre>` sourcing (install/native/CSS cards). The whole downstream (`examples-to-elm.mjs` → generated/rich → `build-examples-data.mjs` → `data/examples.json`) is unchanged and simply receives complete markup. Then regenerate + commit the committed data artifacts.

**Tech Stack:** Node ESM (`scripts/examples-gen/*.mjs`), `linkedom` for HTML parsing, `node --test` (the existing `test:examples-gen` idiom), playwright for visual verification.

**Spec:** `docs/superpowers/specs/2026-07-07-example-sourcing-and-folding-design.md`

**Working directory for all commands:** `/Users/jack/Documents/code/elm-m3e/docs`

**Prerequisite:** the matraic clone must be present at `../matraic-m3e` (it is) so `build:examples-source` can run.

---

## File Structure

- **Modify** `docs/scripts/examples-gen/extract-matraic-examples.mjs` — refactor `extractPage(file)` into a pure, testable `extractPageFromHtml(slug, html)` + a thin file wrapper; add `dedent` and `showcaseCode` helpers; export them; guard `main()` so importing the module for tests doesn't run it; implement section-grouped sourcing.
- **Create** `docs/scripts/examples-gen/extract-matraic-examples.test.mjs` — unit tests for the new sourcing rules.
- **Regenerate (committed artifacts):** `config/examples.matraic.json`, `config/examples.generated.json`, `config/examples.rich.json`, `config/examples.surfaces.json`, `config/examples.barrel.json`, `config/examples.skipped.txt`, `docs/data/examples.json`.

---

## Task 1: Refactor + re-source the extractor (TDD)

**Files:**
- Modify: `docs/scripts/examples-gen/extract-matraic-examples.mjs`
- Create: `docs/scripts/examples-gen/extract-matraic-examples.test.mjs`

- [ ] **Step 1: Write the failing test**

Create `docs/scripts/examples-gen/extract-matraic-examples.test.mjs`:

```js
import { test } from "node:test";
import assert from "node:assert/strict";
import { extractPageFromHtml, dedent } from "./extract-matraic-examples.mjs";

// A heading section with a .showcase (complete markup) followed by a trimmed
// .example (the brevity oracle). Mirrors the matraic app-bar "Sizes" shape.
const SHOWCASE_SECTION = `
<m3e-heading level="1">App Bar</m3e-heading>
<m3e-heading level="3">Sizes</m3e-heading>
<p>Use the size attribute.</p>
<m3e-card class="showcase"><div slot="content">
  <m3e-app-bar size="medium">
    <span slot="title">Trails</span>
  </m3e-app-bar>
</div></m3e-card>
<m3e-card class="example"><pre slot="content">
&lt;m3e-app-bar size="medium"&gt;
  &lt;!-- Content omitted for brevity --&gt;
&lt;/m3e-app-bar&gt;</pre></m3e-card>
`;

test("showcase section sources COMPLETE markup, not the trimmed pre", () => {
  const { examples } = extractPageFromHtml("appbar", SHOWCASE_SECTION);
  assert.equal(examples.length, 1);
  const ex = examples[0];
  assert.equal(ex.title, "Sizes");
  // Complete: the title span survived; nothing was "omitted for brevity".
  assert.match(ex.code, /<span slot="title">Trails<\/span>/);
  assert.doesNotMatch(ex.code, /omitted for brevity/);
  // The trimmed pre is captured as the brevity oracle for B2.
  assert.match(ex.brevitySource, /omitted for brevity/);
});

// A pure-code section: an .example with NO preceding .showcase (install/native).
const PURE_CODE_SECTION = `
<m3e-heading level="3">Native module support</m3e-heading>
<m3e-card class="example"><pre slot="content">
&lt;m3e-app-bar&gt;&lt;/m3e-app-bar&gt;
&lt;script type="module"&gt;&lt;/script&gt;</pre></m3e-card>
`;

test("example-only section falls back to the pre source", () => {
  const { examples } = extractPageFromHtml("appbar", PURE_CODE_SECTION);
  assert.equal(examples.length, 1);
  assert.match(examples[0].code, /<m3e-app-bar><\/m3e-app-bar>/);
  assert.equal(examples[0].brevitySource, undefined);
});

test("dedent strips common leading indentation and blank edges", () => {
  assert.equal(dedent("\n    <a>\n      <b/>\n    </a>\n"), "<a>\n  <b/>\n</a>");
});
```

- [ ] **Step 2: Run the test to verify it FAILS**

Run: `node --test scripts/examples-gen/extract-matraic-examples.test.mjs`
Expected: FAIL — the module currently runs `main()` on import (no matraic dir in test context) and/or `extractPageFromHtml`/`dedent` are not exported. This is the red state.

- [ ] **Step 3: Refactor the extractor**

In `docs/scripts/examples-gen/extract-matraic-examples.mjs`:

(a) Add these helpers near `decodePre` (keep `decodePre`, `normText`, `SKIP_SLUGS` as-is):

```js
/** Strip common leading indentation and blank leading/trailing lines. */
export function dedent(s) {
  const lines = s.replace(/\t/g, "  ").split("\n");
  while (lines.length && lines[0].trim() === "") lines.shift();
  while (lines.length && lines[lines.length - 1].trim() === "") lines.pop();
  const indents = lines
    .filter((l) => l.trim() !== "")
    .map((l) => l.match(/^ */)[0].length);
  const min = indents.length ? Math.min(...indents) : 0;
  return lines.map((l) => l.slice(min)).join("\n");
}

/** Complete component markup from a .showcase card's slotted content, dedented. */
function showcaseCode(card) {
  const content = card.querySelector('[slot="content"]');
  if (!content) return null;
  const code = dedent(content.innerHTML);
  return code.trim().startsWith("<") ? code : null;
}
```

(b) Replace `extractPage(file)` (the whole function, lines ~62-125) with a pure core + a file wrapper:

```js
/** Pure, testable core: (slug, htmlString) -> { slug, examples, nonHtml }. */
export function extractPageFromHtml(slug, html) {
  const { document } = parseHTML(html);

  const examples = [];
  const nonHtml = [];
  const titleCounts = new Map();

  let title = "Usage";
  let description = "";
  // Cards accumulated under the current heading section.
  let section = { showcases: [], examplePres: [] };

  const pushExample = (code, brevitySource) => {
    const n = (titleCounts.get(title) || 0) + 1;
    titleCounts.set(title, n);
    const rec = {
      title: n === 1 ? title : `${title} (${n})`,
      description,
      code,
      source: `matraic: docs/components/${slug}.html`,
    };
    if (brevitySource) rec.brevitySource = brevitySource;
    examples.push(rec);
  };

  const flush = () => {
    const brevitySource =
      section.examplePres.length > 0 ? decodePre(section.examplePres[0]) : null;
    if (section.showcases.length > 0) {
      // Showcase-backed: one COMPLETE example per showcase card.
      for (const card of section.showcases) {
        const code = showcaseCode(card);
        if (code) pushExample(code, brevitySource);
      }
    } else {
      // Pure-code section (install/native/CSS): keep the current pre sourcing.
      for (const pre of section.examplePres) {
        const code = decodePre(pre);
        if (!code.trim().startsWith("<")) {
          nonHtml.push({ title, snippet: code.slice(0, 60) });
          continue;
        }
        pushExample(code, null);
      }
    }
    section = { showcases: [], examplePres: [] };
  };

  const stream = document.querySelectorAll("m3e-heading, p, m3e-card");
  for (const el of stream) {
    const tag = el.tagName.toLowerCase();

    if (tag === "m3e-heading") {
      if (el.getAttribute("level") === "1") continue; // component-name banner
      flush(); // close the previous section before switching headings
      title = normText(el.textContent) || "Usage";
      description = "";
      continue;
    }
    if (tag === "p") {
      description = normText(el.textContent);
      continue;
    }

    // m3e-card
    const cls = el.getAttribute("class") || "";
    if (/\bshowcase\b/.test(cls)) {
      section.showcases.push(el);
    } else if (/\bexample\b/.test(cls)) {
      const pre = el.querySelector("pre");
      if (pre) section.examplePres.push(pre);
    }
    // other cards (install banners without a pre, etc.) are ignored as before
  }
  flush(); // final section

  return { slug, examples, nonHtml };
}

function extractPage(file) {
  const slug = basename(file, ".html");
  return extractPageFromHtml(slug, readFileSync(file, "utf8"));
}
```

(c) Guard the CLI entry so importing the module in tests does not run `main()`. Add `pathToFileURL` to the existing `node:url` import, and replace the bare `main();` at the bottom:

```js
import { fileURLToPath, pathToFileURL } from "node:url";
```
```js
// Run only when invoked directly (not when imported by tests).
if (process.argv[1] && import.meta.url === pathToFileURL(process.argv[1]).href) {
  main();
}
```

(Leave `main()`'s body unchanged — it already loops files, writes `OUT_PATH`, and logs totals.)

- [ ] **Step 4: Run the test to verify it PASSES**

Run: `node --test scripts/examples-gen/extract-matraic-examples.test.mjs`
Expected: PASS — 3/3 tests. If `showcaseCode` returns markup with different whitespace than the assertion, the assertions use `match` on structural substrings, so incidental indentation differences won't fail them.

- [ ] **Step 5: Run the existing examples-gen tests to confirm no regression**

Run: `npm run test:examples-gen`
Expected: existing lib tests still pass (they test `to-elm`, `sections`, `naming`, `oracle` — untouched).

- [ ] **Step 6: Commit**

```bash
git add scripts/examples-gen/extract-matraic-examples.mjs scripts/examples-gen/extract-matraic-examples.test.mjs
git commit -m "feat(docs): source examples from .showcase complete markup, not trimmed pre

Section with a .showcase emits one complete example per showcase and captures
the paired .example <pre> as brevitySource (for B2 fold defaults). Sections
with no showcase keep pre sourcing (install/native/CSS). extractPage split into
testable extractPageFromHtml + file wrapper; main() guarded behind CLI check."
```

---

## Task 2: Regenerate the matraic corpus and verify completeness

**Files:**
- Regenerate: `config/examples.matraic.json`

- [ ] **Step 1: Regenerate the corpus**

Run: `npm run build:examples-source`
Expected: logs `extract-matraic-examples: N HTML examples across M pages …` with **N noticeably higher** than before (brevity-drop recovery). No crash.

- [ ] **Step 2: Verify the appbar "Sizes" example is now complete**

Run:
```bash
node -e "const c=require('./config/examples.matraic.json'); const s=c.appbar.find(e=>/^Sizes/.test(e.title)); console.log('title:', s.title); console.log('has brevitySource:', !!s.brevitySource); console.log('code omits brevity comment:', !/omitted for brevity/.test(s.code)); console.log(s.code.slice(0,200))"
```
Expected: `has brevitySource: true`, `code omits brevity comment: true`, and the printed code contains real slotted content (title/leading/trailing), not an empty shell.

- [ ] **Step 3: Commit the regenerated corpus**

```bash
git add config/examples.matraic.json
git commit -m "chore(docs): regenerate matraic corpus from .showcase markup"
```

---

## Task 3: Regenerate downstream data and confirm the gates

**Files:**
- Regenerate: `config/examples.generated.json`, `config/examples.rich.json`, `config/examples.surfaces.json`, `config/examples.barrel.json`, `config/examples.skipped.txt`, `docs/data/examples.json`

- [ ] **Step 1: Capture the current skipped/example baseline**

Run:
```bash
wc -l config/examples.skipped.txt; node -e "const e=require('./data/examples.json'); console.log('example pages:', Object.keys(e).length, 'total examples:', Object.values(e).reduce((n,v)=>n+(v.examples?.length||v.length||0),0))"
```
Note the two numbers.

- [ ] **Step 2: Regenerate the full example pipeline**

Run: `npm run build:examples-config && npm run build:examples-surfaces && npm run build:examples-barrel && npm run build:examples`
Expected: each step completes; `build:examples-config` re-runs the compile-verify gate.

- [ ] **Step 3: Verify skipped shrank and examples grew**

Run the same measurement as Step 1. Expected: `examples.skipped.txt` line count is **lower** (brevity-related drops recovered; remaining skips are the API-gap cases — `Html.script` "Native module support", `child`/`children`, unmapped attrs), and total examples in `data/examples.json` is **higher**. Spot-check `config/examples.skipped.txt` no longer contains brevity-hollow failures (it should be dominated by `Html.script` / `child` / unmapped-attr reasons).

- [ ] **Step 4: Run the deploy build gate**

Run: `npm run build:ci`
Expected: exit 0; `check-nav: OK`; `Success - Adapter script complete`.

- [ ] **Step 5: Verify elm-format is clean on any touched Elm**

Run: `node_modules/.bin/elm-format --validate app src` 
Expected: `[]` (no changes needed; B1 touches no `.elm`).

- [ ] **Step 6: Commit the regenerated data**

```bash
git add config/examples.generated.json config/examples.rich.json config/examples.surfaces.json config/examples.barrel.json config/examples.skipped.txt data/examples.json
git commit -m "chore(docs): regenerate example data from complete markup

More examples recovered (brevity drops eliminated); skipped.txt now dominated by
API-gap cases only. Live previews now receive complete markup."
```

---

## Task 4: Playwright — verify previews are no longer hollow

**Files:**
- Create (temporary, not committed): a playwright check script under the scratchpad.

- [ ] **Step 1: Build dist and serve it**

Run:
```bash
npm run build   # build:assets (incl. regenerated data) + elm-pages build
node scripts/serve-dist.mjs dist 1239 &
```
Expected: server logs `static server on http://localhost:1239 serving dist/`.

- [ ] **Step 2: Assert the appbar "Sizes" previews render real, non-empty app bars**

Create a scratch script (path under the session scratchpad) that loads
`http://localhost:1239/components/appbar`, waits for custom elements to upgrade, and for
every `m3e-app-bar` on the page measures whether it has visible slotted content (e.g. a
non-empty `[slot="title"]` and a bounding-box height > 40px). Import chromium from the
resolved `@playwright/test` entry (bare `playwright` is not installed here):

```js
import pkg from "/Users/jack/Documents/code/elm-m3e/docs/node_modules/.pnpm/@playwright+test@1.61.1/node_modules/@playwright/test/index.js";
const { chromium } = pkg;
const browser = await chromium.launch();
const page = await browser.newPage({ viewport: { width: 1200, height: 2400 } });
await page.goto("http://localhost:1239/components/appbar", { waitUntil: "networkidle" });
await page.waitForTimeout(1500);
const bars = await page.evaluate(() =>
  [...document.querySelectorAll("m3e-app-bar")].map((b) => ({
    height: Math.round(b.getBoundingClientRect().height),
    hasTitle: !!b.querySelector('[slot="title"]')?.textContent.trim(),
  }))
);
console.log(JSON.stringify(bars, null, 2));
const hollow = bars.filter((b) => b.height < 40 || !b.hasTitle);
console.log(hollow.length ? `FAIL: ${hollow.length} hollow app bar(s)` : `PASS: all ${bars.length} app bars have content`);
await page.screenshot({ path: "<scratchpad>/appbar-after.png", fullPage: true });
await browser.close();
```

Run it with `node <scratchpad>/verify-appbar.mjs`.
Expected: `PASS: all N app bars have content`, every bar height well above 40px, `hasTitle: true`. Read the screenshot to confirm the "Sizes" section shows fully-populated medium/large app bars (not empty shells).

- [ ] **Step 3: Stop the server**

Run: `pkill -f "serve-dist.mjs"`

- [ ] **Step 4: (No commit)** — Task 4 is verification only; the scratch script stays out of the repo.

---

## Final Verification

- [ ] `node --test scripts/examples-gen/extract-matraic-examples.test.mjs` → 3/3 pass.
- [ ] `npm run test:examples-gen` → existing lib tests pass.
- [ ] `npm run build:ci` → exit 0, guard OK, adapter success.
- [ ] `data/examples.json` total example count is higher than the Task 3 Step 1 baseline; `config/examples.skipped.txt` is lower and dominated by API-gap reasons.
- [ ] Playwright: `/components/appbar` "Sizes" app bars are fully populated (no hollow shells), confirmed by assertion + screenshot.
- [ ] Spot-check 2-3 other formerly-hollow pages (any component whose matraic page uses "omitted for brevity") render complete previews.
