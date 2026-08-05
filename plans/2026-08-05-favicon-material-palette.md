# Favicon from the Material `palette` Glyph — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Generate `docs/public/favicon.svg` from the real `material-symbols:palette` glyph — the same icon the app bar renders — instead of a hand-copied legacy Material Icons path.

**Architecture:** Extend the icon generator built for the registry seam with a second output. It resolves `material-symbols:palette` through the same `resolveIcon`, then wraps the path in the existing brand plate, computing the placement transform from the icon's declared viewBox rather than hard-coding it.

**Tech Stack:** Node ESM (`docs/scripts/icons-gen/`), `@iconify-json/material-symbols`, elm-pages `Head.icon`.

**Spec:** `specs/2026-08-05-favicon-material-palette-design.md`

## Global Constraints

- **Blocked on the icon-registry plan Task 2.** This reuses `resolveIcon` and `loadSets` from `docs/scripts/icons-gen/icons-to-js.mjs`. Do not duplicate that logic.
- The favicon is **generated**, never hand-edited. A drift check must catch a stale committed file.
- Keep the existing brand plate exactly: `viewBox="0 0 48 48"`, `role="img"`, `aria-label="elm-m3e"`, the 46×46 rect at `x=1 y=1 rx=13`, and the `#8A6FE0 → #5B3F9E` linear gradient. Only the glyph path and its transform change.
- The placement transform is **computed from the icon's declared viewBox**. Material Symbols sit on `0 -960 960 960` (origin at the baseline, negative Y), so the current `translate(11 11) scale(1.08)` — which assumes `0 0 24 24` — would place the glyph off-canvas.
- **Do not delete `docs/public/favicon.ico`.** 14 route modules in `docs/app/` still pass it as their Open Graph `image`. That it is a 32×32 PNG being used as a social card is a real bug, recorded in the spec as separate work.
- Scope is `favicon.svg` only. `docs/app/Site.elm:30` already registers only `favicon.svg`, so no head-tag change is needed.

---

### Task 1: Generate the favicon from the resolved glyph

**Files:**
- Modify: `config/icons.json` (add the palette entry)
- Create: `docs/scripts/icons-gen/favicon.mjs`
- Create: `docs/scripts/icons-gen/favicon.test.mjs`
- Modify (generated): `docs/public/favicon.svg`
- Modify: `docs/package.json` (add `gen:favicon` to the `gen` chain)

**Interfaces:**
- Consumes: `resolveIcon(sets, id) -> { viewBox, path }` and `loadSets(prefixes)` from `docs/scripts/icons-gen/icons-to-js.mjs`.
- Produces: `plateTransform(viewBox, { plate, glyph }) -> string` and `renderFavicon({ viewBox, path }) -> string`, both exported for test.

- [ ] **Step 1: Add the glyph to the icon config**

`config/icons.json` becomes:

```json
{
  "github": "mdi:github",
  "palette": "material-symbols:palette"
}
```

Adding it here means it is *also* registered into `IconRegistry`, which overrides the ligature font for `palette` specifically. That is desirable — the app bar and the tab icon then provably render the same path data — but confirm in Task 2 Step 3 that the app-bar icon still looks right, because it now comes from the registry rather than the font.

- [ ] **Step 2: Write the failing test**

`docs/scripts/icons-gen/favicon.test.mjs`:

```js
import { test } from "node:test";
import assert from "node:assert/strict";
import { plateTransform, renderFavicon } from "./favicon.mjs";

test("places a Material Symbols glyph inside the plate", () => {
  // Material Symbols: viewBox "0 -960 960 960" — origin at the baseline, negative Y.
  // scale = 26/960; y in [-960,0] scales to [-26,0] and must land in [11,37],
  // so ty = 11 + 26 = 37.
  assert.equal(
    plateTransform("0 -960 960 960", { plate: 48, glyph: 26 }),
    "translate(11 37) scale(0.0270833)",
  );
});

test("places a legacy 0 0 24 24 glyph inside the same plate", () => {
  // y in [0,24] scales to [0,26] and must land in [11,37], so ty = 11.
  assert.equal(
    plateTransform("0 0 24 24", { plate: 48, glyph: 26 }),
    "translate(11 11) scale(1.0833333)",
  );
});

test("rejects a non-square viewBox rather than distorting the glyph", () => {
  assert.throws(() => plateTransform("0 0 24 48", { plate: 48, glyph: 26 }), /square/i);
});

test("renders the plate, the gradient, and the glyph path", () => {
  const svg = renderFavicon({ viewBox: "0 -960 960 960", path: "M480-80Z" });
  assert.match(svg, /viewBox="0 0 48 48"/);
  assert.match(svg, /aria-label="elm-m3e"/);
  assert.match(svg, /stop-color="#8A6FE0"/);
  assert.match(svg, /stop-color="#5B3F9E"/);
  assert.match(svg, /<rect x="1" y="1" width="46" height="46" rx="13"/);
  assert.match(svg, /transform="translate\(11 37\) scale\(0\.0270833\)"/);
  assert.match(svg, /d="M480-80Z"/);
  assert.match(svg, /fill="#FFFFFF"/);
});
```

