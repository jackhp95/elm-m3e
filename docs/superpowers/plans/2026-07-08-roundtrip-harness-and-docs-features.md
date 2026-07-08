# Round-trip Harness + Kitchen-Sink Page + Open-by-Default Code — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Ship three docs improvements — (C) code folds open by default, (B) a `/components/all` kitchen-sink page, (A) a bidirectional round-trip verification harness over the example corpus — in that order.

**Architecture:** C is a one-attribute render change. B extracts the per-component Usage rendering into a shared `Doc.Usage` module (adding an index offset so tab state doesn't collide across stacked components) and adds a new stateful elm-pages route. A is a two-layer Node script harness: Layer 1 statically scans converted Elm for escape hatches (no render); Layer 2 code-generates a transient elm-pages route that SSR-renders every converted cell, then DOM-diffs the re-rendered HTML against the raw corpus. A deployed `/roundtrip` route renders the resulting report JSON.

**Tech Stack:** Elm 0.19.1 + elm-pages 3.5, Node ESM scripts, `linkedom` (already a dependency) for DOM parsing, Playwright for browser assertions, `elm-format` for hand-written Elm.

**Sequencing:** C → B → A. Within A: Layer 1 ships before Layer 2. Each phase below is independently mergeable and leaves the site green.

**Repo facts every task relies on:**
- Repo root: `/Users/jack/Documents/code/elm-m3e`. Docs project: `docs/`. Config: `config/` (repo root, **not** under `docs/`).
- Elm binary: `docs/node_modules/.bin/elm`. elm-format: `docs/node_modules/.bin/elm-format`. Run `elm-format` after editing any **hand-written** `.elm` (generated modules are intentionally left unformatted).
- Library compile check: `cd packages/m3e && ../../docs/node_modules/.bin/elm make src/M3e.elm --output=/dev/null`.
- Docs build (full, runs `build:assets`): `cd docs && npm run build`. CI/Netlify build (skips `build:assets`): `npm run build:ci`.
- Browser tests: `cd docs && npm run build && node scripts/serve-dist.mjs dist 1239 &` then `BASE_URL=http://localhost:1239 npx playwright test` (or `npm run test:browser` against a running dev server on port 1239). Test dir: `docs/tests-browser/`.
- Pre-render output lands at `docs/dist/<route>/index.html` (gitignored).
- Push to `main` requires the user's session authorization (a guardrail blocks it otherwise). Commit locally; do not push unless the user says so.

---

## File Structure

**Phase C — created/modified:**
- Modify `docs/src/Doc/Fold.elm` — flip both `<details class="cf-fold">` sites to render `open`.
- Modify `docs/tests-browser/usage.spec.ts` — add an "open by default" assertion; fix the now-stale header comment.

**Phase B — created/modified:**
- Create `docs/src/Doc/Usage.elm` — shared Usage rendering: `Layer`, `Msg`, `Model`, `UsageExample`, its decoder, `init`/`update`, and `usageBlocks` (now taking an index offset). Owns everything that was Usage-specific in `Name_.elm`.
- Create `docs/src/Doc/Data.elm` — shared reference/example data loading: `Component`, `Member`, decoders, `allComponents`, `allUsage`.
- Modify `docs/app/Route/Components/Name_.elm` — import the two new modules; delete the moved code; call `Doc.Usage.usageBlocks 0 …`.
- Create `docs/app/Route/Components/All.elm` — the `/components/all` stateful single route.
- Modify `docs/app/Shared.elm` — expose `componentCategories`; add an "All components" nav leaf.
- Modify `docs/style.css` — add a `.cv-auto` content-visibility utility class.
- Create `docs/tests-browser/all-page.spec.ts` — smoke test for `/components/all`.
- Modify `docs/tests-browser/nav.spec.ts` — assert the new nav link.

**Phase A — created/modified:**
- Create `docs/scripts/roundtrip/escape-scan.mjs` (+ `escape-scan.test.mjs`) — Layer 1 static escape-hatch scanner.
- Create `docs/scripts/roundtrip/join.mjs` (+ `join.test.mjs`) — join the four config JSONs into a cell matrix.
- Create `docs/scripts/roundtrip/dom-diff.mjs` (+ `dom-diff.test.mjs`) — Layer 2 semantic DOM tree diff.
- Create `docs/scripts/roundtrip/gen-harness-route.mjs` — code-generates the transient SSR harness route.
- Create `docs/scripts/verify-roundtrip.mjs` — orchestrator; writes `docs/data/roundtrip-report.json`.
- Create `docs/app/Route/Roundtrip.elm` — deployed human report route reading the JSON.
- Modify `docs/package.json` — add `verify:roundtrip` script + `--test` glob for the new tests.
- Modify `.gitignore` (repo root or `docs/`) — ignore the transient `docs/app/Route/RoundtripHarness.elm`.
- Modify `docs/app/Shared.elm` — add a "Round-trip report" nav leaf (optional, under Reference).

---

# PHASE C — Code folds open by default

`docs/src/Doc/Fold.elm` emits two `<details class="cf-fold">` elements. The `Fold` case (lines ~317-322) opens conditionally on `not f.collapsed`; the `Siblings` case (lines ~324-336) has no `open` attribute so it is always closed. We want both open by default. The module already has an `openAttr : Bool -> List (Html.Attribute msg)` helper (lines ~349-355) that emits `[ attribute "open" "" ]` when `True`.

### Task C1: Flip both fold sites to open-by-default

**Files:**
- Modify: `docs/src/Doc/Fold.elm` (the `Fold` case ~317-322 and the `Siblings` case ~324-336)
- Test: `docs/tests-browser/usage.spec.ts`

- [ ] **Step 1: Read the current render sites**

Run: `sed -n '315,356p' docs/src/Doc/Fold.elm`
Confirm the `Fold` case uses `openAttr (not f.collapsed)` and the `Siblings` case uses a bare `[ class "cf-fold cf-sib" ]` list.

- [ ] **Step 2: Change the `Fold` case to always open**

In the `Fold f ->` branch, change:
```elm
            Html.node "details"
                (class "cf-fold" :: openAttr (not f.collapsed))
```
to:
```elm
            Html.node "details"
                (class "cf-fold" :: openAttr True)
```
(We keep `openAttr` rather than inlining, so the idiom stays consistent. The `f.collapsed` field is still computed and still exercised by `docs/tests/FoldTest.elm`; we simply no longer let it gate the rendered `open` attribute.)

- [ ] **Step 3: Change the `Siblings` case to always open**

In the `Siblings raws ->` branch, change:
```elm
            Html.node "details"
                [ class "cf-fold cf-sib" ]
```
to:
```elm
            Html.node "details"
                (class "cf-fold cf-sib" :: openAttr True)
```

- [ ] **Step 4: Format the file**

Run: `docs/node_modules/.bin/elm-format --yes docs/src/Doc/Fold.elm`
Expected: `Processed 1 file` (or no diff if already formatted).

- [ ] **Step 5: Compile-check the docs app**

Run: `cd docs && npx elm-pages gen && ./node_modules/.bin/elm make src/Doc/Fold.elm --output=/dev/null`
Expected: `Success!` (no compile errors). If `elm make` complains about missing app modules, instead run `cd docs && npm run build:ci` and expect exit 0.

- [ ] **Step 6: Add the "open by default" browser assertion**

In `docs/tests-browser/usage.spec.ts`, inside the existing `test("/components/button shows a live Usage section …")` block, after the existing `await expect(page.getByText("M3e.button").first()).toBeAttached();` line, add:
```ts
  // Code folds render OPEN by default (Phase C): every cf-fold <details> should
  // carry the `open` attribute so the code shows without a click.
  const folds = page.locator("details.cf-fold");
  const foldCount = await folds.count();
  expect(foldCount).toBeGreaterThan(0);
  for (let i = 0; i < foldCount; i++) {
    await expect(folds.nth(i)).toHaveAttribute("open", "");
  }
```

- [ ] **Step 7: Fix the now-stale header comment**

In `docs/tests-browser/usage.spec.ts`, the header comment (~lines 10-14) says code folds into a *closed* `<details>` and that we assert presence because folded code may be hidden. Replace that paragraph with:
```ts
 *  - long code blocks render in an OPEN `<details class="cf-fold">` (open by
 *    default as of Phase C), so their text is present and visible. We still
 *    assert code *presence* (`toBeAttached`) for surfaces that may be behind an
 *    inactive tab, and add an explicit `open`-attribute check on the folds.
```
(Match the surrounding comment style exactly — verify by reading lines 1-16 first.)

- [ ] **Step 8: Run the browser test**

Run:
```bash
cd docs && npm run build && node scripts/serve-dist.mjs dist 1239 & sleep 2
BASE_URL=http://localhost:1239 npx playwright test tests-browser/usage.spec.ts
kill %1 2>/dev/null
```
Expected: PASS (the fold assertions confirm `open` is present).

- [ ] **Step 9: Commit**

```bash
git add docs/src/Doc/Fold.elm docs/tests-browser/usage.spec.ts
git commit -m "feat(docs): render code folds open by default

Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>
Claude-Session: https://claude.ai/code/session_01Ap4D1B7LnEde7MVfd5uuCy"
```

---

# PHASE B — Kitchen-sink `/components/all` page

The per-component route `docs/app/Route/Components/Name_.elm` renders one component's Usage section via `usageBlocks`. We factor that rendering (plus its `Model`/`Msg`/`Layer`/`UsageExample`) into `Doc.Usage`, add an **index offset** so stacked components don't collide on the shared `Dict Int Layer` tab state, factor the data loaders into `Doc.Data`, then build the new stacked route. Category order comes from `Shared.componentCategories` (7 groups), which we expose.

**Critical design point:** `usageBlocks` currently does `List.indexedMap Tuple.pair examples`, and that index keys into `model.layers : Dict Int Layer`. Calling it once per component would restart every component's indices at 0 and cross-wire their tab selections. The shared version takes a base `offset` and emits `offset + i`; the All route threads a running offset (sum of prior components' example counts).

