module M3e.Slide exposing (view, selectedIndex)

{-| A carousel-like container used to horizontally cycle through slotted items.

**Component Info:**

  - **Extends:** `LitElement`

@docs view, selectedIndex

-}

import M3e.Html.Slide
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Node


{-| Build the `<m3e-slide>` element (lazy IR).
-}
view :
    List
        (Markup.Html.Attr.Attr
            { selectedIndex : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | slide : M3e.Kind.Brand } msg
view attributes children =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.Slide.slide
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.map Markup.Element.toNode children)
        )


{-| The zero-based index of the visible item. (default: `null`)
-}
selectedIndex :
    Float
    -> Markup.Html.Attr.Attr { c | selectedIndex : M3e.Token.Supported } msg
selectedIndex =
    M3e.Html.Slide.selectedIndex
