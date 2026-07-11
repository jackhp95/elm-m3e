module M3e.Build.Breadcrumb exposing
    ( Builder, AttrCaps, SlotCaps, breadcrumb, attr, wrap
    , separator, build
    )

{-| The Build form for `<m3e-breadcrumb>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Breadcrumb as Breadcrumb`.

@docs Builder, AttrCaps, SlotCaps, breadcrumb, attr, wrap
@docs separator, build

-}

import M3e.Build.Internal
import M3e.Element
import M3e.Element.Internal
import M3e.Html.Attr.Internal
import M3e.Html.Breadcrumb
import M3e.Node
import M3e.Token


{-| Phantom-typed opaque builder for `<m3e-breadcrumb>`.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder
        { kind
            | breadcrumb : M3e.Token.Supported
        }
        attrCaps
        slotCaps
        msg


{-| Per-component attribute capability row for the phantom-typed Builder.
-}
type alias AttrCaps =
    { wrap : M3e.Build.Internal.Available }


{-| Per-component slot capability row for the phantom-typed Builder.
-}
type alias SlotCaps =
    { separator : M3e.Build.Internal.Available
    , unnamed : M3e.Build.Internal.NotFilled
    }


{-| Seed a `Builder` for `<m3e-breadcrumb>`.
-}
breadcrumb : Builder AttrCaps SlotCaps msg kind
breadcrumb =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
            (\erased_ ch_ ->
                M3e.Html.Breadcrumb.breadcrumb
                    (List.map M3e.Html.Attr.Internal.forget erased_)
                    ch_
            )
            []
            []
        )


{-| Inject an already-built universal `Attr` (e.g. from `M3e.Aria.*`) into the pipeline, appending it to the accumulated attrs. Unlike the typed per-attribute setters it consumes no phantom capability, so it can be applied any number of times.
-}
attr :
    M3e.Html.Attr.Internal.Attr caps msg
    -> Builder a s msg kind
    -> Builder a s msg kind
attr a_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget a_)
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether items wrap to a new line. (default: `false`)
-}
wrap :
    Bool
    -> Builder { a | wrap : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | wrap : M3e.Build.Internal.Used } s msg kind
wrap v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.Breadcrumb.wrap v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `separator` slot.
-}
separator :
    M3e.Element.Element any msg
    -> Builder a { s | separator : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | separator : M3e.Build.Internal.Used } msg kind
separator el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Element.toNode (M3e.Element.withSlot "separator" el_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-breadcrumb>` element from a `Builder`.
-}
build :
    Builder a { s | unnamed : M3e.Build.Internal.Filled } msg kind
    -> M3e.Element.Element { breadcrumb : M3e.Token.Supported } msg
build b_ =
    M3e.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)
