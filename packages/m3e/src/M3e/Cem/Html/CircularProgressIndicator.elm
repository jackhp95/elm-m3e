module M3e.Cem.Html.CircularProgressIndicator exposing
    ( circularProgressIndicator, indeterminate, max, value, variant
    )

{-|
Bottom layer for `<m3e-circular-progress-indicator>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, R1-correct DOM emission, no phantom typing. The rawest escape in the gradient.

@docs circularProgressIndicator, indeterminate, max, value, variant
-}


import Html
import Html.Attributes
import Json.Encode


{-| The raw `<m3e-circular-progress-indicator>` element — a partial application of `Html.node`. -}
circularProgressIndicator :
    List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
circularProgressIndicator =
    Html.node "m3e-circular-progress-indicator"


{-| Whether to show something is happening without conveying progress. (default: `false`) -}
indeterminate : Bool -> Html.Attribute msg
indeterminate val_ =
    Html.Attributes.property "indeterminate" (Json.Encode.bool val_)


{-| The maximum progress value. (default: `100`) -}
max : Float -> Html.Attribute msg
max val_ =
    Html.Attributes.property "max" (Json.Encode.float val_)


{-| A fractional value, between 0 and `max`, indicating progress. (default: `0`) -}
value : Float -> Html.Attribute msg
value val_ =
    Html.Attributes.property "value" (Json.Encode.float val_)


{-| The appearance of the indicator. (default: `"flat"`) -}
variant : String -> Html.Attribute msg
variant =
    Html.Attributes.attribute "variant"