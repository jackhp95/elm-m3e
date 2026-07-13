module M3e.ActionList exposing (view, variant)

{-| A list of actions.

**Component Info:**

  - **Extends:** `M3eListElement` from `/src/list/ListElement`

@docs view, variant

-}

import M3e.Html.ActionList
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Node


{-| Build the `<m3e-action-list>` element (lazy IR).
-}
view :
    List
        (Markup.Html.Attr.Attr
            { variant : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    ->
        List
            (Markup.Element.Element
                { listAction : M3e.Kind.Brand
                , expandableListItem : M3e.Kind.Brand
                , divider : M3e.Kind.Brand
                }
                msg
            )
    -> Markup.Element.Element { s | actionList : M3e.Kind.Brand } msg
view attributes children =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.ActionList.actionList
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.map Markup.Element.toNode children)
        )


{-| The appearance variant of the list. (default: `"standard"`)
-}
variant :
    M3e.Token.Value
        { segmented : M3e.Token.Supported
        , standard : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variant =
    M3e.Html.ActionList.variant
