module M3e.TextOverflow exposing (view)

{-| An inline container which presents an ellipsis when content overflows.

**Component Info:**

  - **Extends:** `LitElement`

@docs view

-}

import M3e.Html.TextOverflow
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Kind
import Markup.Node


{-| Build the `<m3e-text-overflow>` element (lazy IR).
-}
view :
    List (Markup.Html.Attr.Attr { slot : M3e.Token.Supported } msg)
    -> List (Markup.Element.Element { text : Markup.Kind.Shared } msg)
    -> Markup.Element.Element { s | textOverflow : M3e.Kind.Brand } msg
view attributes children =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.TextOverflow.textOverflow
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.map Markup.Element.toNode children)
        )
