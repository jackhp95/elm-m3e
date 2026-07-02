module M3e.Cem.Html.Tooltip exposing
    ( tooltip, disabled, for, hideDelay, position, showDelay
    , touchGestures
    )

{-|
Bottom layer for `<m3e-tooltip>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, R1-correct DOM emission, no phantom typing. The rawest escape in the gradient.

@docs tooltip, disabled, for, hideDelay, position, showDelay
@docs touchGestures
-}


import Html
import Html.Attributes
import Json.Encode


{-| The raw `<m3e-tooltip>` element — a partial application of `Html.node`. -}
tooltip : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
tooltip =
    Html.node "m3e-tooltip"


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for : String -> Html.Attribute msg
for =
    Html.Attributes.attribute "for"


{-| The amount of time, in milliseconds, before hiding the tooltip. (default: `200`) -}
hideDelay : Float -> Html.Attribute msg
hideDelay val_ =
    Html.Attributes.property "hideDelay" (Json.Encode.float val_)


{-| The position of the tooltip. (default: `"below"`) -}
position : String -> Html.Attribute msg
position =
    Html.Attributes.attribute "position"


{-| The amount of time, in milliseconds, before showing the tooltip. (default: `0`) -}
showDelay : Float -> Html.Attribute msg
showDelay val_ =
    Html.Attributes.property "showDelay" (Json.Encode.float val_)


{-| The mode in which to handle touch gestures. (default: `"auto"`) -}
touchGestures : String -> Html.Attribute msg
touchGestures =
    Html.Attributes.attribute "touch-gestures"