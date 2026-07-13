module M3e.Build.ListItem exposing
    ( Builder, AttrCaps, SlotCaps, listItem, attr, child
    , leading, overline, supportingText, trailing, build
    )

{-| The Build form for `<m3e-list-item>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.ListItem as ListItem`.

@docs Builder, AttrCaps, SlotCaps, listItem, attr, child
@docs leading, overline, supportingText, trailing, build

-}

import M3e.Build.Internal
import M3e.Html.ListItem
import M3e.Kind
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr.Internal
import Markup.Kind
import Markup.Node


{-| Phantom-typed opaque builder for `<m3e-list-item>`.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder
        { kind
            | listItem : M3e.Kind.Brand
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
    { unnamed : M3e.Build.Internal.Available
    , leading : M3e.Build.Internal.Available
    , overline : M3e.Build.Internal.Available
    , supportingText : M3e.Build.Internal.Available
    , trailing : M3e.Build.Internal.Available
    }


{-| Seed a `Builder` for `<m3e-list-item>`.
-}
listItem : Builder AttrCaps SlotCaps msg kind
listItem =
    M3e.Build.Internal.wrap_
        (Markup.Node.fromComponent
            (\erased_ ch_ ->
                M3e.Html.ListItem.listItem
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


{-| Place content in the `(default)` slot.
-}
child :
    Markup.Element.Element
        { text : Markup.Kind.Shared
        , html : M3e.Kind.Brand
        }
        msg
    -> Builder a { s | unnamed : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | unnamed : M3e.Build.Internal.Used } msg kind
child el_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (Markup.Element.toNode el_)
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `leading` slot.
-}
leading :
    Markup.Element.Element
        { icon : Markup.Kind.Shared
        , avatar : M3e.Kind.Brand
        , text : Markup.Kind.Shared
        , html : M3e.Kind.Brand
        }
        msg
    -> Builder a { s | leading : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | leading : M3e.Build.Internal.Used } msg kind
leading el_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (Markup.Element.toNode (Markup.Element.withSlot "leading" el_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `overline` slot.
-}
overline :
    Markup.Element.Element
        { text : Markup.Kind.Shared
        , html : M3e.Kind.Brand
        }
        msg
    -> Builder a { s | overline : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | overline : M3e.Build.Internal.Used } msg kind
overline el_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (Markup.Element.toNode (Markup.Element.withSlot "overline" el_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `supporting-text` slot.
-}
supportingText :
    Markup.Element.Element
        { text : Markup.Kind.Shared
        , html : M3e.Kind.Brand
        }
        msg
    -> Builder a { s | supportingText : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | supportingText : M3e.Build.Internal.Used } msg kind
supportingText el_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (Markup.Element.toNode
                (Markup.Element.withSlot "supporting-text" el_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `trailing` slot.
-}
trailing :
    Markup.Element.Element
        { icon : Markup.Kind.Shared
        , avatar : M3e.Kind.Brand
        , text : Markup.Kind.Shared
        , html : M3e.Kind.Brand
        , switch : M3e.Kind.Brand
        , radio : M3e.Kind.Brand
        , checkbox : M3e.Kind.Brand
        }
        msg
    -> Builder a { s | trailing : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | trailing : M3e.Build.Internal.Used } msg kind
trailing el_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (Markup.Element.toNode (Markup.Element.withSlot "trailing" el_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-list-item>` element from a `Builder`.
-}
build :
    Builder a s msg kind
    -> Markup.Element.Element { listItem : M3e.Kind.Brand } msg
build b_ =
    Markup.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)
