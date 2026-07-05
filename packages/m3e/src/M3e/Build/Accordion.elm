module M3e.Build.Accordion exposing
    ( Builder, AttrCaps, SlotCaps, accordion, multi, build
    )

{-|
The ⑤ Build shape for `<m3e-accordion>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Accordion as Accordion`.

@docs Builder, AttrCaps, SlotCaps, accordion, multi, build
-}


import M3e.Build.Internal
import M3e.Cem.Accordion
import M3e.Cem.Attr
import M3e.Element
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-accordion>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | accordion : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { multi : M3e.Build.Internal.Available }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-accordion>`. -}
accordion : Builder AttrCaps SlotCaps msg kind
accordion =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.Accordion.accordion
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             []
             []
        )


{-| Whether multiple expansion panels can be open at the same time. (default: `false`) -}
multi :
    Bool
    -> Builder { a | multi : M3e.Build.Internal.Available } s msg kind
    -> Builder { multi : M3e.Build.Internal.Used } s msg kind
multi v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Accordion.multi v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-accordion>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { accordion : M3e.Value.Supported } msg
build b_ =
    M3e.Element.fromNode (M3e.Build.Internal.node_ b_)