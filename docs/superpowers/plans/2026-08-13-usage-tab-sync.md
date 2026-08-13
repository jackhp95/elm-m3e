# Usage Tab Sync Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace per-example `Dict Int Surface` tab state in `Doc/Usage.elm` with one page-wide `activeSurface : Surface`, persisted to localStorage under its own key, so switching any example's layer tab switches all examples on the page — and survives reloads and page navigation.

**Architecture:** `Doc.Usage` becomes a port module with its own `storeSurface`/`readSurface` port pair (mirroring `Theme.Ports`). `Route.Components.Name_.elm` (the sole owner of `Usage.Model`) gains a `SurfaceLoaded Decode.Value` msg, a subscription, and wires `Effect.fromCmd` for the store port. `index.ts` registers the two port handlers under a separate `SURFACE_STORAGE_KEY`, matching the existing theme-port pattern exactly. `exampleBlock` resolves the active surface per example using the fallback rule: if `activeSurface` is not in `surfacesFor ex`, use `defaultSurfaceFor ex`.

**Tech Stack:** Elm 0.19, elm-pages 3.x (StatefulRoute / Effect), TypeScript (index.ts port handlers), Playwright browser tests.

---

## Files modified / created

| File | Change |
|---|---|
| `docs/src/Doc/Usage.elm` | Replace `Dict Int Surface` model + port pair + fallback logic |
| `docs/app/Route/Components/Name_.elm` | Wire subscription + SurfaceLoaded msg + Effect.fromCmd |
| `docs/index.ts` | Register `storeSurface` / `readSurface` port handlers |
| `docs/tests-browser/usage.spec.ts` | Update assertions for page-wide model |

---

## Task 1: Rewrite `Doc/Usage.elm` — new model, port pair, fallback

**Files:**
- Modify: `docs/src/Doc/Usage.elm:1-70` (module declaration, imports, Model, Msg, init, update, surfaceTabs, exampleBlock)

### Before (current code being replaced)

Current `Model` / `Msg` / `init` / `update` at lines 55–70:
```elm
type alias Model =
    { surfaces : Dict Int Surface }

type Msg
    = SelectSurface Int Surface

init : Model
init =
    { surfaces = Dict.empty }

update : Msg -> Model -> Model
update (SelectSurface index surface) model =
    { model | surfaces = Dict.insert index surface model.surfaces }
```

Current `exampleBlock` resolve at line 175:
```elm
surface =
    Dict.get index model.surfaces |> Maybe.withDefault (defaultSurfaceFor ex)
```

Current `surfaceTabs` signature and click handler at lines 258–270:
```elm
surfaceTabs : Int -> Surface -> UsageExample -> Element { s | tabs : M3e.Kind.Brand } admittedBy Msg
surfaceTabs index current ex =
    M3e.tabs []
        (List.map
            (\( lbl, surface ) ->
                M3e.tab
                    [ M3e.Attributes.selected (surface == current)
                    , M3e.Events.onClick (SelectSurface index surface)
                    ]
                    [ M3e.text lbl ]
            )
            (surfacesFor ex)
        )
```

- [ ] **Step 1: Change the module declaration to `port module`**

Replace the first line of `docs/src/Doc/Usage.elm`:

```elm
port module Doc.Usage exposing
    ( Model
    , Msg
    , Surface
    , UsageExample
    , init
    , storeSurface
    , readSurface
    , update
    , usageBlocks
    , usageExampleDecoder
    )
```

- [ ] **Step 2: Update imports — add Json.Encode, remove Dict**

Replace the import block (lines 12–26) with:

```elm
import Doc
import Doc.Slider
import Json.Decode as Decode
import Json.Encode as Encode
import M3e exposing (Element)
import M3e.Attributes
import M3e.Component.Heading
import M3e.Events
import M3e.Kind
import M3e.Values as Value
import TypedHtml
import TypedHtml.Attributes as TA
import TypedHtml.Grouping
import TypedHtml.Kind
```

(Remove `import Dict exposing (Dict)` — it is no longer needed.)

- [ ] **Step 3: Replace Model, Msg, init, update, and add port declarations**

Replace lines 50–70 (the `Model` type alias through `update`) with:

