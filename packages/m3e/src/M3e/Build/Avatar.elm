module M3e.Build.Avatar exposing
    ( Builder, AttrCaps, SlotCaps, avatar, child, build
    )

{-|
The ⑤ Build shape for `<m3e-avatar>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Avatar as Avatar`.

@docs Builder, AttrCaps, SlotCaps, avatar, child, build
-}


import M3e.Build.Internal
import M3e.Cem.Attr.Internal
import M3e.Cem.Avatar
import M3e.Element
import M3e.Element.Internal
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
    { unnamed : M3e.Build.Internal.Available }


{-| Seed a `Builder` for `<m3e-avatar>`. -}
avatar : Builder AttrCaps SlotCaps msg kind
avatar =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.Avatar.avatar
                      (List.map M3e.Cem.Attr.Internal.forget erased_)
                      ch_
             )
             []
             []
        )


{-| Place content in the `(default)` slot. -}
child :
    M3e.Element.Element any msg
    -> Builder a { s | unnamed : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | unnamed : M3e.Build.Internal.Used } msg kind
child el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Element.toNode el_)
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-avatar>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { avatar : M3e.Value.Supported } msg
build b_ =
    M3e.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)