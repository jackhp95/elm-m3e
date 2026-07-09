module M3e.Build.Slide exposing
    ( Builder, AttrCaps, SlotCaps, slide, attr, selectedIndex
    , build
    )

{-|
The ⑤ Build shape for `<m3e-slide>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Slide as Slide`.

@docs Builder, AttrCaps, SlotCaps, slide, attr, selectedIndex
@docs build
-}


import M3e.Build.Internal
import M3e.Cem.Attr.Internal
import M3e.Cem.Slide
import M3e.Element
import M3e.Element.Internal
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
                  M3e.Cem.Slide.slide
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


{-| The zero-based index of the visible item. (default: `null`) -}
selectedIndex :
    Float
    -> Builder { a | selectedIndex : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | selectedIndex : M3e.Build.Internal.Used } s msg kind
selectedIndex v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Slide.selectedIndex v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-slide>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { slide : M3e.Value.Supported } msg
build b_ =
    M3e.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)