module M3e.Build.Toolbar exposing
    ( Builder, AttrCaps, SlotCaps, toolbar, elevated, shape
    , variant, vertical
    )

{-|
The ⑤ Build shape for `<m3e-toolbar>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Toolbar as Toolbar`.

@docs Builder, AttrCaps, SlotCaps, toolbar, elevated, shape
@docs variant, vertical
-}


import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.Toolbar
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-toolbar>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | toolbar : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { elevated : M3e.Build.Internal.Available
    , shape : M3e.Build.Internal.Available
    , variant : M3e.Build.Internal.Available
    , vertical : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-toolbar>`. -}
toolbar : Builder AttrCaps SlotCaps msg kind
toolbar =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.Toolbar.toolbar
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             []
             []
        )


{-| Whether the toolbar is elevated. (default: `false`) -}
elevated :
    Bool
    -> Builder { a | elevated : M3e.Build.Internal.Available } s msg kind
    -> Builder { elevated : M3e.Build.Internal.Used } s msg kind
elevated v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Toolbar.elevated v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The shape of the toolbar. (default: `"square"`) -}
shape :
    M3e.Value.Value { rounded : M3e.Value.Supported
    , square : M3e.Value.Supported
    }
    -> Builder { a | shape : M3e.Build.Internal.Available } s msg kind
    -> Builder { shape : M3e.Build.Internal.Used } s msg kind
shape v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Toolbar.shape v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The appearance variant of the toolbar. (default: `"standard"`) -}
variant :
    M3e.Value.Value { standard : M3e.Value.Supported
    , vibrant : M3e.Value.Supported
    }
    -> Builder { a | variant : M3e.Build.Internal.Available } s msg kind
    -> Builder { variant : M3e.Build.Internal.Used } s msg kind
variant v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Toolbar.variant v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether the element is oriented vertically. (default: `false`) -}
vertical :
    Bool
    -> Builder { a | vertical : M3e.Build.Internal.Available } s msg kind
    -> Builder { vertical : M3e.Build.Internal.Used } s msg kind
vertical v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Toolbar.vertical v_))
             (M3e.Build.Internal.node_ b_)
        )