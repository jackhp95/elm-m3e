module M3e.Cem.Html.Elevation exposing (disabled, elevation, for, level)

{-| 
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
level : String -> Html.Attribute msg
level =
    Html.Attributes.attribute "level"