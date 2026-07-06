module M3e.Build.DrawerContainer exposing
    ( Builder, AttrCaps, SlotCaps, drawerContainer, end, endMode
    , endDivider, start, startMode, startDivider, onChange, child, startSlot
    , endSlot, build
    )

{-|
The ⑤ Build shape for `<m3e-drawer-container>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.DrawerContainer as DrawerContainer`.

@docs Builder, AttrCaps, SlotCaps, drawerContainer, end, endMode
@docs endDivider, start, startMode, startDivider, onChange, child
@docs startSlot, endSlot, build
-}


import M3e.Build.Internal
import M3e.Cem.Attr.Internal
import M3e.Cem.DrawerContainer
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-drawer-container>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | drawerContainer : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { end : M3e.Build.Internal.Available
    , endMode : M3e.Build.Internal.Available
    , endDivider : M3e.Build.Internal.Available
    , start : M3e.Build.Internal.Available
    , startMode : M3e.Build.Internal.Available
    , startDivider : M3e.Build.Internal.Available
    , onChange : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { unnamed : M3e.Build.Internal.Available
    , start : M3e.Build.Internal.Available
    , end : M3e.Build.Internal.Available
    }


{-| Seed a `Builder` for `<m3e-drawer-container>`. -}
drawerContainer : Builder AttrCaps SlotCaps msg kind
drawerContainer =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.DrawerContainer.drawerContainer
                      (List.map M3e.Cem.Attr.Internal.forget erased_)
                      ch_
             )
             []
             []
        )


{-| Whether the end drawer is open. (default: `false`) -}
end :
    Bool
    -> Builder { a | end : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | end : M3e.Build.Internal.Used } s msg kind
end v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.DrawerContainer.end v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The behavior mode of the end drawer. (default: `"side"`) -}
endMode :
    M3e.Value.Value { auto : M3e.Value.Supported
    , over : M3e.Value.Supported
    , push : M3e.Value.Supported
    , side : M3e.Value.Supported
    }
    -> Builder { a | endMode : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | endMode : M3e.Build.Internal.Used } s msg kind
endMode v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.DrawerContainer.endMode v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether to show a divider between the end drawer and content for `side` mode. (default: `false`) -}
endDivider :
    Bool
    -> Builder { a | endDivider : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | endDivider : M3e.Build.Internal.Used } s msg kind
endDivider v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget
                  (M3e.Cem.DrawerContainer.endDivider v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether the start drawer is open. (default: `false`) -}
start :
    Bool
    -> Builder { a | start : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | start : M3e.Build.Internal.Used } s msg kind
start v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.DrawerContainer.start v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The behavior mode of the start drawer. (default: `"side"`) -}
startMode :
    M3e.Value.Value { auto : M3e.Value.Supported
    , over : M3e.Value.Supported
    , push : M3e.Value.Supported
    , side : M3e.Value.Supported
    }
    -> Builder { a | startMode : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | startMode : M3e.Build.Internal.Used } s msg kind
startMode v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget
                  (M3e.Cem.DrawerContainer.startMode v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether to show a divider between the start drawer and content for `side` mode. (default: `false`) -}
startDivider :
    Bool
    -> Builder { a | startDivider : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | startDivider : M3e.Build.Internal.Used } s msg kind
startDivider v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget
                  (M3e.Cem.DrawerContainer.startDivider v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the state of the start or end drawers change. -}
onChange :
    msg
    -> Builder { a | onChange : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onChange : M3e.Build.Internal.Used } s msg kind
onChange v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.DrawerContainer.onChange v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `(default)` slot. -}
child :
    M3e.Element.Element any msg
    -> Builder a { s | unnamed : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | unnamed : M3e.Build.Internal.Used } msg kind
child el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Element.toNode el_)
             (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `start` slot. -}
startSlot :
    M3e.Element.Element any msg
    -> Builder a { s | start : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | start : M3e.Build.Internal.Used } msg kind
startSlot el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Element.toNode (M3e.Element.withSlot "start" el_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `end` slot. -}
endSlot :
    M3e.Element.Element any msg
    -> Builder a { s | end : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | end : M3e.Build.Internal.Used } msg kind
endSlot el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Element.toNode (M3e.Element.withSlot "end" el_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-drawer-container>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { drawerContainer : M3e.Value.Supported } msg
build b_ =
    M3e.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)