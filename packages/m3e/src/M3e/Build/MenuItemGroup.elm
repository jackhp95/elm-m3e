module M3e.Build.MenuItemGroup exposing
    ( Builder, AttrCaps, SlotCaps, menuItemGroup, build
    )

{-|
The ⑤ Build shape for `<m3e-menu-item-group>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.MenuItemGroup as MenuItemGroup`.

@docs Builder, AttrCaps, SlotCaps, menuItemGroup, build
-}


import M3e.Build.Internal
import M3e.Cem.Attr.Internal
import M3e.Cem.MenuItemGroup
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-menu-item-group>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | menuItemGroup : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-menu-item-group>`. -}
menuItemGroup : Builder AttrCaps SlotCaps msg kind
menuItemGroup =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.MenuItemGroup.menuItemGroup
                      (List.map M3e.Cem.Attr.Internal.forget erased_)
                      ch_
             )
             []
             []
        )


{-| Build the `<m3e-menu-item-group>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { menuItemGroup : M3e.Value.Supported } msg
build b_ =
    M3e.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)