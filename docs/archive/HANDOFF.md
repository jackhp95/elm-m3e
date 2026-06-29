# elm-m3e — Work-in-progress handoff (2026-06-28)

Resume point for continuing on another device/session. Everything below is on
`main` and **pushed to `origin/main`**. Latest commit: `4c4f6a3` (see `git log -1`).

---

## TL;DR

- **Two epics fully done & closed this session:** the *tidy/consolidate wave*
  (rename, View→IR, elm-review, Layout) and the **#58 @m3e/web alignment epic**
  (11 children — all correctness defects, missing components, docs parity).
- **Facade epic #52 is in progress:** #53 (`M3e.Attr`) **done**; **#54
  (`M3e.Value` shared tokens) done — all three axes shipped**; #56/#55/#57 not
  started.
- **Metrics:** 55 → **73 components**; tests **610 → 909**; `elm-review` green
  (toHtml gate + 4 rule families; 230 suppressed legacy findings).
- **All four gates green on `main`.** CI fixed to be push-safe.
- **Open GitHub issues:** **#52** (facade epic), **#54** (impl done — body
  updated, safe to close), **#70** (typed-attribute follow-up), and
  **jackhp95/elm-cem#1** (generator retarget). Everything else closed.

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
- `a3803a3`+`139e593`+`4c4f6a3` **#54 `M3e.Value`** — shared phantom-tagged
  tokens, shipped across all three axes (size → 8 components, variant → 21,
  shape → 4). **Built as a single `M3e.Value` type** spanning all axes with
  **bare, axis-neutral token names** (`Value.large`, `Value.filled`,
  `Value.rounded`) — NOT separate `Variant`/`Size`/`Shape` modules. A token
  carries only the emitted string; the component supplies the attribute name, so
  one `Value.rounded` serves both a variant axis and a shape axis. Values now
  emit via introspectable `Node.attribute "variant"/"size"/"shape"` (DOM
  unchanged). See Concerns §1 for what this resolved + the one known leak (#70).

---

## What's left — facade epic #52

| # | Status | What |
|---|---|---|
| #53 | ✅ done | `M3e.Attr` shared attributes |
| #54 | ✅ done | `M3e.Value` shared phantom-tagged tokens (size/variant/shape) |
| #56 | not started | disambiguate flat-namespace collisions |
| #55 | not started | top-level `M3e` module + component-prefixed entry points (`M3e.buttonOutlined`) |
| #57 | not started | migrate docs to `import M3e exposing (..)` (acceptance test) |

Recommended order: #56 → #55 → #57.

---

## Concerns (with examples) — READ BEFORE RESUMING

### §1. #54 — RESOLVED (shipped a unified `M3e.Value`)

The earlier fork (skip / size-only / full) was resolved by going **fuller than
Path B but unified**: a **single `M3e.Value` type spans all three axes**
(variant/size/shape), with **bare, axis-neutral token names**. This avoids the
"21 semantically-different Variant types" problem because the type doesn't model
the axis at all — a token carries only its emitted *string* and the component
supplies the *attribute name*. So `Value.rounded` (emits `"rounded"`) serves
both Icon's variant axis and Button/IconButton's shape axis; same-meaning tokens
(`Value.large`) collapse across components for free.

```elm
import M3e.Button as Button
import M3e.Value as Value
Button.view { label = "Save", variant = Value.filled } [ Button.size Value.large ]
-- Value.filled : Value { a | filled : Supported }
-- Button's variant field is a CLOSED row { elevated, filled, tonal, outlined, text };
--   a token outside that row is a compile error.
```

Each component publishes a closed supported-row per field; row unification
accepts members and rejects outsiders. Values emit via introspectable
`Node.attribute` (testable; DOM output unchanged from the old `Cem` rawAttr).
Shipped in `a3803a3` (size, 8 comps) → `139e593` (variant, 21) → `4c4f6a3`
(shape, 4). Issue #54 body updated to match the as-built design.

**Known leak (tracked in #70):** a token is structurally untyped w.r.t. axis, so
a component whose closed row admits a token accepts it even if the upstream web
component doesn't honor that combination — e.g. `SplitButton.Variants` had to
widen 4→5 members to match Button's required row. A future opt-in
**typed-attribute helper** (token → named `Attr`) could re-tighten this without
abandoning bare-name sharing. Out-of-scope tokens deliberately left per-component:
`Progress.Shape` (HTML-tag selector linear/circular) and `M3e.Shape.Name`
(Material shape-name concept) — neither is a Value axis.

### §2. Naming collisions the facade (#55/#56) must resolve — concrete examples
- **`M3e.Shape` already exists** (the `m3e-shape` *component*). This is why the
  shared shape tokens live in **`M3e.Value`** (`Value.rounded`/`Value.square`/…),
  not a `M3e.Shape` token module — no collision, and shape shares the same
  facade as variant/size. (Resolved by #54; see §1.)
- **`text` variant vs `text` builder:** `M3e.Element.text : String -> Element …`
  (a text node) collides with Button's `Text` variant if both are re-exposed flat
  as `text`. The facade must rename one (e.g. keep `text` = builder, expose the
  variant as `textVariant` or via the `buttonText` entry point).
- **`view`** exists in all 73 modules; the facade can't expose a bare `view` —
  it must use prefixed entry points (`M3e.button`, `M3e.buttonOutlined`).
- ~~Enum constructors like `Small`/`Filled`/`Rounded` repeat across modules~~ —
  **resolved by #54**: these are now shared `M3e.Value` tokens, no per-module
  constructors to clash. (Remaining per-component enums — e.g. `Skeleton.Animation`,
  `IconButton.Width`, `ButtonType` — are axis-specific and not yet shared.)

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
node_modules/.bin/elm-test --compiler docs/node_modules/.bin/elm     # → 909 pass
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
