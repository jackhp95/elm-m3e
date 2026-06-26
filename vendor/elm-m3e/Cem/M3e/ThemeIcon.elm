module Cem.M3e.ThemeIcon exposing (Scheme(..), Variant(..), color, component, scheme, variant)

{-| 
An icon that visually presents a preview of a theme.

## Component

@docs component

### Attributes

@docs color, Scheme, scheme, Variant, variant
-}


import Html
import Html.Attributes


{-| An icon that visually presents a preview of a theme. -}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-theme-icon" attributes children


{-| The hex color of the theme to preview (default: `"#6750A4"`) -}
color : String -> Html.Attribute msg
color val_ =
    Html.Attributes.attribute "color" val_


{-| Values for the `scheme` attribute. -}
type Scheme
    = Auto
    | Dark
    | Light


{-| The color scheme of the theme. (default: `"auto"`) -}
scheme : Scheme -> Html.Attribute msg
scheme val_ =
    Html.Attributes.attribute "scheme" (schemeToString val_)


schemeToString : Scheme -> String
schemeToString val_ =
    case val_ of
        Auto ->
            "auto"
    
        Dark ->
            "dark"
    
        Light ->
            "light"


{-| Values for the `variant` attribute. -}
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


{-| The color variant of the theme. (default: `"neutral"`) -}
variant : Variant -> Html.Attribute msg
variant val_ =
    Html.Attributes.attribute "variant" (variantToString val_)


variantToString : Variant -> String
variantToString val_ =
    case val_ of
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