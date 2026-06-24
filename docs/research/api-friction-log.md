# API friction log

A running record of stubbed toes while building the docs **with** the `Ui.*`
library — bugs, API gaps, confusing behavior, and DX papercuts. Each entry is
phrased as: what I hit → why it bit → suggested fix (library / docs / tooling).

Ordered newest-first within each section.

---

## Library bugs (shipped behavior is wrong)

### F1 — `Ui.Icon.view` rendered every icon invisible (FIXED)
- **Hit:** every icon on every page was blank. App bar actions, card glyphs,
  nav icons — all gone. Looked like the whole component layer was unstyled.
- **Why:** `Ui.Icon.view` passed the symbol name as a **child text node**
  (`[ Html.text cfg.name ]`). `<m3e-icon>` has **no `<slot>`** — it reads the
  glyph from its **`name` attribute** and renders it into a shadow `.icon`
  div. The child text was silently dropped, so the shadow div was always
  empty. Type-correct and `Test.Html`-clean (the emitted markup *looked*
  fine), so it passed the compiler and the unit suite — only a real browser
  revealed it.
- **Fix:** emit `M3e.Icon.name cfg.name` as an attribute, no children. ✅
- **Lesson for the library:** any binding whose element reads content from an
  **attribute/property** rather than a slot is a silent-drop trap. A custom
  elm-review rule could flag `Html.text` children passed to elements known to
  be slotless (or at least `m3e-icon`).

---

## API gaps (couldn't express a real, in-spec use case)

### F2 — `Ui.NavigationDrawer` couldn't model the real nav-menu tree (EXTENDED)
- **Hit:** matraic's shell nav is a **tree** — collapsible `m3e-nav-menu-item`
  groups whose leaves are real `a[href]` anchors. The only `Ui.NavigationDrawer`
  API was flat: `new { items, selected, onChange }` with value-based selection.
  No grouping, no nesting, no `href`, and the main content couldn't be projected
  into the drawer's content region.
- **Why:** the binding was modeled as an in-app section switcher, not as the
  hierarchical anchor navigation that `m3e-nav-menu` actually supports (and
  that a docs/app shell needs).
- **Fix:** added a parallel `tree` shape — `tree` + `group`/`link` entries with
  `withEntry{Icon,Href,Target,Selected,Open,Badge,Children}` + `withContent`
  (projects page body into the drawer's default slot). Kept the flat API intact
  so existing consumers (Reply, the component demo) are unaffected. ✅
- **Lesson:** when a wrapped element supports both flat and hierarchical use,
  the binding should expose both from the start.

### F3 — no body-text typography primitive
- **Hit:** wanted to render body copy as a component (per "prefer primitives").
  The only typography primitive is `Ui.Heading` (Display/Headline/Title/Label).
- **Why:** there's no element for non-heading running text; matraic's own body
  copy isn't a component either (it's slotted markdown).
- **Workaround:** body paragraphs use the M3 **type-scale utilities**
  (`text-body-large`, `text-on-surface-variant`, …) — which *are* the m3e
  design tokens delivered through the Tailwind bridge, not arbitrary styling.
- **Suggested:** document explicitly that the type-scale + color-role utilities
  are the sanctioned way to render body text (the bridge is the primitive
  here), so it doesn't read as "gave up and used Tailwind."

---

## Testing / verification gaps

### F4 — boolean element state is invisible to `Test.Html`
- **Hit:** tests asserting `Selector.attribute (Attr.attribute "open" "true")`
  and `"selected" "true"` on `m3e-nav-menu-item` found **0 matches**, despite
  rendering correctly in the browser.
- **Why:** the bindings set these as **DOM properties**
  (`Html.Attributes.property "open" …`, `Html.Attributes.selected`), not string
  attributes. `Test.Html.Query` only sees real attributes, never properties.
- **Implication:** any state expressed as a property (`open`, `selected`,
  `disabled`, `checked`, `value`, …) **cannot be unit-tested via Test.Html** —
  it must be verified in a real browser (Playwright). Unit tests should assert
  observable structure (tags, slots, text, real attributes) only.
- **Suggested:** call this out in a testing guide, and make sure every
  property-driven behavior has a Playwright check (this is the discipline that
  was skipped — see the icon bug).

---

## Tooling / DX papercuts

### F5 — the dev server does not rebuild Tailwind
- **Hit:** added new utility classes in Elm; they did nothing in the browser.
- **Why:** `elm-pages dev` serves the **pre-built** `public/style.css`. New
  classes only appear after `npm run build:css` (Tailwind scans `./app` +
  `../src`). Easy to forget and misread as "my class is wrong."
- **Suggested:** either run Tailwind in watch mode alongside `elm-pages dev`,
  or document the `build:css` step prominently in the docs README / a dev
  script that runs both.

### F6 — `Test.Html` `Query.find` vs `Query.findAll` (self-inflicted, but worth a note)
- **Hit:** `Query.find` on a selector matching 2 anchors errored ("found 2").
- **Note:** expected behavior, but the error is only obvious once you know
  `find` requires exactly 1. Minor; just a reminder to reach for `findAll` +
  `count`/`index` when a selector is non-unique.
