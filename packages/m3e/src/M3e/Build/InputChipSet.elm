module M3e.Build.InputChipSet exposing
    ( Builder, AttrCaps, SlotCaps, inputChipSet, attr, disabled
    , name, required, vertical, onChange, input, build
    )

{-|
The ⑤ Build shape for `<m3e-input-chip-set>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.InputChipSet as InputChipSet`.

@docs Builder, AttrCaps, SlotCaps, inputChipSet, attr, disabled
@docs name, required, vertical, onChange, input, build
-}


import M3e.Build.Internal
import M3e.Cem.Attr.Internal
import M3e.Cem.InputChipSet
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-input-chip-set>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | inputChipSet : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , name : M3e.Build.Internal.Available
    , required : M3e.Build.Internal.Available
    , vertical : M3e.Build.Internal.Available
    , onChange : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { input : M3e.Build.Internal.Available }


{-| Seed a `Builder` for `<m3e-input-chip-set>`. -}
inputChipSet : Builder AttrCaps SlotCaps msg kind
inputChipSet =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.InputChipSet.inputChipSet
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
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.InputChipSet.disabled v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The name that identifies the element when submitting the associated form. -}
name :
    String
    -> Builder { a | name : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | name : M3e.Build.Internal.Used } s msg kind
name v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.InputChipSet.name v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether a value is required for the element. (default: `false`) -}
required :
    Bool
    -> Builder { a | required : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | required : M3e.Build.Internal.Used } s msg kind
required v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.InputChipSet.required v_))
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
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.InputChipSet.vertical v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when a chip is added to, or removed from, the set. -}
onChange :
    msg
    -> Builder { a | onChange : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onChange : M3e.Build.Internal.Used } s msg kind
onChange v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.InputChipSet.onChange v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `input` slot. -}
input :
    M3e.Element.Element any msg
    -> Builder a { s | input : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | input : M3e.Build.Internal.Used } msg kind
input el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Element.toNode (M3e.Element.withSlot "input" el_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-input-chip-set>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { inputChipSet : M3e.Value.Supported } msg
build b_ =
    M3e.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)