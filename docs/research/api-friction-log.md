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

### F7 — Switch / Slider / RadioButton force an outlined form-field wrapper
- **Hit:** in the Settings study every toggle row renders with the control
  crammed into an **outlined box with a floating label that overlaps the
  control** (e.g. "Reduce motion", "Color scheme", "Brightness"). Because the
  study's row already shows the label on the left, you also get a **double
  label**.
- **Why:** `Ui.Switch`/`Ui.Slider`/`Ui.RadioButton` always wrap themselves in
  `<m3e-form-field variant="outlined">` + `<label slot="label">`. That's the
  text-field affordance — an outlined container is correct for a text input,
  but drawing it around a switch/slider/radio (and floating a label into it)
  is not standard M3 and looks broken in a labeled row. `Ui.Select` does the
  right thing (bare, native `label` attr) — the others are inconsistent.
- **Suggested (needs a deliberate API decision):**
  - Don't wrap toggles in `m3e-form-field` at all, **or**
  - add a "bare / label-suppressed" mode so a control used inside a row that
    already provides its label can render just the control (the row's label
    can associate via `for`), **or**
  - at minimum default these to no outline (the form-field `variant` is wrong
    for non-text controls).
  - Whatever the choice, make Switch/Slider/RadioButton/Select **consistent**.
- **Resolved:** added `withVisibleLabel : Bool` (default `True`, non-breaking)
  to **Switch, Slider, RadioButton, and Checkbox** — `False` renders the bare
  control with the label as `aria-label`, no form-field. Applied across the
  Settings + Reply studies. (Checkbox had the same bug — it surfaced in the
  Reply study as a broken outlined "Select <subject>" box on every row.)
- **Still open (design):** whether the *default* should be bare for
  non-text controls (an outlined field around a switch/checkbox is arguably
  never right). Left as default-wrapped for now to stay non-breaking.

### F9 — Carousel is out of scope (REMOVED, not fixed)
- **Hit:** the Carousel component page and Crane's "Featured destinations"
  rendered **empty** — `Ui.Carousel` emitted `m3e-slide-group`/`m3e-slide`
  correctly and the slide *content* had size, but the `m3e-slide` host
  collapsed to 0×0.
- **Resolution:** **`@m3e/web` (matraic) does not provide a Carousel** — it's
  outside the component set we support. So `Ui.Carousel` was removed entirely
  (module + test + nav/reference entries + component demo), and the Crane /
  Shrine "featured" rows were rebuilt as a plain Tailwind horizontal scroll
  row (`flex gap-4 overflow-x-auto`) of existing card builders — layout only.
- **Layer note:** this is the "identify the right layer" lesson — the fix
  wasn't in the builder or the atom, it was a **scope** decision (don't wrap a
  component the underlying library doesn't have). `Ui.Slide` (the real
  `m3e-slide-group` utility) stays.

### F11 — heterogeneous chrome slots legitimately stay `Html msg`
- **Hit:** the audit flagged `AppBar.leading`/`trailing` (and `Breadcrumb`/`Chip`
  labels) as candidates for typed-slot conversion. For AppBar I started typing
  them as `Ui.IconButton` (with an `EscapeHatchHtml` parallel), then real call
  sites pushed back: Rally puts a brand `<span>+Icon` in leading; Reply trailing
  is `[Search, IconButton, Avatar]`. These slots are inherently heterogeneous,
  not "a list of one builder type."
- **Rule (refines F10):** typed slots apply where the slotted alternatives form
  an enumerable set we want to enforce (`Card.headline : Ui.Heading`,
  `Card.actions : List Ui.Button`, `IconButton.icon : Ui.Icon`). Slots whose
  semantic is **"arbitrary author content"** — like `Card.media`/`body`/`footer`
  or `AppBar.leading`/`trailing` — should stay `Html msg` as the primary type.
  Naming such a slot `*EscapeHatchHtml` is misleading: `Html` is the *natural*
  shape there, not an opt-out.
- **What still drove value:** the related Q1=(c) win — added `withTarget`,
  `withRel`, `withDownload` to `Ui.IconButton` (it already had `withHref`).
  Now an "external github link" *is* a `Ui.IconButton` (no `<a>` wrapper), and
  composes cleanly into `AppBar.trailing`'s `List (Html msg)` via `|> view`.
  Reverted the AppBar typed conversion; kept the IconButton anchor surface.

### F10 — builders must be styling-free + expose escape hatches (PRINCIPLE)
- **Hit:** while fixing the Card media/title slotting I baked
  `class "text-title-medium"` into the builder. Wrong.
- **Rule (binding, Layer 4):** a `Ui.*` builder **never** bakes styling
  (no Tailwind/token classes by default); its **only** deps are the generated
  `M3e.*` modules (+ other `Ui.*` for composition); and it **exposes escape
  hatches** for customization.
- **Canonical pattern (set by `Ui.Card`):**
  - `withAttributes : List (Attribute msg)` → appended to the host element;
    structural attrs (e.g. `variant`) emitted *after* so callers can't clobber.
  - Typed slots take **builder types** (`withHeadline : Ui.Heading`), which are
    introspectable (composition), with a parallel `with*EscapeHatchHtml :
    Html msg` for raw cases. The M3 typescale comes from the wrapped element
    (e.g. `m3e-heading`), not a baked class.
  - Terse text via `Ui.Heading.{display,headline,title,label} : String ->
    Heading` keeps call sites one-liners.
