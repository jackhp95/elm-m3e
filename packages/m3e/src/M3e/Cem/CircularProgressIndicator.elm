module M3e.Cem.CircularProgressIndicator exposing
    ( circularProgressIndicator, indeterminate, max, value, variant
    )

{-|
Middle layer for `<m3e-circular-progress-indicator>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.CircularProgressIndicator` module for everyday use.

@docs circularProgressIndicator, indeterminate, max, value, variant
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.Html.CircularProgressIndicator
import M3e.Value


{-| A circular indicator of progress and activity.

**Component Info:**
- **Extends:** `ProgressElementIndicatorBase` from `/src/progress-indicator/ProgressElementIndicatorBase`
-}
circularProgressIndicator :
    List (M3e.Cem.Attr.Attr { indeterminate : M3e.Value.Supported
    , max : M3e.Value.Supported
    , value : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
circularProgressIndicator attributes children =
    M3e.Cem.Html.CircularProgressIndicator.circularProgressIndicator
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| Whether to show something is happening without conveying progress. (default: `false`) -}
indeterminate :
    Bool -> M3e.Cem.Attr.Attr { c | indeterminate : M3e.Value.Supported } msg
indeterminate =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.CircularProgressIndicator.indeterminate


{-| The maximum progress value. (default: `100`) -}
max : Float -> M3e.Cem.Attr.Attr { c | max : M3e.Value.Supported } msg
max =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.CircularProgressIndicator.max


{-| A fractional value, between 0 and `max`, indicating progress. (default: `0`) -}
value : Float -> M3e.Cem.Attr.Attr { c | value : M3e.Value.Supported } msg
value =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.CircularProgressIndicator.value


{-| The appearance of the indicator. (default: `"flat"`) -}
variant :
    M3e.Value.Value { flat : M3e.Value.Supported, wavy : M3e.Value.Supported }
    -> M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variant v_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.CircularProgressIndicator.variant
        (M3e.Value.toString v_)