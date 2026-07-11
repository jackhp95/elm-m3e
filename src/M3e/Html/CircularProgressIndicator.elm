module M3e.Html.CircularProgressIndicator exposing (circularProgressIndicator, indeterminate, max, value, variant)

{-| Middle layer for `<m3e-circular-progress-indicator>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.CircularProgressIndicator` module for everyday use.

@docs circularProgressIndicator, indeterminate, max, value, variant

-}

import Html
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Raw.CircularProgressIndicator
import M3e.Token


{-| A circular indicator of progress and activity.

**Component Info:**

  - **Extends:** `ProgressElementIndicatorBase` from `/src/progress-indicator/ProgressElementIndicatorBase`

-}
circularProgressIndicator :
    List
        (M3e.Html.Attr.Attr
            { indeterminate : M3e.Token.Supported
            , max : M3e.Token.Supported
            , valueFloat : M3e.Token.Supported
            , variant : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
circularProgressIndicator attributes children =
    M3e.Raw.CircularProgressIndicator.circularProgressIndicator
        (List.map M3e.Html.Attr.toAttribute attributes)
        children


{-| Whether to show something is happening without conveying progress. (default: `false`)
-}
indeterminate : Bool -> M3e.Html.Attr.Attr { c | indeterminate : M3e.Token.Supported } msg
indeterminate =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.CircularProgressIndicator.indeterminate


{-| The maximum progress value. (default: `100`)
-}
max : Float -> M3e.Html.Attr.Attr { c | max : M3e.Token.Supported } msg
max =
    M3e.Html.Attr.Internal.attribute M3e.Raw.CircularProgressIndicator.max


{-| A fractional value, between 0 and `max`, indicating progress. (default: `0`)
-}
value : Float -> M3e.Html.Attr.Attr { c | valueFloat : M3e.Token.Supported } msg
value =
    M3e.Html.Attr.Internal.attribute M3e.Raw.CircularProgressIndicator.value


{-| The appearance of the indicator. (default: `"flat"`)
-}
variant :
    M3e.Token.Value { flat : M3e.Token.Supported, wavy : M3e.Token.Supported }
    -> M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variant v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.CircularProgressIndicator.variant
        (M3e.Token.toString v_)
