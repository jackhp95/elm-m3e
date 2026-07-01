module M3e.Cem.Html.Heading exposing (emphasized, heading, level, size, variant)

{-| 
@docs heading, emphasized, level, size, variant
-}


import Html
import Html.Attributes
import Json.Encode


{-| The raw `<m3e-heading>` element — a partial application of `Html.node`. -}
heading : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
heading =
    Html.node "m3e-heading"


{-| Whether the heading uses an emphasized typescale. (default: `false`) -}
emphasized : Bool -> Html.Attribute msg
emphasized val_ =
    Html.Attributes.property "emphasized" (Json.Encode.bool val_)


{-| The accessibility level of the heading. -}
level : String -> Html.Attribute msg
level =
    Html.Attributes.attribute "level"


{-| The size of the heading. (default: `"medium"`) -}
size : String -> Html.Attribute msg
size =
    Html.Attributes.attribute "size"


{-| The appearance variant of the heading. (default: `"display"`) -}
variant : String -> Html.Attribute msg
variant =
    Html.Attributes.attribute "variant"