### Task B1: Extract `Doc.Data` (shared reference + example loaders)

**Files:**
- Create: `docs/src/Doc/Data.elm`
- Reference (do not modify yet): `docs/app/Route/Components/Name_.elm:76-169`

- [ ] **Step 1: Read the source to move**

Run: `sed -n '76,170p' docs/app/Route/Components/Name_.elm`
Identify: `Component`, `Member` type aliases; `componentDecoder`, `memberDecoder`; `allComponents`, `allUsage` (`BackendTask.File.jsonFile` loaders). Note `allUsage` decodes `data/examples.json` as `Dict String (List UsageExample)` — but `UsageExample` will live in `Doc.Usage`, so `Doc.Data` imports it from there.

- [ ] **Step 2: Create `docs/src/Doc/Data.elm`**

```elm
module Doc.Data exposing
    ( Component, Member
    , componentDecoder, memberDecoder
    , allComponents, allUsage
    )

{-| Shared loaders for the docs reference + usage data. Used by the
per-component route (`Route.Components.Name_`) and the kitchen-sink route
(`Route.Components.All`).
-}

import BackendTask exposing (BackendTask)
import BackendTask.File
import Dict exposing (Dict)
import Doc.Usage exposing (UsageExample, usageExampleDecoder)
import FatalError exposing (FatalError)
import Json.Decode as Decode


type alias Component =
    { name : String
    , slug : String
    , category : String
    , summary : String
    , overview : String
    , members : List Member
    }


type alias Member =
    { name : String
    , kind : String
    , signature : String
    , doc : String
    , role : String
    }


componentDecoder : Decode.Decoder Component
componentDecoder =
    Decode.map6 Component
        (Decode.field "name" Decode.string)
        (Decode.field "slug" Decode.string)
        (Decode.field "category" Decode.string)
        (Decode.field "summary" Decode.string)
        (Decode.field "overview" Decode.string)
        (Decode.field "members" (Decode.list memberDecoder))


memberDecoder : Decode.Decoder Member
memberDecoder =
    Decode.map5 Member
        (Decode.field "name" Decode.string)
        (Decode.field "kind" Decode.string)
        (Decode.field "signature" Decode.string)
        (Decode.field "doc" Decode.string)
        (Decode.field "role" Decode.string)


allComponents : BackendTask FatalError (List Component)
allComponents =
    BackendTask.File.jsonFile (Decode.list componentDecoder) "data/reference.json"
        |> BackendTask.allowFatal


allUsage : BackendTask FatalError (Dict String (List UsageExample))
allUsage =
    BackendTask.File.jsonFile
        (Decode.dict (Decode.field "examples" (Decode.list usageExampleDecoder)))
        "data/examples.json"
        |> BackendTask.allowFatal
```

> **Before finalizing:** open `docs/app/Route/Components/Name_.elm:122-140` and copy the **exact** field names, decoder arity (`map5`/`map6`), and `BackendTask.allowFatal` usage verbatim — if any differ from the above (e.g. an extra field, a `Decode.oneOf` wrapper), match the source, not this template.

- [ ] **Step 3: Format**

Run: `docs/node_modules/.bin/elm-format --yes docs/src/Doc/Data.elm`
Expected: `Processed 1 file`. (Do not compile yet — it depends on `Doc.Usage`, created next.)

- [ ] **Step 4: Commit (with B2, after both compile)** — see Task B2 Step 6.

### Task B2: Extract `Doc.Usage` (shared Usage rendering with an index offset)

**Files:**
- Create: `docs/src/Doc/Usage.elm`
- Reference: `docs/app/Route/Components/Name_.elm` — types (55-119), Usage render functions (367-562)

- [ ] **Step 1: Read every function being moved**

Run: `sed -n '55,120p;360,562p' docs/app/Route/Components/Name_.elm`
Catalog what moves: type `Layer` (~55-61), `Msg` (~69), `UsageExample` (~101-119), `usageExampleDecoder` (~143-153), and render helpers `usageBlocks`, `sectionBlock`, `exampleBlock`, `layersFor`, `layerTabs`, `codeFor`, `activeIndexFor`, `defaultLayerFor`, `groupBySection` (~367-562). Note their imports (`Doc`, `Doc.Slider`, `Heading`, `Layout`, `Kit`, `Tab`, `Element`, `Value`, `Dict`).

- [ ] **Step 2: Create `docs/src/Doc/Usage.elm` — module + moved types + state**

Create the file with this header and state block, then paste the moved functions (Steps 3-4). Adjust `usageBlocks` to take an offset (Step 3).

```elm
module Doc.Usage exposing
    ( Layer(..), Msg(..), Model, UsageExample
    , init, update, usageExampleDecoder
    , usageBlocks
    )

{-| Shared rendering of a component's "Usage" section: the heading, the live
raw-HTML previews, the surface tab strip, and the sliding code panels. Used by
both the per-component route and the `/components/all` kitchen-sink route.

Each example is addressed by a **global index** into `Model.layers`. Callers
pass a base `offset` to `usageBlocks` so multiple components stacked on one page
get disjoint index ranges and their tab selections never collide.
-}

import Dict exposing (Dict)
import Doc
import Doc.Slider
import Element exposing (Element)
import Heading
import Json.Decode as Decode
import Kit
import Layout
import Tab
import Value


type alias Model =
    { layers : Dict Int Layer }


init : Model
init =
    { layers = Dict.empty }


type Msg
    = SelectLayer Int Layer


update : Msg -> Model -> Model
update (SelectLayer index layer) model =
    { model | layers = Dict.insert index layer model.layers }


type Layer
    = Top
    | Record
    | Build
    | Middle
    | Bottom
    | Raw


type alias UsageExample =
    { title : String
    , section : String
    , html : String
    , top : Maybe String
    , mid : Maybe String
    , bottom : Maybe String
    , record : Maybe String
    , build : Maybe String
    }
```

> **Match the source:** copy `Layer`'s exact constructors and `UsageExample`'s exact fields from `Name_.elm:55-119`. The `init`/`update` above are new tiny helpers that centralize what `Name_.elm`'s `init`/`update` did inline — verify `Name_.elm`'s `update` (~188-192) only does the `Dict.insert` shown.

- [ ] **Step 3: Move the decoder and the render functions, adding the offset**

Paste `usageExampleDecoder` verbatim from `Name_.elm:143-153`. Then paste `sectionBlock`, `exampleBlock`, `layersFor`, `layerTabs`, `codeFor`, `activeIndexFor`, `defaultLayerFor`, `groupBySection` **verbatim** from `Name_.elm:388-562` (they are pure functions of `Model`/`UsageExample`/`index` and move unchanged). Finally, replace `usageBlocks` with the offset-taking version:

```elm
usageBlocks : Int -> Model -> List UsageExample -> List (Element { s | html : Supported, heading : Supported, card : Supported, tabs : Supported } Msg)
usageBlocks offset model examples =
    case examples of
        [] ->
            []

        _ ->
            [ Layout.div "space-y-6"
                (Heading.view { content = Kit.text "Usage" }
                    [ Heading.variant Value.headline, Heading.size Value.small, Heading.level 2 ]
                    []
                    :: List.concatMap (sectionBlock model)
                        (groupBySection (List.indexedMap (\i ex -> ( offset + i, ex )) examples))
                )
            ]
```

The only change from the original (`Name_.elm:367-381`) is `List.indexedMap (\i ex -> ( offset + i, ex ))` in place of `List.indexedMap Tuple.pair`. Everything downstream already keys off that `Int`, so the offset propagates for free.

> **Import note:** `Supported` in the return type comes from the design-system module the source uses (likely `Element` exposes it, or a `M3e.Value`/design-tokens module). Copy the **exact** return-type annotation and its `Supported` import from `Name_.elm:367` so the signature matches.

- [ ] **Step 4: Format**

Run: `docs/node_modules/.bin/elm-format --yes docs/src/Doc/Usage.elm docs/src/Doc/Data.elm`
Expected: `Processed 2 files`.

- [ ] **Step 5: Compile-check both new modules**

Run: `cd docs && npx elm-pages gen && ./node_modules/.bin/elm make src/Doc/Usage.elm src/Doc/Data.elm --output=/dev/null`
Expected: `Success!`. Fix any import or field mismatches against the real `Name_.elm` source until it compiles.

- [ ] **Step 6: Commit the two shared modules**

