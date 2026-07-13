module M3e.Build.Accordion exposing
    ( Builder, AttrCaps, SlotCaps, accordion, attr, multi
    , build
    )

{-| The Build form for `<m3e-accordion>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Accordion as Accordion`.

@docs Builder, AttrCaps, SlotCaps, accordion, attr, multi
@docs build

-}

import M3e.Build.Internal
import M3e.Html.Accordion
import M3e.Kind
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr.Internal
import Markup.Node


{-| Phantom-typed opaque builder for `<m3e-accordion>`.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder
        { kind
            | accordion : M3e.Kind.Brand
        }
        attrCaps
        slotCaps
        msg


{-| Per-component attribute capability row for the phantom-typed Builder.
-}
type alias AttrCaps =
    { multi : M3e.Build.Internal.Available }


{-| Per-component slot capability row for the phantom-typed Builder.
-}
type alias SlotCaps =
    { unnamed : M3e.Build.Internal.NotFilled }


{-| Seed a `Builder` for `<m3e-accordion>`.
-}
accordion : Builder AttrCaps SlotCaps msg kind
accordion =
    M3e.Build.Internal.wrap_
        (Markup.Node.fromComponent
            (\erased_ ch_ ->
                M3e.Html.Accordion.accordion
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


{-| Whether multiple expansion panels can be open at the same time. (default: `false`)
-}
multi :
    Bool
    -> Builder { a | multi : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | multi : M3e.Build.Internal.Used } s msg kind
multi v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.Accordion.multi v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-accordion>` element from a `Builder`.
-}
build :
    Builder a { s | unnamed : M3e.Build.Internal.Filled } msg kind
    -> Markup.Element.Element { accordion : M3e.Kind.Brand } msg
build b_ =
    Markup.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)
