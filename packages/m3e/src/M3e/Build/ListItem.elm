module M3e.Build.ListItem exposing
    ( Builder, AttrCaps, SlotCaps, listItem, attr, child
    , leading, overline, supportingText, trailing, build
    )

{-|
The ⑤ Build shape for `<m3e-list-item>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.ListItem as ListItem`.

@docs Builder, AttrCaps, SlotCaps, listItem, attr, child
@docs leading, overline, supportingText, trailing, build
-}


import M3e.Build.Internal
import M3e.Cem.Attr.Internal
import M3e.Cem.ListItem
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-list-item>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | listItem : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { unnamed : M3e.Build.Internal.Available
    , leading : M3e.Build.Internal.Available
    , overline : M3e.Build.Internal.Available
    , supportingText : M3e.Build.Internal.Available
    , trailing : M3e.Build.Internal.Available
    }


{-| Seed a `Builder` for `<m3e-list-item>`. -}
listItem : Builder AttrCaps SlotCaps msg kind
listItem =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.ListItem.listItem
                      (List.map M3e.Cem.Attr.Internal.forget erased_)
                      ch_
             )
             []
             []
        )


{-| Inject an already-built universal `Attr` (e.g. from `M3e.Aria.*`) into the pipeline, appending it to the accumulated attrs. Unlike the typed per-attribute setters it consumes no phantom capability, so it can be applied any number of times. -}
attr :
    M3e.Cem.Attr.Internal.Attr caps msg
    -> Builder a s msg kind
    -> Builder a s msg kind
attr a_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget a_)
             (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `(default)` slot. -}
child :
    M3e.Element.Element { text : M3e.Value.Supported
    , html : M3e.Value.Supported
    } msg
    -> Builder a { s | unnamed : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | unnamed : M3e.Build.Internal.Used } msg kind
child el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Element.toNode el_)
             (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `leading` slot. -}
leading :
    M3e.Element.Element { icon : M3e.Value.Supported
    , avatar : M3e.Value.Supported
    , text : M3e.Value.Supported
    , html : M3e.Value.Supported
    } msg
    -> Builder a { s | leading : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | leading : M3e.Build.Internal.Used } msg kind
leading el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Element.toNode (M3e.Element.withSlot "leading" el_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `overline` slot. -}
overline :
    M3e.Element.Element { text : M3e.Value.Supported
    , html : M3e.Value.Supported
    } msg
    -> Builder a { s | overline : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | overline : M3e.Build.Internal.Used } msg kind
overline el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Element.toNode (M3e.Element.withSlot "overline" el_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `supporting-text` slot. -}
supportingText :
    M3e.Element.Element { text : M3e.Value.Supported
    , html : M3e.Value.Supported
    } msg
    -> Builder a { s | supportingText : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | supportingText : M3e.Build.Internal.Used } msg kind
supportingText el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Element.toNode (M3e.Element.withSlot "supporting-text" el_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `trailing` slot. -}
trailing :
    M3e.Element.Element { icon : M3e.Value.Supported
    , avatar : M3e.Value.Supported
    , text : M3e.Value.Supported
    , html : M3e.Value.Supported
    , switch : M3e.Value.Supported
    , radio : M3e.Value.Supported
    , checkbox : M3e.Value.Supported
    } msg
    -> Builder a { s | trailing : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | trailing : M3e.Build.Internal.Used } msg kind
trailing el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Element.toNode (M3e.Element.withSlot "trailing" el_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-list-item>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { listItem : M3e.Value.Supported } msg
build b_ =
    M3e.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)