```elm
{-| Page-wide surface selection. All examples on the page share this single
value. Navigating away and back restores the persisted choice from localStorage.
-}
type alias Model =
    { activeSurface : Surface }


type Msg
    = SelectSurface Surface
    | SurfaceLoaded Decode.Value


init : Model
init =
    { activeSurface = Top }


{-| Persist the selected surface to localStorage via the JS port handler in
`index.ts`. Encode as a plain string — the four constructor names are stable
keys ("Top", "Record", "Build", "Raw").
-}
port storeSurface : Encode.Value -> Cmd msg


{-| On boot, `index.ts` reads localStorage and sends the stored string back in
(or `Encode.null` if absent/private-mode) — `update` decodes it, falling back
to `Top` on decode failure or absence.
-}
port readSurface : (Decode.Value -> msg) -> Sub msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SelectSurface surface ->
            ( { model | activeSurface = surface }
            , storeSurface (Encode.string (surfaceToString surface))
            )

        SurfaceLoaded value ->
            let
                decoded : Surface
                decoded =
                    Decode.decodeValue Decode.string value
                        |> Result.andThen surfaceFromString
                        |> Result.withDefault Top
            in
            ( { model | activeSurface = decoded }, Cmd.none )


surfaceToString : Surface -> String
surfaceToString surface =
    case surface of
        Top ->
            "Top"

        Record ->
            "Record"

        Build ->
            "Build"

        Raw ->
            "Raw"


surfaceFromString : String -> Result String Surface
surfaceFromString s =
    case s of
        "Top" ->
            Ok Top

        "Record" ->
            Ok Record

        "Build" ->
            Ok Build

        "Raw" ->
            Ok Raw

        _ ->
            Err ("Unknown surface: " ++ s)
```

- [ ] **Step 4: Update `usageBlocks` — drop `offset` parameter (index no longer needed)**

`usageBlocks` currently takes `offset : Int` to give each example a unique index key. That is only needed for `Dict Int Surface`. Remove it.

Replace lines 117–135 with:

```elm
usageBlocks : Model -> List UsageExample -> List (Element (TypedHtml.Grouping.DivIs s) adm_ Msg)
usageBlocks model examples =
    case examples of
        [] ->
            []

        _ ->
            [ TypedHtml.div [ TA.class "space-y-6" ]
                (M3e.heading
                    [ M3e.Component.Heading.variant Value.headline
                    , M3e.Component.Heading.size Value.small
                    , M3e.Attributes.level 2
                    , M3e.Attributes.id (Doc.slugify "Usage")
                    ]
                    [ M3e.text "Usage" ]
                    :: List.concatMap (sectionBlock model)
                        (groupBySection examples)
                )
            ]
```

- [ ] **Step 5: Update `sectionBlock` — drop the index tuple, pass plain `UsageExample`**

Replace lines 142–160:

```elm
sectionBlock : Model -> ( String, List UsageExample ) -> List (Element { a | card : M3e.Kind.Brand, sharedFlow : TypedHtml.Kind.Shared, heading : M3e.Kind.Brand, tabs : M3e.Kind.Brand } admittedBy Msg)
sectionBlock model ( sec, examples ) =
    let
        headingEl : List (Element { s | heading : M3e.Kind.Brand, card : M3e.Kind.Brand, tabs : M3e.Kind.Brand } admittedBy Msg)
        headingEl =
            if sec == "" then
                []

            else
                [ M3e.heading
                    [ M3e.Component.Heading.variant Value.title
                    , M3e.Component.Heading.size Value.large
                    , M3e.Attributes.level 3
                    , M3e.Attributes.id (Doc.slugify sec)
                    ]
                    [ M3e.text sec ]
                ]
    in
    headingEl ++ List.map (exampleBlock model) examples
```

- [ ] **Step 6: Update `exampleBlock` — use page-wide `activeSurface` with fallback**

Replace lines 170–184:

