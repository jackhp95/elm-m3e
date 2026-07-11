module M3e.ChipSet exposing (view, vertical)

{-| A container used to organize chips into a cohesive unit.

**Component Info:**

  - **Extends:** `LitElement`

@docs view, vertical

-}

import M3e.Element
import M3e.Element.Internal
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Html.ChipSet
import M3e.Node
import M3e.Token


{-| Build the `<m3e-chip-set>` element (lazy IR).
-}
view :
    List
        (M3e.Html.Attr.Attr
            { vertical : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    ->
        List
            (M3e.Element.Element
                { assistChip : M3e.Token.Supported
                , chip : M3e.Token.Supported
                , filterChip : M3e.Token.Supported
                , inputChip : M3e.Token.Supported
                , suggestionChip : M3e.Token.Supported
                }
                msg
            )
    -> M3e.Element.Element { s | chipSet : M3e.Token.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Html.ChipSet.chipSet
                    (List.map M3e.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map M3e.Html.Attr.Internal.forget attributes)
            (List.map M3e.Element.toNode children)
        )


{-| Whether the element is oriented vertically. (default: `false`)
-}
vertical : Bool -> M3e.Html.Attr.Attr { c | vertical : M3e.Token.Supported } msg
vertical =
    M3e.Html.ChipSet.vertical
