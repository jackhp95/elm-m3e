# Docs Quick Fixes (Stream A) Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Fix the docs-site 404 nav links and the collapsed full-width previews, and add a guard so the nav list can't silently drift again.

**Architecture:** Three surgical changes. (1) A new Node guard script cross-checks the drawer's `componentList` slugs against `reference.json` (hard fail) and reports example-bearing pages missing from nav (warn). (2) `componentList` in `Shared.elm` is remapped/pruned/extended so every link resolves. (3) `rawPreview` in `Doc.elm` drops its forced flex row for a plain block container (matraic parity) so full-width components fill width. The guard is written first so it is the executable spec that proves the nav fix.

**Tech Stack:** Elm (elm-pages v3), Node ESM scripts (`scripts/*.mjs`), Tailwind v4 utility classes, `node --test` for the existing test idiom.

**Spec:** `docs/superpowers/specs/2026-07-07-docs-quick-fixes-design.md`

**Working directory for all commands:** `/Users/jack/Documents/code/elm-m3e/docs`

---

## File Structure

- **Create** `docs/scripts/check-nav.mjs` — the nav drift guard. Reads `data/reference.json` + `data/examples.json`, extracts `componentList` slugs from `app/Shared.elm`, exits non-zero on any nav slug with no page.
- **Modify** `docs/app/Shared.elm:809-863` — `componentList`: remap 7 slugs, drop 3 orphans, add 4 missing components.
- **Modify** `docs/package.json` — add `check:nav` script; invoke it in `build:assets` and `build:ci`.
- **Modify** `docs/src/Doc.elm:53-67` — `rawPreview`: replace the flex row with a plain block container.

---

## Task 1: Nav drift guard (the failing check)

**Files:**
- Create: `docs/scripts/check-nav.mjs`

- [ ] **Step 1: Write the guard script**

Create `docs/scripts/check-nav.mjs`:

```js
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
const block = shared.slice(start, shared.indexOf("\n    ]", start));
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
```

- [ ] **Step 2: Run it to verify it FAILS on the current (broken) list**

Run: `node scripts/check-nav.mjs`
Expected: exits non-zero, prints
`check-nav: FAIL — ... disclosure, extendedfab, navigationbar, navigationdrawer, navigationrail, radiobutton, search, sidesheet, textfield, timepicker`
(order alphabetical; also a WARNING line listing autocomplete, contentpane, expansionpanel, textareaautosize, tree, …).

This is the "red" state — the guard correctly detects the live bug.

- [ ] **Step 3: Commit the guard**

```bash
git add scripts/check-nav.mjs
git commit -m "test(docs): add nav drift guard (fails on current stale componentList)"
```

---

## Task 2: Fix `componentList` (make the guard pass)

**Files:**
- Modify: `docs/app/Shared.elm:809-863`

- [ ] **Step 1: Apply the remaps, drops, and adds**

In `docs/app/Shared.elm`, replace the `componentList` body (the list literal at
lines 810-863) with the following. Changes vs. current: 7 slugs remapped, 3 orphans
removed (`extendedfab`, `sidesheet`, `timepicker`), 4 components added
(`autocomplete`, `contentpane`, `textareaautosize`, `tree`). Categories for the added
entries come from `reference.json`. Entries kept alphabetical by slug within the
existing style.