```bash
git add docs/src/Doc/Usage.elm docs/src/Doc/Data.elm
git commit -m "refactor(docs): extract Doc.Usage + Doc.Data shared modules

Adds an index offset to usageBlocks so stacked components get disjoint
tab-state ranges. No route wired to them yet.

Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>
Claude-Session: https://claude.ai/code/session_01Ap4D1B7LnEde7MVfd5uuCy"
```

### Task B3: Rewire `Name_.elm` onto the shared modules

**Files:**
- Modify: `docs/app/Route/Components/Name_.elm`

- [ ] **Step 1: Replace the moved code with imports + aliases**

Delete from `Name_.elm` the definitions now living in `Doc.Usage`/`Doc.Data` (the `Layer`, `Msg`, `UsageExample`, `Component`, `Member` types; `componentDecoder`, `memberDecoder`, `usageExampleDecoder`, `allComponents`, `allUsage`; and all the render helpers `usageBlocks`…`groupBySection`). Add:
```elm
import Doc.Data exposing (Component, allComponents, allUsage, componentDecoder)
import Doc.Usage as Usage exposing (UsageExample)
```
Set the route's `Model`/`Msg` to the shared ones:
```elm
type alias Model =
    Usage.Model


type alias Msg =
    Usage.Msg
```
(Keep `RouteParams`, `Data`, `ActionData` as they were.)

- [ ] **Step 2: Delegate `init`/`update`; call `usageBlocks` with offset 0**

`init` returns `( Usage.init, Effect.none )`. `update` becomes:
```elm
update _ _ msg model =
    ( Usage.update msg model, Effect.none )
```
In `view`, change `usageBlocks model app.data.usage` to `Usage.usageBlocks 0 model app.data.usage`.

> Keep `Name_.elm`'s own `header`, `apiSection`, `pane`, and the `Component`/`Data` wiring. Only the Usage-and-data pieces move out.

- [ ] **Step 3: Format + compile**

Run:
```bash
docs/node_modules/.bin/elm-format --yes docs/app/Route/Components/Name_.elm
cd docs && npm run build:ci
```
Expected: `build:ci` exit 0.

- [ ] **Step 4: Verify no visual/behavior regression in the browser**

Run:
```bash
cd docs && npm run build && node scripts/serve-dist.mjs dist 1239 & sleep 2
BASE_URL=http://localhost:1239 npx playwright test tests-browser/usage.spec.ts tests-browser/contract.spec.ts
kill %1 2>/dev/null
```
Expected: PASS — the per-component route renders identically (tabs, previews, folds) after the refactor.

- [ ] **Step 5: Commit**

```bash
git add docs/app/Route/Components/Name_.elm
git commit -m "refactor(docs): point Components/Name_ at Doc.Usage + Doc.Data

Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>
Claude-Session: https://claude.ai/code/session_01Ap4D1B7LnEde7MVfd5uuCy"
```

### Task B4: Expose `componentCategories` from `Shared.elm`

**Files:**
- Modify: `docs/app/Shared.elm` (module declaration line 1; `componentCategories` ~791-800)

- [ ] **Step 1: Add to the exposing list**

`Shared.elm:1` currently reads:
```elm
module Shared exposing (Contrast, Data, Direction, Model, Msg, Scheme, template)
```
Change to:
```elm
module Shared exposing (Contrast, Data, Direction, Model, Msg, Scheme, componentCategories, template)
```
(`componentCategories : List ( String, String )` is already defined at ~791-800 — the 7 `(label, glyph)` pairs in display order.)

- [ ] **Step 2: Compile**

Run: `cd docs && npm run build:ci`
Expected: exit 0.

- [ ] **Step 3: Commit (bundle with B5 nav change).** Proceed to B5 before committing.

### Task B5: Add the "All components" nav leaf

**Files:**
- Modify: `docs/app/Shared.elm` (`componentsGroup` ~737-759)

- [ ] **Step 1: Read the nav builder**

Run: `sed -n '737,786p' docs/app/Shared.elm`
Identify `componentsGroup` (builds the "Components" parent → per-category subgroups), `navGroup`, and `navLeaf : String -> ( String, String ) -> Element { navMenuItem : Supported } msg`.

- [ ] **Step 2: Insert an "All components" leaf as the first child**

In `componentsGroup`, the children list currently starts with the icon and maps categories to subgroups. Add `navLeaf currentPath ( "/components/all", "All components" )` as the first child after the icon. For example, if the children expression is:
```elm
        (NavMenuItem.icon (Icon.view [ Icon.name "widgets" ] [])
            :: List.map (\( category, glyph ) -> navGroup currentPath glyph category (itemsFor category)) componentCategories
        )
```
change it to:
```elm
        (NavMenuItem.icon (Icon.view [ Icon.name "widgets" ] [])
            :: navLeaf currentPath ( "/components/all", "All components" )
            :: List.map (\( category, glyph ) -> navGroup currentPath glyph category (itemsFor category)) componentCategories
        )
```

> Match the **exact** shape of the source (the real children list may name its category-mapping helper differently, e.g. inline `componentList` filtering). Read lines 737-759 and splice the `navLeaf` in at the correct position; do not rewrite the surrounding structure. `componentsGroup`'s `open` already triggers on `String.startsWith "/components/"`, so `/components/all` auto-expands the group.

- [ ] **Step 3: Format + compile**

Run:
```bash
docs/node_modules/.bin/elm-format --yes docs/app/Shared.elm
cd docs && npm run build:ci
```
Expected: exit 0. (The link target `/components/all` 404s until Task B6 adds the route — that's fine; it's just an anchor.)

- [ ] **Step 4: Commit**

```bash
git add docs/app/Shared.elm
git commit -m "feat(docs): expose componentCategories; add All-components nav link

Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>
Claude-Session: https://claude.ai/code/session_01Ap4D1B7LnEde7MVfd5uuCy"
```

### Task B6: Add the `.cv-auto` content-visibility utility

**Files:**
- Modify: `docs/style.css`

- [ ] **Step 1: Append the utility class**

Elm can only apply class strings (per project convention it cannot set inline CSS/vars), and Tailwind v4 ships no `content-visibility` utility, so add a hand-authored class. Append to `docs/style.css`:
```css
/* Kitchen-sink page: skip rendering off-screen component blocks until scrolled
   near, keeping the 329-example /components/all page snappy. contain-intrinsic-size
   reserves an estimated height so the scrollbar stays stable. */
.cv-auto {
  content-visibility: auto;
  contain-intrinsic-size: 0 1200px;
}
```

- [ ] **Step 2: Verify the class survives the build**

Run: `cd docs && npm run build:ci && grep -c "content-visibility" dist/assets/*.css 2>/dev/null || echo "check dist css output path"`
Expected: at least 1 match (the hand-authored rule is emitted; unlike Tailwind-generated utilities it does not depend on class-name scanning).

- [ ] **Step 3: Commit (bundle with B7).** Proceed to B7.

### Task B7: Create the `/components/all` route

**Files:**
- Create: `docs/app/Route/Components/All.elm`
- Reference: `docs/app/Route/Index.elm` (StatelessRoute `single` scaffold), `docs/app/Route/Components/Name_.elm` (stateful view + `pane`)

- [ ] **Step 1: Read a `single` route and the `pane`/`header` helpers**

Run: `sed -n '1,100p' docs/app/Route/Index.elm; sed -n '231,260p;565,596p' docs/app/Route/Components/Name_.elm`
Confirm the elm-pages 3.x `single` scaffolding shape and how `view` wraps content in `pane`/`ContentPane.view` and `Element.toNode`/`Element.map PagesMsg.fromMsg`.

- [ ] **Step 2: Create `docs/app/Route/Components/All.elm`**

```elm
module Route.Components.All exposing (ActionData, Data, Model, Msg, route)

{-| /components/all — the kitchen-sink page: every component's Usage section
stacked in category order on one scrolling page. Reuses Doc.Usage rendering with
a running index offset so tab state never collides across components.
-}

import BackendTask exposing (BackendTask)
import Dict exposing (Dict)
import Doc.Data as Data exposing (Component, allComponents, allUsage)
import Doc.Usage as Usage exposing (UsageExample)
import Effect exposing (Effect)
import Element
import FatalError exposing (FatalError)
import Head
import Heading
import Kit
import Layout
import PagesMsg exposing (PagesMsg)
import RouteBuilder exposing (App, StatefulRoute)
import Shared
import UrlPath exposing (UrlPath)
import Value
import View exposing (View)


type alias Model =
    Usage.Model


type alias Msg =
    Usage.Msg


type alias RouteParams =
    {}


type alias Data =
    { components : List Component
    , usage : Dict String (List UsageExample)
    }


type alias ActionData =
    {}


route : StatefulRoute RouteParams Data ActionData Model Msg
route =
    RouteBuilder.single { head = head, data = data }
        |> RouteBuilder.buildWithLocalState
            { view = view
            , init = init
            , update = update
            , subscriptions = subscriptions
            }


data : BackendTask FatalError Data
data =
    BackendTask.map2 Data allComponents allUsage


init : App Data ActionData RouteParams -> Shared.Model -> ( Model, Effect Msg )
init _ _ =
    ( Usage.init, Effect.none )


update : App Data ActionData RouteParams -> Shared.Model -> Msg -> Model -> ( Model, Effect Msg )
update _ _ msg model =
    ( Usage.update msg model, Effect.none )


subscriptions : RouteParams -> UrlPath -> Shared.Model -> Model -> Sub Msg
subscriptions _ _ _ _ =
    Sub.none


head : App Data ActionData RouteParams -> List Head.Tag
head _ =
    []
```

