module M3e.Cem.FocusTrap exposing ( focusTrap, disabled )

{-|
Middle layer for `<m3e-focus-trap>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.FocusTrap` module for everyday use.

@docs focusTrap, disabled
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Html.FocusTrap
import M3e.Value


{-| A non-visual element used to trap focus within nested content.

**Component Info:**
- **Extends:** `LitElement`
-}
focusTrap :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
focusTrap attributes children =
    M3e.Cem.Html.FocusTrap.focusTrap
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| Disables the focus trap. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.Attr.attribute M3e.Cem.Html.FocusTrap.disabled