```elm
{-| A live preview paired with a per-example tab strip. The global
`model.activeSurface` is used when that surface is offered by this example;
otherwise falls back to `defaultSurfaceFor ex` (the example's own first-offered
surface — a static, per-example default, not a distance ranking).
-}
exampleBlock : Model -> UsageExample -> Element (TypedHtml.Grouping.DivIs s) adm_ Msg
exampleBlock model ex =
    let
        offered : List Surface
        offered =
            List.map Tuple.second (surfacesFor ex)

        surface : Surface
        surface =
            if List.member model.activeSurface offered then
                model.activeSurface

            else
                defaultSurfaceFor ex
    in
    TypedHtml.div [ TA.class "space-y-3" ]
        [ TypedHtml.p [ TA.class "max-w-2xl text-body-md text-on-surface-variant" ] [ M3e.text ex.title ]
        , Doc.showcase (Doc.rawPreview ex.html)
        , surfaceTabs surface ex
        , Doc.Slider.slidingPanels
            (activeIndexFor surface ex)
            (List.map (\( _, l ) -> codeFor l ex) (surfacesFor ex))
        ]
```

- [ ] **Step 7: Update `surfaceTabs` — drop `index` argument**

Replace lines 258–270:

```elm
surfaceTabs : Surface -> UsageExample -> Element { s | tabs : M3e.Kind.Brand } admittedBy Msg
surfaceTabs current ex =
    M3e.tabs []
        (List.map
            (\( lbl, surface ) ->
                M3e.tab
                    [ M3e.Attributes.selected (surface == current)
                    , M3e.Events.onClick (SelectSurface surface)
                    ]
                    [ M3e.text lbl ]
            )
            (surfacesFor ex)
        )
```

- [ ] **Step 8: Update `groupBySection` — remove index tuples**

The existing `groupBySection` takes `List ( Int, UsageExample )` and returns `List ( String, List ( Int, UsageExample ) )`. Now that there are no per-example indices, rewrite it to work on plain `List UsageExample`:

Replace lines 349–365:

```elm
{-| Group examples by `.section`, preserving first-seen order of both
sections and examples within each section.
-}
groupBySection : List UsageExample -> List ( String, List UsageExample )
groupBySection examples =
    let
        sections : List String
        sections =
            List.foldl
                (\ex acc ->
                    if List.member ex.section acc then
                        acc

                    else
                        acc ++ [ ex.section ]
                )
                []
                examples
    in
    List.map (\sec -> ( sec, List.filter (\ex -> ex.section == sec) examples )) sections
```

- [ ] **Step 9: elm-format**

```bash
cd /Users/jack/Documents/code/elm-m3e/docs && node_modules/.bin/elm-format src/Doc/Usage.elm --yes
```

Expected: no output (formats in place, exits 0).

- [ ] **Step 10: Commit**

```bash
cd /Users/jack/Documents/code/elm-m3e && git add docs/src/Doc/Usage.elm && git commit -m "refactor(usage): page-wide activeSurface + port pair; drop per-example Dict"
```

---

## Task 2: Update `Route/Components/Name_.elm` — wire subscription and Effect

**Files:**
- Modify: `docs/app/Route/Components/Name_.elm` (full file, particularly `Model`, `Msg`, `update`, `subscriptions`, `view`)

The current file has:
- `type alias Model = Usage.Model` — stays, but `Usage.Model` shape changed
- `type alias Msg = Usage.Msg` — stays, but `Usage.Msg` shape changed (SurfaceLoaded added, SelectSurface arity changed)
- `update` returns `( Usage.update msg model, Effect.none )` — needs `Effect.fromCmd` for `storeSurface`
- `subscriptions _ _ _ _ = Sub.none` — needs `Usage.readSurface Usage.SurfaceLoaded`
- `view` calls `Usage.usageBlocks 0 model app.data.usage` — drop the `0` (offset removed)

- [ ] **Step 1: Update `update` to handle `Cmd`**

Replace lines 74–77:

```elm
update : App Data ActionData RouteParams -> Shared.Model -> Msg -> Model -> ( Model, Effect Msg )
update _ _ msg model =
    let
        ( newModel, cmd ) =
            Usage.update msg model
    in
    ( newModel, Effect.fromCmd cmd )
```

- [ ] **Step 2: Add port subscription**

Replace lines 79–81:

```elm
subscriptions : RouteParams -> UrlPath -> Shared.Model -> Model -> Sub Msg
subscriptions _ _ _ _ =
    Usage.readSurface Usage.SurfaceLoaded
```

