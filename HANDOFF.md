# elm-m3e — Work-in-progress handoff (2026-06-27)

Resume point for continuing on another device/session. Everything below is on
`main` and **pushed to `origin/main`**. Latest commit: see `git log -1`.

---

## TL;DR

- **Two epics fully done & closed this session:** the *tidy/consolidate wave*
  (rename, View→IR, elm-review, Layout) and the **#58 @m3e/web alignment epic**
  (11 children — all correctness defects, missing components, docs parity).
- **Facade epic #52 is in progress:** #53 (`M3e.Attr`) **done**; **#54 has a
  pending strategic decision (see "Concerns" §1)**; #56/#55/#57 not started.
- **Metrics:** 55 → **73 components**; tests **610 → 896**; `elm-review` green
  (toHtml gate + 4 rule families; 230 suppressed legacy findings).
- **All four gates green on `main`.** CI fixed to be push-safe.
- **Open GitHub issues:** **#52** (facade epic) and **jackhp95/elm-cem#1**
  (generator retarget). Everything else closed.

---

## What was accomplished (commit trail on main)

Tidy wave (Epic 1):
- `5e196ed` rename `Renderable` → `Element` (the IR is bespoke — no Elm package
  offers an introspectable IR with typed slots; confirmed by research).
- `c88b26d` carry the IR through elm-pages `View`; the **only** `Node.toHtml`
  now lives in `Shared.view` (was 41 per-route converters).
- `79f6c73` extend `elm-review` to `docs/app`; add the **toHtml-at-root gate**
  (`NoFunctionOutsideOfModules`, regression-proof) + code-style/imports/
  cognitive-complexity. 399 legacy findings baselined in `review/suppressed/`.
- `9d228ec` app-owned `docs/src/Layout.elm` (named presets + escapes, returns
  IR) + `NoRawLayoutOutsideLayoutModule` rule; ~228 hand-rolled layout divs
  migrated faithfully. (Library stays layout-unopinionated.)

Alignment epic #58 (all 11 children — see closed issues #59–#69):
- `970a32a` #59 boolean-property-reset (emit `Encode.bool c.flag` unconditionally
  so toggles reset; fixed the whole ~38-module class) + #60 numeric props as
  `Encode.float` not strings.
- `3d9e9a1` #65 List/Slide structural redesign (List → `list`/`actionList`/
  `selectionList` with public `m3e-list-action` + real `change` events; Slide as
  standalone carousel).
- `8d135b2` **CI fix**: `npx elm-pages gen` before `elm-review` (see Concerns §6).
- `15bcae9` #63 named slots (PRECISE phantom rows, not `Element any`).
- `90aadb3` #64 real DOM change/input events with target-state decoders.
- `55d11f7` #61 Bool→enum (Switch `icons`, SideSheet `mode`, Breadcrumb `current`).
- `05720f0` #62 form association + `ariaLabel` rename (Avatar/Checkbox/Fab/
  IconButton/Switch); `name`/`value`/`type` per upstream mixin.
- `f0126d7` #66 missing options (Icon visual axes, Button toggle/selected slots,
  Card orientation+link, Field variant, DatePicker range, NavRail mode, …).
- `e04981e`+`eeab0f2`+`d28700e` #67 **18 new component wrappers** (Tree,
  Autocomplete, Collapsible, ContentPane, FloatingPanel, OptionPanel,
  TextOverflow + 11 companion sub-elements).
- `3b20a58` #69 camelCase **all** inert hyphenated DOM-property keys (41 vendor
  atoms + 2 in src). Interim hand-patch — see Concerns §3.
- `21d14db`+`d206b9d` #68 docs-parity (fixed 4 misleading demos + demos for the
  18 new components + ~30 parity gaps).

Facade epic #52 (in progress):
- `8678458` **#53 `M3e.Attr`** — shared `disabled`/`onClick`/`href`/`target`/
  `rel`/`download`/`id` as polymorphic extensible-record options; 88
  per-component constructors re-aliased to it. `tests/M3e/AttrTest.elm` proves
  the cross-component guarantee. **This is the facade foundation and it works.**

