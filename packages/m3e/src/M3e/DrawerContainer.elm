module M3e.DrawerContainer exposing (child, children, drawerContainer, endSlot, startSlot)

{-| 
@docs drawerContainer, child, startSlot, endSlot, children
-}


import M3e.Cem.Attr
import M3e.Cem.DrawerContainer
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-drawer-container>` element (lazy IR). -}
drawerContainer :
    List (M3e.Cem.Attr.Attr { end : M3e.Value.Supported
    , endMode : M3e.Value.Supported
    , endDivider : M3e.Value.Supported
    , start : M3e.Value.Supported
    , startMode : M3e.Value.Supported
    , startDivider : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , start : M3e.Value.Supported
    , end : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | drawerContainer : M3e.Value.Supported } msg
drawerContainer attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.DrawerContainer.drawerContainer
                    (List.map M3e.Cem.Attr.forget erased)
                    ch
            )
            (List.map M3e.Cem.Attr.forget attributes)
            (List.map M3e.Content.toNode content_)
        )


{-| Place content in the `(default)` slot. -}
child :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
child el =
    M3e.Content.slot "" el


{-| Place content in the `start` slot. -}
startSlot :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | start : M3e.Value.Supported } msg
startSlot el =
    M3e.Content.slot "start" el


{-| Place content in the `end` slot. -}
endSlot :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | end : M3e.Value.Supported } msg
endSlot el =
    M3e.Content.slot "end" el


{-| Place many elements in the default slot. -}
children :
    List (M3e.Element.Element any msg)
    -> List (M3e.Content.Content { r | default : M3e.Value.Supported } msg)
children els =
    List.map (M3e.Content.slot "") els