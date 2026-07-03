module M3e.Cem.NavRailToggle exposing ( navRailToggle, for )

{-|
Middle layer for `<m3e-nav-rail-toggle>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.NavRailToggle` module for everyday use.

@docs navRailToggle, for
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Html.NavRailToggle
import M3e.Value


{-| An element, nested within a clickable element, used to toggle the expanded state of a navigation rail.

**Component Info:**
- **Extends:** `ActionElementBase`
-}
navRailToggle :
    List (M3e.Cem.Attr.Attr { for : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
navRailToggle attributes children =
    M3e.Cem.Html.NavRailToggle.navRailToggle
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for : String -> M3e.Cem.Attr.Attr { c | for : M3e.Value.Supported } msg
for =
    M3e.Cem.Attr.attribute M3e.Cem.Html.NavRailToggle.for