- [ ] **Step 3: Update `view` — drop `0` offset from `usageBlocks` call**

At line 130, change:

```elm
-- BEFORE
Usage.usageBlocks 0 model app.data.usage

-- AFTER
Usage.usageBlocks model app.data.usage
```

- [ ] **Step 4: elm-format**

```bash
cd /Users/jack/Documents/code/elm-m3e/docs && node_modules/.bin/elm-format app/Route/Components/Name_.elm --yes
```

- [ ] **Step 5: Commit**

```bash
cd /Users/jack/Documents/code/elm-m3e && git add docs/app/Route/Components/Name_.elm && git commit -m "feat(name-route): wire Usage port subscription and Effect.fromCmd"
```

---

## Task 3: Register port handlers in `docs/index.ts`

**Files:**
- Modify: `docs/index.ts` — add `SURFACE_STORAGE_KEY`, `storeSurface` subscriber, `readSurface` send (after the theme boot send, following the same pattern)

The current `app` type annotation at line 263 covers only theme-related ports. The new ports must be added there too, or TypeScript will give a type error when accessing them.

- [ ] **Step 1: Add `SURFACE_STORAGE_KEY` constant**

After line 259 (`const THEME_STORAGE_KEY = "m3e-theme-state";`), add:

```typescript
const SURFACE_STORAGE_KEY = "m3e-docs-active-surface";
```

- [ ] **Step 2: Extend the `app` type annotation**

Inside the `app` type annotation (starting at line 263), add two port entries alongside the existing ones:

```typescript
const app = (await elmLoaded) as {
  ports?: {
    storeThemeState?: { subscribe: (cb: (v: unknown) => void) => void };
    readThemeState?: { send: (v: unknown) => void };
    setCssOverride?: {
      subscribe: (cb: (v: { property: string; value: string }) => void) => void;
    };
    setFaviconColor?: { subscribe: (cb: (v: string) => void) => void };
    loadFonts?: { subscribe: (cb: (v: string) => void) => void };
    loadSpecimenFonts?: { subscribe: (cb: (v: string[]) => void) => void };
    setIconVariant?: { subscribe: (cb: (v: string) => void) => void };
    requestPreset?: { subscribe: (cb: (v: string) => void) => void };
    onPresetRequested?: { send: (v: string) => void };
    onOpenSearchRequested?: { send: (v: null) => void };
    // Usage surface persistence
    storeSurface?: { subscribe: (cb: (v: unknown) => void) => void };
    readSurface?: { send: (v: unknown) => void };
  };
};
```

- [ ] **Step 3: Add `storeSurface` subscribe handler**

After the `storeThemeState` block (around line 296), add:

```typescript
// Persist the docs-layer surface selection so switching layer tabs on one
// component page carries over to every other component page (site-wide,
// not page-scoped). Stored separately from the theme blob: this is a
// docs-navigation preference, not a visual theme setting.
app?.ports?.storeSurface?.subscribe((surface: unknown) => {
  try {
    window.localStorage.setItem(SURFACE_STORAGE_KEY, JSON.stringify(surface));
  } catch (_) {
    /* localStorage unavailable (private mode / SSR) — ignore */
  }
});
```

- [ ] **Step 4: Add `readSurface` boot send**

After the `readThemeState` boot send (around line 475), add:

```typescript
// Boot: send back the persisted surface string (or null if absent).
// `Doc.Usage.update` decodes it, falling back to `Top` on null/bad value.
try {
  const rawSurface = window.localStorage.getItem(SURFACE_STORAGE_KEY);
  app?.ports?.readSurface?.send(rawSurface ? JSON.parse(rawSurface) : null);
} catch (_) {
  app?.ports?.readSurface?.send(null);
}
```

- [ ] **Step 5: Commit**

```bash
cd /Users/jack/Documents/code/elm-m3e && git add docs/index.ts && git commit -m "feat(index.ts): register storeSurface/readSurface port handlers"
```

---

## Task 4: Build check

- [ ] **Step 1: Run `build:site`**

```bash
cd /Users/jack/Documents/code/elm-m3e/docs && npm run build:site
```

