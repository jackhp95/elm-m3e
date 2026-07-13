module M3e.Build.Divider exposing
    ( Builder, AttrCaps, SlotCaps, divider, attr, inset
    , insetStart, insetEnd, vertical, build
    )

{-| The Build form for `<m3e-divider>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Divider as Divider`.

@docs Builder, AttrCaps, SlotCaps, divider, attr, inset
@docs insetStart, insetEnd, vertical, build

-}

import M3e.Build.Internal
import M3e.Html.Divider
import M3e.Kind
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr.Internal
import Markup.Node


{-| Phantom-typed opaque builder for `<m3e-divider>`.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder
        { kind
            | divider : M3e.Kind.Brand
        }
        attrCaps
        slotCaps
        msg


{-| Per-component attribute capability row for the phantom-typed Builder.
-}
type alias AttrCaps =
    { inset : M3e.Build.Internal.Available
    , insetStart : M3e.Build.Internal.Available
    , insetEnd : M3e.Build.Internal.Available
    , vertical : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder.
-}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-divider>`.
-}
divider : Builder AttrCaps SlotCaps msg kind
divider =
    M3e.Build.Internal.wrap_
        (Markup.Node.fromComponent
            (\erased_ ch_ ->
                M3e.Html.Divider.divider
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


{-| Whether the divider is indented with equal padding on both sides. (default: `false`)
-}
inset :
    Bool
    -> Builder { a | inset : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | inset : M3e.Build.Internal.Used } s msg kind
inset v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Divider.inset v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether the divider is indented with padding on the leading side. (default: `false`)
-}
insetStart :
    Bool
    -> Builder { a | insetStart : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | insetStart : M3e.Build.Internal.Used } s msg kind
insetStart v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Divider.insetStart v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether the divider is indented with padding on the trailing side. (default: `false`)
-}
insetEnd :
    Bool
    -> Builder { a | insetEnd : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | insetEnd : M3e.Build.Internal.Used } s msg kind
insetEnd v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Divider.insetEnd v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether the divider is vertically aligned with adjacent content. (default: `false`)
-}
vertical :
    Bool
    -> Builder { a | vertical : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | vertical : M3e.Build.Internal.Used } s msg kind
vertical v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Divider.vertical v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-divider>` element from a `Builder`.
-}
build :
    Builder a s msg kind
    -> Markup.Element.Element { divider : M3e.Kind.Brand } msg
build b_ =
    Markup.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)
