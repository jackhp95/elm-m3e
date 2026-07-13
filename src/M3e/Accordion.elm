module M3e.Accordion exposing (view, multi)

{-| Combines multiple expansion panels in to an accordion.

**Component Info:**

  - **Extends:** `LitElement`

@docs view, multi

-}

import M3e.Html.Accordion
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Node


{-| Build the `<m3e-accordion>` element (lazy IR).
-}
view :
    List
        (Markup.Html.Attr.Attr
            { multi : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element { expansionPanel : M3e.Kind.Brand } msg)
    -> Markup.Element.Element { s | accordion : M3e.Kind.Brand } msg
view attributes children =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.Accordion.accordion
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.map Markup.Element.toNode children)
        )


{-| Whether multiple expansion panels can be open at the same time. (default: `false`)
-}
multi : Bool -> Markup.Html.Attr.Attr { c | multi : M3e.Token.Supported } msg
multi =
    M3e.Html.Accordion.multi
