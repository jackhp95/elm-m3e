module M3e.Html.LinearProgressIndicator exposing (linearProgressIndicator, bufferValue, max, mode, value, variant)

{-| Middle layer for `<m3e-linear-progress-indicator>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.LinearProgressIndicator` module for everyday use.

@docs linearProgressIndicator, bufferValue, max, mode, value, variant

-}

import Html
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Raw.LinearProgressIndicator
import M3e.Token


{-| A horizontal bar for indicating progress and activity.

**Component Info:**

  - **Extends:** `ProgressElementIndicatorBase` from `/src/progress-indicator/ProgressElementIndicatorBase`

-}
linearProgressIndicator :
    List
        (M3e.Html.Attr.Attr
            { bufferValue : M3e.Token.Supported
            , max : M3e.Token.Supported
            , mode : M3e.Token.Supported
            , valueFloat : M3e.Token.Supported
            , variant : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
linearProgressIndicator attributes children =
    M3e.Raw.LinearProgressIndicator.linearProgressIndicator
        (List.map M3e.Html.Attr.toAttribute attributes)
        children


{-| A fractional value, between 0 and `max`, indicating buffer progress. (default: `0`)
-}
bufferValue : Float -> M3e.Html.Attr.Attr { c | bufferValue : M3e.Token.Supported } msg
bufferValue =
    M3e.Html.Attr.Internal.attribute M3e.Raw.LinearProgressIndicator.bufferValue


{-| The maximum progress value. (default: `100`)
-}
max : Float -> M3e.Html.Attr.Attr { c | max : M3e.Token.Supported } msg
max =
    M3e.Html.Attr.Internal.attribute M3e.Raw.LinearProgressIndicator.max


{-| The mode of the progress bar. (default: `"determinate"`)
-}
mode :
    M3e.Token.Value
        { buffer : M3e.Token.Supported
        , determinate : M3e.Token.Supported
        , indeterminate : M3e.Token.Supported
        , query : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | mode : M3e.Token.Supported } msg
mode v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.LinearProgressIndicator.mode
        (M3e.Token.toString v_)


{-| A fractional value, between 0 and `max`, indicating progress. (default: `0`)
-}
value : Float -> M3e.Html.Attr.Attr { c | valueFloat : M3e.Token.Supported } msg
value =
    M3e.Html.Attr.Internal.attribute M3e.Raw.LinearProgressIndicator.value


{-| The appearance of the indicator. (default: `"flat"`)
-}
variant :
    M3e.Token.Value { flat : M3e.Token.Supported, wavy : M3e.Token.Supported }
    -> M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variant v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.LinearProgressIndicator.variant
        (M3e.Token.toString v_)
