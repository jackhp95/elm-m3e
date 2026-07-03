module M3e.Cem.ActionElementBase exposing ( actionElementBase )

{-|
Middle layer for `<ActionElementBase>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.ActionElementBase` module for everyday use.

@docs actionElementBase
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Html.ActionElementBase
import M3e.Value


{-| A base implementation for an element, nested within a clickable element, used to
perform an action. This class must be inherited.

**Component Info:**
- **Extends:** `LitElement`
-}
actionElementBase :
    List (M3e.Cem.Attr.Attr { slot : M3e.Value.Supported } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
actionElementBase attributes children =
    M3e.Cem.Html.ActionElementBase.actionElementBase
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children