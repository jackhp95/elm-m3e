module M3e.Slide exposing (view, selectedIndex)

{-| A carousel-like container used to horizontally cycle through slotted items.

**Component Info:**

  - **Extends:** `LitElement`

@docs view, selectedIndex

-}

import M3e.Element
import M3e.Element.Internal
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Html.Slide
import M3e.Node
import M3e.Token


{-| Build the `<m3e-slide>` element (lazy IR).
-}
view :
    List
        (M3e.Html.Attr.Attr
            { selectedIndex : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | slide : M3e.Token.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Html.Slide.slide
                    (List.map M3e.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map M3e.Html.Attr.Internal.forget attributes)
            (List.map M3e.Element.toNode children)
        )


{-| The zero-based index of the visible item. (default: `null`)
-}
selectedIndex : Float -> M3e.Html.Attr.Attr { c | selectedIndex : M3e.Token.Supported } msg
selectedIndex =
    M3e.Html.Slide.selectedIndex
