module Ui.Theme exposing
    ( Theme, new
    , withSeedColor
    , Scheme(..), withScheme
    , Variant(..), withVariant
    , Contrast(..), withContrast
    , withDensity, withStrongFocus
    , Motion(..), withMotion
    , onChange
    , view
    )

{-| Typed builder for application-level M3 theming. Wraps the `m3e-theme`
custom element.

`m3e-theme` is a non-visual element that derives dynamic color, density,
motion, and strong-focus tokens from a seed color and applies them — via the
`--md-sys-color-*` (and related) custom properties — to its themed subtree.
`Ui.Theme` therefore wraps a subtree: `view children theme` renders the
themed elements inside an `<m3e-theme>`.

This module deliberately ships no class contract of its own; the real M3
theming mechanism is the element, and the tokens it cascades.


# Construction

@docs Theme, new


# Seed color

@docs withSeedColor


# Scheme

@docs Scheme, withScheme


# Variant

@docs Variant, withVariant


# Contrast

@docs Contrast, withContrast


# Density and focus

@docs withDensity, withStrongFocus


# Motion

@docs Motion, withMotion


# Events

@docs onChange


# Render

@docs view

-}

import Html exposing (Html)
import Json.Decode
import M3e.Theme


type Theme msg
    = Theme (Config msg)


{-| The color scheme of the theme, mirroring the `m3e-theme` `scheme` enum
(`auto | light | dark`).
-}
type Scheme
    = Auto
    | Light
    | Dark


{-| The dynamic-color variant of the theme, mirroring the `m3e-theme`
`variant` enum.
-}
type Variant
    = Content
    | Vibrant
    | Expressive
    | Monochrome
    | Neutral
    | TonalSpot
    | Fidelity
    | Rainbow
    | FruitSalad


{-| The contrast level of the theme, mirroring the `m3e-theme` `contrast` enum
(`medium | standard | high`).
-}
type Contrast
    = Medium
    | Standard
    | High


{-| The motion scheme of the theme, mirroring the `m3e-theme` `motion` enum
(`standard | expressive`).
-}
type Motion
    = MotionStandard
    | MotionExpressive


type alias Config msg =
    { seedColor : Maybe String
    , scheme : Maybe Scheme
    , variant : Maybe Variant
    , contrast : Maybe Contrast
    , density : Maybe Float
    , strongFocus : Maybe Bool
    , motion : Maybe Motion
    , onChange : Maybe (Json.Decode.Decoder msg)
    }


{-| A new theme with no overrides; the `m3e-theme` element supplies its own
defaults (seed `#6750A4`, scheme `auto`, variant `neutral`, contrast
`standard`, density `0`, motion `standard`).
-}
new : Theme msg
new =
    Theme
        { seedColor = Nothing
        , scheme = Nothing
        , variant = Nothing
        , contrast = Nothing
        , density = Nothing
        , strongFocus = Nothing
        , motion = Nothing
        , onChange = Nothing
        }


{-| Set the hex seed color from which the dynamic palettes are derived
(the `color` attribute, default `#6750A4`).
-}
withSeedColor : String -> Theme msg -> Theme msg
withSeedColor color (Theme cfg) =
    Theme { cfg | seedColor = Just color }


{-| Set the color scheme (the `scheme` attribute).
-}
withScheme : Scheme -> Theme msg -> Theme msg
withScheme scheme (Theme cfg) =
    Theme { cfg | scheme = Just scheme }


{-| Set the dynamic-color variant (the `variant` attribute).
-}
withVariant : Variant -> Theme msg -> Theme msg
withVariant variant (Theme cfg) =
    Theme { cfg | variant = Just variant }


{-| Set the contrast level (the `contrast` attribute).
-}
withContrast : Contrast -> Theme msg -> Theme msg
withContrast contrast (Theme cfg) =
    Theme { cfg | contrast = Just contrast }


{-| Set the density scale (the `density` property; typically `0`, `-1`, `-2`).
-}
withDensity : Float -> Theme msg -> Theme msg
withDensity density (Theme cfg) =
    Theme { cfg | density = Just density }


{-| Enable or disable strong focus indicators (the `strong-focus` property).
-}
withStrongFocus : Bool -> Theme msg -> Theme msg
withStrongFocus strongFocus (Theme cfg) =
    Theme { cfg | strongFocus = Just strongFocus }


{-| Set the motion scheme (the `motion` attribute).
-}
withMotion : Motion -> Theme msg -> Theme msg
withMotion motion (Theme cfg) =
    Theme { cfg | motion = Just motion }


{-| Listen for the `change` event the theme dispatches when it recomputes.
-}
onChange : Json.Decode.Decoder msg -> Theme msg -> Theme msg
onChange decoder (Theme cfg) =
    Theme { cfg | onChange = Just decoder }


{-| Render the themed subtree inside an `<m3e-theme>` carrying the configured
attributes.
-}
view : List (Html msg) -> Theme msg -> Html msg
view children (Theme cfg) =
    M3e.Theme.component
        (List.filterMap identity
            [ Maybe.map M3e.Theme.color cfg.seedColor
            , Maybe.map (toM3eScheme >> M3e.Theme.scheme) cfg.scheme
            , Maybe.map (toM3eVariant >> M3e.Theme.variant) cfg.variant
            , Maybe.map (toM3eContrast >> M3e.Theme.contrast) cfg.contrast
            , Maybe.map M3e.Theme.density cfg.density
            , Maybe.map M3e.Theme.strongFocus cfg.strongFocus
            , Maybe.map (toM3eMotion >> M3e.Theme.motion) cfg.motion
            , Maybe.map M3e.Theme.onChange cfg.onChange
            ]
        )
        children


toM3eScheme : Scheme -> M3e.Theme.Scheme
toM3eScheme scheme =
    case scheme of
        Auto ->
            M3e.Theme.Auto

        Light ->
            M3e.Theme.Light

        Dark ->
            M3e.Theme.Dark


toM3eVariant : Variant -> M3e.Theme.Variant
toM3eVariant variant =
    case variant of
        Content ->
            M3e.Theme.Content

        Vibrant ->
            M3e.Theme.Vibrant

        Expressive ->
            M3e.Theme.VariantExpressive

        Monochrome ->
            M3e.Theme.Monochrome

        Neutral ->
            M3e.Theme.Neutral

        TonalSpot ->
            M3e.Theme.TonalSpot

        Fidelity ->
            M3e.Theme.Fidelity

        Rainbow ->
            M3e.Theme.Rainbow

        FruitSalad ->
            M3e.Theme.FruitSalad


toM3eContrast : Contrast -> M3e.Theme.Contrast
toM3eContrast contrast =
    case contrast of
        Medium ->
            M3e.Theme.Medium

        Standard ->
            M3e.Theme.ContrastStandard

        High ->
            M3e.Theme.High


toM3eMotion : Motion -> M3e.Theme.Motion
toM3eMotion motion =
    case motion of
        MotionStandard ->
            M3e.Theme.MotionStandard

        MotionExpressive ->
            M3e.Theme.MotionExpressive
