module M3e.Build.Toc exposing
    ( Builder, AttrCaps, SlotCaps, toc, attr, for
    , maxDepth, child, overline, title, build
    )

{-| The Build form for `<m3e-toc>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Toc as Toc`.

@docs Builder, AttrCaps, SlotCaps, toc, attr, for
@docs maxDepth, child, overline, title, build

-}

import M3e.Build.Internal
import M3e.Html.Toc
import M3e.Kind
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr.Internal
import Markup.Kind
import Markup.Node


{-| Phantom-typed opaque builder for `<m3e-toc>`.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder
        { kind
            | toc : M3e.Kind.Brand
        }
        attrCaps
        slotCaps
        msg


{-| Per-component attribute capability row for the phantom-typed Builder.
-}
type alias AttrCaps =
    { for : M3e.Build.Internal.Available
    , maxDepth : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder.
-}
type alias SlotCaps =
    { unnamed : M3e.Build.Internal.Available
    , overline : M3e.Build.Internal.Available
    , title : M3e.Build.Internal.Available
    }


{-| Seed a `Builder` for `<m3e-toc>`.
-}
toc : Builder AttrCaps SlotCaps msg kind
toc =
    M3e.Build.Internal.wrap_
        (Markup.Node.fromComponent
            (\erased_ ch_ ->
                M3e.Html.Toc.toc
                    (List.map Markup.Html.Attr.Internal.forget erased_)
                    ch_
            )
            []
            []
        )


{-| Inject an already-built universal `Attr` (e.g. from `M3e.Aria.*`) into the pipeline, appending it to the accumulated attrs. Unlike the typed per-attribute setters it consumes no phantom capability, so it can be applied any number of times.
-}
attr :
    Markup.Html.Attr.Internal.Attr caps msg
    -> Builder a s msg kind
    -> Builder a s msg kind
attr a_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget a_)
            (M3e.Build.Internal.node_ b_)
        )


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for :
    String
    -> Builder { a | for : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | for : M3e.Build.Internal.Used } s msg kind
for v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Toc.for v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The maximum depth of the table of contents. (default: `2`)
-}
maxDepth :
    Float
    -> Builder { a | maxDepth : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | maxDepth : M3e.Build.Internal.Used } s msg kind
maxDepth v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Toc.maxDepth v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `(default)` slot.
-}
child :
    Markup.Element.Element any msg
    -> Builder a { s | unnamed : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | unnamed : M3e.Build.Internal.Used } msg kind
child el_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (Markup.Element.toNode el_)
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `overline` slot.
-}
overline :
    Markup.Element.Element { sharedText : Markup.Kind.Shared } msg
    -> Builder a { s | overline : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | overline : M3e.Build.Internal.Used } msg kind
overline el_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (Markup.Element.toNode (Markup.Element.withSlot "overline" el_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `title` slot.
-}
title :
    Markup.Element.Element { sharedText : Markup.Kind.Shared } msg
    -> Builder a { s | title : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | title : M3e.Build.Internal.Used } msg kind
title el_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (Markup.Element.toNode (Markup.Element.withSlot "title" el_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-toc>` element from a `Builder`.
-}
build : Builder a s msg kind -> Markup.Element.Element { toc : M3e.Kind.Brand } msg
build b_ =
    Markup.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)
