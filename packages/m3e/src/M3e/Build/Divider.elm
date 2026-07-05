module M3e.Build.Divider exposing
    ( Builder, AttrCaps, SlotCaps, divider, inset, insetStart
    , insetEnd, vertical, build
    )

{-|
The ⑤ Build shape for `<m3e-divider>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Divider as Divider`.

@docs Builder, AttrCaps, SlotCaps, divider, inset, insetStart
@docs insetEnd, vertical, build
-}


import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.Divider
import M3e.Element
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-divider>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | divider : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { inset : M3e.Build.Internal.Available
    , insetStart : M3e.Build.Internal.Available
    , insetEnd : M3e.Build.Internal.Available
    , vertical : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-divider>`. -}
divider : Builder AttrCaps SlotCaps msg kind
divider =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.Divider.divider
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             []
             []
        )


{-| Whether the divider is indented with equal padding on both sides. (default: `false`) -}
inset :
    Bool
    -> Builder { a | inset : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | inset : M3e.Build.Internal.Used } s msg kind
inset v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Divider.inset v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether the divider is indented with padding on the leading side. (default: `false`) -}
insetStart :
    Bool
    -> Builder { a | insetStart : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | insetStart : M3e.Build.Internal.Used } s msg kind
insetStart v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Divider.insetStart v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether the divider is indented with padding on the trailing side. (default: `false`) -}
insetEnd :
    Bool
    -> Builder { a | insetEnd : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | insetEnd : M3e.Build.Internal.Used } s msg kind
insetEnd v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Divider.insetEnd v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether the divider is vertically aligned with adjacent content. (default: `false`) -}
vertical :
    Bool
    -> Builder { a | vertical : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | vertical : M3e.Build.Internal.Used } s msg kind
vertical v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Divider.vertical v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-divider>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { divider : M3e.Value.Supported } msg
build b_ =
    M3e.Element.fromNode (M3e.Build.Internal.node_ b_)