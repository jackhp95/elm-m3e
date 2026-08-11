module Theme.Reel exposing (Config, view)

{-| A horizontal-scrolling reel of theme-demo cards, each an `m3e-card` wrapped
in its own `<m3e-theme>` — the "themes work by inheritance" live demo.

Anatomy of one card (all m3e components; Tailwind is layout-only):

    <m3e-theme color scheme contrast>        ← live-derived palette for this card
      <m3e-card actionable variant=…>        ← the interactive surface + selection state
        <m3e-heading> name (display font)    ← per-preset display font (inline font-family)
        <m3e-heading>A</> <m3e-heading>a</>  ← "Aa" specimen (display + body font)
        <m3e-avatar>×4                        ← role palette strip (primary/secondary/…)
      </m3e-card>
    </m3e-theme>

Colours are derived live from the nested `<m3e-theme>`: the role avatars are
painted DIRECTLY from `--md-sys-color-<role>` tokens (via a `m3e-avatar-color-[…]`
arbitrary utility), which the nested theme re-declares for its subtree, and the
card's own surface derives from the same nested palette through the shadow
boundary (CSS custom properties inherit into shadow DOM). No hex is painted by
hand. (The Tailwind bridge `--color-<role>` token is NOT used for this — it is
declared once at `:root`, so a nested theme can't change it; see `cardRoleStrip`.)

`m3e-card` (with `actionable`) is the interactive element: it dispatches a
standard `click` event (`bubbles: true`, `composed: true`) that Elm's
`Html.Events.on "click"` observes. The earlier native `<button>` wrapper was a
workaround written before this was confirmed; this module now uses `M3e.Card.onClick`
directly so the card itself is the click target — no `M3e.Unsafe` needed.

This module is pure and `msg`-generic. Two placements share it:

  - `Route.GettingStarted.Welcome` — the on-page reel section.

  - `Theme.view` (the settings drawer) — replaces the old `presetGallery`.

        Theme.Reel.view
            { presets = Theme.Presets.presets
            , activeId = shared.theme.activePresetId
            , onPick = PickTheme
            }

@docs Config, view

-}

import M3e exposing (Element)
import M3e.Attributes as MA
import M3e.Avatar
import M3e.Card
import M3e.Heading
import M3e.Icon
import M3e.Theme
import M3e.Values as Value
import Theme.Fonts
import Theme.Presets exposing (Preset)
import TypedHtml
import TypedHtml.Aria as Aria
import TypedHtml.Attributes as TA
import TypedHtml.Grouping


{-| Configuration for the reel view — kept as a record so callers can omit
fields they don't need and future fields can be added without touching call
sites. All fields are explicit; nothing is implicit.
-}
type alias Config msg =
    { presets : List Preset
    , activeId : Maybe String
    , onPick : Preset -> msg
    }


{-| The full reel: a `flex overflow-x-auto snap-x snap-mandatory` row of
`card`s, one per preset. `snap-start` on each card keeps swipes feeling
intentional on touch screens. The reel is layout-only Tailwind; the visual
surface of every card is an `m3e-card`.
-}
view : Config msg -> Element (TypedHtml.Grouping.DivIs s) admittedBy msg
view config =
    TypedHtml.div
        [ TA.class "flex gap-3 overflow-x-auto snap-x snap-mandatory px-4 py-3" ]
        (List.map (card config) config.presets)


{-| One theme card. The `m3e-card` (with `actionable`) is the interactive
element — `M3e.Card.onClick` fires on user click and dispatches `onPick`.
`<m3e-theme>` scopes the live-derived palette to this card's preset, and carries
the `snap-start` + sizing layout so the card fills its snap region.
-}
card : Config msg -> Preset -> Element (M3e.Theme.Is s) admittedBy msg
card config preset =
    let
        isActive : Bool
        isActive =
            config.activeId == Just preset.id
    in
    M3e.theme
        [ M3e.Theme.color preset.seedColor
        , M3e.Theme.scheme preset.scheme
        , M3e.Theme.contrast preset.contrast
        , TA.class "block shrink-0 w-32 snap-start"
        ]
        [ presetCard config isActive preset ]


{-| The `m3e-card` surface: `actionable` makes it the click target; `onClick`
delivers the `onPick` message; `aria-pressed` + `aria-label` make it accessible.
Selection state is expressed the M3 way — `elevated` when active, `outlined`
otherwise — plus a `check_circle` badge.
-}
presetCard : Config msg -> Bool -> Preset -> Element (M3e.Card.Is s) admittedBy msg
presetCard config isActive preset =
    M3e.card
        [ M3e.Card.actionable True
        , M3e.Card.onClick (config.onPick preset)
        , M3e.Card.variant
            (if isActive then
                Value.elevated

             else
                Value.outlined
            )
        , Aria.pressed
            (if isActive then
                Aria.true

             else
                Aria.false
            )
        , Aria.label ("Apply " ++ preset.name ++ " theme")
        , MA.class "w-full text-left m3e-card-padding-[0.625rem]"
        ]
        [ M3e.Card.content (cardBody isActive preset) ]


{-| The card's inner content, one row per line. Each row is a `TypedHtml.div`
(so the row list stays a single kind), and every row's own children are a
single m3e component kind — keeping the phantom-row lists homogeneous without
per-child escapes.
-}
cardBody : Bool -> Preset -> Element (TypedHtml.Grouping.DivIs s) admittedBy msg
cardBody isActive preset =
    TypedHtml.div
        [ TA.class "flex flex-col gap-1.5" ]
        (List.concat
            [ if isActive then
                [ selectedBadge ]

              else
                []
            , [ cardName preset
              , cardSpecimen preset
              , cardRoleStrip
              ]
            ]
        )


{-| The "selected" affordance: a filled `check_circle` icon, right-aligned.
Shown only for the active card. Its colour inherits `on-surface` from the
card's own nested theme.
-}
selectedBadge : Element (TypedHtml.Grouping.DivIs s) admittedBy msg
selectedBadge =
    TypedHtml.div
        [ TA.class "flex justify-end -mb-1 text-primary" ]
        [ M3e.icon
            [ M3e.Icon.name "check_circle"
            , M3e.Icon.filled True
            , MA.class "text-base"
            ]
            []
        ]


{-| The theme name as an `m3e-heading` (title/small) in the preset's display
font. `font-family` is a regular CSS property, so inline `style` is reliable
here (only CSS _custom_ properties are unreliable via the style encoder).
-}
cardName : Preset -> Element (TypedHtml.Grouping.DivIs s) admittedBy msg
cardName preset =
    TypedHtml.div
        [ TA.class "min-w-0" ]
        [ M3e.heading
            [ M3e.Heading.variant Value.title
            , M3e.Heading.size Value.small
            , MA.class "truncate"
            , MA.style "font-family" (Theme.Fonts.fontStack preset.displayFont)
            ]
            [ M3e.text preset.name ]
        ]


{-| "Aa" specimen: uppercase A in the display font, lowercase a in the body
font — two `m3e-heading`s side by side so both fonts show at a glance.
-}
cardSpecimen : Preset -> Element (TypedHtml.Grouping.DivIs s) admittedBy msg
cardSpecimen preset =
    TypedHtml.div
        [ TA.class "flex items-baseline gap-1" ]
        [ M3e.heading
            [ M3e.Heading.variant Value.display
            , M3e.Heading.size Value.small
            , MA.style "font-family" (Theme.Fonts.fontStack preset.displayFont)
            ]
            [ M3e.text "A" ]
        , M3e.heading
            [ M3e.Heading.variant Value.title
            , M3e.Heading.size Value.medium
            , MA.style "font-family" (Theme.Fonts.fontStack preset.bodyFont)
            ]
            [ M3e.text "a" ]
        ]


{-| A strip of 4 role-derived swatches, each a blank `m3e-avatar` painted
DIRECTLY from a `--md-sys-color-<role>` token. The nested `<m3e-theme>`
re-declares those tokens for its subtree, so painting from them resolves to
this card's own live palette — the "themes work by inheritance" demo.

Note the tokens are `--md-sys-color-*`, NOT the Tailwind bridge `--color-*`:
`--color-primary` is declared once at `:root` (as `var(--md-sys-color-primary)`)
and is computed there, so it inherits a fixed root value and a nested theme
never changes it. Referencing `--md-sys-color-primary` directly, on the avatar,
resolves against the nearest `<m3e-theme>` instead.

-}
cardRoleStrip : Element (TypedHtml.Grouping.DivIs s) admittedBy msg
cardRoleStrip =
    TypedHtml.div
        [ TA.class "flex gap-1 mt-0.5" ]
        [ roleAvatar "m3e-avatar-color-[var(--md-sys-color-primary)]"
        , roleAvatar "m3e-avatar-color-[var(--md-sys-color-secondary)]"
        , roleAvatar "m3e-avatar-color-[var(--md-sys-color-tertiary)]"
        , roleAvatar "m3e-avatar-color-[var(--md-sys-color-surface-container-highest)]"
        ]


{-| One blank role swatch: a small circular `m3e-avatar` whose background is set
to a role token via the vendored utility class. `m3e-avatar-size-*` keeps it a
compact dot; the colour derives from the nearest `<m3e-theme>`.
-}
roleAvatar : String -> Element (M3e.Avatar.Is s) admittedBy msg
roleAvatar colorUtility =
    M3e.avatar
        [ MA.class ("m3e-avatar-size-[0.875rem] " ++ colorUtility) ]
        []