> Copy `head`'s real shape from `Index.elm`/`Reference.elm` (they build `Seo.summary … |> Seo.website`); an empty list compiles but a proper `Seo` head matches the site. Confirm the exact `RouteBuilder`/`App`/`View`/`PagesMsg` import names against `Index.elm` — elm-pages generated names must match.

- [ ] **Step 3: Add the ordered-stacking `view`**

Append to `All.elm`:
```elm
view : App Data ActionData RouteParams -> Shared.Model -> Model -> View (PagesMsg Msg)
view app _ model =
    { title = "All components · elm-m3e"
    , body =
        [ Element.toNode
            (Element.map PagesMsg.fromMsg
                (pane
                    [ Layout.div "space-y-12"
                        (Heading.view { content = Kit.text "All components" }
                            [ Heading.variant Value.display, Heading.size Value.small, Heading.level 1 ]
                            []
                            :: stackedBlocks model app.data
                        )
                    ]
                )
            )
        ]
    }


{-| Every component's Usage section in category order, each with a running index
offset so tab state stays disjoint, wrapped in an id anchor + `.cv-auto`.
-}
stackedBlocks : Model -> Data -> List (Element.Element { s | html : Value.Supported, heading : Value.Supported, card : Value.Supported, tabs : Value.Supported } Msg)
stackedBlocks model d =
    let
        orderedComponents : List Component
        orderedComponents =
            Shared.componentCategories
                |> List.concatMap
                    (\( category, _ ) ->
                        List.filter (\c -> c.category == category) d.components
                    )

        step : Component -> ( Int, List (Element.Element _ Msg) ) -> ( Int, List (Element.Element _ Msg) )
        step component ( offset, acc ) =
            let
                examples : List UsageExample
                examples =
                    Dict.get component.slug d.usage |> Maybe.withDefault []

                block : List (Element.Element _ Msg)
                block =
                    if List.isEmpty examples then
                        []

                    else
                        [ Layout.divWithId component.slug
                            "cv-auto space-y-6 scroll-mt-24"
                            (Heading.view { content = Kit.text component.name }
                                [ Heading.variant Value.headline, Heading.size Value.medium, Heading.level 2 ]
                                []
                                :: Usage.usageBlocks offset model examples
                            )
                        ]
            in
            ( offset + List.length examples, acc ++ block )
    in
    List.foldl step ( 0, [] ) orderedComponents |> Tuple.second


pane : List (Element.Element s Msg) -> Element.Element { s2 | contentPane : Value.Supported } Msg
pane items =
    ContentPane.view [] items
```
(Add `import ContentPane` to the module's imports.)

> **Resolve these before compiling:**
> 1. `pane`/`ContentPane` — confirm the exact `ContentPane.view` arity and its return-type row against `Name_.elm:565-567`; match the signature (the `{ s2 | contentPane : … }` row above is a template — copy the real one).
> 2. `Layout.divWithId` — check `docs/src/Layout.elm` for an id-taking div helper. If none exists, add one: `divWithId : String -> String -> List (Element …) -> Element …` that sets `Html.Attributes.id` + the class string (mirror `Layout.div` at `Layout.elm:210`). Anchors enable deep-linking (`/components/all#button`).
> 3. `Value.display`/`Value.Supported` — confirm the exact heading-variant and `Supported` names against `Name_.elm`'s usage; match them.
> 4. The `Element.Element _ Msg` wildcard rows in `step` may need the concrete `{ s | html … }` row — if elm rejects the wildcard, copy the exact row from `Usage.usageBlocks`'s signature.

- [ ] **Step 4: Format + compile**

Run:
```bash
docs/node_modules/.bin/elm-format --yes docs/app/Route/Components/All.elm
cd docs && npx elm-pages gen && npm run build:ci
```
Expected: exit 0. Iterate on the four resolution points above until it compiles.

- [ ] **Step 5: Manually eyeball the page**

Run: `cd docs && npm run build && node scripts/serve-dist.mjs dist 1239 & sleep 2`
Open `http://localhost:1239/components/all`. Confirm: components appear in the 7 categories' order, each with a heading, previews, and working tab strips; switching a tab on one component does **not** change another component's tab (the offset check). Then `kill %1`.

- [ ] **Step 6: Commit**

```bash
git add docs/app/Route/Components/All.elm docs/style.css
git commit -m "feat(docs): add /components/all kitchen-sink page

Stacks every component's Usage section in category order with disjoint
tab-state offsets and content-visibility:auto for scroll performance.

Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>
Claude-Session: https://claude.ai/code/session_01Ap4D1B7LnEde7MVfd5uuCy"
```

### Task B8: Browser tests for the kitchen-sink page

**Files:**
- Create: `docs/tests-browser/all-page.spec.ts`
- Modify: `docs/tests-browser/nav.spec.ts`

- [ ] **Step 1: Write the smoke test**

Create `docs/tests-browser/all-page.spec.ts`:
```ts
import { test, expect } from "@playwright/test";

// /components/all stacks every component's Usage section on one page. Scope waits
// to document.body (the page uses no .max-w-4xl wrapper) and avoid networkidle
// (the dev server holds a long-lived SSE stream open).
test("/components/all mounts and renders many components", async ({ page }) => {
  const errors: string[] = [];
  page.on("console", (m) => { if (m.type() === "error") errors.push(m.text()); });
  page.on("pageerror", (e) => errors.push(String(e)));

  await page.goto("/components/all");

  // At least one m3e-* custom element upgrades (proves the page mounted live).
  await page.waitForFunction(() => {
    const els = [...document.querySelectorAll("[slot], m3e-button, m3e-app-bar")];
    return els.some((el) => (el as HTMLElement & { shadowRoot: unknown }).shadowRoot);
  });

  // The page heading and multiple per-component Usage sections render.
  await expect(page.getByRole("heading", { name: "All components" }).first()).toBeVisible();
  const usageCount = await page.getByText("Usage", { exact: true }).count();
  expect(usageCount).toBeGreaterThan(10);

  // Deep-link anchors exist (e.g. the button block).
  await expect(page.locator("#button")).toBeAttached();

  expect(errors, `console errors:\n${errors.join("\n")}`).toEqual([]);
});
```

- [ ] **Step 2: Add the nav-link assertion**

In `docs/tests-browser/nav.spec.ts`, after the existing category-name assertions, add:
```ts
  await expect(page.getByRole("link", { name: "All components" })).toBeVisible();
```
(Read the existing test first — if the nav is collapsed by default, click the "Components" group open before asserting, matching how the existing assertions reach category names.)

- [ ] **Step 3: Run both**

Run:
```bash
cd docs && npm run build && node scripts/serve-dist.mjs dist 1239 & sleep 2
BASE_URL=http://localhost:1239 npx playwright test tests-browser/all-page.spec.ts tests-browser/nav.spec.ts
kill %1 2>/dev/null
```
Expected: PASS. If `#button` isn't attached, confirm `Layout.divWithId` actually set the `id` (Task B7 Step 3.2).

- [ ] **Step 4: Commit**

```bash
git add docs/tests-browser/all-page.spec.ts docs/tests-browser/nav.spec.ts
git commit -m "test(docs): browser coverage for /components/all + nav link

Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>
Claude-Session: https://claude.ai/code/session_01Ap4D1B7LnEde7MVfd5uuCy"
```

---

# PHASE A — Round-trip verification harness

Two layers. **Layer 1** (Tasks A1-A3) is static: join the four config JSONs into a cell matrix and scan each converted-Elm cell for `Seam.*`/`Native.*` escape hatches. It needs no rendering and ships a first `docs/data/roundtrip-report.json`. **Layer 2** (Tasks A4-A7) code-generates a transient elm-pages route that SSR-renders every converted cell, splits the pre-rendered HTML by a `data-rt` marker, and DOM-diffs each cell against the raw corpus, augmenting the report. Task A8 deploys the `/roundtrip` human view. Gate-later (a committed baseline + CI regression check) is explicitly a **follow-up**, noted at the end, not built here.

**Cell keying (from the pipeline investigation):**
- `config/examples.rich.json` (top/mid/bottom), `config/examples.surfaces.json` (record/build), `config/examples.barrel.json` (barrel) are keyed by **PascalCase module** → **parallel arrays** (same index = same example).
- `config/examples.matraic.json` is keyed by **kebab-case family** and includes filtered entries, so it is **positionally misaligned** with rich. Join matraic→rich by the raw HTML string (`matraic[].code === rich[].html`, confirmed equal) with `title` as a fallback/label.
- Canonical cell id: `"<PascalModule>/<index>/<surface>"`, surfaces ∈ `top, mid, bottom, record, build, barrel`. The raw corpus HTML for a cell comes from `rich[Module][index].html`.

### Task A1: Cell-matrix join module

**Files:**
- Create: `docs/scripts/roundtrip/join.mjs`
- Test: `docs/scripts/roundtrip/join.test.mjs`

- [ ] **Step 1: Write the failing test**

Create `docs/scripts/roundtrip/join.test.mjs`:
```js
import { test } from "node:test";
import assert from "node:assert/strict";
import { buildMatrix } from "./join.mjs";

test("buildMatrix produces one cell per (module, index, surface) with raw html", () => {
  const rich = {
    AppBar: [{ title: "Anatomy", html: "<m3e-app-bar></m3e-app-bar>", top: "M3e.AppBar.view [] []", mid: "M3e.Cem.AppBar.appBar [] []", bottom: null }],
  };
  const surfaces = { AppBar: [{ record: "M3e.Record.AppBar.view {}", build: null }] };
  const barrel = { AppBar: ["M3e.appBar [] []"] };

  const cells = buildMatrix({ rich, surfaces, barrel });

  // 6 surfaces per example, all recorded (null = not converted).
  const appbar0 = cells.filter((c) => c.module === "AppBar" && c.index === 0);
  assert.equal(appbar0.length, 6);
  const bySurface = Object.fromEntries(appbar0.map((c) => [c.surface, c]));
  assert.equal(bySurface.top.converted, true);
  assert.equal(bySurface.bottom.converted, false);
  assert.equal(bySurface.build.converted, false);
  assert.equal(bySurface.top.raw, "<m3e-app-bar></m3e-app-bar>");
  assert.equal(bySurface.top.title, "Anatomy");
});
```

- [ ] **Step 2: Run it — expect failure**

Run: `cd docs && node --test scripts/roundtrip/join.test.mjs`
Expected: FAIL (`Cannot find module './join.mjs'`).

- [ ] **Step 3: Implement `join.mjs`**

Create `docs/scripts/roundtrip/join.mjs`:
```js
// Join the pipeline's per-surface config JSONs into a flat cell matrix.
// rich/surfaces/barrel are keyed by PascalCase module -> parallel arrays.

export const SURFACES = ["top", "mid", "bottom", "record", "build", "barrel"];

/** @returns {Array<{module,index,surface,title,raw,elm,converted}>} */
export function buildMatrix({ rich, surfaces, barrel }) {
  const cells = [];
  for (const module of Object.keys(rich)) {
    const examples = rich[module] || [];
    const surf = (surfaces && surfaces[module]) || [];
    const barr = (barrel && barrel[module]) || [];
    examples.forEach((ex, index) => {
      const surfaceCode = {
        top: ex.top ?? null,
        mid: ex.mid ?? null,
        bottom: ex.bottom ?? null,
        record: (surf[index] && surf[index].record) ?? null,
        build: (surf[index] && surf[index].build) ?? null,
        // A null barrel entry means "keep the Standard top"; treat as top for parity.
        barrel: barr[index] ?? null,
      };
      for (const surface of SURFACES) {
        const elm = surfaceCode[surface];
        cells.push({
          module,
          index,
          surface,
          title: ex.title ?? `${module}[${index}]`,
          raw: ex.html ?? null,
          elm,
          converted: typeof elm === "string" && elm.length > 0,
        });
      }
    });
  }
  return cells;
}
```

- [ ] **Step 4: Run the test — expect pass**

Run: `cd docs && node --test scripts/roundtrip/join.test.mjs`
Expected: PASS.

- [ ] **Step 5: Commit (bundle with A2).**

### Task A2: Escape-hatch scanner (Layer 1 core)

**Files:**
- Create: `docs/scripts/roundtrip/escape-scan.mjs`
- Test: `docs/scripts/roundtrip/escape-scan.test.mjs`

- [ ] **Step 1: Write the failing test**

Create `docs/scripts/roundtrip/escape-scan.test.mjs`:
```js
import { test } from "node:test";
import assert from "node:assert/strict";
import { scanEscapes } from "./escape-scan.mjs";

test("fully typed conversion scores zero", () => {
  const r = scanEscapes("M3e.AppBar.view [] [ M3e.IconButton.view [] [] ]");
  assert.equal(r.seam.count, 0);
  assert.equal(r.native.count, 0);
  assert.equal(r.charsInside, 0);
  assert.equal(r.benign, true);
});

test("counts Native.* and Seam.* call sites and inner char span", () => {
  const r = scanEscapes('M3e.card [] [ Seam.asElement (Html.div [] [ Html.text "x" ]) ]');
  assert.equal(r.seam.count, 1);
  assert.ok(r.seam.charsInside > 0);
  assert.equal(r.native.count, 0);
});

test("lone Native.span wrapping text is flagged benign", () => {
  const r = scanEscapes('M3e.appBar [] [ Native.span [] [ Kit.text "Title" ] ]');
  assert.equal(r.native.count, 1);
  assert.equal(r.benign, true); // text-wrapping only
});

test("Native wrapping real structure is NOT benign", () => {
  const r = scanEscapes("M3e.appBar [] [ Native.div [] [ M3e.icon [] [], M3e.icon [] [] ] ]");
  assert.equal(r.benign, false);
});

test("null / non-string input is inert", () => {
  const r = scanEscapes(null);
  assert.equal(r.converted, false);
  assert.equal(r.seam.count, 0);
});
```

- [ ] **Step 2: Run it — expect failure**

Run: `cd docs && node --test scripts/roundtrip/escape-scan.test.mjs`
Expected: FAIL (module not found).

- [ ] **Step 3: Implement `escape-scan.mjs`**

Create `docs/scripts/roundtrip/escape-scan.mjs`:
```js
// Layer 1: statically scan a converted-Elm string for escape hatches.
//   Seam.*   — the sanctioned type-hole (asElement/asAttribute/fromHtml/…).
//   Native.* — raw-HTML fallback used where no typed component existed.
// Reports per-mechanism call-site count and the char span of the arguments
// *inside* each call ("how much code is behind the hatch"). Zero = fully typed.

/** Char length inside the first balanced (...) or [...] following `fromIndex`. */
function innerSpanAfter(code, fromIndex) {
  let i = fromIndex;
  while (i < code.length && code[i] !== "(" && code[i] !== "[") i++;
  if (i >= code.length) return 0;
  const open = code[i];
  const close = open === "(" ? ")" : "]";
  let depth = 0;
  const start = i + 1;
  for (; i < code.length; i++) {
    if (code[i] === open) depth++;
    else if (code[i] === close) {
      depth--;
      if (depth === 0) return i - start;
    }
  }
  return code.length - start; // unbalanced: count to end
}

function scanMechanism(code, prefix) {
  const re = new RegExp("\\b" + prefix + "\\.[A-Za-z][A-Za-z0-9_]*", "g");
  let m;
  let count = 0;
  let charsInside = 0;
  const sites = [];
  while ((m = re.exec(code)) !== null) {
    count++;
    const span = innerSpanAfter(code, m.index + m[0].length);
    charsInside += span;
    sites.push({ token: m[0], span });
  }
  return { count, charsInside, sites };
}

// Benign = the only escapes are text-wrapping helpers: Native.span/Native.text
// or Kit.text, with no nested component/structure inside. Heuristic: a Native.*
// site is benign iff its inner span contains no `M3e.` or second element.
function isBenign(code, native) {
  if (native.count === 0) return true;
  return native.sites.every((s) => {
    const inner = code.slice(0); // sites carry only spans; re-scan tokenlessly:
    return !/M3e\.|,\s*Native\.|,\s*Html\./.test(sliceInner(code, s));
  });
}

function sliceInner(code, site) {
  // Re-locate this token's inner region for the benign test.
  const idx = code.indexOf(site.token);
  if (idx < 0) return "";
  let i = idx + site.token.length;
  while (i < code.length && code[i] !== "(" && code[i] !== "[") i++;
  const open = code[i];
  if (!open) return "";
  const close = open === "(" ? ")" : "]";
  let depth = 0;
  const start = i + 1;
  for (; i < code.length; i++) {
    if (code[i] === open) depth++;
    else if (code[i] === close) { depth--; if (depth === 0) return code.slice(start, i); }
  }
  return code.slice(start);
}

export function scanEscapes(code) {
  if (typeof code !== "string" || code.length === 0) {
    return { converted: false, seam: { count: 0, charsInside: 0 }, native: { count: 0, charsInside: 0 }, charsInside: 0, benign: true };
  }
  const seam = scanMechanism(code, "Seam");
  const native = scanMechanism(code, "Native");
  const benign = seam.count === 0 && isBenign(code, native);
  return {
    converted: true,
    seam: { count: seam.count, charsInside: seam.charsInside },
    native: { count: native.count, charsInside: native.charsInside },
    charsInside: seam.charsInside + native.charsInside,
    benign,
  };
}
```

> The benign heuristic (`isBenign`/`sliceInner`) is intentionally simple and, per the spec, expected to need tuning after the first report — iterate on which `Native.*`/`Seam.*` usages count as benign once you can see real data. Keep the count + char-span numbers authoritative; `benign` is only a display hint.

- [ ] **Step 4: Run the test — expect pass**

Run: `cd docs && node --test scripts/roundtrip/escape-scan.test.mjs`
Expected: PASS. If the benign tests fail, fix `isBenign`/`sliceInner` (they share the same balanced-scan logic as `innerSpanAfter` — consider refactoring to one helper that returns both the inner string and its length).

- [ ] **Step 5: Commit**

```bash
git add docs/scripts/roundtrip/join.mjs docs/scripts/roundtrip/join.test.mjs docs/scripts/roundtrip/escape-scan.mjs docs/scripts/roundtrip/escape-scan.test.mjs
git commit -m "feat(roundtrip): Layer 1 cell-join + escape-hatch scanner

Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>
Claude-Session: https://claude.ai/code/session_01Ap4D1B7LnEde7MVfd5uuCy"
```

### Task A3: Orchestrator — write the Layer 1 report + npm script

**Files:**
- Create: `docs/scripts/verify-roundtrip.mjs`
- Modify: `docs/package.json`

- [ ] **Step 1: Implement the Layer-1 orchestrator**

Create `docs/scripts/verify-roundtrip.mjs`:
```js
// verify-roundtrip.mjs — round-trip verification harness.
// Layer 1 (default): join the config JSONs, scan each converted cell for escape
// hatches, and write docs/data/roundtrip-report.json.
// Layer 2 (--render): additionally SSR-render + DOM-diff each cell (Task A5+).

import { readFileSync, writeFileSync } from "node:fs";
import { dirname, resolve } from "node:path";
import { fileURLToPath } from "node:url";
import { buildMatrix, SURFACES } from "./roundtrip/join.mjs";
import { scanEscapes } from "./roundtrip/escape-scan.mjs";

const HERE = dirname(fileURLToPath(import.meta.url));
const REPO = resolve(HERE, "..", "..");
const CONFIG = resolve(REPO, "config");
const OUT = resolve(REPO, "docs", "data", "roundtrip-report.json");

const readJson = (p) => JSON.parse(readFileSync(p, "utf8"));

function main() {
  const rich = readJson(resolve(CONFIG, "examples.rich.json"));
  const surfaces = readJson(resolve(CONFIG, "examples.surfaces.json"));
  const barrel = readJson(resolve(CONFIG, "examples.barrel.json"));

  const cells = buildMatrix({ rich, surfaces, barrel }).map((cell) => {
    const escape = scanEscapes(cell.elm);
    return {
      id: `${cell.module}/${cell.index}/${cell.surface}`,
      module: cell.module,
      index: cell.index,
      surface: cell.surface,
      title: cell.title,
      converted: cell.converted,
      escapeHatch: {
        seam: escape.seam,
        native: escape.native,
        charsInside: escape.charsInside,
        benign: escape.benign,
      },
      roundtrip: null, // filled by Layer 2 (--render)
    };
  });

  const perSurface = {};
  for (const s of SURFACES) {
    const scoped = cells.filter((c) => c.surface === s);
    const converted = scoped.filter((c) => c.converted);
    perSurface[s] = {
      total: scoped.length,
      converted: converted.length,
      clean: converted.filter((c) => c.escapeHatch.charsInside === 0).length,
      usedEscapeHatch: converted.filter((c) => c.escapeHatch.charsInside > 0).length,
    };
  }

  const report = {
    generatedAtNote: "stamp externally; Date.now() intentionally not embedded",
    layer2: false,
    perSurface,
    cells,
  };
  writeFileSync(OUT, JSON.stringify(report, null, 2) + "\n");
  const totalConverted = cells.filter((c) => c.converted).length;
  console.log(`roundtrip Layer 1: ${cells.length} cells, ${totalConverted} converted → ${OUT}`);
}

main();
```

- [ ] **Step 2: Add the npm scripts**

In `docs/package.json` `"scripts"`, add:
```json
    "verify:roundtrip": "node scripts/verify-roundtrip.mjs",
    "test:roundtrip": "node --test scripts/roundtrip/*.test.mjs",
```

- [ ] **Step 3: Run it against the real corpus**

Run: `cd docs && npm run verify:roundtrip`
Expected: a line like `roundtrip Layer 1: ~1500 cells, ~N converted → …/docs/data/roundtrip-report.json`. Open the JSON; confirm `perSurface.top.converted` roughly matches the corpus (top had ~21 nulls out of ~309), and spot-check a cell with a known `Native.span` shows `native.count ≥ 1`.

- [ ] **Step 4: Run the unit tests via the new script**

Run: `cd docs && npm run test:roundtrip`
Expected: all `join`/`escape-scan` tests PASS.

- [ ] **Step 5: Commit**

```bash
git add docs/scripts/verify-roundtrip.mjs docs/package.json docs/data/roundtrip-report.json
git commit -m "feat(roundtrip): Layer 1 orchestrator + report + npm scripts

Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>
Claude-Session: https://claude.ai/code/session_01Ap4D1B7LnEde7MVfd5uuCy"
```

### Task A4: Semantic DOM-tree diff (Layer 2 core)

**Files:**
- Create: `docs/scripts/roundtrip/dom-diff.mjs`
- Test: `docs/scripts/roundtrip/dom-diff.test.mjs`

Uses `linkedom` (already a `docs/` dependency) to parse both sides; canonicalizes (sort attributes, collapse insignificant whitespace, normalize boolean-attribute forms); compares structurally; returns `{ matches, deviations: [...] }`.

- [ ] **Step 1: Write the failing test**

Create `docs/scripts/roundtrip/dom-diff.test.mjs`:
```js
import { test } from "node:test";
import assert from "node:assert/strict";
import { diffHtml } from "./dom-diff.mjs";

test("identical markup matches", () => {
  const r = diffHtml("<m3e-button variant='filled'>Go</m3e-button>", "<m3e-button variant='filled'>Go</m3e-button>");
  assert.equal(r.matches, true);
  assert.deepEqual(r.deviations, []);
});

test("attribute order is normalized away", () => {
  const r = diffHtml('<m3e-button a="1" b="2"></m3e-button>', '<m3e-button b="2" a="1"></m3e-button>');
  assert.equal(r.matches, true);
});

test("insignificant whitespace is normalized away", () => {
  const r = diffHtml("<m3e-list>\n  <m3e-list-item></m3e-list-item>\n</m3e-list>", "<m3e-list><m3e-list-item></m3e-list-item></m3e-list>");
  assert.equal(r.matches, true);
});

test("boolean attribute forms are normalized (disabled vs disabled='')", () => {
  const r = diffHtml("<m3e-button disabled></m3e-button>", '<m3e-button disabled=""></m3e-button>');
  assert.equal(r.matches, true);
});

test("a changed attribute value is a structured deviation", () => {
  const r = diffHtml('<m3e-button variant="filled"></m3e-button>', '<m3e-button variant="tonal"></m3e-button>');
  assert.equal(r.matches, false);
  assert.equal(r.deviations[0].kind, "changed-attr");
  assert.equal(r.deviations[0].attr, "variant");
});

test("a missing element is a structured deviation", () => {
  const r = diffHtml("<m3e-app-bar><span slot='title'>T</span></m3e-app-bar>", "<m3e-app-bar></m3e-app-bar>");
  assert.equal(r.matches, false);
  assert.ok(r.deviations.some((d) => d.kind === "removed-element"));
});
```

- [ ] **Step 2: Run — expect failure**

Run: `cd docs && node --test scripts/roundtrip/dom-diff.test.mjs`
Expected: FAIL (module not found).

- [ ] **Step 3: Implement `dom-diff.mjs`**

Create `docs/scripts/roundtrip/dom-diff.mjs`:
```js
// Semantic DOM-tree diff for round-trip verification. Parses both HTML strings
// with linkedom, canonicalizes, and compares structurally. Mechanical
// differences (attr order, insignificant whitespace, boolean-attr form, quote
// style) are normalized away; real differences become structured deviations.

import { parseHTML } from "linkedom";

const VOID = new Set(["area","base","br","col","embed","hr","img","input","link","meta","param","source","track","wbr"]);

function canonAttrs(el) {
  const out = {};
  for (const { name, value } of [...el.attributes]) {
    // Normalize boolean attrs: `disabled` and `disabled=""` both -> "".
    out[name] = value == null ? "" : String(value);
  }
  return out;
}

function significantText(node) {
  // Collapse runs of whitespace; a node that is all-whitespace is insignificant.
  const t = (node.textContent || "").replace(/\s+/g, " ").trim();
  return t;
}

function toTree(el) {
  const children = [];
  for (const child of el.childNodes) {
    if (child.nodeType === 1) {
      children.push(toTree(child));
    } else if (child.nodeType === 3) {
      const t = child.textContent.replace(/\s+/g, " ").trim();
      if (t) children.push({ type: "text", text: t });
    }
  }
  return { type: "el", tag: el.tagName.toLowerCase(), attrs: canonAttrs(el), children };
}

function rootOf(html) {
  const { document } = parseHTML(`<body>${html}</body>`);
  // Return the first element child of body (the corpus/render is one root cell).
  const el = document.body.firstElementChild;
  return el ? toTree(el) : null;
}

function diffNode(a, b, path, out) {
  if (!a || !b) {
    out.push({ kind: !a ? "added-element" : "removed-element", path, tag: (a || b).tag });
    return;
  }
  if (a.type !== b.type) {
    out.push({ kind: "changed-node", path, from: a.type, to: b.type });
    return;
  }
  if (a.type === "text") {
    if (a.text !== b.text) out.push({ kind: "changed-text", path, from: a.text, to: b.text });
    return;
  }
  if (a.tag !== b.tag) {
    out.push({ kind: "changed-element", path, from: a.tag, to: b.tag });
    return;
  }
  // Attributes.
  const keys = new Set([...Object.keys(a.attrs), ...Object.keys(b.attrs)]);
  for (const k of keys) {
    const av = a.attrs[k];
    const bv = b.attrs[k];
    if (av === undefined) out.push({ kind: "added-attr", path, attr: k, value: bv });
    else if (bv === undefined) out.push({ kind: "removed-attr", path, attr: k, value: av });
    else if (av !== bv) out.push({ kind: "changed-attr", path, attr: k, from: av, to: bv });
  }
  // Children (positional).
  const n = Math.max(a.children.length, b.children.length);
  for (let i = 0; i < n; i++) {
    diffNode(a.children[i], b.children[i], `${path}/${a.tag}[${i}]`, out);
  }
}

/** @returns {{ matches: boolean, deviations: Array<object> }} */
export function diffHtml(expectedRawHtml, actualRenderedHtml) {
  const a = rootOf(expectedRawHtml);
  const b = rootOf(actualRenderedHtml);
  const deviations = [];
  diffNode(a, b, "", deviations);
  return { matches: deviations.length === 0, deviations };
}
```

- [ ] **Step 4: Run — expect pass**

Run: `cd docs && node --test scripts/roundtrip/dom-diff.test.mjs`
Expected: PASS. If linkedom lowercases custom-element tag names differently than expected, adjust `toTree`'s `tag` normalization; if boolean-attr normalization fails, confirm linkedom reports a bare `disabled` with `value === ""`.

- [ ] **Step 5: Commit (bundle with A5).**

### Task A5: Generate the transient SSR harness route

**Files:**
- Create: `docs/scripts/roundtrip/gen-harness-route.mjs`
- Modify: `.gitignore` (add `docs/app/Route/RoundtripHarness.elm`)

The generator reuses `verify-examples.mjs`'s proven approach: compute the union of referenced modules that resolve to real sources, import each, and emit one binding per cell. Each binding is wrapped by a per-surface `→ Html` adapter, then rendered into a `<div data-rt="…">`. Adapter table (from surface return types):
- `top`, `record`, `build`, `barrel` → `M3e.Element` → `M3e.Element.toNode >> M3e.Node.toHtml`
- `mid`, `bottom` → already `Html msg` → identity

- [ ] **Step 1: Implement the generator**

Create `docs/scripts/roundtrip/gen-harness-route.mjs`:
```js
// Code-generate a transient elm-pages route that SSR-renders every converted
// cell wrapped in <div data-rt="Module/index/surface">. NOT committed (gitignored)
// and NOT deployed (Netlify uses build:ci which never runs this). verify-roundtrip
// generates it, builds, reads dist, then removes it.

import { writeFileSync } from "node:fs";
import { dirname, resolve } from "node:path";
import { fileURLToPath } from "node:url";
import { referencedModules } from "../examples-gen/verify-examples.mjs";

const HERE = dirname(fileURLToPath(import.meta.url));
const REPO = resolve(HERE, "..", "..", "..");
const ROUTE = resolve(REPO, "docs", "app", "Route", "RoundtripHarness.elm");

// Modules that resolve to real library sources; import only these (a bad import
// aborts the whole compile). Reuse verify-examples' resolver semantics: import
// everything referenced that also appears in the set of importable modules.
const STDLIB = new Set(["Html","Json","VirtualDom","Basics","Dict","Set","List","Maybe","Result","String","Char","Tuple","Array"]);

const ADAPTER = {
  top: "elementToHtml",
  record: "elementToHtml",
  build: "elementToHtml",
  barrel: "elementToHtml",
  mid: "identity",
  bottom: "identity",
};

function bindingName(module, index, surface) {
  return `cell_${module.replace(/\./g, "_")}_${index}_${surface}`;
}

/**
 * @param {Array<{module,index,surface,elm,converted}>} cells
 * @param {(mod:string)=>boolean} resolves  reuse verify-examples' moduleResolves
 */
export function generateHarness(cells, resolves) {
  const converted = cells.filter((c) => c.converted);

  const imports = new Set(["M3e.Element", "M3e.Node", "Html", "Html.Attributes"]);
  for (const c of converted) {
    for (const mod of referencedModules(c.elm)) {
      if (!STDLIB.has(mod.split(".")[0]) && resolves(mod)) imports.add(mod);
    }
  }

  const L = [];
  L.push("module Route.RoundtripHarness exposing (ActionData, Data, Model, Msg, route)");
  L.push("");
  L.push("-- GENERATED transient harness — do not edit or commit. See scripts/roundtrip/gen-harness-route.mjs.");
  L.push("");
  for (const mod of [...imports].sort()) L.push(`import ${mod}`);
  L.push("import BackendTask exposing (BackendTask)");
  L.push("import FatalError exposing (FatalError)");
  L.push("import Head");
  L.push("import PagesMsg exposing (PagesMsg)");
  L.push("import RouteBuilder exposing (App, StatelessRoute)");
  L.push("import Shared");
  L.push("import View exposing (View)");
  L.push("");
  L.push("type alias Model = {}");
  L.push("type alias Msg = ()");
  L.push("type alias RouteParams = {}");
  L.push("type alias Data = {}");
  L.push("type alias ActionData = {}");
  L.push("");
  L.push("route : StatelessRoute RouteParams Data ActionData");
  L.push("route = RouteBuilder.single { head = head, data = data } |> RouteBuilder.buildNoState { view = view }");
  L.push("");
  L.push("data : BackendTask FatalError Data");
  L.push("data = BackendTask.succeed {}");
  L.push("");
  L.push("head : App Data ActionData RouteParams -> List Head.Tag");
  L.push("head _ = []");
  L.push("");
  L.push("elementToHtml : M3e.Element.Element any msg -> Html.Html msg");
  L.push("elementToHtml el = M3e.Node.toHtml (M3e.Element.toNode el)");
  L.push("");
  L.push("identity : a -> a");
  L.push("identity x = x");
  L.push("");

  // One binding per converted cell.
  for (const c of converted) {
    const adapter = ADAPTER[c.surface];
    L.push(`${bindingName(c.module, c.index, c.surface)} : Html.Html msg`);
    L.push(`${bindingName(c.module, c.index, c.surface)} =`);
    L.push(`    ${adapter}`);
    const body = c.elm.split("\n").map((l) => "        " + l).join("\n");
    L.push(`        (${c.elm.includes("\n") ? "\n" + body + "\n        " : c.elm})`);
    L.push("");
  }

  // view: wrap each binding in <div data-rt="id">.
  L.push("view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)");
  L.push('view _ _ =');
  L.push('    { title = "roundtrip-harness"');
  L.push("    , body =");
  L.push("        [ Html.map (\\_ -> PagesMsg.fromMsg ()) (Html.div []");
  L.push("            [");
  const wrapped = converted.map((c) => {
    const id = `${c.module}/${c.index}/${c.surface}`;
    return `            Html.div [ Html.Attributes.attribute "data-rt" "${id}" ] [ ${bindingName(c.module, c.index, c.surface)} ]`;
  });
  L.push(wrapped.join("\n            ,\n"));
  L.push("            ])");
  L.push("        ]");
  L.push("    }");
  L.push("");

  return L.join("\n");
}

export function writeHarness(cells, resolves) {
  writeFileSync(ROUTE, generateHarness(cells, resolves) + "\n");
  return ROUTE;
}
```

> **Known integration risks to resolve while wiring A6 (the SSR build actually exercises this):**
> 1. `verify-examples.mjs` does not currently `export` its `moduleResolves`. Add `export` to `moduleResolves` in `docs/scripts/examples-gen/verify-examples.mjs` (it already exports `referencedModules`, `flattenExamples`), or re-implement the same resolver here. Prefer exporting to stay DRY.
> 2. The docs app's `elm.json` must see `packages/m3e` + `m3e-kit` sources. The examples-gen build already compiles these surfaces, so the docs `elm.json` `source-directories` already include them — confirm by grepping `docs/elm.json` for the library `src` paths; if absent, the harness route won't resolve `M3e.*`. (verify-examples uses a *scratch* app for this reason; if the docs app can't see the libraries, fall back to rendering the harness as a scratch elm-pages app rather than a route in the docs app.)
> 3. Per-cell type unification: examples are static (no event handlers), so every binding is `Html msg` with a free `msg` — they unify under one `view`. If any cell carries a concrete msg, the compile will flag it; drop that cell to `converted:false` in the report with a reason.

- [ ] **Step 2: Add the gitignore entry**

Append to `.gitignore` (repo root — confirm which `.gitignore` covers `docs/app/`):
```
# transient round-trip SSR harness (generated by scripts/roundtrip/gen-harness-route.mjs)
docs/app/Route/RoundtripHarness.elm
```

- [ ] **Step 3: Commit (bundle with A4 + A6).**

### Task A6: Wire Layer 2 into the orchestrator

**Files:**
- Modify: `docs/scripts/verify-roundtrip.mjs`
- Modify: `docs/scripts/examples-gen/verify-examples.mjs` (export `moduleResolves`)

- [ ] **Step 1: Export the resolver**

In `docs/scripts/examples-gen/verify-examples.mjs`, change `function moduleResolves(mod)` to `export function moduleResolves(mod)`.

- [ ] **Step 2: Add a `--render` branch to the orchestrator**

In `docs/scripts/verify-roundtrip.mjs`, after building `cells` (before writing), add Layer 2 when `process.argv.includes("--render")`:
```js
import { execFileSync } from "node:child_process";
import { readFileSync as rf, rmSync } from "node:fs";
import { parseHTML } from "linkedom";
import { writeHarness } from "./roundtrip/gen-harness-route.mjs";
import { moduleResolves } from "./examples-gen/verify-examples.mjs";
import { diffHtml } from "./roundtrip/dom-diff.mjs";

function runLayer2(cells) {
  // 1. Generate the transient harness route.
  const routePath = writeHarness(cells, moduleResolves);
  try {
    // 2. Build the docs site (SSR pre-render) so the harness route renders.
    execFileSync("npm", ["run", "build"], { cwd: resolve(REPO, "docs"), stdio: "inherit" });
    // 3. Read the pre-rendered harness HTML.
    const html = rf(resolve(REPO, "docs", "dist", "roundtrip-harness", "index.html"), "utf8");
    // 4. Split by data-rt marker.
    const { document } = parseHTML(html);
    const rendered = new Map();
    for (const el of document.querySelectorAll("[data-rt]")) {
      rendered.set(el.getAttribute("data-rt"), el.innerHTML);
    }
    // 5. Diff each converted cell against its raw corpus HTML.
    for (const cell of cells) {
      if (!cell.converted) continue;
      const got = rendered.get(cell.id);
      if (got == null) { cell.roundtrip = { matches: false, deviations: [{ kind: "not-rendered" }] }; continue; }
      cell.roundtrip = diffHtml(cell.raw, got);
    }
  } finally {
    // 6. Remove the transient route so it never deploys.
    rmSync(routePath, { force: true });
  }
}
```
Then, in `main`, capture the raw per-cell fields the report needs (`cell.raw`, `cell.id`) before mapping to the report shape, call `runLayer2(reportCells)` when `--render`, and set `report.layer2 = true`. (Refactor `main` so the mutable cell objects carry `raw`, `id`, `converted`, `elm`, and `roundtrip`, and the `perSurface` aggregate adds `deviations` counts when Layer 2 ran.)

> Building the whole site per run is the heavy SSR pass the spec anticipates. If it's unwieldy, split by surface (generate + build once per surface) — but start with the single-build path.

- [ ] **Step 3: Smoke-run Layer 2**

Run: `cd docs && npm run verify:roundtrip -- --render`
Expected: the docs build runs, then a report with `layer2: true` and non-null `roundtrip` on converted cells. Manually inspect: `M3e.Cem.Html` (bottom) cells should mostly `matches: true` (it renders identically by construction); high-deviation cells on `top` are the high-signal findings. If the harness route fails to compile, work the three risks in Task A5 Step 1.

- [ ] **Step 4: Add a combined test run**

Run: `cd docs && npm run test:roundtrip`
Expected: `join`, `escape-scan`, `dom-diff` tests all PASS.

- [ ] **Step 5: Commit**

```bash
git add docs/scripts/roundtrip/dom-diff.mjs docs/scripts/roundtrip/dom-diff.test.mjs docs/scripts/roundtrip/gen-harness-route.mjs docs/scripts/verify-roundtrip.mjs docs/scripts/examples-gen/verify-examples.mjs .gitignore docs/data/roundtrip-report.json
git commit -m "feat(roundtrip): Layer 2 SSR render + semantic DOM diff

Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>
Claude-Session: https://claude.ai/code/session_01Ap4D1B7LnEde7MVfd5uuCy"
```

### Task A7: Deployed `/roundtrip` human report route

**Files:**
- Create: `docs/app/Route/Roundtrip.elm`
- Modify: `docs/app/Shared.elm` (add a nav leaf under Reference — optional)

The route reads `docs/data/roundtrip-report.json` via `BackendTask.File.jsonFile` (same idiom as `Reference.elm`) and renders a ranked view: **deviations first**, then heavy-escape-hatch cells, then clean, with per-surface aggregates at the top.

- [ ] **Step 1: Read the JSON shape you're decoding**

Run: `cd docs && head -c 1500 data/roundtrip-report.json`
Confirm the cell fields (`id`, `module`, `surface`, `title`, `converted`, `escapeHatch.{seam,native,charsInside,benign}`, `roundtrip.{matches,deviations}`) and `perSurface`.

- [ ] **Step 2: Create the route**

Create `docs/app/Route/Roundtrip.elm` following the `Reference.elm` `StatelessRoute`/`single`/`buildNoState` scaffold (read `docs/app/Route/Reference.elm:34-95` for the exact boilerplate and copy it). Decode into:
```elm
type alias Data =
    { perSurface : List ( String, SurfaceAgg )
    , cells : List Cell
    }


type alias SurfaceAgg =
    { total : Int, converted : Int, clean : Int, usedEscapeHatch : Int }


type alias Cell =
    { id : String
    , surface : String
    , title : String
    , converted : Bool
    , seam : Int
    , native : Int
    , charsInside : Int
    , matches : Maybe Bool
    , deviationCount : Int
    }
```
with decoders (`Decode.map8`/`Decode.at`/`Decode.maybe`) reaching into the nested `escapeHatch`/`roundtrip` objects. Rank in `view`:
```elm
rankedCells : List Cell -> List Cell
rankedCells cells =
    let
        rank : Cell -> Int
        rank c =
            if c.matches == Just False then
                0
            else if c.charsInside > 0 then
                1
            else
                2
    in
    List.sortBy (\c -> ( rank c, negate c.charsInside )) cells
```
Render the per-surface aggregates as a summary block, then the ranked cell list (each showing `id`, deviation count, escape-hatch counts). Use the docs `Layout`/`Kit`/`Heading` helpers already used by `Reference.elm`. Keep it a plain read-only page (no local state).

> This page is **deployed** (the user's decision). It reads `data/roundtrip-report.json`, which must therefore be committed. `build:ci` (Netlify) does not run `verify:roundtrip`, so the committed JSON is what deploys — regenerate + commit it (Layer 1 at least) whenever the corpus changes, same discipline as `examples.json`.

- [ ] **Step 3: Add a nav leaf (optional but recommended)**

In `docs/app/Shared.elm` `navMenu`, the Reference `navGroup` currently has `[ ( "/reference", "Full API reference" ) ]`. Add a second entry: `( "/roundtrip", "Round-trip report" )`.

- [ ] **Step 4: Format + build**

Run:
```bash
docs/node_modules/.bin/elm-format --yes docs/app/Route/Roundtrip.elm docs/app/Shared.elm
cd docs && npm run build:ci
```
Expected: exit 0. Confirm `dist/roundtrip/index.html` exists.

- [ ] **Step 5: Eyeball the deployed page**

Run: `cd docs && node scripts/serve-dist.mjs dist 1239 & sleep 1`
Open `http://localhost:1239/roundtrip`. Confirm the per-surface summary and the deviations-first ranking render. `kill %1`.

- [ ] **Step 6: Commit**

```bash
git add docs/app/Route/Roundtrip.elm docs/app/Shared.elm docs/data/roundtrip-report.json
git commit -m "feat(docs): deployed /roundtrip verification report route

Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>
Claude-Session: https://claude.ai/code/session_01Ap4D1B7LnEde7MVfd5uuCy"
```

### Task A8: (Follow-up, not this ship) Gate-later baseline

Per the spec, promoting a known-clean subset to a CI gate via a committed `roundtrip-baseline.json` is a **follow-up**. When ready: snapshot today's clean cells, add a `verify:roundtrip --check` mode that fails only when a previously-clean cell regresses (a `matches:true`→`false` flip, or an escape-hatch weight crossing its recorded level), and wire it as a CI step. Do **not** build this in the initial ship; it is listed here so it isn't lost.

---

## Final verification (run before declaring the whole plan done)

- [ ] Library compiles: `cd packages/m3e && ../../docs/node_modules/.bin/elm make src/M3e.elm --output=/dev/null` → `Success!`
- [ ] Docs CI build green: `cd docs && npm run build:ci` → exit 0
- [ ] Full docs build green: `cd docs && npm run build` → exit 0
- [ ] Unit tests: `cd docs && npm run test:roundtrip` and `npm run test:examples-gen` → all PASS
- [ ] Browser tests: build + serve on 1239, then `BASE_URL=http://localhost:1239 npx playwright test` → all PASS (usage, all-page, nav, contract)
- [ ] elm-review clean (needs the sibling `elm-review-cem` rules cloned beside the repo): `cd docs && npx elm-review` → no NEW findings beyond the 18 suppressed
- [ ] `docs/data/roundtrip-report.json` committed and `/roundtrip` renders it
- [ ] `docs/app/Route/RoundtripHarness.elm` is NOT committed (gitignored)
```
