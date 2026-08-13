# Implementation Plan — Theme Drawer Redesign (11 sub-changes)

Spec: `specs/2026-08-13-theme-drawer-redesign-design.md`
Date: 2026-08-13
Repo: `elm-m3e` (docs app: Elm + elm-pages)

## Goal

Rework the theme drawer's controls into their right-sized shapes: shared stepper→form-field
widget, variant segmented→menu, scheme 3→2 toggle, direction→icon toggle, one shared
variant/scheme/direction row with a scoped reset, source-color flex-wrap→snap-scroll,
Typography preview removal, Color 37 tokens→chips-with-menu, labeled Appearance rows, an
Advanced description line, and a new CSS Variables 6th accordion panel. No persisted-state
shape change beyond representing the new control values; no `type Button` work; no
`/theme-editor` route; Advanced's 19 curated tokens stay separate from CSS Variables.

## Architecture

Import graph (rigid, Elm rejects cycles): `Shared.elm` → `Theme.elm` → `Theme.Sections.*`.
Sections import `Theme` for `Model`/`Msg`; `Theme.elm` CANNOT import sections (would cycle),
so `Shared.elm` (above both) assembles each `section.view model` and threads the results into
`Theme.view` via the `sectionsEl` record field. Any helper a section needs (`segmented`,
`capitalize`, and now `controlLabel`) must live in `Theme.elm`, never `Shared.elm`.

Persisted state is unchanged: `Theme.Ports.encode`/`decoder` already round-trip `scheme`,
`variant`, `dir` (via `Shared`), `colorOverrides`, `cssOverrides`. New controls only change
RENDERING of existing model fields (§2/§3/§4/§8) plus one possible new `Msg`
(`UnsetCssOverride`, §11 — see fork). Direction lives in `Shared.Model.dir`, not `Theme.Model`.

CSS-var constraint (drives §8/§11 design): **Elm cannot set a CSS custom property directly**
(`Shared.elm:928-930` comment). All var writes go through the `Theme.Ports.setCssOverride`
port. There is no read-back of a *computed* var, so an UNset color chip shows a neutral
placeholder (outline ring, no fill), never a live-resolved color.

DEV-server caveat (bake into every manual-test step): the docs dev server (`:1234`, HMR) does
NOT wire Elm event listeners onto SSR-hydrated `<m3e-*>` nodes — interactivity is a false
negative there. **Verify all interactivity against the PROD build / gate (`:1239`), never dev.**

## Tech Stack

- Elm 0.19 (docs app under `docs/app/`), elm-pages, `@m3e/web` custom elements.
- `M3e.*` barrel (`src/M3e.elm`) + per-component `M3e.Component.*`.
- Format: `docs/node_modules/.bin/elm-format --yes <file>` after EVERY `.elm` edit.
- Build: `npm run build:site` (run from `docs/`).
- Browser regression: `docs/tests-browser/settings-sheet.spec.ts` (Playwright, against prod build).

## Component-API reality checks (done — read before executing)

- **Chip icon slot** (`src/M3e/Internal/Types/Chip.elm`): `IconSlot = { sharedIcon : Shared }`.
  It does NOT admit the `avatar`/`theme` brands. §8's "reuse nested-`<m3e-theme>` avatar in the
  chip icon slot" is a **type error** — the inline-styled circle branch is REQUIRED, not optional.
- **Menu triggering** (`src/M3e/Component/Menu.elm`, `MenuTrigger.elm`): `menu` has no
  `open`/`for`; wiring is `menuTrigger [ MenuTrigger.for "id" ]` next to `menu [ M3e.Attributes.id "id" ]`.
  There is **no existing `M3e.menu` usage in `docs/app/`** — the only proven picker is
  `M3e.select`/`M3e.option` (`Typography.elm:41-63`, value read via `M3e.Events.onChangeWith`).
  → §2 and §11's token menu use `select`/`option` (low-risk). §8's chip value-entry uses a real
  `menu` (needs per-item click actions, not a value-select) — the one place the `menu` family is
  genuinely required; fall back to an inline expand if `menu` wiring proves flaky.

---

## Task 1 — §1 Shared stepper → form-field widget

Foundational: §1 propagates to Shape, Typography, Advanced. Keep `numberStepper`'s signature
`String -> Float -> Float -> (Float -> msg) -> Element ...` IDENTICAL so all three call sites
(`Shared.stepperControls`, `Advanced.durationRow`/`opacityRow`) keep compiling untouched. Only
the body changes: label + editable text input holding the current value + trailing −/+ icon
buttons. Typing commits on blur/enter, parsed like the buttons step; invalid text falls back to
the last valid value (achieved by: on invalid parse, emit no msg — the model keeps its value, and
the input re-renders to that value on the next frame).

File: `docs/app/Theme/Sections/Shared.elm`

BEFORE (`:67-82`):
```elm
numberStepper : String -> Float -> Float -> (Float -> msg) -> Element (TypedHtml.Grouping.DivIs s) admittedBy msg
numberStepper labelText current step toMsg =
    TypedHtml.div [ TypedHtml.Attributes.class "flex items-center gap-1" ]
        [ M3e.text labelText
        , M3e.iconButton
            [ TypedHtml.Events.onClick (toMsg (current - step))
            , Aria.label ("Decrease " ++ labelText)
            ]
            [ M3e.icon [ M3e.Component.Icon.name "remove" ] [] ]
        , M3e.text (String.fromFloat current)
        , M3e.iconButton
            [ TypedHtml.Events.onClick (toMsg (current + step))
            , Aria.label ("Increase " ++ labelText)
            ]
            [ M3e.icon [ M3e.Component.Icon.name "add" ] [] ]
        ]
```

