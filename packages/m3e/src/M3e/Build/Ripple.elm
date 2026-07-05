module M3e.Build.Ripple exposing
    ( Builder, AttrCaps, SlotCaps, ripple, centered, disabled
    , for, radius, unbounded
    )

{-|
The ⑤ Build shape for `<m3e-ripple>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Ripple as Ripple`.

@docs Builder, AttrCaps, SlotCaps, ripple, centered, disabled
@docs for, radius, unbounded
-}


import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.Ripple
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-ripple>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | ripple : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { centered : M3e.Build.Internal.Available
    , disabled : M3e.Build.Internal.Available
    , for : M3e.Build.Internal.Available
    , radius : M3e.Build.Internal.Available
    , unbounded : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-ripple>`. -}
ripple : Builder AttrCaps SlotCaps msg kind
ripple =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.Ripple.ripple
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             []
             []
        )


{-| Whether the ripple always originates from the center of the element's bounds, rather
than originating from the location of the click event. (default: `false`)
-}
centered :
    Bool
    -> Builder { a | centered : M3e.Build.Internal.Available } s msg kind
    -> Builder { centered : M3e.Build.Internal.Used } s msg kind
centered v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Ripple.centered v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether click events will not trigger the ripple.
Ripples can be still controlled manually by using the `show` and 'hide' methods. (default: `false`)
-}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg kind
    -> Builder { disabled : M3e.Build.Internal.Used } s msg kind
disabled v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Ripple.disabled v_))
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
             (M3e.Cem.Attr.forget (M3e.Cem.Ripple.for v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The radius, in pixels, of the ripple. (default: `null`) -}
radius :
    Float
    -> Builder { a | radius : M3e.Build.Internal.Available } s msg kind
    -> Builder { radius : M3e.Build.Internal.Used } s msg kind
radius v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Ripple.radius v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether the ripple is visible outside the element's bounds. (default: `false`) -}
unbounded :
    Bool
    -> Builder { a | unbounded : M3e.Build.Internal.Available } s msg kind
    -> Builder { unbounded : M3e.Build.Internal.Used } s msg kind
unbounded v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Ripple.unbounded v_))
             (M3e.Build.Internal.node_ b_)
        )