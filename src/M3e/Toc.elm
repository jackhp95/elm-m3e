module M3e.Toc exposing (view, for, maxDepth, overline, title)

{-| A table of contents that provides in-page scroll navigation.

**Component Info:**

  - **Extends:** `LitElement`

**Slots:**

  - `overline`: Renders the overline of the table of contents.
  - `title`: Renders the title of the table of contents.

@docs view, for, maxDepth, overline, title

-}

import M3e.Element
import M3e.Element.Internal
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Html.Toc
import M3e.Node
import M3e.Token


{-| Build the `<m3e-toc>` element (lazy IR).
-}
view :
    List
        (M3e.Html.Attr.Attr
            { for : M3e.Token.Supported
            , maxDepth : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | toc : M3e.Token.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Html.Toc.toc
                    (List.map M3e.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map M3e.Html.Attr.Internal.forget attributes)
            (List.map M3e.Element.toNode children)
        )


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for : String -> M3e.Html.Attr.Attr { c | for : M3e.Token.Supported } msg
for =
    M3e.Html.Toc.for


{-| The maximum depth of the table of contents. (default: `2`)
-}
maxDepth : Float -> M3e.Html.Attr.Attr { c | maxDepth : M3e.Token.Supported } msg
maxDepth =
    M3e.Html.Toc.maxDepth


{-| Place content in the `overline` slot.
-}
overline :
    M3e.Element.Element { text : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
overline el =
    M3e.Element.Internal.placeSlot "overline" el


{-| Place content in the `title` slot.
-}
title :
    M3e.Element.Element { text : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
title el =
    M3e.Element.Internal.placeSlot "title" el
