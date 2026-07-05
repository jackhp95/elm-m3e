module M3e.Build.Toc exposing
    ( Builder, AttrCaps, SlotCaps, toc, for, maxDepth
    )

{-|
The ⑤ Build shape for `<m3e-toc>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Toc as Toc`.

@docs Builder, AttrCaps, SlotCaps, toc, for, maxDepth
-}


import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.Toc
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-toc>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | toc : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { for : M3e.Build.Internal.Available
    , maxDepth : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { default : M3e.Build.Internal.Available
    , overline : M3e.Build.Internal.Available
    , title : M3e.Build.Internal.Available
    }


{-| Seed a `Builder` for `<m3e-toc>`. -}
toc : Builder AttrCaps SlotCaps msg kind
toc =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.Toc.toc (List.map M3e.Cem.Attr.forget erased_) ch_
             )
             []
             []
        )


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for :
    String
    -> Builder { a | for : M3e.Build.Internal.Available } s msg kind
    -> Builder { for : M3e.Build.Internal.Used } s msg kind
for v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Toc.for v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The maximum depth of the table of contents. (default: `2`) -}
maxDepth :
    Float
    -> Builder { a | maxDepth : M3e.Build.Internal.Available } s msg kind
    -> Builder { maxDepth : M3e.Build.Internal.Used } s msg kind
maxDepth v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.Toc.maxDepth v_))
             (M3e.Build.Internal.node_ b_)
        )