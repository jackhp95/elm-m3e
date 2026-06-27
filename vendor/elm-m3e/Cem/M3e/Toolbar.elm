module Cem.M3e.Toolbar exposing
    ( component
    , elevated, Shape(..), shape, Variant(..), variant, vertical
    , shapeToString, variantToString
    )

{-| Presents frequently used actions relevant to the current page.


## Component

@docs component


### Attributes

@docs elevated, Shape, shape, Variant, variant, vertical

-}

import Html
import Html.Attributes
import Json.Encode


{-| Presents frequently used actions relevant to the current page.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-toolbar" attributes children


{-| Whether the toolbar is elevated. (default: `false`)
-}
elevated : Bool -> Html.Attribute msg
elevated val_ =
    Html.Attributes.property "elevated" (Json.Encode.bool val_)


{-| Values for the `shape` attribute.
-}
type Shape
    = Rounded
    | Square


{-| The shape of the toolbar. (default: `"square"`)
-}
shape : Shape -> Html.Attribute msg
shape val_ =
    Html.Attributes.attribute "shape" (shapeToString val_)


shapeToString : Shape -> String
shapeToString val_ =
    case val_ of
        Rounded ->
            "rounded"

        Square ->
            "square"


{-| Values for the `variant` attribute.
-}
type Variant
    = Standard
    | Vibrant


{-| The appearance variant of the toolbar. (default: `"standard"`)
-}
variant : Variant -> Html.Attribute msg
variant val_ =
    Html.Attributes.attribute "variant" (variantToString val_)


variantToString : Variant -> String
variantToString val_ =
    case val_ of
        Standard ->
            "standard"

        Vibrant ->
            "vibrant"


{-| Whether the element is oriented vertically. (default: `false`)
-}
vertical : Bool -> Html.Attribute msg
vertical val_ =
    Html.Attributes.property "vertical" (Json.Encode.bool val_)
