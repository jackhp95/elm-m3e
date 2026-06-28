module M3e.ThemeIcon exposing
    ( view
    , Option
    , Scheme(..), Variant(..)
    , color, scheme, variant
    )

{-| `<m3e-theme-icon>` — an icon that visually previews a [`M3e.Theme`](M3e.Theme)
colour scheme, showing a small palette swatch.

Spec (per upstream CEM):

  - Required: none
  - Options: color, scheme, variant
  - Slots: none (self-rendering leaf)
  - Attrs: `color`, `scheme`, `variant` via `Node.attribute` (introspectable)
  - Tag: themeIcon

@docs view
@docs Option
@docs Scheme, Variant
@docs color, scheme, variant

-}

import M3e.Element exposing (Element, Supported)
import M3e.Internal as Internal
import M3e.Node as Node


{-| The colour scheme rendered by the icon.

  - `Auto` — follows the system preference (default).
  - `Dark` — always dark.
  - `Light` — always light.

Upstream: `scheme` attribute on `<m3e-theme-icon>`, `ColorScheme` type.

-}
type Scheme
    = Auto
    | Dark
    | Light


{-| The colour variant used to generate the theme palette.

Upstream: `variant` attribute on `<m3e-theme-icon>`, `ThemeVariant` type.

-}
type Variant
    = Content
    | Expressive
    | Fidelity
    | FruitSalad
    | Monochrome
    | Neutral
    | Rainbow
    | TonalSpot
    | Vibrant


{-| Private configuration record.
-}
type alias Config =
    { color : Maybe String
    , scheme : Maybe Scheme
    , variant : Maybe Variant
    }


{-| Configuration option for [`view`](#view).
-}
type alias Option msg =
    Internal.Option Config msg


{-| Set the seed hex colour of the theme to preview (the `color` attribute).
Defaults to `"#6750A4"` when omitted.
-}
color : String -> Option msg
color v =
    Internal.option (\c -> { c | color = Just v })


{-| Set the colour scheme of the preview (the `scheme` attribute).
Default `Auto`.
-}
scheme : Scheme -> Option msg
scheme s =
    Internal.option (\c -> { c | scheme = Just s })


{-| Set the colour variant of the preview (the `variant` attribute).
Default `Neutral`.
-}
variant : Variant -> Option msg
variant v =
    Internal.option (\c -> { c | variant = Just v })


{-| Render an `<m3e-theme-icon>`.

    M3e.ThemeIcon.view
        [ M3e.ThemeIcon.color "#6750A4"
        , M3e.ThemeIcon.scheme M3e.ThemeIcon.Dark
        , M3e.ThemeIcon.variant M3e.ThemeIcon.TonalSpot
        ]

-}
view : List (Option msg) -> Element { s | themeIcon : Supported } msg
view opts =
    let
        c : Config
        c =
            Internal.applyOptions opts
                { color = Nothing
                , scheme = Nothing
                , variant = Nothing
                }
    in
    Internal.fromNode
        (Node.element "m3e-theme-icon"
            (List.filterMap identity
                [ Maybe.map (Node.attribute "color") c.color
                , Maybe.map (\s -> Node.attribute "scheme" (schemeToString s)) c.scheme
                , Maybe.map (\v -> Node.attribute "variant" (variantToString v)) c.variant
                ]
            )
            []
        )


schemeToString : Scheme -> String
schemeToString s =
    case s of
        Auto ->
            "auto"

        Dark ->
            "dark"

        Light ->
            "light"


variantToString : Variant -> String
variantToString v =
    case v of
        Content ->
            "content"

        Expressive ->
            "expressive"

        Fidelity ->
            "fidelity"

        FruitSalad ->
            "fruit-salad"

        Monochrome ->
            "monochrome"

        Neutral ->
            "neutral"

        Rainbow ->
            "rainbow"

        TonalSpot ->
            "tonal-spot"

        Vibrant ->
            "vibrant"