Expected: exits 0. If Elm compiler errors appear, they will be type errors from callers of `usageBlocks` (only `Name_.elm` calls it), from the `Msg` pattern match shape change, or from the changed `update` return type. Fix any errors before moving on.

**Common failure modes to watch for:**
- `usageBlocks` called with old 3-arg form `(offset, model, examples)` somewhere else — grep for `usageBlocks` to confirm `Name_.elm` is the only call site.
- `Usage.update` return type changed from `Model` to `( Model, Cmd Msg )` — any other caller that does `Usage.update msg model` without destructuring will fail to compile.
- `SelectSurface` pattern match in `update` — the old `SelectSurface Int Surface` becomes `SelectSurface Surface`; if any other file pattern-matches on this, it will fail.

```bash
cd /Users/jack/Documents/code/elm-m3e/docs && grep -r "usageBlocks\|SelectSurface\|Usage\.update" app/ --include="*.elm"
```

---

## Task 5: Update browser tests — `docs/tests-browser/usage.spec.ts`

The existing test file (`docs/tests-browser/usage.spec.ts`) has two tests. Neither test currently clicks a layer tab or asserts per-example tab independence — the tests assert code *presence* and that the "M3e" tab is visible. The page-wide model change does not break these assertions. However, the spec requires updating the tests to reflect and verify the new page-wide behavior.

**Current assertions that remain valid unchanged:**
- `page.getByText("Usage", { exact: true })` — still valid
- `page.getByText("M3e.Button.view").first()` code presence — still valid
- `page.getByText("M3e", { exact: true })` tab visible — still valid
- `details.cf-fold` fold assertions — unaffected

**New test to add:** A third test that verifies page-wide sync: clicking a tab on one example updates all examples on the page.

- [ ] **Step 1: Add the page-wide sync test**

Append to `docs/tests-browser/usage.spec.ts`:

```typescript
test("/components/button Usage tab sync: clicking a tab updates all examples", async ({
  page,
}) => {
  await page.goto("/components/button");

  // Wait for the first Usage tab strip to appear and be interactive.
  // NOTE: The docs DEV server (:1234) does NOT wire Elm event listeners onto
  // SSR-hydrated <m3e-*> nodes. This test MUST run against the PROD build
  // served at :1239 (gate), never the dev server. Interactivity failures on
  // :1234 are false negatives, not bugs.
  await page.waitForFunction(() =>
    [...document.querySelectorAll("code.elmsh")].some((c) =>
      (c.textContent || "").includes("M3e.Button.view"),
    ),
  );

  // Locate ALL tab strips rendered by surfaceTabs. Each strip is an <m3e-tabs>
  // element. If the button component has multiple Usage examples, there will be
  // multiple strips.
  const tabStrips = page.locator("m3e-tabs");
  const count = await tabStrips.count();

  // The button component has at least one Usage example; skip this test if
  // somehow none render (data pipeline issue, not a tab-sync issue).
  if (count < 1) {
    return;
  }

  // Click the "HTML" tab on the FIRST strip. "HTML" (Raw surface) is always
  // offered and is not the default, so this always represents a real change.
  await tabStrips.first().getByText("HTML", { exact: true }).click();

  // After clicking, every tab strip should show "HTML" as selected. In
  // <m3e-tabs>/<m3e-tab>, the selected tab carries `selected` attribute.
  // Assert that no strip still has "M3e" tab selected (i.e. none have
  // <m3e-tab selected> containing "M3e" text).
  //
  // We use page.evaluate to inspect shadow DOM state, since Playwright
  // locators don't pierce shadow roots for attribute checks.
  await page.waitForFunction(() => {
    const strips = [...document.querySelectorAll("m3e-tabs")];
    if (strips.length < 2) return true; // Only one example — sync trivially holds
    return strips.every((strip) => {
      const tabs = [...strip.querySelectorAll("m3e-tab")];
      const selected = tabs.find((t) => t.hasAttribute("selected"));
      return selected?.textContent?.trim() === "HTML";
    });
  });

  // Verify persistence: the selection must survive a reload.
  await page.reload();
  await page.waitForFunction(() =>
    [...document.querySelectorAll("code.elmsh")].some((c) =>
      (c.textContent || "").includes("<m3e-button"),
    ),
  );

  // After reload, at least one tab strip must show HTML as the active tab.
  const htmlTabActive = await page.evaluate(() => {
    const strips = [...document.querySelectorAll("m3e-tabs")];
    return strips.some((strip) => {
      const tabs = [...strip.querySelectorAll("m3e-tab")];
      const selected = tabs.find((t) => t.hasAttribute("selected"));
      return selected?.textContent?.trim() === "HTML";
    });
  });
  expect(htmlTabActive).toBe(true);
});
```

