module M3e.Build.InputChipSet exposing
    ( Builder, AttrCaps, SlotCaps, inputChipSet, disabled, name
    , required, vertical, onChange
    )

{-|
The ⑤ Build shape for `<m3e-input-chip-set>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.InputChipSet as InputChipSet`.

@docs Builder, AttrCaps, SlotCaps, inputChipSet, disabled, name
@docs required, vertical, onChange
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.Html.InputChipSet
import M3e.Cem.InputChipSet
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
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             []
             []
        )


{-| Whether the element is disabled. (default: `false`) -}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg kind
    -> Builder { disabled : M3e.Build.Internal.Used } s msg kind
disabled v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.InputChipSet.disabled v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The name that identifies the element when submitting the associated form. -}
name :
    String
    -> Builder { a | name : M3e.Build.Internal.Available } s msg kind
    -> Builder { name : M3e.Build.Internal.Used } s msg kind
name v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.InputChipSet.name v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether a value is required for the element. (default: `false`) -}
required :
    Bool
    -> Builder { a | required : M3e.Build.Internal.Available } s msg kind
    -> Builder { required : M3e.Build.Internal.Used } s msg kind
required v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.InputChipSet.required v_))
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
             (M3e.Cem.Attr.forget (M3e.Cem.InputChipSet.vertical v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when a chip is added to, or removed from, the set. -}
onChange :
    Json.Decode.Decoder msg
    -> Builder { a | onChange : M3e.Build.Internal.Available } s msg kind
    -> Builder { onChange : M3e.Build.Internal.Used } s msg kind
onChange v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.Attr.attribute M3e.Cem.Html.InputChipSet.onChange v_)
             )
             (M3e.Build.Internal.node_ b_)
        )