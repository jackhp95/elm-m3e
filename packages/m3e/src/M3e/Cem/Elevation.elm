module M3e.Cem.Elevation exposing ( elevation, disabled, for, level )

{-|
Middle layer for `<m3e-elevation>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.Elevation` module for everyday use.

@docs elevation, disabled, for, level
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Html.Elevation
import M3e.Value


{-| Visually depicts elevation using a shadow.

**Component Info:**
- **Extends:** `LitElement`
-}
elevation :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , for : M3e.Value.Supported
    , level : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
elevation attributes children =
    M3e.Cem.Html.Elevation.elevation
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| Whether hover and press events will not trigger changes in elevation, when attached to an interactive element. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Elevation.disabled


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for : String -> M3e.Cem.Attr.Attr { c | for : M3e.Value.Supported } msg
for =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Elevation.for


{-| The level at which to visually depict elevation. (default: `null`) -}
level : String -> M3e.Cem.Attr.Attr { c | level : M3e.Value.Supported } msg
level =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Elevation.level