```elm
componentList : List ( String, String, String )
componentList =
    [ ( "appbar", "App Bar", "Navigation" )
    , ( "autocomplete", "Autocomplete", "Text inputs" )
    , ( "avatar", "Avatar", "Layout & style" )
    , ( "badge", "Badge", "Communication" )
    , ( "bottomsheet", "Bottom Sheet", "Containment" )
    , ( "breadcrumb", "Breadcrumb", "Navigation" )
    , ( "button", "Button", "Actions" )
    , ( "buttongroup", "Button Group", "Actions" )
    , ( "calendar", "Calendar", "Text inputs" )
    , ( "card", "Card", "Containment" )
    , ( "checkbox", "Checkbox", "Selection" )
    , ( "chip", "Chips", "Selection" )
    , ( "contentpane", "Content Pane", "Containment" )
    , ( "datepicker", "Date Picker", "Text inputs" )
    , ( "dialog", "Dialog", "Containment" )
    , ( "divider", "Divider", "Containment" )
    , ( "drawercontainer", "Navigation Drawer", "Navigation" )
    , ( "expansionpanel", "Expansion Panel", "Containment" )
    , ( "fab", "FAB", "Actions" )
    , ( "fabmenu", "FAB Menu", "Actions" )
    , ( "formfield", "Text Field", "Text inputs" )
    , ( "heading", "Heading", "Layout & style" )
    , ( "icon", "Icon", "Layout & style" )
    , ( "iconbutton", "Icon Button", "Actions" )
    , ( "list", "List", "Layout & style" )
    , ( "loadingindicator", "Loading Indicator", "Communication" )
    , ( "menu", "Menu", "Navigation" )
    , ( "navbar", "Navigation Bar", "Navigation" )
    , ( "navrail", "Navigation Rail", "Navigation" )
    , ( "paginator", "Paginator", "Navigation" )
    , ( "progress", "Progress", "Communication" )
    , ( "radiogroup", "Radio Button", "Selection" )
    , ( "scrollcontainer", "Scroll Container", "Containment" )
    , ( "searchbar", "Search", "Text inputs" )
    , ( "segmentedbutton", "Segmented Button", "Actions" )
    , ( "select", "Select", "Text inputs" )
    , ( "shape", "Shape", "Layout & style" )
    , ( "skeleton", "Skeleton", "Communication" )
    , ( "slidegroup", "Slide Group", "Navigation" )
    , ( "slider", "Slider", "Selection" )
    , ( "snackbar", "Snackbar", "Communication" )
    , ( "splitbutton", "Split Button", "Actions" )
    , ( "splitpane", "Split Pane", "Containment" )
    , ( "stepper", "Stepper", "Navigation" )
    , ( "switch", "Switch", "Selection" )
    , ( "tabs", "Tabs", "Navigation" )
    , ( "textareaautosize", "Textarea Autosize", "Text inputs" )
    , ( "texthighlight", "Text Highlight", "Layout & style" )
    , ( "theme", "Theme", "Layout & style" )
    , ( "toc", "TOC", "Navigation" )
    , ( "toolbar", "Toolbar", "Containment" )
    , ( "tooltip", "Tooltip", "Communication" )
    , ( "tree", "Tree", "Layout & style" )
    ]
```

Note: `scrollcontainer`, `slidegroup`, and `splitbutton` — verify each exists in
`reference.json` (they were in the original list). `scrollcontainer` and `slidegroup`
are present; `splitbutton` is present as a page but has no examples (guard will WARN,
not fail — acceptable, it is a real page). If the guard reports any of these as dead,
remove that single entry.

- [ ] **Step 2: Format**

Run: `node_modules/.bin/elm-format --yes app/Shared.elm`
Expected: `Processed 1 file` (or no output on no-change).

- [ ] **Step 3: Run the guard to verify it PASSES**

Run: `node scripts/check-nav.mjs`
Expected: exit 0, `check-nav: OK — 52 drawer links all resolve.` (count may differ
slightly; the point is no FAIL line). A WARNING line for remaining example-only pages
(e.g. `splitbutton` has a page but is fine) is acceptable.

- [ ] **Step 4: Verify pages build**

Run: `npm run build:reference && node scripts/check-nav.mjs`
Expected: reference regenerates, guard still OK.

- [ ] **Step 5: Commit**

```bash
git add app/Shared.elm
git commit -m "fix(docs): repoint stale drawer slugs, drop orphans, add missing components

Fixes /components/search and ~9 other 404s. Remaps search->searchbar,
navigationbar->navbar, navigationdrawer->drawercontainer, navigationrail->navrail,
radiobutton->radiogroup, textfield->formfield, disclosure->expansionpanel; drops
extendedfab/sidesheet/timepicker (no page); adds autocomplete, contentpane,
textareaautosize, tree."
```

