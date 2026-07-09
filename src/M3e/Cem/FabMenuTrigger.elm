module M3e.Cem.FabMenuTrigger exposing ( fabMenuTrigger, for )

{-|
Middle layer for `<m3e-fab-menu-trigger>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.FabMenuTrigger` module for everyday use.

@docs fabMenuTrigger, for
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.Html.FabMenuTrigger
import M3e.Value


{-| An element, nested within a clickable element, used to open a floating action button (FAB) menu.

**Component Info:**
- **Extends:** `ActionElementBase`
-}
fabMenuTrigger :
    List (M3e.Cem.Attr.Attr { for : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
fabMenuTrigger attributes children =
    M3e.Cem.Html.FabMenuTrigger.fabMenuTrigger
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for : String -> M3e.Cem.Attr.Attr { c | for : M3e.Value.Supported } msg
for =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.FabMenuTrigger.for