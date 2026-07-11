module M3e.ActionList exposing (view, variant)

{-| A list of actions.

**Component Info:**

  - **Extends:** `M3eListElement` from `/src/list/ListElement`

@docs view, variant

-}

import M3e.Element
import M3e.Element.Internal
import M3e.Html.ActionList
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Node
import M3e.Token


{-| Build the `<m3e-action-list>` element (lazy IR).
-}
view :
    List
        (M3e.Html.Attr.Attr
            { variant : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    ->
        List
            (M3e.Element.Element
                { listAction : M3e.Token.Supported
                , expandableListItem : M3e.Token.Supported
                , divider : M3e.Token.Supported
                }
                msg
            )
    -> M3e.Element.Element { s | actionList : M3e.Token.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Html.ActionList.actionList
                    (List.map M3e.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map M3e.Html.Attr.Internal.forget attributes)
            (List.map M3e.Element.toNode children)
        )


{-| The appearance variant of the list. (default: `"standard"`)
-}
variant :
    M3e.Token.Value
        { segmented : M3e.Token.Supported
        , standard : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variant =
    M3e.Html.ActionList.variant