---

## Task 3: Wire the guard into the build

**Files:**
- Modify: `docs/package.json`

- [ ] **Step 1: Add a `check:nav` script and invoke it in both build paths**

In `docs/package.json` `scripts`, add:

```json
"check:nav": "node scripts/check-nav.mjs",
```

Then append the guard to the end of `build:assets` and to `build:ci` (which does not
run `build:assets`). The guard needs `reference.json` (regenerated by `build:reference`)
and the committed `data/examples.json`, so it must run after `build:reference`:

- Change `build:assets` to end with `&& npm run build:examples && npm run check:nav`.
- Change `build:ci` from `npm run build:reference && elm-pages build` to
  `npm run build:reference && npm run check:nav && elm-pages build`.

- [ ] **Step 2: Run the CI build path locally to confirm the guard runs green**

Run: `npm run build:reference && npm run check:nav`
Expected: `check-nav: OK — ... drawer links all resolve.`

- [ ] **Step 3: Commit**

```bash
git add package.json
git commit -m "ci(docs): run nav drift guard in build:assets and build:ci"
```

---

## Task 4: Preview block-layout parity (`Doc.elm`)

**Files:**
- Modify: `docs/src/Doc.elm:53-67`

- [ ] **Step 1: Replace the forced flex row with a plain block container**

In `docs/src/Doc.elm`, `rawPreview`, change the wrapper class and update the comment.

Replace this attribute (currently at ~line 64):

```elm
            , class "flex max-w-full flex-wrap items-center gap-3 py-2"
```

with:

```elm
            , class "max-w-full py-2"
```

And replace the explanatory comment block directly above it with:

```elm
            -- Plain block flow, matching matraic's `.showcase` (which sets no
            -- flex): each component uses its own `display`, so inline components
            -- (buttons/chips) flow and wrap while full-width components (linear
            -- progress, sliders, dividers, text fields) fill the row. No flex
            -- row — that collapses width-less components to min-content. No
            -- overflow clipping either: an escaping menu/tooltip must be free to
            -- leave the card, and `overflow-x-auto` would force a spurious
            -- vertical scrollbar off the ~4px state-layer bleed.
```

- [ ] **Step 2: Format**

Run: `node_modules/.bin/elm-format --yes src/Doc.elm`
Expected: `Processed 1 file` (or no change).

- [ ] **Step 3: Build and start the dev server**

Run: `npm run start`
Expected: elm-pages dev server boots with no Elm compile errors.

- [ ] **Step 4: Verify in the browser**

Open `http://localhost:1234/components/progress` (port per elm-pages output).
Expected:
- Linear progress examples now render **full-width**, not collapsed to a sliver.
- Circular progress indicators are unchanged (they have intrinsic size).
Then open `http://localhost:1234/components/button`.
Expected: button-variant galleries still flow as a wrapping row (they are inline-flow),
not a single vertical stack.

- [ ] **Step 5: Commit**

```bash
git add src/Doc.elm
git commit -m "fix(docs): preview uses block flow so full-width components fill width

The forced flex row sized width-less components (linear progress, sliders,
dividers) to min-content, rendering them tiny. Match matraic's .showcase, which
sets no flex and lets each component's own display drive layout."
```

---

## Final Verification

- [ ] `node scripts/check-nav.mjs` → OK, no FAIL.
- [ ] `npm run build` → completes green (build:assets incl. guard + elm-pages build).
- [ ] `node_modules/.bin/elm-format --validate app/Shared.elm src/Doc.elm` → clean.
- [ ] Manual: `/components/search`, `/components/textfield`→ (removed; `formfield` link
      labelled "Text Field"), the 4 added links, and `/components/progress` all load.
- [ ] Spot-check no other drawer link 404s by clicking through each category.
