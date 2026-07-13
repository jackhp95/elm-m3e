module M3e.Build.ChipSet exposing
    ( Builder, AttrCaps, SlotCaps, chipSet, attr, vertical
    , build
    )

{-| The Build form for `<m3e-chip-set>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.ChipSet as ChipSet`.

@docs Builder, AttrCaps, SlotCaps, chipSet, attr, vertical
@docs build

-}

import M3e.Build.Internal
import M3e.Html.ChipSet
import M3e.Kind
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr.Internal
import Markup.Node


{-| Phantom-typed opaque builder for `<m3e-chip-set>`.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder
        { kind
            | chipSet : M3e.Kind.Brand
        }
        attrCaps
        slotCaps
        msg


{-| Per-component attribute capability row for the phantom-typed Builder.
-}
type alias AttrCaps =
    { vertical : M3e.Build.Internal.Available }


{-| Per-component slot capability row for the phantom-typed Builder.
-}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-chip-set>`.
-}
chipSet : Builder AttrCaps SlotCaps msg kind
chipSet =
    M3e.Build.Internal.wrap_
        (Markup.Node.fromComponent
            (\erased_ ch_ ->
                M3e.Html.ChipSet.chipSet
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


{-| Whether the element is oriented vertically. (default: `false`)
-}
vertical :
    Bool
    -> Builder { a | vertical : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | vertical : M3e.Build.Internal.Used } s msg kind
vertical v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.ChipSet.vertical v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-chip-set>` element from a `Builder`.
-}
build :
    Builder a s msg kind
    -> Markup.Element.Element { chipSet : M3e.Kind.Brand } msg
build b_ =
    Markup.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)