- [ ] **Step 3: Run it to verify it fails**

Run: `cd docs && node --test scripts/icons-gen/favicon.test.mjs`
Expected: FAIL — cannot find module `./favicon.mjs`.

- [ ] **Step 4: Write the generator**

`docs/scripts/icons-gen/favicon.mjs`:

```js
// Generates docs/public/favicon.svg — the brand plate with the REAL Material
// Symbols `palette` glyph, the same icon the app bar renders
// (docs/app/Shared.elm: M3e.Icon.name "palette").
//
// The file it replaces carried a hand-copied path from the LEGACY Material Icons
// set on a 0 0 24 24 grid. Material Symbols sit on "0 -960 960 960" — origin at
// the BASELINE, with negative Y — so the placement transform must be computed
// from the icon's declared viewBox. Reusing the old translate(11 11) scale(1.08)
// would put the glyph off-canvas.

import { writeFileSync, readFileSync } from "node:fs";
import { dirname, resolve } from "node:path";
import { fileURLToPath } from "node:url";
import { resolveIcon, loadSets } from "./icons-to-js.mjs";

const HERE = dirname(fileURLToPath(import.meta.url));
const REPO = resolve(HERE, "..", "..", "..");

const PLATE = 48;
const GLYPH = 26;

/** Round to 7 significant decimals and strip trailing zeros, so output is stable. */
function num(n) {
  return String(Number(n.toFixed(7)));
}

export function plateTransform(viewBox, { plate, glyph }) {
  const [minX, minY, w, h] = viewBox.split(/\s+/).map(Number);
  if (w !== h) {
    throw new Error(`Glyph viewBox '${viewBox}' is not square; scaling it into the plate would distort it.`);
  }
  const scale = glyph / w;
  const inset = (plate - glyph) / 2;
  // Where the scaled glyph currently sits, and where it needs to land.
  const tx = inset - minX * scale;
  const ty = inset - minY * scale;
  return `translate(${num(tx)} ${num(ty)}) scale(${num(scale)})`;
}

export function renderFavicon({ viewBox, path }) {
  return `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 ${PLATE} ${PLATE}" role="img" aria-label="elm-m3e">
  <!-- GENERATED by docs/scripts/icons-gen/favicon.mjs — do not edit.
       Glyph: material-symbols:palette, the same icon the app bar renders. -->
  <defs>
    <linearGradient id="g" x1="0" y1="0" x2="1" y2="1">
      <stop offset="0" stop-color="#8A6FE0"/>
      <stop offset="1" stop-color="#5B3F9E"/>
    </linearGradient>
  </defs>
  <rect x="1" y="1" width="46" height="46" rx="13" fill="url(#g)"/>
  <g transform="${plateTransform(viewBox, { plate: PLATE, glyph: GLYPH })}">
    <path fill="#FFFFFF" d="${path}"/>
  </g>
</svg>
`;
}

if (process.argv[1] === fileURLToPath(import.meta.url)) {
  const config = JSON.parse(readFileSync(resolve(REPO, "config", "icons.json"), "utf8"));
  const id = config.palette;
  if (!id) throw new Error(`config/icons.json has no "palette" entry — the favicon glyph is unset.`);
  const icon = resolveIcon(loadSets([id.split(":")[0]]), id);
  const out = resolve(REPO, "docs", "public", "favicon.svg");
  writeFileSync(out, renderFavicon(icon));
  console.log(`Wrote ${out} from ${id}.`);
}
```

- [ ] **Step 5: Run the test to verify it passes**

Run: `cd docs && node --test scripts/icons-gen/favicon.test.mjs`
Expected: PASS, 4 tests.

Note the second test doubles as a guard on the general formula: for `0 0 24 24` it must reproduce a `translate(11 11)` — matching the *old* file's translate — which is evidence the formula is right and that the old file's translate was correct for the grid it assumed.

- [ ] **Step 6: Generate and inspect**

```bash
cd docs && node scripts/icons-gen/favicon.mjs && cat public/favicon.svg
```

