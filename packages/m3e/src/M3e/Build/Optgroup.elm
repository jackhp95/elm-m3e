module M3e.Build.Optgroup exposing ( Builder, AttrCaps, SlotCaps, optgroup )

{-|
The ⑤ Build shape for `<m3e-optgroup>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Optgroup as Optgroup`.

@docs Builder, AttrCaps, SlotCaps, optgroup
-}


import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.Optgroup
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-optgroup>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | optgroup : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { label : M3e.Build.Internal.Available }


{-| Seed a `Builder` for `<m3e-optgroup>`. -}
optgroup : Builder AttrCaps SlotCaps msg kind
optgroup =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.Optgroup.optgroup
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             []
             []
        )