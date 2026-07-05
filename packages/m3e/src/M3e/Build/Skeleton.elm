module M3e.Build.Skeleton exposing
    ( Builder, AttrCaps, SlotCaps, skeleton, animation, shape
    , loaded
    )

{-|
The ⑤ Build shape for `<m3e-skeleton>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Skeleton as Skeleton`.

@docs Builder, AttrCaps, SlotCaps, skeleton, animation, shape
@docs loaded
-}


import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.Skeleton
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-skeleton>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | skeleton : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { animation : M3e.Build.Internal.Available
    , shape : M3e.Build.Internal.Available
    , loaded : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-skeleton>`. -}
skeleton : Builder AttrCaps SlotCaps msg kind
skeleton =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.Skeleton.skeleton
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             []
             []
        )


{-| The animation effect of the skeleton. (default: `"wave"`) -}
animation :
    M3e.Value.Value { none : M3e.Value.Supported
    , pulse : M3e.Value.Supported
    , wave : M3e.Value.Supported
    }
    -> Builder { a | animation : M3e.Build.Internal.Available } s msg kind
    -> Builder { animation : M3e.Build.Internal.Used } s msg kind
animation v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Skeleton.animation v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The shape of the skeleton. (default: `"auto"`) -}
shape :
    M3e.Value.Value { auto : M3e.Value.Supported
    , circular : M3e.Value.Supported
    , rounded : M3e.Value.Supported
    , square : M3e.Value.Supported
    }
    -> Builder { a | shape : M3e.Build.Internal.Available } s msg kind
    -> Builder { shape : M3e.Build.Internal.Used } s msg kind
shape v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Skeleton.shape v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether the content of the skeleton has been loaded. (default: `false`) -}
loaded :
    Bool
    -> Builder { a | loaded : M3e.Build.Internal.Available } s msg kind
    -> Builder { loaded : M3e.Build.Internal.Used } s msg kind
loaded v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Skeleton.loaded v_))
             (M3e.Build.Internal.node_ b_)
        )