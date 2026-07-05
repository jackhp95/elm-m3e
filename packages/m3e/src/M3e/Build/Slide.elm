module M3e.Build.Slide exposing
    ( Builder, AttrCaps, SlotCaps, slide, selectedIndex
    )

{-|
The ⑤ Build shape for `<m3e-slide>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Slide as Slide`.

@docs Builder, AttrCaps, SlotCaps, slide, selectedIndex
-}


import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.Slide
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-slide>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | slide : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { selectedIndex : M3e.Build.Internal.Available }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-slide>`. -}
slide : Builder AttrCaps SlotCaps msg kind
slide =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.Slide.slide (List.map M3e.Cem.Attr.forget erased_) ch_
             )
             []
             []
        )


{-| The zero-based index of the visible item. (default: `null`) -}
selectedIndex :
    Float
    -> Builder { a | selectedIndex : M3e.Build.Internal.Available } s msg kind
    -> Builder { selectedIndex : M3e.Build.Internal.Used } s msg kind
selectedIndex v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Slide.selectedIndex v_))
             (M3e.Build.Internal.node_ b_)
        )