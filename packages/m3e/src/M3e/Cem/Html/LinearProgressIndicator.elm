module M3e.Cem.Html.LinearProgressIndicator exposing (bufferValue, linearProgressIndicator, max, mode, value, variant)

{-| 
@docs linearProgressIndicator, bufferValue, max, mode, value, variant
-}


import Html
import Html.Attributes
import Json.Encode


{-| The raw `<m3e-linear-progress-indicator>` element — a partial application of `Html.node`. -}
linearProgressIndicator :
    List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
linearProgressIndicator =
    Html.node "m3e-linear-progress-indicator"


{-| A fractional value, between 0 and `max`, indicating buffer progress. (default: `0`) -}
bufferValue : Float -> Html.Attribute msg
bufferValue val_ =
    Html.Attributes.property "bufferValue" (Json.Encode.float val_)


{-| The maximum progress value. (default: `100`) -}
max : Float -> Html.Attribute msg
max val_ =
    Html.Attributes.property "max" (Json.Encode.float val_)


{-| The mode of the progress bar. (default: `"determinate"`) -}
mode : String -> Html.Attribute msg
mode =
    Html.Attributes.attribute "mode"


{-| A fractional value, between 0 and `max`, indicating progress. (default: `0`) -}
value : Float -> Html.Attribute msg
value val_ =
    Html.Attributes.property "value" (Json.Encode.float val_)


{-| The appearance of the indicator. (default: `"flat"`) -}
variant : String -> Html.Attribute msg
variant =
    Html.Attributes.attribute "variant"