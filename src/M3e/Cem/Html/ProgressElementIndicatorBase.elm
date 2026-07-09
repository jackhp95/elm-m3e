module M3e.Cem.Html.ProgressElementIndicatorBase exposing ( progressElementIndicatorBase, value, max, variant )

{-|
Bottom layer for `<ProgressElementIndicatorBase>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, R1-correct DOM emission, no phantom typing. The rawest escape in the gradient.

@docs progressElementIndicatorBase, value, max, variant
-}


import Html
import Html.Attributes


{-| The raw `<div>` element — a partial application of `Html.node`. -}
progressElementIndicatorBase :
    List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
progressElementIndicatorBase =
    Html.node "div"


{-| A fractional value, between 0 and `max`, indicating progress. (default: `0`) -}
value : Float -> Html.Attribute msg
value val_ =
    Html.Attributes.attribute "value" (String.fromFloat val_)


{-| The maximum progress value. (default: `100`) -}
max : Float -> Html.Attribute msg
max val_ =
    Html.Attributes.attribute "max" (String.fromFloat val_)


{-| The appearance of the indicator. (default: `"flat"`) -}
variant : String -> Html.Attribute msg
variant =
    Html.Attributes.attribute "variant"