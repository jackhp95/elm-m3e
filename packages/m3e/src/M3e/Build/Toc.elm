module M3e.Build.Toc exposing
    ( Builder, AttrCaps, SlotCaps, toc, for, maxDepth
    , child, overline, title, build
    )

{-|
The ⑤ Build shape for `<m3e-toc>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Toc as Toc`.

@docs Builder, AttrCaps, SlotCaps, toc, for, maxDepth
@docs child, overline, title, build
-}


import M3e.Build.Internal
import M3e.Cem.Attr.Internal
import M3e.Cem.Toc
import M3e.Element
import M3e.Element.Internal
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
    { unnamed : M3e.Build.Internal.Available
    , overline : M3e.Build.Internal.Available
    , title : M3e.Build.Internal.Available
    }


{-| Seed a `Builder` for `<m3e-toc>`. -}
toc : Builder AttrCaps SlotCaps msg kind
toc =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.Toc.toc
                      (List.map M3e.Cem.Attr.Internal.forget erased_)
                      ch_
             )
             []
             []
        )


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for :
    String
    -> Builder { a | for : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | for : M3e.Build.Internal.Used } s msg kind
for v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Toc.for v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The maximum depth of the table of contents. (default: `2`) -}
maxDepth :
    Float
    -> Builder { a | maxDepth : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | maxDepth : M3e.Build.Internal.Used } s msg kind
maxDepth v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.Toc.maxDepth v_))
             (M3e.Build.Internal.node_ b_)
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


{-| Place content in the `overline` slot. -}
overline :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> Builder a { s | overline : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | overline : M3e.Build.Internal.Used } msg kind
overline el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Element.toNode (M3e.Element.withSlot "overline" el_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `title` slot. -}
title :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> Builder a { s | title : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | title : M3e.Build.Internal.Used } msg kind
title el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Element.toNode (M3e.Element.withSlot "title" el_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-toc>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { toc : M3e.Value.Supported } msg
build b_ =
    M3e.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)