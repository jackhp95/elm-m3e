module M3e.ChipSet exposing (view, vertical)

{-| A container used to organize chips into a cohesive unit.

**Component Info:**

  - **Extends:** `LitElement`

@docs view, vertical

-}

import M3e.Html.ChipSet
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Node


{-| Build the `<m3e-chip-set>` element (lazy IR).
-}
view :
    List
        (Markup.Html.Attr.Attr
            { vertical : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    ->
        List
            (Markup.Element.Element
                { assistChip : M3e.Kind.Brand
                , chip : M3e.Kind.Brand
                , filterChip : M3e.Kind.Brand
                , inputChip : M3e.Kind.Brand
                , suggestionChip : M3e.Kind.Brand
                }
                msg
            )
    -> Markup.Element.Element { s | chipSet : M3e.Kind.Brand } msg
view attributes children =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.ChipSet.chipSet
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.map Markup.Element.toNode children)
        )


{-| Whether the element is oriented vertically. (default: `false`)
-}
vertical : Bool -> Markup.Html.Attr.Attr { c | vertical : M3e.Token.Supported } msg
vertical =
    M3e.Html.ChipSet.vertical
