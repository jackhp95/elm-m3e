module M3e.Build.MenuItemElementBase exposing
    ( Builder, AttrCaps, SlotCaps, menuItemElementBase, attr, disabled
    , onClick, build
    )

{-|
The ⑤ Build shape for `<MenuItemElementBase>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.MenuItemElementBase as MenuItemElementBase`.

@docs Builder, AttrCaps, SlotCaps, menuItemElementBase, attr, disabled
@docs onClick, build
-}


import M3e.Build.Internal
import M3e.Cem.Attr.Internal
import M3e.Cem.MenuItemElementBase
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<MenuItemElementBase>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | menuItemElementBase : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , onClick : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<MenuItemElementBase>`. -}
menuItemElementBase : Builder AttrCaps SlotCaps msg kind
menuItemElementBase =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.MenuItemElementBase.menuItemElementBase
                      (List.map M3e.Cem.Attr.Internal.forget erased_)
                      ch_
             )
             []
             []
        )


{-| Inject an already-built universal `Attr` (e.g. from `M3e.Aria.*`) into the pipeline, appending it to the accumulated attrs. Unlike the typed per-attribute setters it consumes no phantom capability, so it can be applied any number of times. -}
attr :
    M3e.Cem.Attr.Internal.Attr caps msg
    -> Builder a s msg kind
    -> Builder a s msg kind
attr a_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget a_)
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether the element is disabled. (default: `false`) -}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg kind
disabled v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget
                  (M3e.Cem.MenuItemElementBase.disabled v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Listen for `click` events. -}
onClick :
    msg
    -> Builder { a | onClick : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onClick : M3e.Build.Internal.Used } s msg kind
onClick v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget
                  (M3e.Cem.MenuItemElementBase.onClick v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<MenuItemElementBase>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { menuItemElementBase : M3e.Value.Supported } msg
build b_ =
    M3e.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)