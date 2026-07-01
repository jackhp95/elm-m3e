module M3e.MenuItemElementBase exposing (menuItemElementBase)

{-| 
@docs menuItemElementBase
-}


import M3e.Cem.Attr
import M3e.Cem.MenuItemElementBase
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<div>` element (lazy IR). -}
menuItemElementBase :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element child msg)
    -> M3e.Element.Element { s | menuItemElementBase : M3e.Value.Supported } msg
menuItemElementBase attributes children =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.MenuItemElementBase.menuItemElementBase
                    (List.map M3e.Cem.Attr.forget erased)
                    ch
            )
            (List.map M3e.Cem.Attr.forget attributes)
            (List.map M3e.Element.toNode children)
        )