AFTER (label above, editable input, trailing −/+ pair — the common M3 stepper-field layout):
```elm
numberStepper : String -> Float -> Float -> (Float -> msg) -> Element (TypedHtml.Grouping.DivIs s) admittedBy msg
numberStepper labelText current step toMsg =
    let
        inputId : String
        inputId =
            "stepper-" ++ (labelText |> String.toLower |> String.replace " " "-" |> String.filter Char.isAlphaNum)

        commit : String -> msg
        commit raw =
            -- Invalid text falls back to the last valid value: re-emit `current`
            -- so the model (and thus the re-rendered input) snaps back unchanged.
            toMsg (String.toFloat (String.trim raw) |> Maybe.withDefault current)
    in
    TypedHtml.div [ TypedHtml.Attributes.class "flex flex-col gap-1" ]
        [ TypedHtml.label
            [ TypedHtml.Attributes.for inputId
            , TypedHtml.Attributes.class "text-on-surface-variant"
            ]
            [ M3e.text labelText ]
        , TypedHtml.div [ TypedHtml.Attributes.class "flex items-center gap-1" ]
            [ TypedHtml.input
                [ TypedHtml.Attributes.id inputId
                , TypedHtml.Attributes.type_ "text"
                , TypedHtml.Attributes.value (String.fromFloat current)
                , TypedHtml.Events.onBlur (commit (String.fromFloat current))
                , TypedHtml.Events.onInput commit
                , TypedHtml.Attributes.class "w-20 rounded border border-outline bg-transparent px-2 py-1 text-on-surface"
                , Aria.label labelText
                ]
                []
            , M3e.iconButton
                [ TypedHtml.Events.onClick (toMsg (current - step))
                , Aria.label ("Decrease " ++ labelText)
                ]
                [ M3e.icon [ M3e.Component.Icon.name "remove" ] [] ]
            , M3e.iconButton
                [ TypedHtml.Events.onClick (toMsg (current + step))
                , Aria.label ("Increase " ++ labelText)
                ]
                [ M3e.icon [ M3e.Component.Icon.name "add" ] [] ]
            ]
        ]
```

Notes / forks:
- Add `import Char` and confirm `TypedHtml.Events.onBlur` exists — if the `TypedHtml.Events`
  surface has no `onBlur`, drop it and rely on `onInput commit` alone (every keystroke commits;
  the fallback-to-current still holds on invalid). Grep `TypedHtml/Events.elm` for `onBlur` first.
- `onInput commit` firing per-keystroke is acceptable (each valid keystroke is a legal value; the
  buttons still step by the fixed increment). This preserves the exact `(Float -> msg)` contract,
  so Shape/Typography/Advanced call sites need ZERO changes and stay compiling.

Commands:
```
docs/node_modules/.bin/elm-format --yes docs/app/Theme/Sections/Shared.elm
cd docs && npm run build:site
```
Increment check: builds green; Shape/Typography/Advanced steppers now render as editable fields.

---

## Task 2 — §9 relocate `controlLabel` into `Theme.elm` (foundational for §9/§10/§11)

`controlLabel` currently lives in `Shared.elm:905-909`. Sections can't import `Shared`, so move it
to `Theme.elm` next to the already-ported `segmented`/`capitalize` helpers, expose it, and have
`Shared.elm` call `Theme.controlLabel`. This unblocks §9 (Appearance labels), §10, §11.

File: `docs/app/Theme.elm`

1. Add `controlLabel` to the exposing list (line 1):
```elm
module Theme exposing (Model, Msg(..), TypeScaleParam(..), capitalize, controlLabel, init, segmented, subscriptions, update, view)
```
2. Add the function (after `capitalize`, ~line 538). `Msg` here is `Theme.Msg`, but `controlLabel`
   produces no events, so make it msg-polymorphic so `Shared.elm` can use it under its own `Msg`:
```elm
{-| A small label heading above a control. Relocated from `Shared.elm` — sections
(`Theme.Sections.*`) can't import `Shared` (it sits ABOVE `Theme` in the import
graph), so this lives alongside `segmented`/`capitalize`, the same relocation
pattern used when the drawer was split out. msg-polymorphic so both `Theme` and
`Shared` render it under their own `Msg`.
-}
controlLabel : String -> Element { s | heading : M3e.Kind.Brand } admittedBy msg
controlLabel lbl =
    M3e.heading
        [ M3e.Attributes.variant Value.label, M3e.Attributes.size Value.large, TypedHtml.Attributes.class "text-on-surface" ]
        [ M3e.text lbl ]
```
   (`M3e.Attributes`, `M3e.Kind`, `Value`, `TypedHtml.Attributes` are all already imported in `Theme.elm`.)

