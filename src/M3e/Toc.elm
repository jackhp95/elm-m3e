module M3e.Toc exposing (view, for, maxDepth, overline, title)

{-| A table of contents that provides in-page scroll navigation.

**Component Info:**

  - **Extends:** `LitElement`

**Slots:**

  - `overline`: Renders the overline of the table of contents.
  - `title`: Renders the title of the table of contents.

@docs view, for, maxDepth, overline, title

-}

import M3e.Html.Toc
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Kind
import Markup.Node


{-| Build the `<m3e-toc>` element (lazy IR).
-}
view :
    List
        (Markup.Html.Attr.Attr
            { for : M3e.Token.Supported
            , maxDepth : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | toc : M3e.Kind.Brand } msg
view attributes children =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.Toc.toc
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.map Markup.Element.toNode children)
        )


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for : String -> Markup.Html.Attr.Attr { c | for : M3e.Token.Supported } msg
for =
    M3e.Html.Toc.for


{-| The maximum depth of the table of contents. (default: `2`)
-}
maxDepth : Float -> Markup.Html.Attr.Attr { c | maxDepth : M3e.Token.Supported } msg
maxDepth =
    M3e.Html.Toc.maxDepth


{-| Place content in the `overline` slot.
-}
overline :
    Markup.Element.Element { text : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
overline el =
    Markup.Element.Internal.placeSlot "overline" el


{-| Place content in the `title` slot.
-}
title :
    Markup.Element.Element { text : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
title el =
    Markup.Element.Internal.placeSlot "title" el
