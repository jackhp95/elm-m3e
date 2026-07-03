module M3e.Cem.PseudoCheckbox exposing ( pseudoCheckbox, checked, disabled, indeterminate )

{-|
Middle layer for `<m3e-pseudo-checkbox>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.PseudoCheckbox` module for everyday use.

@docs pseudoCheckbox, checked, disabled, indeterminate
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Html.PseudoCheckbox
import M3e.Value


{-| An element which looks like a checkbox.

**Component Info:**
- **Extends:** `LitElement`
-}
pseudoCheckbox :
    List (M3e.Cem.Attr.Attr { checked : M3e.Value.Supported
    , disabled : M3e.Value.Supported
    , indeterminate : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
pseudoCheckbox attributes children =
    M3e.Cem.Html.PseudoCheckbox.pseudoCheckbox
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| A value indicating whether the element is checked. (default: `false`) -}
checked : Bool -> M3e.Cem.Attr.Attr { c | checked : M3e.Value.Supported } msg
checked =
    M3e.Cem.Attr.attribute M3e.Cem.Html.PseudoCheckbox.checked


{-| A value indicating whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.Attr.attribute M3e.Cem.Html.PseudoCheckbox.disabled


{-| A value indicating whether the element's checked state is indeterminate. (default: `false`) -}
indeterminate :
    Bool -> M3e.Cem.Attr.Attr { c | indeterminate : M3e.Value.Supported } msg
indeterminate =
    M3e.Cem.Attr.attribute M3e.Cem.Html.PseudoCheckbox.indeterminate