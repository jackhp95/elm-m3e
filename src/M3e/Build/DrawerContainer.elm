module M3e.Build.DrawerContainer exposing
    ( Builder, AttrCaps, SlotCaps, drawerContainer, attr, end
    , endMode, endDivider, start, startMode, startDivider, onChange
    , child, startSlot, endSlot, build
    )

{-| The Build form for `<m3e-drawer-container>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.DrawerContainer as DrawerContainer`.

@docs Builder, AttrCaps, SlotCaps, drawerContainer, attr, end
@docs endMode, endDivider, start, startMode, startDivider, onChange
@docs child, startSlot, endSlot, build

-}

import M3e.Build.Internal
import M3e.Html.DrawerContainer
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr.Internal
import Markup.Node


{-| Phantom-typed opaque builder for `<m3e-drawer-container>`.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder
        { kind
            | drawerContainer : M3e.Kind.Brand
        }
        attrCaps
        slotCaps
        msg


{-| Per-component attribute capability row for the phantom-typed Builder.
-}
type alias AttrCaps =
    { end : M3e.Build.Internal.Available
    , endMode : M3e.Build.Internal.Available
    , endDivider : M3e.Build.Internal.Available
    , start : M3e.Build.Internal.Available
    , startMode : M3e.Build.Internal.Available
    , startDivider : M3e.Build.Internal.Available
    , onChange : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder.
-}
type alias SlotCaps =
    { unnamed : M3e.Build.Internal.Available
    , start : M3e.Build.Internal.Available
    , end : M3e.Build.Internal.Available
    }


{-| Seed a `Builder` for `<m3e-drawer-container>`.
-}
drawerContainer : Builder AttrCaps SlotCaps msg kind
drawerContainer =
    M3e.Build.Internal.wrap_
        (Markup.Node.fromComponent
            (\erased_ ch_ ->
                M3e.Html.DrawerContainer.drawerContainer
                    (List.map Markup.Html.Attr.Internal.forget erased_)
                    ch_
            )
            []
            []
        )


{-| Inject an already-built universal `Attr` (e.g. from `M3e.Aria.*`) into the pipeline, appending it to the accumulated attrs. Unlike the typed per-attribute setters it consumes no phantom capability, so it can be applied any number of times.
-}
attr :
    Markup.Html.Attr.Internal.Attr caps msg
    -> Builder a s msg kind
    -> Builder a s msg kind
attr a_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget a_)
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether the end drawer is open. (default: `false`)
-}
end :
    Bool
    -> Builder { a | end : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | end : M3e.Build.Internal.Used } s msg kind
end v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.DrawerContainer.end v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The behavior mode of the end drawer. (default: `"side"`)
-}
endMode :
    M3e.Token.Value
        { auto : M3e.Token.Supported
        , over : M3e.Token.Supported
        , push : M3e.Token.Supported
        , side : M3e.Token.Supported
        }
    -> Builder { a | endMode : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | endMode : M3e.Build.Internal.Used } s msg kind
endMode v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.DrawerContainer.endMode v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether to show a divider between the end drawer and content for `side` mode. (default: `false`)
-}
endDivider :
    Bool
    -> Builder { a | endDivider : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | endDivider : M3e.Build.Internal.Used } s msg kind
endDivider v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.DrawerContainer.endDivider v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether the start drawer is open. (default: `false`)
-}
start :
    Bool
    -> Builder { a | start : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | start : M3e.Build.Internal.Used } s msg kind
start v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.DrawerContainer.start v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| The behavior mode of the start drawer. (default: `"side"`)
-}
startMode :
    M3e.Token.Value
        { auto : M3e.Token.Supported
        , over : M3e.Token.Supported
        , push : M3e.Token.Supported
        , side : M3e.Token.Supported
        }
    -> Builder { a | startMode : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | startMode : M3e.Build.Internal.Used } s msg kind
startMode v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.DrawerContainer.startMode v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether to show a divider between the start drawer and content for `side` mode. (default: `false`)
-}
startDivider :
    Bool
    -> Builder { a | startDivider : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | startDivider : M3e.Build.Internal.Used } s msg kind
startDivider v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.DrawerContainer.startDivider v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the state of the start or end drawers change.
-}
onChange :
    msg
    -> Builder { a | onChange : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onChange : M3e.Build.Internal.Used } s msg kind
onChange v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.DrawerContainer.onChange v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `(default)` slot.
-}
child :
    Markup.Element.Element any msg
    -> Builder a { s | unnamed : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | unnamed : M3e.Build.Internal.Used } msg kind
child el_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (Markup.Element.toNode el_)
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `start` slot.
-}
startSlot :
    Markup.Element.Element any msg
    -> Builder a { s | start : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | start : M3e.Build.Internal.Used } msg kind
startSlot el_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (Markup.Element.toNode (Markup.Element.withSlot "start" el_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `end` slot.
-}
endSlot :
    Markup.Element.Element any msg
    -> Builder a { s | end : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | end : M3e.Build.Internal.Used } msg kind
endSlot el_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (Markup.Element.toNode (Markup.Element.withSlot "end" el_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-drawer-container>` element from a `Builder`.
-}
build :
    Builder a s msg kind
    -> Markup.Element.Element { drawerContainer : M3e.Kind.Brand } msg
build b_ =
    Markup.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)
