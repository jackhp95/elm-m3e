module M3e.Build.Toolbar exposing
    ( Builder, AttrCaps, SlotCaps, toolbar, attr, elevated
    , shape, variant, vertical, build
    )

{-|
The ⑤ Build shape for `<m3e-toolbar>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Toolbar as Toolbar`.

@docs Builder, AttrCaps, SlotCaps, toolbar, attr, elevated
@docs shape, variant, vertical, build
-}


import M3e.Build.Internal
import M3e.Cem.Attr.Internal
import M3e.Cem.Toolbar
import M3e.Element
import M3e.Element.Internal
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


{-| Whether the toolbar is elevated. (default: `false`) -}
elevated :
    Bool
    -> Builder { a | elevated : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | elevated : M3e.Build.Internal.Used } s msg kind
elevated v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Toolbar.elevated v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The shape of the toolbar. (default: `"square"`) -}
shape :
    M3e.Value.Value { rounded : M3e.Value.Supported
    , square : M3e.Value.Supported
    }
    -> Builder { a | shape : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | shape : M3e.Build.Internal.Used } s msg kind
shape v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Toolbar.shape v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The appearance variant of the toolbar. (default: `"standard"`) -}
variant :
    M3e.Value.Value { standard : M3e.Value.Supported
    , vibrant : M3e.Value.Supported
    }
    -> Builder { a | variant : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | variant : M3e.Build.Internal.Used } s msg kind
variant v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Toolbar.variant v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether the element is oriented vertically. (default: `false`) -}
vertical :
    Bool
    -> Builder { a | vertical : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | vertical : M3e.Build.Internal.Used } s msg kind
vertical v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Toolbar.vertical v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-toolbar>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { toolbar : M3e.Value.Supported } msg
build b_ =
    M3e.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)