- **Rollout status:**
  - (a) baked styling — **done**: audit found 0 bakers except `Ui.Toc` (fixed).
    `Ui.Shape`/`Ui.Skeleton` expose a caller-owned `withClass` (not baked) that
    now overlaps `withAttributes` — deprecation candidate.
  - (b) `withAttributes` host hatch — **DONE: all 52 builders** (Card/Toc by
    hand; 34 mechanical + 14 tricky via verified sub-agents). See
    `docs/research/builder-audit.md` for the per-builder host decisions. Chip
    needed a parallel `withSetAttributes` (two opaque types). A few internal
    `Config` records were parameterized to `Config msg`.
  - (c) opaque-`Html` slots → typed builder inputs + `EscapeHatchHtml` —
    **still open** (per-builder judgment): `AppBar.leading/trailing`,
    `Breadcrumb` item label, `Chip` label are the main candidates. Not blockers.

### F11 — slot API: no `Html.text` assumption, no presumptive `<span>` wrapper
User directives (reference impl: **`Ui.AppBar`**; to roll out library-wide after review):
1. **No `Html.text`.** Any field that was a `String` the builder wrapped via
   `Html.text` becomes `Html msg` or a typed `Ui.*` builder. The builder never
   decides "this is a text node."
2. **No presumptive `<span>` wrapper.** A slot setter must not wrap the caller's
   content in a builder-created `Html.span [slot] […]`. The builder owns only the
   slot **attribute**, injected onto the element actually rendered.
- **The pattern (AppBar):** a slot is stored as `Slotted msg = Attribute msg ->
  Html msg` ("give me the slot attr, I yield the element"). Two fillers:
  - **typed**: `withTitle : Ui.Heading` / `withLeadingIconButton : Ui.IconButton`
    — `fromBuilder addAttrs view builder slot = view (addAttrs [slot] builder)`.
    Works because the typed builder exposes `withAttributes` (F10) to inject the slot.
  - **element escape hatch**: `with…HtmlElementEscapeHatch tag attrs children` —
    `fromElement tag attrs children slot = tag (slot :: attrs) children`. Caller
    picks the element; builder prepends the slot attr.
- **Choices I made (review these):**
  - `AppBar.new` no longer takes a required title — title is an optional slot
    (consistent with every other slot; an icon-only bar is valid).
  - title/subtitle are typed as `Ui.Heading` (typescale from `m3e-heading`),
    with an element escape hatch for non-heading cases.
  - list slots (trailing) are filled by **repeated** `withTrailing*` calls
    (typed or escape-hatch), appended in order — no `List` argument.
  - naming follows the user's example: `with<Slot>HtmlElementEscapeHatch`.
- **Library-wide implication (big):** every slot in every builder gets this
  treatment — typed setter(s) + an `…HtmlElementEscapeHatch`, and every
  `String`+`Html.text` content field becomes `Html msg`/typed. This is a large
  public-API reshape; the AppBar reference is committed for review BEFORE the
  sweep (a wrong 52-module slot redesign is very expensive). Filed as a task.

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

## Docs-generation opportunities

### F8 — drive the component reference pages from `elm make --docs` — DONE
- **Context:** the per-component pages got their API content from a heuristic
  extractor that scanned Elm source with regex.
- **Resolved:** `docs/scripts/extract-reference.mjs` now sets up a scratch
  package project (symlinks to `src/Ui` + `vendor/elm-m3e/M3e`, generated
  `elm.json` listing all 52 Ui modules as `exposed-modules`), runs
  `elm make --docs docs.json` there, and maps the structured output to the
  existing `reference.json` schema. Type signatures come from the elm compiler
  (not regex); every value has a doc comment (the compiler enforces it).
- **Surfaced (fixed):** the switch revealed **98 missing doc comments across
  17 modules** that the heuristic silently glossed over. All filled in
  (mostly trivial 1-line `{-| Set the X. -}` modifiers; a few non-obvious got
  more useful descriptions). `elm make --docs` now succeeds, 0 errors.
- **Bonus:** member count jumped from the heuristic's count to **632 members
  across 52 modules** — the pipeline catches everything the heuristic missed.
  Same artifact Phase 8 (package-readiness) will need; this is half of that
  work landed early.
- **Caveat:** the scratch elm.json uses `vendor/elm-m3e/M3e/*` as part of the
  package's own `src/` (via symlink). For a real publishable package, the M3e
  atoms must become a published dep — that's the remaining Phase 8 work.

## Tooling / DX papercuts

### F5 — the dev server does not rebuild Tailwind
- **Hit:** added new utility classes in Elm; they did nothing in the browser.
- **Why:** `elm-pages dev` serves the **pre-built** `public/style.css`. New
  classes only appear after `npm run build:css` (Tailwind scans `./app` +
  `../src`). Easy to forget and misread as "my class is wrong."
- **Suggested:** either run Tailwind in watch mode alongside `elm-pages dev`,
  or document the `build:css` step prominently in the docs README / a dev
  script that runs both.

### F6 — `Test.Html` `Query.find`/`findAll` only search descendants, never the root
- **Hit (a):** `Query.find` on a selector matching 2 anchors errored ("found 2").
- **Hit (b):** when a control renders **bare** (the element is the root of the
  fragment, e.g. `withVisibleLabel False`), `Query.find [tag "m3e-switch"]`
  returns **0** — `find`/`findAll` traverse *descendants only*, so the root
  node is never matched. Assert the root with `Query.has [...]` directly on the
  `Query.fromHtml` result instead.
- **Note:** both are expected Test.Html semantics, but easy to trip on. Reach
  for `findAll` + `count`/`index` for non-unique selectors, and `has` (not
  `find`) when the thing you're checking is the root element.
