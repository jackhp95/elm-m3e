module M3e.Build.MenuItemRadio exposing
    ( Builder, AttrCaps, SlotCaps, menuItemRadio, disabled, checked
    , onClick, build
    )

{-|
The ⑤ Build shape for `<m3e-menu-item-radio>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.MenuItemRadio as MenuItemRadio`.

@docs Builder, AttrCaps, SlotCaps, menuItemRadio, disabled, checked
@docs onClick, build
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.Html.MenuItemRadio
import M3e.Cem.MenuItemRadio
import M3e.Element
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-menu-item-radio>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | menuItemRadio : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , checked : M3e.Build.Internal.Available
    , onClick : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { default : M3e.Build.Internal.Available
    , icon : M3e.Build.Internal.Available
    , trailingIcon : M3e.Build.Internal.Available
    }


{-| Seed a `Builder` for `<m3e-menu-item-radio>`. -}
menuItemRadio : Builder AttrCaps SlotCaps msg kind
menuItemRadio =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.MenuItemRadio.menuItemRadio
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             []
             []
        )


{-| Whether the element is disabled. (default: `false`) -}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg kind
    -> Builder { disabled : M3e.Build.Internal.Used } s msg kind
disabled v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.MenuItemRadio.disabled v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether the element is checked. (default: `false`) -}
checked :
    Bool
    -> Builder { a | checked : M3e.Build.Internal.Available } s msg kind
    -> Builder { checked : M3e.Build.Internal.Used } s msg kind
checked v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.MenuItemRadio.checked v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the element is clicked. -}
onClick :
    Json.Decode.Decoder msg
    -> Builder { a | onClick : M3e.Build.Internal.Available } s msg kind
    -> Builder { onClick : M3e.Build.Internal.Used } s msg kind
onClick v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.Attr.attribute M3e.Cem.Html.MenuItemRadio.onClick v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-menu-item-radio>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { menuItemRadio : M3e.Value.Supported } msg
build b_ =
    M3e.Element.fromNode (M3e.Build.Internal.node_ b_)