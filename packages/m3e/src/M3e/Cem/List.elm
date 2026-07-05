module M3e.Cem.List exposing ( list, variant )

{-|
Middle layer for `<m3e-list>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.List` module for everyday use.

@docs list, variant
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.Html.List
import M3e.Value


{-| A list of items.

**Component Info:**
- **Extends:** `LitElement`
-}
list :
    List (M3e.Cem.Attr.Attr { variant : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
list attributes children =
    M3e.Cem.Html.List.list
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| The appearance variant of the list. (default: `"standard"`) -}
variant :
    M3e.Value.Value { segmented : M3e.Value.Supported
    , standard : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variant v_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.List.variant
        (M3e.Value.toString v_)