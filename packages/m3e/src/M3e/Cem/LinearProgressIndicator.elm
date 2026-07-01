module M3e.Cem.LinearProgressIndicator exposing (bufferValue, linearProgressIndicator, max, mode, value, variant)

{-| 
@docs linearProgressIndicator, bufferValue, max, mode, value, variant
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Html.LinearProgressIndicator
import M3e.Value


{-| A horizontal bar for indicating progress and activity.

**Component Info:**
- **Extends:** `ProgressElementIndicatorBase` from `/src/progress-indicator/ProgressElementIndicatorBase`
-}
linearProgressIndicator :
    List (M3e.Cem.Attr.Attr { bufferValue : M3e.Value.Supported
    , max : M3e.Value.Supported
    , mode : M3e.Value.Supported
    , value : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
linearProgressIndicator attributes children =
    M3e.Cem.Html.LinearProgressIndicator.linearProgressIndicator
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| A fractional value, between 0 and `max`, indicating buffer progress. (default: `0`) -}
bufferValue :
    Float -> M3e.Cem.Attr.Attr { c | bufferValue : M3e.Value.Supported } msg
bufferValue =
    M3e.Cem.Attr.attribute M3e.Cem.Html.LinearProgressIndicator.bufferValue


{-| The maximum progress value. (default: `100`) -}
max : Float -> M3e.Cem.Attr.Attr { c | max : M3e.Value.Supported } msg
max =
    M3e.Cem.Attr.attribute M3e.Cem.Html.LinearProgressIndicator.max


{-| The mode of the progress bar. (default: `"determinate"`) -}
mode :
    M3e.Value.Value { buffer : M3e.Value.Supported
    , determinate : M3e.Value.Supported
    , indeterminate : M3e.Value.Supported
    , query : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | mode : M3e.Value.Supported } msg
mode v_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.LinearProgressIndicator.mode
        (M3e.Value.toString v_)


{-| A fractional value, between 0 and `max`, indicating progress. (default: `0`) -}
value : Float -> M3e.Cem.Attr.Attr { c | value : M3e.Value.Supported } msg
value =
    M3e.Cem.Attr.attribute M3e.Cem.Html.LinearProgressIndicator.value


{-| The appearance of the indicator. (default: `"flat"`) -}
variant :
    M3e.Value.Value { flat : M3e.Value.Supported, wavy : M3e.Value.Supported }
    -> M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variant v_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.LinearProgressIndicator.variant
        (M3e.Value.toString v_)