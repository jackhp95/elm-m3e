module M3e.Cem.Html.StateLayer exposing (disableHover, disabled, for, stateLayer)

{-| 
@docs stateLayer, disabled, disableHover, for
-}


import Html
import Html.Attributes
import Json.Encode


{-| The raw `<m3e-state-layer>` element — a partial application of `Html.node`. -}
stateLayer : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
stateLayer =
    Html.node "m3e-state-layer"


{-| Whether hover and focus events will not trigger the state layer. State layers can still
be controlled manually using the `show` and `hide` methods. (default: `false`)
-}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| Whether hover events will not trigger the state layer. State layers can still
be controlled manually using the `show` and `hide` methods. (default: `false`)
-}
disableHover : Bool -> Html.Attribute msg
disableHover val_ =
    Html.Attributes.property "disableHover" (Json.Encode.bool val_)


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for : String -> Html.Attribute msg
for =
    Html.Attributes.attribute "for"