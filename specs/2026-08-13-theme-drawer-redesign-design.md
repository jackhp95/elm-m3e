# Spec — Theme Drawer redesign: controls, chips, row layout, CSS variables

Date: 2026-08-13
Repo: `elm-m3e`
Status: approved design, not yet planned
Related: `docs/app/Theme.elm`, `docs/app/Theme/Sections/*.elm`, `docs/app/Shared.elm`
(drawer host + `directionSegmented`), `specs/2026-08-08-theme-editor-drawer-design.md`
(prior spec that built the drawer this one reworks)

## Problem

The theme drawer (`Theme.elm` + 5 `Theme.Sections.*` accordion panels, hosted by
`Shared.elm:879-902`) works but has grown organically: some controls exist as
segmented buttons that don't fit their option count (`variantSegmented`, 9 options,
`Theme.elm:662-667`, explicitly commented as "may overflow on narrow screens"), some
have no labels (`Appearance`'s three segmented rows), the color editor uses a raw
native `<input type=color>` per token with no indication of override state at a
glance, the Typography preview duplicates content already on the Styles/Typography
page, and there's no general-purpose way to poke an arbitrary CSS custom property
without adding a dedicated section for it.

## Non-goals

- No change to the underlying persisted-state shape/port mechanism
  (`Theme.Ports.encode`/`decoder`) beyond what's needed to represent the redesigned
  controls' values — the localStorage blob strategy stays.
- No new `type Button`-style work, no relation to the naming-convention spec.
- No dedicated `/theme-editor` route (reaffirming the prior spec's non-goal) — stays
  the global overlay drawer.
- Advanced section's 19 curated tokens are NOT merged into the new CSS Variables
  section (confirmed: kept separate, curated section stays; CSS Variables is an
  additional escape hatch, not a replacement).
- Color-chip "swatch" color for an UNset token: Elm has no read-back of the live
  *computed* CSS custom property value (same constraint noted in the prior spec,
  `Shared.elm`'s "Elm cannot set a CSS custom property directly" comment, which cuts
  both ways — no read either). An unset chip therefore shows a neutral placeholder
  (outline ring, no fill / an icon glyph) rather than attempting to preview the live
  resolved color. Not a regression — today's native `<input type=color>` has the same
  gap (`Color.elm:61`, hardcoded `"#000000"` fallback).

## Design

### 1. Shared stepper → form-field widget (`Theme/Sections/Shared.elm`)

Replaces `numberStepper` (label + minus-iconButton + value-text + plus-iconButton,
`Shared.elm:67-82` in the Sections module) with a form-field pattern: label above/
beside, a text input in the middle holding the current numeric value (editable
directly, not just via the buttons), a leading OR trailing decrement icon button and
a trailing increment icon button (mirrors the "leading/trailing icons for increment/
decrement" ask — exact left/right placement is an implementation-time call, right-side
pair is the more common M3 pattern for a stepper-style text field). Typing a value
commits on blur/enter, parsed the same way the buttons currently step by their fixed
increment; invalid text falls back to the last valid value rather than erroring.

This ONE widget change propagates to every current `numberStepper` call site:
`Theme.Sections.Shape` (`shapeScale` params), `Theme.Sections.Typography` (`typeScale`
params — after the preview removal below, these become the section's main content),
and `Theme.Sections.Advanced` (motion-duration + state-opacity rows). No per-section
code beyond swapping which widget function they call.

### 2. Variant control → menu (`Theme.elm`)

`variantSegmented` (9-option segmented button) is replaced by a menu/dropdown
(`M3e.menu`-family component, mirroring the pattern `Theme.Sections.Typography`
already uses for font pickers via `M3e.select`/`M3e.option`) listing all 9
`themeVariantValues` with their existing `variantLabelFor` labels. Selecting an item
fires the existing `SetVariant` msg — no `Msg`/model change needed, just the
rendering swap.

### 3. Scheme control → 2-option toggle (`Theme.elm`)

`schemeSegmented` (3-option: Light/System/Dark, `Theme.elm:546-552`) becomes a
2-option toggle showing only Light/Dark (`Value.light`/`Value.dark`, using
`Theme.segmented` with just those two, or a simpler toggle-icon-button if a genuine
binary toggle widget is preferred at implementation time — either reads as "click to
flip between the two"). `Value.auto` ("System", the default) is no longer directly
selectable from this control — reachable only via the row reset (§4). The toggle's
checked state, when `model.scheme == Value.auto`, needs a defined visual (neither
Light nor Dark shows "on") — implementation picks between "both unchecked" (if the
widget supports it) or defaulting the toggle's initial visual read to whichever the
OS/document currently resolves to, without that constituting a `SetScheme` call.

### 4. Direction control → single toggle icon button (`Shared.elm`)

`directionSegmented` (`Shared.elm:944-960`, 2-option segmented LTR/RTL, already
filters out `auto`) becomes a single icon toggle button using the Material Symbols
`format_textdirection_l_to_r` / `format_textdirection_r_to_l` glyph pair (swapping
icon + `aria-pressed`/`aria-label` on click), firing the same `SetDirection` msg.

### 5. Variant + Scheme + Direction share one row, with one reset

These three controls (previously variant + scheme living in `Theme.elm`'s `view`,
direction living separately in `Shared.elm`) move onto a single row, rendered
together (likely still assembled in `Shared.elm`'s `settingsSheetContent` alongside
directionality, since `Theme.view` doesn't currently own direction — the exact
module-boundary call, whether direction moves INTO `Theme.Model`/`Theme.elm` or the
row is composed in `Shared.elm` importing three separately-exposed pieces, is an
implementation-time decision; either preserves current behavior). The row carries one
reset icon button (`restart_alt`, matching the existing per-token reset icon
convention from `Color.elm:65-70`) that fires three resets together: `SetVariant
Value.neutral`, `SetScheme Value.auto`, `SetDirection auto` — i.e. this row's own
scoped reset, distinct from the drawer-wide `resetAllButton` (`Theme.elm:835-839`,
unchanged).

### 6. Source color → horizontal scroll row (`Theme.elm`)

`colorOptions` (`Theme.elm:678-691`) currently lays out `sourceColorOption` + the 20
curated swatches (`colorAvatar`) in a `flex flex-wrap` container. Changes to
`flex gap-3 overflow-x-auto snap-x snap-mandatory` — the exact class list
`Theme.Reel`'s preset row already uses (`Theme/Reel.elm:75-84`) — so it scrolls
horizontally instead of wrapping to multiple lines. `sourceColorOption` and
`colorAvatar` themselves are unchanged (still the OS-picker-overlay avatar + curated
hex swatches); only the container's layout class changes.

### 7. Typography: drop the live preview

`Theme.Sections.Typography`'s 15-token preview block (lines 66-76 per the earlier
exploration) is deleted. Font pickers, scale-mode segmented control, and the numeric
steppers (now form-fields per §1) stay.

### 8. Color section → chips with color-circle icons (`Theme.Sections.Color.elm`)

Every one of the 37 tokens across 9 groups (`Tokens.colorGroups`) switches from the
current row (`label` + native `<input type=color>` + reset `iconButton`,
`Color.elm:56-71`) to a chip:

- **Chip visual**: a circular color-swatch "icon" (reusing the existing nested
  `<m3e-theme>`-seeded avatar trick from `colorAvatar`/`sourceColorOption` in
  `Theme.elm`, OR a simpler inline-styled circle if the chip component's icon slot
  doesn't accept a nested branded child — implementation-time call) + the token's
  role label as the chip's text.
- **Selected state**: chip shows selected/filled ONLY when `Dict.get token.cssVar
  model.colorOverrides /= Nothing` (i.e. selected ⇔ customized, not a manual toggle).
- **Click behavior**: opens a menu (not the chip's default click action) offering
  three things: (a) a text input for a literal hex/color value (commits via the
  existing `SetColorOverride token.cssVar` msg), (b) a button that opens the native
  OS color picker (same mechanism `sourceColorOption` already uses — a transparent
  `<input type=color>` overlay, or an explicit `<label for=...>` trigger button
  pointing at a hidden color input), (c) an "unset" action firing the existing
  `ResetColorOverride token.cssVar` msg, closing the menu and reverting the chip to
  unselected.
- **Grouping**: `groupView`'s 9 `Tokens.colorGroups` headings stay; only `tokenRow`'s
  internals change (chip instead of label+input+iconButton row), likely laid out in a
  wrapping/scrolling chip cluster per group rather than one-per-line, matching the
  more compact chip idiom.

### 9. Appearance: label the three segmented rows

`Theme.Sections.Appearance.view` (lines 12-18) gains a label above each of
`contrastSegmented`/`motionSegmented`/`densitySegmented` — "Contrast" / "Motion" /
"Density" — using the same `controlLabel` pattern `Shared.elm:905-909` already uses
for "Directionality". Since `Appearance.elm` can't import `Shared.elm` (`Shared`
imports `Theme`, which sections import — see `Theme.elm:800-809`'s note on the import
graph), `controlLabel` needs to move to (or be duplicated into) `Theme.elm` alongside
the already-ported `segmented`/`capitalize` helpers, the same relocation pattern used
when the drawer was split out originally.

### 10. Advanced section: clarify, keep curated

No structural change beyond the shared form-field widget (§1). Add a short
description line at the top of `Theme.Sections.Advanced.view` explaining what the
section is: "Motion durations and state-layer opacities — raw CSS custom property
overrides for the 16 transition-timing tokens and 3 interaction-state opacity
tokens `@m3e/web` exposes." This resolves "I have no idea what advanced does" as a
one-line in-UI answer rather than tribal knowledge.

### 11. New CSS Variables section (6th accordion panel)

New `Theme.Sections.CssVariables` module, added to `sectionsAccordion`
(`Shared.elm:855-862`) as a 6th panel. Free-form entry list, each row a form field:

- **Leading icon**: click opens a menu listing known/valid `@m3e/web` CSS custom
  property names (source: `Theme.Tokens`' existing token lists — color, motion,
  state-opacity, typescale, shape — deduplicated against ones already covered by
  their own dedicated sections, OR the full CEM-manifest-derived list if that becomes
  available per the API-reference-reorg spec's Raw-layer work; exact source list is
  an implementation-time call, not blocking this spec). Picking a menu item sets that
  row's target property name.
- **Text input**: freeform value, no validation — any string can be typed and
  committed, same permissiveness as the existing `SetCssOverride` msg already allows
  (`Theme.elm:207-209`, currently only reachable via curated sections).
- **Trailing icon**: an `X` that unsets/removes that row's override, firing the
  existing `ResetColorOverride`-shaped logic generalized to any `cssOverrides` key
  (a new `Msg` may be needed, `UnsetCssOverride String`, distinct from
  `ResetColorOverride` which is color-specific — or `ResetColorOverride` gets
  generalized/renamed since it already just does `Dict.remove` + `setCssOverride
  "" `, implementation-time call).
- Rows: one per currently-set arbitrary override (from `model.cssOverrides`) that
  isn't already covered by a curated section, plus an "add new" affordance (a chip or
  button) that appends a blank row.

## Testing

- Manual: verify the variant menu, scheme toggle, and direction icon button all still
  correctly drive `<m3e-theme>`'s live attributes (per the prior spec's confirmed
  reactivity fix) — no regression on the "does the page actually reskin" behavior.
- Manual: the row reset button resets exactly variant/scheme/direction, leaves every
  other section (color, typography, shape, advanced, css-vars) untouched.
- Manual: color chip selected-state toggles correctly when setting/unsetting a token
  via its menu; unset reverts the chip to its neutral placeholder.
- Manual: source-color row scrolls horizontally on narrow viewports instead of
  wrapping/overflowing.
- Manual: CSS Variables section — add a row via the token menu, set a value, confirm
  it's applied live (`setCssOverride` port fires) and persists across reload; remove
  it via the trailing X, confirm it's cleared both visually and from localStorage.
- Regression: `docs/tests-browser/settings-sheet.spec.ts` (existing drawer test file)
  needs its selectors updated for every control that changed shape (segmented →
  menu/toggle/chip) — flag as required plan work, not optional cleanup.
