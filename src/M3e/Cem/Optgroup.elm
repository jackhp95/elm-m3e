module M3e.Cem.Optgroup exposing ( optgroup )

{-|
Middle layer for `<m3e-optgroup>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.Optgroup` module for everyday use.

@docs optgroup
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Html.Optgroup
import M3e.Value


{-| Groups options under a subheading.

**Component Info:**
- **Extends:** `LitElement`

**Slots:**
- `label`: Renders the label of the group.
-}
optgroup :
    List (M3e.Cem.Attr.Attr { slot : M3e.Value.Supported } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
optgroup attributes children =
    M3e.Cem.Html.Optgroup.optgroup
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children