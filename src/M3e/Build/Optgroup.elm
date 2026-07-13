module M3e.Build.Optgroup exposing
    ( Builder, AttrCaps, SlotCaps, optgroup, attr, label
    , build
    )

{-| The Build form for `<m3e-optgroup>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Optgroup as Optgroup`.

@docs Builder, AttrCaps, SlotCaps, optgroup, attr, label
@docs build

-}

import M3e.Build.Internal
import M3e.Html.Optgroup
import M3e.Kind
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr.Internal
import Markup.Kind
import Markup.Node


{-| Phantom-typed opaque builder for `<m3e-optgroup>`.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder
        { kind
            | optgroup : M3e.Kind.Brand
        }
        attrCaps
        slotCaps
        msg


{-| Per-component attribute capability row for the phantom-typed Builder.
-}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder.
-}
type alias SlotCaps =
    { label : M3e.Build.Internal.Available }


{-| Seed a `Builder` for `<m3e-optgroup>`.
-}
optgroup : Builder AttrCaps SlotCaps msg kind
optgroup =
    M3e.Build.Internal.wrap_
        (Markup.Node.fromComponent
            (\erased_ ch_ ->
                M3e.Html.Optgroup.optgroup
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


{-| Place content in the `label` slot.
-}
label :
    Markup.Element.Element { sharedText : Markup.Kind.Shared } msg
    -> Builder a { s | label : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | label : M3e.Build.Internal.Used } msg kind
label el_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (Markup.Element.toNode (Markup.Element.withSlot "label" el_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-optgroup>` element from a `Builder`.
-}
build :
    Builder a s msg kind
    -> Markup.Element.Element { optgroup : M3e.Kind.Brand } msg
build b_ =
    Markup.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)
