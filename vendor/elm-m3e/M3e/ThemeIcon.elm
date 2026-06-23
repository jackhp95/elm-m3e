module M3e.ThemeIcon exposing (Variant(..), component, variant)

{-| 
An icon that visually presents a preview of a theme.

## Component

@docs component

### Attributes

@docs Variant, variant
-}


import Html
import Html.Attributes


{-| An icon that visually presents a preview of a theme. -}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-theme-icon" attributes children


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