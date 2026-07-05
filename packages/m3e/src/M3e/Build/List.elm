module M3e.Build.List exposing
    ( Builder, AttrCaps, SlotCaps, list, variant
    )

{-|
The ⑤ Build shape for `<m3e-list>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.List as List`.

@docs Builder, AttrCaps, SlotCaps, list, variant
-}


import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.List
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-list>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | list : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { variant : M3e.Build.Internal.Available }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-list>`. -}
list : Builder AttrCaps SlotCaps msg kind
list =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.List.list (List.map M3e.Cem.Attr.forget erased_) ch_
             )
             []
             []
        )


{-| The appearance variant of the list. (default: `"standard"`) -}
variant :
    M3e.Value.Value { segmented : M3e.Value.Supported
    , standard : M3e.Value.Supported
    }
    -> Builder { a | variant : M3e.Build.Internal.Available } s msg kind
    -> Builder { variant : M3e.Build.Internal.Used } s msg kind
variant v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.List.variant v_))
             (M3e.Build.Internal.node_ b_)
        )