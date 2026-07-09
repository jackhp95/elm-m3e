module M3e.ActionList exposing ( view, variant )

{-|
A list of actions.

**Component Info:**
- **Extends:** `M3eListElement` from `/src/list/ListElement`

@docs view, variant
-}


import M3e.Cem.ActionList
import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-action-list>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { variant : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element { listAction : M3e.Value.Supported
    , expandableListItem : M3e.Value.Supported
    , divider : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | actionList : M3e.Value.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.ActionList.actionList
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Element.toNode children)
        )


{-| The appearance variant of the list. (default: `"standard"`) -}
variant :
    M3e.Value.Value { segmented : M3e.Value.Supported
    , standard : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variant =
    M3e.Cem.ActionList.variant