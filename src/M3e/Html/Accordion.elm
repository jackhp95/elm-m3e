module M3e.Html.Accordion exposing (accordion, multi)

{-| Middle layer for `<m3e-accordion>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.Accordion` module for everyday use.

@docs accordion, multi

-}

import Html
import M3e.Raw.Accordion
import M3e.Token
import Markup.Html.Attr
import Markup.Html.Attr.Internal


{-| Combines multiple expansion panels in to an accordion.

**Component Info:**

  - **Extends:** `LitElement`

-}
accordion :
    List
        (Markup.Html.Attr.Attr
            { multi : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
accordion attributes children =
    M3e.Raw.Accordion.accordion
        (List.map Markup.Html.Attr.toAttribute attributes)
        children


{-| Whether multiple expansion panels can be open at the same time. (default: `false`)
-}
multi : Bool -> Markup.Html.Attr.Attr { c | multi : M3e.Token.Supported } msg
multi =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Accordion.multi
