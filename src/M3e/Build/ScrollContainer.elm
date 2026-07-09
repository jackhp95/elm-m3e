module M3e.Build.ScrollContainer exposing
    ( Builder, AttrCaps, SlotCaps, scrollContainer, attr, dividers
    , thin, build
    )

{-|
The ⑤ Build shape for `<m3e-scroll-container>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.ScrollContainer as ScrollContainer`.

@docs Builder, AttrCaps, SlotCaps, scrollContainer, attr, dividers
@docs thin, build
-}


import M3e.Build.Internal
import M3e.Cem.Attr.Internal
import M3e.Cem.ScrollContainer
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-scroll-container>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | scrollContainer : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { dividers : M3e.Build.Internal.Available
    , thin : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-scroll-container>`. -}
scrollContainer : Builder AttrCaps SlotCaps msg kind
scrollContainer =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.ScrollContainer.scrollContainer
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


{-| The dividers used to separate scrollable content. (default: `"above-below"`) -}
dividers :
    M3e.Value.Value { above : M3e.Value.Supported
    , aboveBelow : M3e.Value.Supported
    , below : M3e.Value.Supported
    , none : M3e.Value.Supported
    }
    -> Builder { a | dividers : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | dividers : M3e.Build.Internal.Used } s msg kind
dividers v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.ScrollContainer.dividers v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether to present thin scrollbars. (default: `false`) -}
thin :
    Bool
    -> Builder { a | thin : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | thin : M3e.Build.Internal.Used } s msg kind
thin v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.ScrollContainer.thin v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-scroll-container>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { scrollContainer : M3e.Value.Supported } msg
build b_ =
    M3e.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)