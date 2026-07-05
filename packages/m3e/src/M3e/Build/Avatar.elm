module M3e.Build.Avatar exposing ( Builder, AttrCaps, SlotCaps, avatar )

{-|
The ⑤ Build shape for `<m3e-avatar>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Avatar as Avatar`.

@docs Builder, AttrCaps, SlotCaps, avatar
-}


import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.Avatar
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-avatar>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | avatar : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { default : M3e.Build.Internal.Available }


{-| Seed a `Builder` for `<m3e-avatar>`. -}
avatar : Builder AttrCaps SlotCaps msg kind
avatar =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.Avatar.avatar
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             []
             []
        )