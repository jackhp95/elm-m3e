module M3e.Build.Elevation exposing
    ( Builder, AttrCaps, SlotCaps, elevation, disabled, for
    , level, build
    )

{-|
The ⑤ Build shape for `<m3e-elevation>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Elevation as Elevation`.

@docs Builder, AttrCaps, SlotCaps, elevation, disabled, for
@docs level, build
-}


import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.Elevation
import M3e.Element
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-elevation>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | elevation : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , for : M3e.Build.Internal.Available
    , level : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-elevation>`. -}
elevation : Builder AttrCaps SlotCaps msg kind
elevation =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.Elevation.elevation
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             []
             []
        )


{-| Whether hover and press events will not trigger changes in elevation, when attached to an interactive element. (default: `false`) -}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg kind
    -> Builder { disabled : M3e.Build.Internal.Used } s msg kind
disabled v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Elevation.disabled v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for :
    String
    -> Builder { a | for : M3e.Build.Internal.Available } s msg kind
    -> Builder { for : M3e.Build.Internal.Used } s msg kind
for v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Elevation.for v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The level at which to visually depict elevation. (default: `null`) -}
level :
    String
    -> Builder { a | level : M3e.Build.Internal.Available } s msg kind
    -> Builder { level : M3e.Build.Internal.Used } s msg kind
level v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Elevation.level v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-elevation>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { elevation : M3e.Value.Supported } msg
build b_ =
    M3e.Element.fromNode (M3e.Build.Internal.node_ b_)