module M3e.Cem.ProgressElementIndicatorBase exposing ( progressElementIndicatorBase, value, max, variant )

{-|
Middle layer for `<ProgressElementIndicatorBase>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.ProgressElementIndicatorBase` module for everyday use.

@docs progressElementIndicatorBase, value, max, variant
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.Html.ProgressElementIndicatorBase
import M3e.Value


{-| A base implementation for an element used to convey progress. This class must be inherited.

**Component Info:**
- **Extends:** `LitElement`
-}
progressElementIndicatorBase :
    List (M3e.Cem.Attr.Attr { value : M3e.Value.Supported
    , max : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
progressElementIndicatorBase attributes children =
    M3e.Cem.Html.ProgressElementIndicatorBase.progressElementIndicatorBase
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| A fractional value, between 0 and `max`, indicating progress. (default: `0`) -}
value : Float -> M3e.Cem.Attr.Attr { c | value : M3e.Value.Supported } msg
value =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.ProgressElementIndicatorBase.value


{-| The maximum progress value. (default: `100`) -}
max : Float -> M3e.Cem.Attr.Attr { c | max : M3e.Value.Supported } msg
max =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.ProgressElementIndicatorBase.max


{-| The appearance of the indicator. (default: `"flat"`) -}
variant :
    M3e.Value.Value { flat : M3e.Value.Supported, wavy : M3e.Value.Supported }
    -> M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variant v_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.ProgressElementIndicatorBase.variant
        (M3e.Value.toString v_)