File: `docs/app/Shared.elm`
3. DELETE the local `controlLabel` (`:905-909`).
4. Update its call site (`:900`) to `Theme.controlLabel "Directionality"` (note: this line is
   superseded by §5's row assembly in Task 6 — but make it compile now).

Commands:
```
docs/node_modules/.bin/elm-format --yes docs/app/Theme.elm docs/app/Shared.elm
cd docs && npm run build:site
```

---

## Task 3 — §9 Appearance: label the three segmented rows + §10 Advanced description

Both are trivial once `Theme.controlLabel` exists. Group together (both are section-view edits,
each independently compiling).

File: `docs/app/Theme/Sections/Appearance.elm`

BEFORE (`:12-18`):
```elm
view : Theme.Model -> Element (TypedHtml.Grouping.DivIs s) admittedBy Msg
view model =
    TypedHtml.div [ TypedHtml.Attributes.class "flex flex-col gap-3" ]
        [ contrastSegmented model
        , motionSegmented model
        , densitySegmented model
        ]
```
AFTER:
```elm
view : Theme.Model -> Element (TypedHtml.Grouping.DivIs s) admittedBy Msg
view model =
    TypedHtml.div [ TypedHtml.Attributes.class "flex flex-col gap-3" ]
        [ TypedHtml.div [ TypedHtml.Attributes.class "flex flex-col gap-1" ]
            [ Theme.controlLabel "Contrast", contrastSegmented model ]
        , TypedHtml.div [ TypedHtml.Attributes.class "flex flex-col gap-1" ]
            [ Theme.controlLabel "Motion", motionSegmented model ]
        , TypedHtml.div [ TypedHtml.Attributes.class "flex flex-col gap-1" ]
            [ Theme.controlLabel "Density", densitySegmented model ]
        ]
```
(`Theme` is already imported; `controlLabel` is msg-polymorphic so it unifies with `Msg` here.)

File: `docs/app/Theme/Sections/Advanced.elm`

Add a description line at the top of `view` (`:23-30`):
```elm
view : Theme.Model -> Element (TypedHtml.Grouping.DivIs s) admittedBy Msg
view model =
    TypedHtml.div [ TypedHtml.Attributes.class "flex flex-col gap-3" ]
        [ TypedHtml.p [ TypedHtml.Attributes.class "text-on-surface-variant text-sm" ]
            [ M3e.text "Motion durations and state-layer opacities — raw CSS custom property overrides for the 16 transition-timing tokens and 3 interaction-state opacity tokens @m3e/web exposes." ]
        , TypedHtml.div [ TypedHtml.Attributes.class "flex flex-col gap-2" ]
            (List.map (durationRow model) Tokens.motionDurationTokens)
        , TypedHtml.div [ TypedHtml.Attributes.class "flex flex-col gap-2" ]
            (List.map (opacityRow model) Tokens.stateOpacityTokens)
        ]
```
(Confirm `TypedHtml.p` is exposed; if not, use `TypedHtml.div` with the same classes.)

Commands:
```
docs/node_modules/.bin/elm-format --yes docs/app/Theme/Sections/Appearance.elm docs/app/Theme/Sections/Advanced.elm
cd docs && npm run build:site
```

---

## Task 4 — §7 Typography: drop the live preview

File: `docs/app/Theme/Sections/Typography.elm`

1. Remove `preview model` from the `view` list (`:31`) so `view` ends at `Shared.stepperControls ...`.
2. DELETE the `preview` function (`:66-76`).
3. Prune now-unused imports: `Theme.Scale as Scale`, `Theme.Tokens as Tokens` (verify neither is
   used elsewhere in the file after deletion — they were only used by `preview`). Elm's compiler
   flags unused imports as errors, so this is forced.

Commands:
```
docs/node_modules/.bin/elm-format --yes docs/app/Theme/Sections/Typography.elm
cd docs && npm run build:site
```

---

## Task 5 — §2 Variant segmented → menu; §3 Scheme 3→2 toggle; §6 source-color snap-scroll

All three are `Theme.elm` rendering swaps that keep existing `Msg`s. Group them: each is a
self-contained function edit, and the shared-row assembly (§5) is deferred to Task 6.

File: `docs/app/Theme.elm`

### §6 source-color container class (lowest risk, do first)
BEFORE (`:689`):
```elm
        , TypedHtml.div [ TypedHtml.Attributes.class "flex flex-wrap items-center gap-2" ]
            (sourceColorOption model :: List.map (colorAvatar model) curatedSwatchColors)
```
AFTER (reuse `Theme.Reel`'s exact snap-scroll class list, confirmed `Reel.elm:83`):
```elm
        , TypedHtml.div [ TypedHtml.Attributes.class "flex gap-3 overflow-x-auto snap-x snap-mandatory items-center" ]
            (sourceColorOption model :: List.map (colorAvatar model) curatedSwatchColors)
```
(Add `snap-start` to each avatar's outer div if snapping feels loose — optional polish; the class
list matches Reel's `"flex gap-3 overflow-x-auto snap-x snap-mandatory px-4 py-3"` minus the
padding, which the drawer column already provides.)

### §2 variant → menu (use proven `select`/`option`, not the unproven `menu` family)
Replace `variantSegmented` (`:662-667`) with a `select`. Mirror `Typography.fontSelect` exactly.
```elm
{-| Variant picker: an `m3e-select` of the 9 `themeVariantValues` (was a 9-option
segmented button that overflowed on narrow screens). Selecting fires the existing
`SetVariant` msg — no `Msg`/model change, just the rendering swap. Uses `select`/
`option` (the proven picker; the `menu` family has no existing docs usage and no
clean declarative anchor — see plan's component-API reality check).
-}
variantSelect : Model -> Element (TypedHtml.Grouping.DivIs s) admittedBy Msg
variantSelect model =
    TypedHtml.div [ TypedHtml.Attributes.class "flex flex-col gap-1" ]
        [ controlLabel "Variant"
        , M3e.select
            [ M3e.Attributes.id "variant-select"
            , M3e.Events.onChangeWith
                (Decode.map SetVariant (Decode.at [ "target", "value" ] (Decode.map variantFromWire Decode.string)))
            ]
            (List.map
                (\v ->
                    M3e.option
                        [ M3e.Component.Option.value (Value.toString v)
                        , M3e.Component.Option.selected (model.variant == v)
                        ]
                        [ M3e.text (variantLabelFor v) ]
                )
                themeVariantValues
            )
        ]
```
- Add `variantFromWire = themeVariantFromString` reuse: the option `value` is the wire string
  (`Value.toString v`), and `onChangeWith` must map that back to `Value M3e.Component.Theme.Variant`.
  `themeVariantFromString` (`:611-639`) already does exactly this — reuse it: replace
  `(Decode.map variantFromWire Decode.string)` with `(Decode.map themeVariantFromString Decode.string)`.
- New imports in `Theme.elm`: `import M3e.Component.Option`, `import M3e.Events` (confirm — `M3e.Events`
  is already imported; add `M3e.Component.Option`). `Json.Decode as Decode` is already imported.

### §3 scheme → 2-option Light/Dark toggle
Replace `schemeSegmented` (`:546-552`) with a 2-option segmented (Light/Dark only). `Value.auto`
("System") is no longer directly selectable — reachable only via §5's row reset.
```elm
{-| Scheme toggle: only Light/Dark (was 3-option Light/System/Dark). `Value.auto`
("System", the default) is no longer directly selectable — reachable only via the
row reset (§5). When `model.scheme == Value.auto`, NEITHER segment reads checked
(both `== Value.auto` is False), which is the intended "unresolved" visual —
`M3e.segmentedButton` renders every segment `aria-checked="false"`.
-}
schemeToggle : Model -> Element { s | segmentedButton : M3e.Kind.Brand } admittedBy Msg
schemeToggle model =
    segmented
        [ ( "Light", model.scheme == Value.light, SetScheme Value.light )
        , ( "Dark", model.scheme == Value.dark, SetScheme Value.dark )
        ]
```
- **Fork (§3 checked-state when auto):** RECOMMENDED = "both unchecked" (above — simplest, and
  `segmented`'s `M3e.Attributes.checked False` on both is valid). FALLBACK if a bare toggle widget
  is preferred later: resolve the OS/document scheme to seed the initial visual read without firing
  `SetScheme`; skip unless design objects to the blank state.
- Confirm `Value.light`/`Value.dark` exist (they do — `Value.schemeValues` feeds the old control).
- Delete now-dead `schemeOrder`/`schemeLabel` if nothing else references them (grep first — they
  were only used by `schemeSegmented`). Elm will error on unused; remove them.

### Update `Theme.view` body
BEFORE (`:822-824`):
```elm
        [ colorOptions model |> HtmlIr.Element.map toMsg
        , schemeSegmented model |> HtmlIr.Element.map toMsg
        , variantSegmented model |> HtmlIr.Element.map toMsg
```
AFTER (temporary — Task 6 folds these into one row):
```elm
        [ colorOptions model |> HtmlIr.Element.map toMsg
        , schemeToggle model |> HtmlIr.Element.map toMsg
        , variantSelect model |> HtmlIr.Element.map toMsg
```

Commands:
```
docs/node_modules/.bin/elm-format --yes docs/app/Theme.elm
cd docs && npm run build:site
```

---

## Task 6 — §4 direction icon toggle + §5 shared variant/scheme/direction row with scoped reset

Two sub-decisions (the spec's §5 module-boundary fork). RECOMMENDED branch: **keep direction in
`Shared.Model.dir`**, compose the row in `Shared.elm` importing the three pieces (variant/scheme
from `Theme`, direction assembled locally) — avoids moving `dir` into `Theme.Model` and re-plumbing
`Theme.Ports`. FALLBACK: move `dir` into `Theme.Model` (bigger blast radius, persisted-shape churn) —
only if composing in `Shared` proves awkward.

### §4 direction → single icon toggle button (in `Shared.elm`)
File: `docs/app/Shared.elm`

Replace `directionSegmented` (`:944-960`) with an icon toggle. RTL when `model.dir == rtl`.
```elm
{-| Direction toggle: a single icon button (was a 2-option LTR/RTL segmented). Shows
`format_textdirection_l_to_r` when LTR, `format_textdirection_r_to_l` when RTL;
clicking flips to the other and fires `SetDirection`. `aria-pressed`/`aria-label`
track the current direction.
-}
directionToggle : Model -> Element (M3e.Component.IconButton.Is s) admittedBy Msg
directionToggle model =
    let
        isRtl : Bool
        isRtl =
            TypedHtml.Values.toString model.dir == "rtl"

        ( next, glyph, lbl ) =
            if isRtl then
                ( TypedHtml.Values.ltr, "format_textdirection_l_to_r", "Switch to left-to-right" )

            else
                ( TypedHtml.Values.rtl, "format_textdirection_r_to_l", "Switch to right-to-left" )
    in
    M3e.iconButton
        [ TypedHtml.Events.onClick (SetDirection next)
        , Aria.label lbl
        , Aria.pressed isRtl
        ]
        [ M3e.icon [ M3e.Component.Icon.name glyph ] [] ]
```
- **Fork (§4 icon pair):** the `format_textdirection_l_to_r`/`_r_to_l` glyphs are the recommended
  pair (spec-named). Confirm `TypedHtml.Values.ltr`/`.rtl` constructors exist (they feed
  `dirValues`); if only `dirValues` list exists, pull them from it. Confirm `Aria.pressed` exists in
  `TypedHtml.Aria`; if not, use `M3e.Attributes.attribute "aria-pressed" (...)` or omit (keep `aria-label`).
- Imports: add `M3e.Component.IconButton` (for the `Is` type) and `M3e.Component.Icon` if not present.

### §5 shared row + scoped reset
The row lives in `Shared.settingsSheetContent`. It carries variant (from `Theme.variantSelect`),
scheme (`Theme.schemeToggle`), direction (`directionToggle`), and ONE reset icon button firing all
three resets. But `Theme.view` currently renders scheme+variant itself (Task 5 left them there). Move
them OUT of `Theme.view` and expose them so `Shared` assembles the row.

File: `docs/app/Theme.elm`
1. Expose `variantSelect`, `schemeToggle` (add to module exposing list).
2. Remove `schemeToggle model` and `variantSelect model` from `Theme.view`'s body (Task 5's temp
   lines) — leave only `colorOptions`, the reel, `sectionsEl`, `resetAllButton`.
3. Add a scoped-reset button helper, exposed:
```elm
{-| The variant/scheme/direction row's OWN scoped reset (distinct from the drawer-
wide `resetAllButton`). Fires the three resets together. `restart_alt` matches the
per-token reset icon convention (`Color.elm`). Direction reset is threaded in by the
caller (`Shared`) since `dir` isn't in `Theme.Model`.
-}
controlRowReset : Msg -> Element (M3e.Component.IconButton.Is s) admittedBy Msg
controlRowReset _ =
    -- placeholder: see Shared assembly; kept in Theme only if direction moves here.
    resetAllButton
```
   NOTE: because direction lives in `Shared`, the cleanest form is to assemble the reset in
   `Shared` (it needs both `Theme.SetVariant`/`SetScheme` under `ThemeMsg` AND `Shared.SetDirection`).
   So DO NOT add `controlRowReset` to `Theme`; instead expose nothing new and build the button in
   `Shared`. (Delete the placeholder above — it's shown only to mark the rejected fork.)

File: `docs/app/Shared.elm` — assemble the row in `settingsSheetContent`:
BEFORE (`:886-902`):
```elm
        [ Theme.view
            { dir = model.dir
            , onSetDirection = SetDirection
            , sectionsEl = sectionsAccordion { ... }
            }
            model.theme
            ThemeMsg
        , controlLabel "Directionality"
        , directionSegmented model
        ]
```
AFTER:
```elm
        [ Theme.view
            { dir = model.dir
            , onSetDirection = SetDirection
            , sectionsEl = sectionsAccordion { ... }  -- add cssVariables field in Task 9
            }
            model.theme
            ThemeMsg
        , controlRow model
        ]
```
Add `controlRow`:
```elm
{-| The variant + scheme + direction row (§5). Variant/scheme come from `Theme`
(mapped through `ThemeMsg`); direction is assembled here (it lives in `Shared.Model`,
not `Theme.Model`). One scoped reset fires all three: `SetVariant Value.neutral`,
`SetScheme Value.auto` (both under `ThemeMsg`), and `SetDirection auto`.
-}
controlRow : Model -> Element (TypedHtml.Grouping.DivIs s) admittedBy Msg
controlRow model =
    TypedHtml.div [ TypedHtml.Attributes.class "flex items-end gap-2 flex-wrap" ]
        [ Theme.variantSelect model.theme |> HtmlIr.Element.map ThemeMsg
        , Theme.schemeToggle model.theme |> HtmlIr.Element.map ThemeMsg
        , directionToggle model
        , M3e.iconButton
            [ TypedHtml.Events.onClick ResetControlRow
            , Aria.label "Reset variant, scheme, and direction"
            ]
            [ M3e.icon [ M3e.Component.Icon.name "restart_alt" ] [] ]
        ]
```
Add a `Shared.Msg` constructor `ResetControlRow` and handle it in `Shared.update`:
```elm
        ResetControlRow ->
            let
                ( theme2, themeCmd ) =
                    Theme.update (Theme.SetVariant Value.neutral) model.theme

                ( theme3, themeCmd2 ) =
                    Theme.update (Theme.SetScheme Value.auto) theme2
            in
            ( { model | theme = theme3, dir = TypedHtml.Values.auto }
            , Cmd.batch [ Cmd.map ThemeMsg themeCmd, Cmd.map ThemeMsg themeCmd2 {- + any direction port cmd SetDirection normally fires -} ]
            )
```
- Confirm how `SetDirection` is handled in `Shared.update` today (does it fire a port to set
  `document.dir`?). Mirror that side-effect in the `dir = auto` branch so the reset actually flips
  the document, not just the model. Grep `Shared.update` for `SetDirection` before writing this.
- Fork (§5): if threading two sequential `Theme.update` calls is ugly, add a single
  `Theme.ResetControlRow` msg that does `{model | variant = neutral, scheme = auto}` in one update,
  and pair it with `dir = auto` in `Shared`. Recommended = the single-`Theme`-msg form if the
  double-update reads poorly.
- Delete `directionSegmented` and the old `controlLabel "Directionality"` call.

Commands:
```
docs/node_modules/.bin/elm-format --yes docs/app/Theme.elm docs/app/Shared.elm
cd docs && npm run build:site
```
Manual (PROD `:1239` only): variant menu, scheme toggle, direction icon all reskin the page live;
row reset restores variant=neutral/scheme=System/dir=auto and touches nothing else.

---

## Task 7 — §8 Color section → chips with color-circle icon + value-entry menu

Largest single-file change. Each of 37 tokens becomes a chip: circular color-swatch (inline-styled
circle — the chip icon slot canNOT nest `<m3e-theme>`, see reality check), role label as chip text,
selected⇔customized, click opens a `menu` with hex input / OS picker / unset.

File: `docs/app/Theme/Sections/Color.elm`

Replace `tokenRow` (`:37-71`). `groupView` (`:29-34`) stays; only `tokenRow` internals change, and
the group's row container becomes a wrapping chip cluster.

`groupView` container change (`:31`):
```elm
groupView : Theme.Model -> ( String, List ColorToken ) -> Element (TypedHtml.Grouping.DivIs s) admittedBy Msg
groupView model ( groupName, tokens ) =
    TypedHtml.div [ TypedHtml.Attributes.class "flex flex-col gap-1" ]
        [ TypedHtml.Sectioning.h3 [] [ M3e.text groupName ]
        , TypedHtml.div [ TypedHtml.Attributes.class "flex flex-wrap gap-2" ]
            (List.map (tokenChip model) tokens)
        ]
```

New `tokenChip`:
```elm
tokenChip : Theme.Model -> ColorToken -> Element (TypedHtml.Grouping.DivIs s) admittedBy Msg
tokenChip model token =
    let
        current : Maybe String
        current =
            Dict.get token.cssVar model.colorOverrides

        isSet : Bool
        isSet =
            current /= Nothing

        menuId : String
        menuId =
            "color-menu-" ++ token.cssVar

        inputId : String
        inputId =
            "color-" ++ token.cssVar

        -- Neutral placeholder for an UNset chip: outline ring, no fill (Elm can't
        -- read the live computed var — see plan's CSS-var constraint). A set chip
        -- shows its literal override hex inline (no computed read needed).
        swatchStyle : List (TypedHtml.Attributes.Attribute Msg)
        swatchStyle =
            case current of
                Just hex ->
                    [ TypedHtml.Attributes.style "background-color" hex
                    , TypedHtml.Attributes.class "size-4 rounded-full border border-outline"
                    ]

                Nothing ->
                    [ TypedHtml.Attributes.class "size-4 rounded-full border border-outline bg-transparent" ]
    in
    TypedHtml.div [ TypedHtml.Attributes.class "relative inline-flex" ]
        [ M3e.chip
            [ M3e.Component.Chip.variant
                (if isSet then
                    Value.elevated

                 else
                    Value.outlined
                )
            ]
            [ M3e.Component.Chip.icon (M3e.icon [ M3e.Component.Icon.name "circle", M3e.Attributes.style "color" (Maybe.withDefault "transparent" current) ] [])
            , M3e.text token.role
            , M3e.Component.MenuTrigger.child (menuTriggerFor menuId)  -- opens the value menu
            ]
        , M3e.menu
            [ M3e.Attributes.id menuId, M3e.Attributes.class "..." ]
            [ M3e.menuItem [] [ hexEntry token inputId current ]
            , M3e.menuItem [] [ osPickerButton token inputId current ]
            , M3e.menuItem [ M3e.Component.MenuItem.onClick (ResetColorOverride token.cssVar) ] [ M3e.text "Unset" ]
            ]
        ]
```
**Implementation-time fork (§8 chip icon-slot nesting) — RESOLVED to inline circle:** the chip
`IconSlot` admits only `sharedIcon` kinds, NOT `avatar`/`theme`, so the swatch is either
(a) an `M3e.icon "circle"` tinted via `style "color"` (shown above — simplest, keeps it in the icon
slot), or (b) a plain `TypedHtml.div` circle placed as the chip's leading child if `M3e.icon` tinting
proves unreliable. Use (a); fall back to (b). The `<m3e-theme>` avatar trick is unavailable here.

**Menu wiring fork:** the clean path is `menuTrigger [ for menuId ]` inside the chip + `menu [ id menuId ]`
as a sibling. Because there's no existing `menu` usage to copy, budget a spike: if `menuTrigger`/`menu`
don't reliably open in the drawer, FALL BACK to a lightweight inline approach — render the hex input +
OS-picker + unset directly beneath the chip, gated by a per-token "open" flag. That flag would need a
new `Model` field (`Set String` of open token cssVars) — acceptable, still no persisted-shape change
(it's transient UI state, not persisted). Recommended: try `menu` first (one spike), fall back to inline
if flaky. Keep the hex/OS-picker/unset *actions* identical either way (they reuse `SetColorOverride`/
`ResetColorOverride`).

Helper functions (reuse the existing OS-picker overlay trick from `Theme.sourceColorOption`):
```elm
hexEntry : ColorToken -> String -> Maybe String -> Element (TypedHtml.Grouping.DivIs s) admittedBy Msg
hexEntry token inputId current =
    TypedHtml.input
        [ TypedHtml.Attributes.type_ "text"
        , TypedHtml.Attributes.placeholder "#RRGGBB"
        , TypedHtml.Attributes.value (Maybe.withDefault "" current)
        , TypedHtml.Events.onInput (SetColorOverride token.cssVar)
        , Aria.label ("Hex value for " ++ token.role)
        ]
        []


osPickerButton : ColorToken -> String -> Maybe String -> Element (TypedHtml.Grouping.DivIs s) admittedBy Msg
osPickerButton token inputId current =
    -- Native <input type=color> overlay, same mechanism as `sourceColorOption`.
    TypedHtml.label [ TypedHtml.Attributes.for inputId, TypedHtml.Attributes.class "cursor-pointer" ]
        [ M3e.text "Pick…"
        , TypedHtml.input
            [ TypedHtml.Attributes.id inputId
            , TypedHtml.Attributes.type_ "color"
            , TypedHtml.Attributes.value (Maybe.withDefault "#000000" current)
            , TypedHtml.Events.onInput (SetColorOverride token.cssVar)
            , TypedHtml.Attributes.class "sr-only"
            ]
            []
        ]
```
Imports to add in `Color.elm`: `M3e.Component.Chip`, `M3e.Component.MenuItem`, `M3e.Component.MenuTrigger`,
`M3e.Values as Value` (for `elevated`/`outlined`), `M3e.Attributes`. Confirm `Value.elevated`/`Value.outlined`
exist for chip variant.

Commands:
```
docs/node_modules/.bin/elm-format --yes docs/app/Theme/Sections/Color.elm
cd docs && npm run build:site
```
Manual (PROD): a chip reads outlined/empty-circle when unset; setting a hex or OS color flips it to
elevated/filled and reskins the page; "Unset" reverts chip to neutral placeholder and clears the var.

---

## Task 8 — §11 New `Theme.Sections.CssVariables` module

New 6th accordion panel. Free-form rows: leading token-name picker (`select`/`option` from
`Theme.Tokens` lists), freeform value input (`SetCssOverride`), trailing X to unset. Plus an
"add new" affordance appending a blank row.

**Fork (§11 unset msg):** RECOMMENDED = generalize the existing `ResetColorOverride` — it already does
exactly `Dict.remove` on `colorOverrides` + `setCssOverride "" `. But it targets `colorOverrides`, and
CSS-var rows live in `cssOverrides`. So add a NEW msg `UnsetCssOverride String` that mirrors
`ResetColorOverride` against `cssOverrides`. (Renaming/generalizing `ResetColorOverride` to take a Dict
selector is over-engineering for two call sites — add the parallel msg.) FALLBACK: reuse
`SetCssOverride cssVar ""` (sets empty rather than removing the key) — simpler but leaves a dead key in
`cssOverrides`/localStorage, so prefer the new msg.

File: `docs/app/Theme.elm` — add msg + update branch:
```elm
    | UnsetCssOverride String
```
```elm
        UnsetCssOverride cssVar ->
            persist { model | cssOverrides = Dict.remove cssVar model.cssOverrides }
                |> andThen (Theme.Ports.setCssOverride { property = cssVar, value = "" })
```

New file: `docs/app/Theme/Sections/CssVariables.elm`
```elm
module Theme.Sections.CssVariables exposing (view)

{-| The CSS Variables accordion section (§11): a free-form escape hatch for poking
any `@m3e/web` CSS custom property. One row per currently-set arbitrary override
(from `model.cssOverrides`) not covered by a curated section, plus an "add new" row.
Each row: a token-name picker (`select`/`option` over the known token lists), a
freeform value input (`SetCssOverride`, no validation — same permissiveness the msg
already allows), and a trailing X (`UnsetCssOverride`). Kept SEPARATE from Advanced's
19 curated tokens (spec non-goal: not merged).

Elm cannot set a CSS custom property directly; every value write goes through the
`Theme.Ports.setCssOverride` port (via `SetCssOverride`).
-}

import Dict
import M3e exposing (Element)
import M3e.Attributes
import M3e.Component.Icon
import M3e.Component.Option
import M3e.Events
import Json.Decode as Decode
import Theme exposing (Msg(..))
import Theme.Tokens as Tokens
import TypedHtml
import TypedHtml.Aria as Aria
import TypedHtml.Attributes
import TypedHtml.Events
import TypedHtml.Grouping


{-| Known CSS custom property names offered in the picker — deduped union of the
token lists `Theme.Tokens` already exposes, MINUS the ones each curated section
already owns (color, motion-duration, state-opacity, typescale, shape). Per spec,
the exact source list is an implementation-time call; this uses the existing lists.
-}
knownVars : List ( String, String )
knownVars =
    -- (label, cssVar) — offer the raw @m3e/web tokens as an escape hatch. Color/
    -- motion/opacity/typescale/shape each have a dedicated section, so this list is
    -- the "everything else" set. For the initial cut, offer the full token union and
    -- let the user pick; refine the dedup once the CEM-manifest list lands.
    (Tokens.colorGroups |> List.concatMap Tuple.second |> List.map (\t -> ( t.role, t.cssVar )))
        ++ List.map (\t -> ( t.label, t.cssVar )) Tokens.typescaleTokens
        ++ List.map (\t -> ( t.label, t.cssVar )) Tokens.shapeTokens
        ++ List.map (\t -> ( t.label, t.cssVar )) Tokens.motionDurationTokens
        ++ List.map (\t -> ( t.label, t.cssVar )) Tokens.stateOpacityTokens


view : Theme.Model -> Element (TypedHtml.Grouping.DivIs s) admittedBy Msg
view model =
    TypedHtml.div [ TypedHtml.Attributes.class "flex flex-col gap-3" ]
        [ TypedHtml.div [ TypedHtml.Attributes.class "flex flex-col gap-2" ]
            (List.map cssVarRow (Dict.toList model.cssOverrides))
        , addRow
        ]


cssVarRow : ( String, String ) -> Element (TypedHtml.Grouping.DivIs s) admittedBy Msg
cssVarRow ( cssVar, value ) =
    TypedHtml.div [ TypedHtml.Attributes.class "flex items-center gap-2" ]
        [ M3e.text ("--" ++ cssVar)
        , TypedHtml.input
            [ TypedHtml.Attributes.type_ "text"
            , TypedHtml.Attributes.value value
            , TypedHtml.Events.onInput (SetCssOverride cssVar)
            , Aria.label ("Value for " ++ cssVar)
            ]
            []
        , M3e.iconButton
            [ TypedHtml.Events.onClick (UnsetCssOverride cssVar)
            , Aria.label ("Remove override for " ++ cssVar)
            ]
            [ M3e.icon [ M3e.Component.Icon.name "close" ] [] ]
        ]


{-| The "add new" affordance: a select that, on pick, seeds a blank override for the
chosen var (fires `SetCssOverride cssVar ""`, which creates the Dict key so a
`cssVarRow` appears for it on the next render). The user then types the value there.
-}
addRow : Element (TypedHtml.Grouping.DivIs s) admittedBy Msg
addRow =
    M3e.select
        [ M3e.Attributes.id "css-var-add"
        , M3e.Events.onChangeWith
            (Decode.map (\v -> SetCssOverride v "") (Decode.at [ "target", "value" ] Decode.string))
        ]
        (M3e.option [ M3e.Component.Option.value "", M3e.Component.Option.selected True ] [ M3e.text "Add a variable…" ]
            :: List.map
                (\( lbl, cssVar ) -> M3e.option [ M3e.Component.Option.value cssVar ] [ M3e.text lbl ])
                knownVars
        )
```
- Note: seeding with `SetCssOverride v ""` writes `--v:` (empty) to the DOM via the port — harmless,
  and the user immediately types a real value. If an empty write is undesirable, add a dedicated
  "stage a blank row" flow with a transient `Model` field; keep it simple for the first cut.
- Confirm `Tokens.colorGroups` element type is `{ role, cssVar }` (it is: `ColorToken`) and the other
  lists carry `.label`/`.cssVar` (they do).

Wire into the accordion — file `docs/app/Shared.elm`, `sectionsAccordion` (`:847-862`):
```elm
sectionsAccordion :
    { color : Element cs adm msg
    , typography : Element cs adm msg
    , shape : Element cs adm msg
    , appearance : Element cs adm msg
    , advanced : Element cs adm msg
    , cssVariables : Element cs adm msg
    }
    -> Element { s | accordion : M3e.Kind.Brand } admittedBy msg
sectionsAccordion themeSections =
    M3e.accordion []
        [ sectionPanel "Color" themeSections.color
        , sectionPanel "Typography" themeSections.typography
        , sectionPanel "Shape" themeSections.shape
        , sectionPanel "Appearance" themeSections.appearance
        , sectionPanel "Advanced" themeSections.advanced
        , sectionPanel "CSS Variables" themeSections.cssVariables
        ]
```
And in `settingsSheetContent`'s `sectionsAccordion { ... }` call, add:
```elm
                    , cssVariables = Theme.Sections.CssVariables.view model.theme |> HtmlIr.Element.map ThemeMsg
```
Add `import Theme.Sections.CssVariables` to `Shared.elm`.

Commands:
```
docs/node_modules/.bin/elm-format --yes docs/app/Theme.elm docs/app/Theme/Sections/CssVariables.elm docs/app/Shared.elm
cd docs && npm run build:site
```
Manual (PROD): add a var via the picker, type a value → `setCssOverride` fires, page reskins, value
persists across reload; the X clears it visually AND from localStorage.

---

## Task 9 — Regression: update `docs/tests-browser/settings-sheet.spec.ts`

Every control that changed shape needs new selectors. Current selectors → new:

1. **Contrast (still segmented, unchanged shape)** — `getByRole("radio", { name: "High" })` STILL
   valid (Appearance rows stay segmented; only a label was added above them). No change needed, but
   the added `<label>` "Contrast" must not create a same-name ambiguity — it won't (`role=radio` vs a
   plain heading). Leave as-is; re-run to confirm.

2. **Scheme toggle** — the "a color-token override survives a scheme toggle" test does
   `getByRole("radio", { name: "Dark" }).click()`. Scheme is now a 2-option segmented (still radios),
   so `role=radio name=Dark` STILL resolves. Keep. BUT "System" is gone — no test referenced it, so OK.

3. **Color token input** — the "override survives a scheme toggle but not Reset all" test uses
   `page.locator("#color-md-sys-color-primary").fill("#ff0000")`. That native `<input id=color-...>`
   is GONE (chips now). Rewrite: open the primary chip's menu, use its hex input. New:
```ts
   await page.getByRole("button", { name: "Color" }).last().click();
   // open the primary token's chip menu, then its hex input
   await page.getByRole("button", { name: /Primary/i }).first().click(); // the chip
   const hexInput = page.getByLabel("Hex value for Primary");
   await hexInput.fill("#ff0000");
   await hexInput.blur();
   // scheme toggle
   await page.getByRole("radio", { name: "Dark" }).click();
   await expect(hexInput).toHaveValue("#ff0000"); // reopen chip if the menu closed on toggle
   await page.getByRole("button", { name: "Reset all" }).click();
   // reopen + assert cleared
```
   NOTE: chip menu may close on the scheme click — the assertion may need to reopen the chip first.
   Adjust during execution against the real rendered markup (the chip menu's open/close is
   element-owned, like the sheet). If the §8 menu fell back to the inline-open branch, target the
   inline hex input instead (`getByLabel("Hex value for Primary")` works for both).

4. **Seed color** — the "contrast and seed color survive a reload" test uses `#seed-color`. That
   input is UNCHANGED (`sourceColorOption` keeps `id="seed-color"`; only its container's flex class
   changed in §6). Keep as-is.

5. **Variant** — no existing test targets variant. If adding coverage: the menu is now
   `#variant-select` (an `m3e-select`); selecting fires `SetVariant`. Optional new assertion:
   `page.locator("#variant-select").selectOption("vibrant")` then assert a `--md-sys-color-*` change.
   Confirm `m3e-select` responds to Playwright `selectOption` (it's a custom element — may need
   `page.locator("#variant-select").evaluate(...)` to set value + dispatch `change`). Match the
   `#seed-color` fill pattern's reliability; spike if `selectOption` doesn't drive the custom element.

6. **Direction** — no existing test targets direction. The control is now an icon button
   `getByRole("button", { name: /right-to-left|left-to-right/ })` if coverage is added.

7. **CSS Variables panel** — new coverage recommended (spec Testing bullet): open the panel, pick a
   var from `#css-var-add`, type a value, assert `setCssOverride` applied it live, reload, assert
   persisted, click the X, assert cleared. Mirror the existing reload test's structure.

Run:
```
cd docs && npm run build:site && npx playwright test tests-browser/settings-sheet.spec.ts
```
(Playwright runs against the PROD build — the correct target per the dev-hydration caveat.)

---

## Final verification

```
docs/node_modules/.bin/elm-format --yes docs/app/Theme.elm docs/app/Shared.elm docs/app/Theme/Sections/*.elm
cd docs && npm run build:site
cd docs && npx playwright test tests-browser/settings-sheet.spec.ts
```
Then serve the prod build on `:1239` and walk the spec's manual-test list (variant/scheme/direction
reskin live; scoped reset touches only those three; color chip selected-state toggles; source-color
row scrolls horizontally on narrow viewports; CSS var add/apply/persist/remove round-trips). NEVER
verify interactivity on the `:1234` dev server.

## Non-goals preserved (checklist)

- [x] No persisted-state shape change beyond new control values (`UnsetCssOverride` only removes a
      key that `SetCssOverride` already writes; no new persisted field).
- [x] No `type Button` work.
- [x] No `/theme-editor` route — stays the overlay drawer.
- [x] Advanced's 19 curated tokens NOT merged into CSS Variables (separate module/section).
- [x] Unset color chip shows a neutral placeholder (no live computed read — Elm can't read the var).

## Fork summary (spec-open decisions + this plan's branch)

- §3 toggle-when-auto → **both segments unchecked** (recommended); fallback: seed visual from OS scheme.
- §4 icon pair → **`format_textdirection_l_to_r`/`_r_to_l`** (spec-named); confirm `Aria.pressed` exists.
- §5 direction module boundary → **keep `dir` in `Shared.Model`, compose row in `Shared`** (recommended);
  fallback: move `dir` into `Theme.Model`.
- §8 chip icon slot → **inline `M3e.icon "circle"` tinted** (FORCED — `IconSlot` rejects nested theme);
  fallback: plain `div` circle as leading child.
- §8 value-entry → **real `M3e.menu`+`menuTrigger`** (one spike); fallback: inline per-token open flag
  (transient `Model` field, no persisted change).
- §11 unset msg → **new `UnsetCssOverride String`** (recommended); fallback: `SetCssOverride cssVar ""`.
- §2/§11 picker → **`M3e.select`/`M3e.option`** (proven; no existing `menu` usage in docs).
