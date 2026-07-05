module M3e.Cem.Html.Heading exposing
    ( heading, emphasized, level, size, variant
    )

{-|
Bottom layer for `<m3e-heading>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, R1-correct DOM emission, no phantom typing. The rawest escape in the gradient.

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
level : Int -> Html.Attribute msg
level val_ =
    Html.Attributes.property "level" (Json.Encode.int val_)


{-| The size of the heading. (default: `"medium"`) -}
size : String -> Html.Attribute msg
size =
    Html.Attributes.attribute "size"


{-| The appearance variant of the heading. (default: `"display"`) -}
variant : String -> Html.Attribute msg
variant =
    Html.Attributes.attribute "variant"