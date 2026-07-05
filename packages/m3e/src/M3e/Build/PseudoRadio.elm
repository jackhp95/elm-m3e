module M3e.Build.PseudoRadio exposing
    ( Builder, AttrCaps, SlotCaps, pseudoRadio, checked, disabled
    , build
    )

{-|
The ⑤ Build shape for `<m3e-pseudo-radio>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.PseudoRadio as PseudoRadio`.

@docs Builder, AttrCaps, SlotCaps, pseudoRadio, checked, disabled
@docs build
-}


import M3e.Build.Internal
import M3e.Cem.Attr.Internal
import M3e.Cem.PseudoRadio
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-pseudo-radio>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | pseudoRadio : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { checked : M3e.Build.Internal.Available
    , disabled : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-pseudo-radio>`. -}
pseudoRadio : Builder AttrCaps SlotCaps msg kind
pseudoRadio =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.PseudoRadio.pseudoRadio
                      (List.map M3e.Cem.Attr.Internal.forget erased_)
                      ch_
             )
             []
             []
        )


{-| A value indicating whether the element is checked. (default: `false`) -}
checked :
    Bool
    -> Builder { a | checked : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | checked : M3e.Build.Internal.Used } s msg kind
checked v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.PseudoRadio.checked v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| A value indicating whether the element is disabled. (default: `false`) -}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg kind
disabled v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.PseudoRadio.disabled v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-pseudo-radio>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { pseudoRadio : M3e.Value.Supported } msg
build b_ =
    M3e.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)