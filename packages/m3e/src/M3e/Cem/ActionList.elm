module M3e.Cem.ActionList exposing ( actionList, variant )

{-|
Middle layer for `<m3e-action-list>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.ActionList` module for everyday use.

@docs actionList, variant
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Html.ActionList
import M3e.Value


{-| A list of actions.

**Component Info:**
- **Extends:** `M3eListElement` from `/src/list/ListElement`
-}
actionList :
    List (M3e.Cem.Attr.Attr { variant : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
actionList attributes children =
    M3e.Cem.Html.ActionList.actionList
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| The appearance variant of the list. (default: `"standard"`) -}
variant :
    M3e.Value.Value { segmented : M3e.Value.Supported
    , standard : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variant v_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.ActionList.variant
        (M3e.Value.toString v_)