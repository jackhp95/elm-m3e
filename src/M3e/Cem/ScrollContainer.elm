module M3e.Cem.ScrollContainer exposing ( scrollContainer, dividers, thin )

{-|
Middle layer for `<m3e-scroll-container>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.ScrollContainer` module for everyday use.

@docs scrollContainer, dividers, thin
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.Html.ScrollContainer
import M3e.Value


{-| A vertically oriented content container which presents dividers above and below content when scrolled.

**Component Info:**
- **Extends:** `LitElement`
-}
scrollContainer :
    List (M3e.Cem.Attr.Attr { dividers : M3e.Value.Supported
    , thin : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
scrollContainer attributes children =
    M3e.Cem.Html.ScrollContainer.scrollContainer
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| The dividers used to separate scrollable content. (default: `"above-below"`) -}
dividers :
    M3e.Value.Value { above : M3e.Value.Supported
    , aboveBelow : M3e.Value.Supported
    , below : M3e.Value.Supported
    , none : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | dividers : M3e.Value.Supported } msg
dividers v_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.ScrollContainer.dividers
        (M3e.Value.toString v_)


{-| Whether to present thin scrollbars. (default: `false`) -}
thin : Bool -> M3e.Cem.Attr.Attr { c | thin : M3e.Value.Supported } msg
thin =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.ScrollContainer.thin