module M3e.Cem.Accordion exposing ( accordion, multi )

{-|
Middle layer for `<m3e-accordion>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.Accordion` module for everyday use.

@docs accordion, multi
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Html.Accordion
import M3e.Value


{-| Combines multiple expansion panels in to an accordion.

**Component Info:**
- **Extends:** `LitElement`
-}
accordion :
    List (M3e.Cem.Attr.Attr { multi : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
accordion attributes children =
    M3e.Cem.Html.Accordion.accordion
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| Whether multiple expansion panels can be open at the same time. (default: `false`) -}
multi : Bool -> M3e.Cem.Attr.Attr { c | multi : M3e.Value.Supported } msg
multi =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Accordion.multi