module M3e.Build.Menu exposing
    ( Builder, AttrCaps, SlotCaps, menu, positionX, positionY
    , variant, submenu, onBeforetoggle, onToggle, build
    )

{-|
The ⑤ Build shape for `<m3e-menu>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Menu as Menu`.

@docs Builder, AttrCaps, SlotCaps, menu, positionX, positionY
@docs variant, submenu, onBeforetoggle, onToggle, build
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.Html.Menu
import M3e.Cem.Menu
import M3e.Element
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-menu>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | menu : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { positionX : M3e.Build.Internal.Available
    , positionY : M3e.Build.Internal.Available
    , variant : M3e.Build.Internal.Available
    , submenu : M3e.Build.Internal.Available
    , onBeforetoggle : M3e.Build.Internal.Available
    , onToggle : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-menu>`. -}
menu : Builder AttrCaps SlotCaps msg kind
menu =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.Menu.menu (List.map M3e.Cem.Attr.forget erased_) ch_
             )
             []
             []
        )


{-| The position of the menu, on the x-axis. (default: `"after"`) -}
positionX :
    M3e.Value.Value { after : M3e.Value.Supported
    , before : M3e.Value.Supported
    }
    -> Builder { a | positionX : M3e.Build.Internal.Available } s msg kind
    -> Builder { positionX : M3e.Build.Internal.Used } s msg kind
positionX v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Menu.positionX v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The position of the menu, on the y-axis. (default: `"below"`) -}
positionY :
    M3e.Value.Value { above : M3e.Value.Supported, below : M3e.Value.Supported }
    -> Builder { a | positionY : M3e.Build.Internal.Available } s msg kind
    -> Builder { positionY : M3e.Build.Internal.Used } s msg kind
positionY v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Menu.positionY v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The appearance variant of the menu. (default: `"standard"`) -}
variant :
    M3e.Value.Value { standard : M3e.Value.Supported
    , vibrant : M3e.Value.Supported
    }
    -> Builder { a | variant : M3e.Build.Internal.Available } s msg kind
    -> Builder { variant : M3e.Build.Internal.Used } s msg kind
variant v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Menu.variant v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| A value indicating whether the menu is a submenu. (default: `false`) -}
submenu :
    Bool
    -> Builder { a | submenu : M3e.Build.Internal.Available } s msg kind
    -> Builder { submenu : M3e.Build.Internal.Used } s msg kind
submenu v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Menu.submenu v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched before the toggle state changes. -}
onBeforetoggle :
    Json.Decode.Decoder msg
    -> Builder { a | onBeforetoggle : M3e.Build.Internal.Available } s msg kind
    -> Builder { onBeforetoggle : M3e.Build.Internal.Used } s msg kind
onBeforetoggle v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.Attr.attribute M3e.Cem.Html.Menu.onBeforetoggle v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched after the toggle state has changed. -}
onToggle :
    Json.Decode.Decoder msg
    -> Builder { a | onToggle : M3e.Build.Internal.Available } s msg kind
    -> Builder { onToggle : M3e.Build.Internal.Used } s msg kind
onToggle v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.Attr.attribute M3e.Cem.Html.Menu.onToggle v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-menu>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { menu : M3e.Value.Supported } msg
build b_ =
    M3e.Element.fromNode (M3e.Build.Internal.node_ b_)