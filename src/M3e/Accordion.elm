module M3e.Accordion exposing (view, multi)

{-| Combines multiple expansion panels in to an accordion.

**Component Info:**

  - **Extends:** `LitElement`

@docs view, multi

-}

import M3e.Element
import M3e.Element.Internal
import M3e.Html.Accordion
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Node
import M3e.Token


{-| Build the `<m3e-accordion>` element (lazy IR).
-}
view :
    List
        (M3e.Html.Attr.Attr
            { multi : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element { expansionPanel : M3e.Token.Supported } msg)
    -> M3e.Element.Element { s | accordion : M3e.Token.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Html.Accordion.accordion
                    (List.map M3e.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map M3e.Html.Attr.Internal.forget attributes)
            (List.map M3e.Element.toNode children)
        )


{-| Whether multiple expansion panels can be open at the same time. (default: `false`)
-}
multi : Bool -> M3e.Html.Attr.Attr { c | multi : M3e.Token.Supported } msg
multi =
    M3e.Html.Accordion.multi