- [ ] **Step 2: Commit the test update**

```bash
cd /Users/jack/Documents/code/elm-m3e && git add docs/tests-browser/usage.spec.ts && git commit -m "test(usage): add page-wide tab sync + persistence browser test"
```

---

## Task 6: Run browser tests against PROD build

**IMPORTANT — DEV SERVER CAVEAT:** The docs dev server (`:1234`, HMR) does NOT wire Elm event listeners onto SSR-hydrated `<m3e-*>` nodes (`elmFs` unset). Any interactivity test run against `:1234` will silently fail — tab clicks appear to do nothing. Always run browser tests against the PROD build at `:1239`. This is a known gotcha (see memory: `elm-pages-dev-server-hydration-gotcha`). The `test:browser` script's `pretest:browser` hook kills `:1239` before launching the gate server.

- [ ] **Step 1: Start the PROD gate server in the background**

```bash
cd /Users/jack/Documents/code/elm-m3e/docs && node scripts/serve-dist.mjs dist &
```

This starts the built site at `:1239`. Wait ~2 seconds for it to be ready.

- [ ] **Step 2: Run Playwright tests**

```bash
cd /Users/jack/Documents/code/elm-m3e/docs && npx playwright test tests-browser/usage.spec.ts --reporter=list
```

Expected: all 3 tests pass.

If the new sync test fails:
- Check that `storeSurface` / `readSurface` appear in `app.ports` at runtime — add a `console.log(Object.keys(app?.ports ?? {}))` temporarily to `index.ts` and re-build to verify.
- A port declared in a `port module` but whose subscription is never activated (no `Sub` wired) means `readSurface` will have no subscriber and the send is silently dropped. Verify `subscriptions` in `Name_.elm` returns `Usage.readSurface Usage.SurfaceLoaded`.

- [ ] **Step 3: Kill the gate server**

```bash
lsof -ti:1239 | xargs kill -9 2>/dev/null; true
```

---

## Task 7: Manual verification checklist

Run these manually against the PROD build at `:1239` (NOT the dev server — see caveat above):

- [ ] On `/components/button` (which has multiple Usage examples): click the `HTML` tab on any example. Confirm every other example's tab strip updates to `HTML` simultaneously.
- [ ] Reload the page. Confirm the `HTML` tab is still selected across all examples (persisted via localStorage under key `m3e-docs-active-surface`).
- [ ] Navigate to `/components/icon` or any other component page. Confirm the layer selection carries over (site-wide, not page-scoped).
- [ ] Find a component where not all examples offer all surfaces (e.g. a composite with no `Top` form — it will lack `M3e`/`el`/`build` tabs). With `activeSurface = Top` set globally, confirm that example shows its own first-offered surface (e.g. `HTML`), NOT `Top`.
- [ ] Verify that `surfacesFor` is unchanged by reading its output in the browser: the set of offered tabs per example must match what was there before this change.

---

## Task 8: Rebuild docs output and final commit

Per the memory note `feedback: rebuild+commit docs app before push`: the `docs/.elm-pages/` build output is tracked. Rebuild and commit it before pushing.

- [ ] **Step 1: Rebuild site**

```bash
cd /Users/jack/Documents/code/elm-m3e/docs && npm run build:site
```

- [ ] **Step 2: Stage and commit tracked build output**

```bash
cd /Users/jack/Documents/code/elm-m3e && git add docs/.elm-pages/ && git commit -m "chore(docs): rebuild .elm-pages output after usage tab sync"
```

Note: `docs/.elm-pages/Pages.elm` contains a nondeterministic `builtAt` timestamp — this is expected and is NOT a sign of a bad diff. Commit it anyway per the established pattern.
