module M3e.Raw.LinearProgressIndicator exposing (linearProgressIndicator, bufferValue, max, mode, value, variant)

{-| Bottom layer for `<m3e-linear-progress-indicator>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, faithful DOM emission, no phantom typing. The rawest escape in the gradient.

@docs linearProgressIndicator, bufferValue, max, mode, value, variant

-}

import Html
import Html.Attributes


{-| The raw `<m3e-linear-progress-indicator>` element — a partial application of `Html.node`.
-}
linearProgressIndicator : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
linearProgressIndicator =
    Html.node "m3e-linear-progress-indicator"


{-| A fractional value, between 0 and `max`, indicating buffer progress. (default: `0`)
-}
bufferValue : Float -> Html.Attribute msg
bufferValue val_ =
    Html.Attributes.attribute "buffer-value" (String.fromFloat val_)


{-| The maximum progress value. (default: `100`)
-}
max : Float -> Html.Attribute msg
max val_ =
    Html.Attributes.attribute "max" (String.fromFloat val_)


{-| The mode of the progress bar. (default: `"determinate"`)
-}
mode : String -> Html.Attribute msg
mode =
    Html.Attributes.attribute "mode"


{-| A fractional value, between 0 and `max`, indicating progress. (default: `0`)
-}
value : Float -> Html.Attribute msg
value val_ =
    Html.Attributes.attribute "value" (String.fromFloat val_)


{-| The appearance of the indicator. (default: `"flat"`)
-}
variant : String -> Html.Attribute msg
variant =
    Html.Attributes.attribute "variant"
