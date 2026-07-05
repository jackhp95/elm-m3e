module M3e.Build.Breadcrumb exposing
    ( Builder, AttrCaps, SlotCaps, breadcrumb, wrap, build
    )

{-|
The ⑤ Build shape for `<m3e-breadcrumb>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Breadcrumb as Breadcrumb`.

@docs Builder, AttrCaps, SlotCaps, breadcrumb, wrap, build
-}


import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.Breadcrumb
import M3e.Element
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-breadcrumb>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | breadcrumb : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { wrap : M3e.Build.Internal.Available }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { separator : M3e.Build.Internal.Available
    , default : M3e.Build.Internal.NotFilled
    }


{-| Seed a `Builder` for `<m3e-breadcrumb>`. -}
breadcrumb : Builder AttrCaps SlotCaps msg kind
breadcrumb =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.Breadcrumb.breadcrumb
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             []
             []
        )


{-| Whether items wrap to a new line. (default: `false`) -}
wrap :
    Bool
    -> Builder { a | wrap : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | wrap : M3e.Build.Internal.Used } s msg kind
wrap v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Breadcrumb.wrap v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-breadcrumb>` element from a `Builder`. -}
build :
    Builder a { s | default : M3e.Build.Internal.Filled } msg kind
    -> M3e.Element.Element { breadcrumb : M3e.Value.Supported } msg
build b_ =
    M3e.Element.fromNode (M3e.Build.Internal.node_ b_)