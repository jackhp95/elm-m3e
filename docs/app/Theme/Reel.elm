module Theme.Reel exposing (Config, view)

{-| A horizontal-scrolling reel of theme-demo cards, each wrapped in its own
`<m3e-theme>` — the "themes work by inheritance" live demo.

Each card renders entirely within its own nested `<m3e-theme>`, so
`color`/`scheme`/`contrast` are derived live from that card's preset.
No hex values are painted by hand; the role strip uses CSS role classes
(`bg-primary`, `bg-secondary`, etc.) so they inherit from the nearest
`<m3e-theme>` — i.e., the card's own nested theme.

This module is pure and `msg`-generic. Two placements share it:

  - `Route.GettingStarted.Welcome` — the on-page reel section.

  - `Shared.settingsSheetContent` — replaces the old `presetGallery`.

    import Theme.Reel
    import Theme.Presets

    Theme.Reel.view
    { presets = Theme.Presets.presets
    , activeId = shared.theme.activePresetId
    , onPick = PickTheme
    }

@docs Config, view

-}

import M3e exposing (Element)
import M3e.Theme
import M3e.Unsafe
import Theme.Presets exposing (Preset)
import TypedHtml
import TypedHtml.Aria as Aria
import TypedHtml.Attributes as TA
import TypedHtml.Button
import TypedHtml.Events
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
intentional on touch screens. `px-4 py-3` gives breathing room at the edges.
The reel is layout-only Tailwind; no M3e wrapper needed.
-}
view : Config msg -> Element (TypedHtml.Grouping.DivIs s) admittedBy msg
view config =
    TypedHtml.div
        [ TA.class "flex gap-3 overflow-x-auto snap-x snap-mandatory px-4 py-3" ]
        (List.map (card config) config.presets)


{-| One theme card. Structure:

    <button aria-pressed … snap-start …>          ← interactive, keyboard-safe
      <m3e-theme color=… scheme=… contrast=…>     ← live-derived tokens
        <div class="flex flex-col … bg-surface">  ← visual card body
          name / specimen / role-strip
        </div>
      </m3e-theme>
    </button>

The `<button>` is the card — snap-start, sized, rounded, bordered. It is the
semantically correct interactive element: native keyboard focus, space/enter
activation, screen-reader announced as button with aria-pressed. `M3e.Unsafe.recast`
is used to place the `<m3e-theme>` inside the button's phrasing-content slot —
the same technique `sectionPanel` in `Shared.elm` uses. This is safe because
`<m3e-theme>` is a non-visual layout-transparent element: it only publishes CSS
custom properties to its subtree and emits no UI box of its own.

Border color (`border-primary` vs `border-outline-variant`) is a role class on
the button itself. Since the button is OUTSIDE the nested `<m3e-theme>`, its border
color comes from the APP's global palette — intentional: the active ring adapts
to the app theme, not the card's own palette, giving a consistent selection signal
across all cards regardless of their individual hues.

-}
card : Config msg -> Preset -> Element (TypedHtml.Button.Is s) admittedBy msg
card config preset =
    let
        isActive : Bool
        isActive =
            config.activeId == Just preset.id

        borderClass : String
        borderClass =
            if isActive then
                "border-primary border-2"

            else
                "border-outline-variant border"
    in
    TypedHtml.button
        [ TypedHtml.Events.onClick (config.onPick preset)
        , Aria.pressed
            (if isActive then
                Aria.true

             else
                Aria.false
            )
        , Aria.label ("Apply " ++ preset.name ++ " theme")
        , TA.class ("snap-start shrink-0 w-28 rounded-2xl overflow-hidden bg-surface text-left " ++ borderClass)
        ]
        [ M3e.Unsafe.recast (cardThemeWrapper preset) ]


{-| The nested `<m3e-theme>` that scopes live-derived tokens to this card.
`color`/`scheme`/`contrast` are all that's needed — density is non-reactive in
nested themes (per plan §6) and is not set here. `block w-full` ensures the
theme wrapper fills the button.
-}
cardThemeWrapper : Preset -> Element (M3e.Theme.Is s) admittedBy msg
cardThemeWrapper preset =
    M3e.Theme.view
        [ M3e.Theme.color preset.seedColor
        , M3e.Theme.scheme preset.scheme
        , M3e.Theme.contrast preset.contrast
        , TA.class "block w-full"
        ]
        [ cardBody preset ]


{-| The card's inner content: name heading, specimen text, and the 4-role strip.
CSS role classes (`text-on-surface`, `bg-primary`, etc.) inherit from the enclosing
nested `<m3e-theme>`, so each section reflects that card's own live-derived palette.
-}
cardBody : Preset -> Element (TypedHtml.Grouping.DivIs s) admittedBy msg
cardBody preset =
    TypedHtml.div
        [ TA.class "flex flex-col gap-1.5 p-2.5 bg-surface" ]
        [ cardName preset
        , cardSpecimen preset
        , cardRoleStrip
        ]


{-| The theme name in the preset's display font. `font-family` is a regular
CSS property (not a custom property), so `TA.style` works correctly here —
unlike `--css-custom-properties` which are unreliable via Elm's style encoder.
-}
cardName : Preset -> Element (TypedHtml.Grouping.DivIs s) admittedBy msg
cardName preset =
    TypedHtml.div
        [ TA.class "text-on-surface text-xs font-medium leading-tight truncate"
        , TA.style "font-family" ("\"" ++ preset.displayFont ++ "\", sans-serif")
        ]
        [ M3e.text preset.name ]


{-| "Aa" specimen: the uppercase A in the display font, lowercase a in the
body font. Placed side by side in `text-xl` so both glyphs are legible at
the card's narrow width.

Each glyph is a `<span>` so the two inline `style "font-family"` values can
differ. `text-on-surface-variant` keeps the specimen readable without
competing with the name.

-}
cardSpecimen : Preset -> Element (TypedHtml.Grouping.DivIs s) admittedBy msg
cardSpecimen preset =
    TypedHtml.div
        [ TA.class "flex items-baseline gap-0.5 text-on-surface-variant" ]
        [ TypedHtml.span
            [ TA.class "text-xl leading-none"
            , TA.style "font-family" ("\"" ++ preset.displayFont ++ "\", sans-serif")
            ]
            [ M3e.text "A" ]
        , TypedHtml.span
            [ TA.class "text-base leading-none"
            , TA.style "font-family" ("\"" ++ preset.bodyFont ++ "\", sans-serif")
            ]
            [ M3e.text "a" ]
        ]


{-| A strip of 4 role-derived color swatches: primary, secondary, tertiary,
surface-container-highest. These CSS role classes inherit from the nearest
`<m3e-theme>` — the card's own nested one — so each card's strip is its own
live palette. This is the "themes work by inheritance" demo.
-}
cardRoleStrip : Element (TypedHtml.Grouping.DivIs s) admittedBy msg
cardRoleStrip =
    TypedHtml.div
        [ TA.class "flex gap-0.5 mt-0.5" ]
        [ roleChip "bg-primary"
        , roleChip "bg-secondary"
        , roleChip "bg-tertiary"
        , roleChip "bg-surface-container-highest"
        ]


roleChip : String -> Element (TypedHtml.Grouping.DivIs s) admittedBy msg
roleChip colorClass =
    TypedHtml.div
        [ TA.class ("flex-1 h-2.5 rounded-full " ++ colorClass) ]
        []