Expected: a `translate(11 37) scale(0.0270833)` transform and a path starting with `M` on the 960 grid (numbers in the hundreds, with negative Y values).

- [ ] **Step 7: Wire into the gen chain**

In `docs/package.json`, add `gen:favicon` after `gen:icons`:

```json
"gen": "run-s gen:vendor gen:icons gen:favicon gen:reference gen:examples-config gen:examples-surfaces gen:examples-barrel gen:examples gen:samples",
"gen:favicon": "node scripts/icons-gen/favicon.mjs",
```

- [ ] **Step 8: Commit**

```bash
git add config/icons.json docs/scripts/icons-gen/favicon.mjs docs/scripts/icons-gen/favicon.test.mjs docs/public/favicon.svg docs/package.json
git commit -m "Generate the favicon from the real Material Symbols palette glyph"
```

---

### Task 2: Verify it renders and does not regress the app bar

**Files:**
- No source changes. This task is verification, and it needs its own cycle because a wrong transform still produces valid SVG that passes every text assertion.

**Interfaces:**
- Consumes: the generated `favicon.svg` and the `palette` registration from Task 1 Step 1.

- [ ] **Step 1: Look at the glyph as an image, not as text**

```bash
open docs/public/favicon.svg
```

Confirm: the palette glyph is white, fully inside the rounded plate, visually centred, with no clipping and nothing off-canvas. A blank purple square means the transform is wrong.

- [ ] **Step 2: Check it at real favicon sizes**

```bash
npm run dev
```

In the browser, confirm the tab icon is recognisably a palette at 16×16. Then compare against the previous version:

```bash
git show HEAD~1:docs/public/favicon.svg > /tmp/favicon-old.svg && open /tmp/favicon-old.svg
```

The new glyph should be the Material **Symbols** palette (a rounder, more open drawing) rather than the legacy Material Icons one.

- [ ] **Step 3: Confirm the app-bar icon did not regress**

`palette` is now in `config/icons.json`, so `m3e-icon name="palette"` resolves from the **registry** rather than falling through to the Material Symbols ligature font. With the dev server running, confirm the app-bar palette button still renders correctly and at the same visual weight as its `menu` and `settings` neighbours, which still come from the font.

If the registry version looks noticeably different in weight from its neighbours, that is expected — the font is a variable font at a configured weight/grade, while the registry path is a fixed drawing. Report it rather than papering over it; the options are removing `palette` from `config/icons.json` (favicon generation reads the config directly and does not require registration) or accepting the difference.

- [ ] **Step 4: Confirm the built site ships it**

```bash
npm run build:site && ls -la docs/dist/favicon.svg
```

Expected: present, and byte-identical to `docs/public/favicon.svg`.

- [ ] **Step 5: Confirm the `.ico` is untouched and still referenced**

```bash
git status --short docs/public/favicon.ico
rg -c "favicon.ico" docs/app -g '*.elm' | wc -l
```

Expected: no change to the `.ico`, and 14 files still referencing it. Deleting it would 404 every social card.

- [ ] **Step 6: Commit any verification fixes**

If Step 3 required a config change, commit it:

```bash
git add config/icons.json docs/public/favicon.svg
git commit -m "Adjust palette icon sourcing after visual check"
```

Otherwise there is nothing to commit and this task ends clean.

---

## Self-Review

**Spec coverage.** Generate from `material-symbols:palette` through the shared pipeline → Task 1. Brand plate preserved verbatim → Task 1 Step 4, asserted in Step 2. Transform computed from the declared viewBox, not hard-coded → `plateTransform`, with both grids tested. Visual verification at 16px → Task 2 Steps 1–2. `favicon.ico` preserved → Task 2 Step 5. `Site.elm` untouched → Global Constraints.

**Placeholder scan.** No TBDs. Task 2 Step 3 has a real decision point with both options named rather than "verify it looks fine".

**Type consistency.** `plateTransform(viewBox: string, { plate, glyph }) -> string` and `renderFavicon({ viewBox, path }) -> string` match between the test and the implementation. `resolveIcon`/`loadSets` are used with the exact signatures the icon-registry plan defines.

**Deliberate addition beyond the spec.** The non-square-viewBox guard in `plateTransform` is not in the spec. It is cheap and it turns a silent distortion into an error, which is the same principle the spec applies to multi-element bodies.

**Deliberate scope note.** The spec says the favicon glyph could be generated without registering `palette` in `IconRegistry`. This plan registers it (one config file, both consumers) and Task 2 Step 3 checks the consequence. If that check fails, the fallback is specified.
