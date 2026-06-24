# 1. `Ui.Theme` wraps `m3e-theme`; drop the non-Material `t-*` contract

Date: 2026-06-23

## Status

Accepted

## Context

The old `Ui.Theme` exposed `type Theme = Primary | Secondary | Tertiary |
Neutral | Danger | Warning` and a single `toAttribute : Theme -> Attribute
msg` that tagged an element with a `t-{role}` class (e.g. `t-primary`).

Three problems made this the single biggest "not Material" smell in the
library:

1. **Non-Material mechanism.** `t-*` classes are not part of the Material 3
   spec, the `@material/*` token set, nor the `m3e-*` custom-element contract.
   Material 3 themes a subtree through the `<m3e-theme>` element, which derives
   the `--md-sys-color-*` (and related) custom properties from a seed color and
   cascades them to theme-aware descendants.
2. **A no-op.** The module shipped no CSS for the `t-*` selectors. It only
   emitted the class and left it to the application to define matching rules.
   Out of the box it did nothing at all — a faithful M3 wrapper should produce
   working theming, not a convention the consumer must implement.
3. **A D1 gap.** The vendored `M3e.Theme` (the real `m3e-theme` element) had no
   typed wrapper in `Ui.*`, so the most important theming primitive in the
   library was unreachable through the curated API.

The CEM oracle (`m3e-docs/data/components.json`) and the vendored
`vendor/elm-m3e/M3e/Theme.elm` agree on the `m3e-theme` surface:

| attribute     | type / enum                                                                                                    | default     |
| ------------- | -------------------------------------------------------------------------------------------------------------- | ----------- |
| `color`       | string (hex seed)                                                                                              | `#6750A4`   |
| `scheme`      | `auto \| light \| dark`                                                                                        | `auto`      |
| `variant`     | `content \| vibrant \| expressive \| monochrome \| neutral \| tonal-spot \| fidelity \| rainbow \| fruit-salad`| `neutral`   |
| `contrast`    | `medium \| standard \| high`                                                                                   | `standard`  |
| `density`     | number (property)                                                                                              | `0`         |
| `strong-focus`| boolean (property)                                                                                             | `false`     |
| `motion`      | `standard \| expressive`                                                                                       | `standard`  |
| `change`      | event                                                                                                          | —           |

## Decision

Rewrite `Ui.Theme` as a faithful builder wrapping `M3e.Theme`:

- `new : Theme msg` and `view : List (Html msg) -> Theme msg -> Html msg`,
  where the children are the themed subtree rendered inside `<m3e-theme>`.
- Builders mapping 1:1 to the verified CEM attributes: `withSeedColor`,
  `withScheme` (`Scheme = Auto | Light | Dark`), `withVariant` (`Variant =
  Content | Vibrant | Expressive | Monochrome | Neutral | TonalSpot | Fidelity
  | Rainbow | FruitSalad`), `withContrast` (`Contrast = Medium | Standard |
  High`), `withDensity`, `withStrongFocus`, `withMotion` (`Motion =
  MotionStandard | MotionExpressive`), and `onChange`.
- Every override is a `Maybe`; an unset builder emits no attribute, so the
  element's own documented defaults apply.

Remove the `t-*` class contract entirely.

**Drop role-retinting.** A per-subtree colour-role concept was considered (a
typed `ColorRole = Primary | Secondary | Tertiary | Error | Success | Info |
Warning` that remaps `--md-sys-color-*`). It is rejected here: that is a
*different* mechanism from `m3e-theme` (it requires emitting inline custom-
property overrides), and bolting it onto the theme element would re-introduce
the same "library-invented convention" smell we are removing. Per-element colour
belongs on the per-element `color`/role attributes, not on the theme element.
Had we kept it, `Danger` would have been renamed `Error` (the M3 role is
`error`) and `Neutral` dropped (neutral is a *palette*, not a colour role).

## Consequences

- `Ui.Theme` now produces working M3 theming with zero consumer CSS, closing
  the D1 gap and removing the no-op.
- **Breaking API change.** `Theme(..)` / `toAttribute` are gone. Consumers that
  tagged elements with role classes must instead wrap subtrees in
  `Ui.Theme.view`, or use per-element colour attributes for role tinting.
  `docs/app` still references the old surface; it is out of scope for this
  change and compiled by a separate `elm.json`, so the library build and tests
  are unaffected.
- The enum naming (`MotionStandard`/`MotionExpressive`,
  `Contrast = Medium | Standard | High`) gives `Ui.Theme` a clean public
  namespace while the internal `toM3e*` mappers absorb the vendor module's
  clash-avoidance names (`VariantExpressive`, `ContrastStandard`, …).
- Tests assert the emitted `m3e-theme` carries the right attribute for each
  builder, and that a bare theme emits no scheme/variant/contrast attributes.