---

## What's left — facade epic #52

| # | Status | What |
|---|---|---|
| #53 | ✅ done | `M3e.Attr` shared attributes |
| **#54** | **DECISION PENDING** | shared phantom-tagged variant/size *values* — see Concerns §1 |
| #56 | not started | disambiguate flat-namespace collisions (depends on #54 decision) |
| #55 | not started | top-level `M3e` module + component-prefixed entry points (`M3e.buttonOutlined`) |
| #57 | not started | migrate docs to `import M3e exposing (..)` (acceptance test) |

Recommended order once #54 is decided: #54 (or skip) → #56 → #55 → #57.

---

## Concerns (with examples) — READ BEFORE RESUMING

### §1. The #54 strategic fork (UNDECIDED — needs your call)

`M3e.Attr` (#53) already shares *attributes*. The question for #54 is whether to
also share *enum values* (variant/size). This is the **biggest, riskiest remaining
refactor** and may be **largely redundant with #55's entry points**.

**Path A — skip #54, lean on #55 entry points (my recommendation).**
The single-import goal is met for the common case without touching any enum:
```elm
import M3e exposing (..)
-- #55 mints per-variant entry points that bake the variant in:
M3e.buttonOutlined { label = "Save" } [ M3e.disabled True ]   -- one import
M3e.chipAssist { label = "Add" } [ M3e.onClick Add ]
```
The rare *dynamic* variant case keeps the component enum:
```elm
import M3e.Button as Button
Button.view { label = "Save", variant = chosenVariant } []
```
Cost: ~0 enum churn. Close #54 as "superseded by #55".

**Path B — do #54 fully (shared phantom-tagged values).**
```elm
import M3e exposing (..)
M3e.button { label = "Save", variant = M3e.filled } []   -- dynamic variant, one import
-- M3e.filled : Variant { s | filled : Supported }
-- M3e.button accepts Variant { filled, tonal, elevated, outlined, text };
--   M3e.chipAssist's `assist` is rejected at compile time.
```
This is the proven spike mechanism, but applied to **21 `Variant` enums + 8
`Size` enums + every call site** — a very large breaking refactor. The 21
"Variant" types are *semantically different* axes that happen to share the name
(Button = visual style filled/tonal/…; Chip = kind assist/filter/input/
suggestion; Card = elevated/filled/outlined), so collapsing them needs care.
Benefit over Path A: single-import for the *dynamic-variant* case only.

**Path C — hybrid:** shared values for SIZE only (clean t-shirt vocabulary
extraSmall…extraLarge, real collapse across Button/Fab/IconButton/…), entry
points for variants.

**My recommendation: Path A** (or C). Path B is a lot of risk for marginal gain
now that #53 + #55 exist.

### §2. Naming collisions the facade (#55/#56) must resolve — concrete examples
- **`M3e.Shape` already exists** (the `m3e-shape` *component*). A shared
  shape-token module can't reuse that name. (Reinforces leaving shape per-component.)
- **`text` variant vs `text` builder:** `M3e.Element.text : String -> Element …`
  (a text node) collides with Button's `Text` variant if both are re-exposed flat
  as `text`. The facade must rename one (e.g. keep `text` = builder, expose the
  variant as `textVariant` or via the `buttonText` entry point).
- **`view`** exists in all 73 modules; the facade can't expose a bare `view` —
  it must use prefixed entry points (`M3e.button`, `M3e.buttonOutlined`).
- Enum constructors like `Small`/`Filled`/`Rounded` repeat across modules — only
  the shared-value approach (#54 Path B) or prefixed entry points avoid clashes.

### §3. elm-cem generator drift (jackhp95/elm-cem#1) — vendor patches are interim
#69 hand-patched 41 vendored `Cem.M3e.*` atoms (kebab→camelCase property keys).
**These live in generated files** (`vendor/elm-m3e/Cem/`). If anyone regenerates
the bindings from the upstream CEM manifest, the bug returns. The permanent fix
is the generator at `/Users/jack/Documents/code/elm-cem` (emit camelCase
`fieldName` for properties; also still emits `M3e.*` instead of the
re-namespaced `Cem.M3e.*` — see `vendor/elm-m3e/VENDORED_FROM.txt`). Tracked in
**jackhp95/elm-cem#1**. Don't regen vendor until that lands.

### §4. 230 suppressed elm-review findings = a real backlog
`review/suppressed/` holds 230 pre-existing findings in the newly-linted
`docs/app` (mostly `NoMissingTypeAnnotationInLetIn`, `NoUnused.*`). CI passes
(only NEW violations fail), but this is debt to burn down. `elm-review` prints
"There are still 230 suppressed errors to address."

### §5. Behavioral validation gap — gates are necessary, not sufficient
The browser harness (`docs npm run test:browser`, 66 specs) checks **no console
errors + every `m3e-*` tag registered/upgraded** — it does **NOT** verify visual
or behavioral correctness. So the #58 alignment fixes (e.g. that `change` events
actually fire the right msg, that `selectionList` multi-select works, that the
new components render correctly) are **compile-and-tag-verified but not
behaviorally verified in a browser**. Worth a manual/Playwright pass on the
high-value flows (forms, selection, the 18 new components) before any release.

### §6. .elm-pages must exist before elm-review (already fixed in CI, watch locally)
`elm-review` (now covering `docs/app`) needs the generated `docs/.elm-pages/`
router, or it reports false `NoUnused` errors on `Api`/`Effect`/`View`. CI runs
`npx elm-pages gen` first (commit `8d135b2`). **Locally, always run
`npm run build` or `npx elm-pages gen` before `elm-review`**, else you'll see
phantom errors (this bit two subagents).

### §7. Unconfirmed upstream details flagged during #67
- **Autocomplete `query` event payload:** decoded `event.detail` as a bare
  `String` with `""` fallback; upstream CEM didn't document the shape. If it's an
  object, `M3e.Autocomplete.onQuery`'s decoder needs updating.
- **`m3e-tree-item` `selected`:** treated as a DOM property (CEM atom uses
  `Html.Attributes.selected`, a property setter). Verify in a browser.

---

## How to resume (operational notes)

**Gate commands** (run from repo root; **`build`/`gen` BEFORE `elm-review`**):
```bash
node_modules/.bin/elm-format --validate src/ tests/ review/src/      # → []
node_modules/.bin/elm-test --compiler docs/node_modules/.bin/elm     # → 896 pass
cd docs && npm run build                                             # → "Success - Adapter script complete"
cd docs && node_modules/.bin/elm-review --config ../review --compiler node_modules/.bin/elm  # → "I found no errors!" (230 suppressed)
cd docs && npm run test:browser                                     # Playwright (serves built dist/)
```
Fresh checkout needs `npm ci` at root AND in `docs/`.

**Worktree gotcha:** the editor's auto-worktree branches off session-start HEAD,
NOT latest `main`. For sequential phases, create worktrees manually:
```bash
git worktree add .claude/worktrees/<name> -b <name> main
git merge-base --is-ancestor <latest-sha> HEAD   # verify base
```
Then merge `--ff-only` and push after each verified batch.

**Reference / F8 doc lock:** `cd docs && npm run build:reference` runs
`elm make --docs` over `src/M3e` — **every exposed member needs a doc comment**
or it fails. New modules auto-appear (73 components / ~900 members now).

**Netlify:** deploy-ready. `docs/netlify.toml` + the elm-pages Netlify adapter
are configured (build → `docs/dist` + `docs/functions`). In Netlify, connect the
repo and set **Base directory = `docs`**. (Optional: a root `netlify.toml` with
`base = "docs"` would make it zero-config — not added yet.)

**Docs demo architecture (for #57 / more demos):** per-component demos are in the
`demoSections : String -> List (DemoSection …)` pattern-match in
`docs/app/Route/Components/Name_.elm`, keyed by `ModuleName.toLowerCase()`;
component list comes from `docs/data/reference.json` (generated by build:reference).

**Key local repos:** library = `/Users/jack/Documents/code/elm-m3e`; generator =
`/Users/jack/Documents/code/elm-cem` (for elm-cem#1).
