module M3e.Cem.Html.Elevation exposing ( elevation, disabled, for, level )

{-|
Bottom layer for `<m3e-elevation>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, R1-correct DOM emission, no phantom typing. The rawest escape in the gradient.

@docs elevation, disabled, for, level
-}


import Html
import Html.Attributes
import Json.Encode


{-| The raw `<m3e-elevation>` element — a partial application of `Html.node`. -}
elevation : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
elevation =
    Html.node "m3e-elevation"


{-| Whether hover and press events will not trigger changes in elevation, when attached to an interactive element. (default: `false`) -}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for : String -> Html.Attribute msg
for =
    Html.Attributes.attribute "for"


{-| The level at which to visually depict elevation. (default: `null`) -}
level : Int -> Html.Attribute msg
level val_ =
    Html.Attributes.property "level" (Json.Encode.int val_)