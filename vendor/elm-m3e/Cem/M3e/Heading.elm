module Cem.M3e.Heading exposing
    ( component
    , emphasized, level, Size(..), size, Variant(..), variant
    , sizeToString, variantToString
    )

{-| A heading to a page or section.


## Component

@docs component


### Attributes

@docs emphasized, level, Size, size, Variant, variant

-}

import Html
import Html.Attributes
import Json.Encode


{-| A heading to a page or section.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-heading" attributes children


{-| Whether the heading uses an emphasized typescale. (default: `false`)
-}
emphasized : Bool -> Html.Attribute msg
emphasized val_ =
    Html.Attributes.property "emphasized" (Json.Encode.bool val_)


{-| The accessibility level of the heading.
-}
level : String -> Html.Attribute msg
level val_ =
    Html.Attributes.attribute "level" val_


{-| Values for the `size` attribute.
-}
type Size
    = Large
    | Medium
    | Small


{-| The size of the heading. (default: `"medium"`)
-}
size : Size -> Html.Attribute msg
size val_ =
    Html.Attributes.attribute "size" (sizeToString val_)


sizeToString : Size -> String
sizeToString val_ =
    case val_ of
        Large ->
            "large"

        Medium ->
            "medium"

        Small ->
            "small"


{-| Values for the `variant` attribute.
-}
type Variant
    = Display
    | Headline
    | Label
    | Title


{-| The appearance variant of the heading. (default: `"display"`)
-}
variant : Variant -> Html.Attribute msg
variant val_ =
    Html.Attributes.attribute "variant" (variantToString val_)


variantToString : Variant -> String
variantToString val_ =
    case val_ of
        Display ->
            "display"

        Headline ->
            "headline"

        Label ->
            "label"

        Title ->
            "title"
