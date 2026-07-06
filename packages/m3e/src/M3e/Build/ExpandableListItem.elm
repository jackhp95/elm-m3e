module M3e.Build.ExpandableListItem exposing
    ( Builder, AttrCaps, SlotCaps, expandableListItem, disabled, open
    , onOpening, onOpened, onClosing, onClosed, child, leading, overline
    , supportingText, toggleIcon, items, build
    )

{-|
The ⑤ Build shape for `<m3e-expandable-list-item>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.ExpandableListItem as ExpandableListItem`.

@docs Builder, AttrCaps, SlotCaps, expandableListItem, disabled, open
@docs onOpening, onOpened, onClosing, onClosed, child, leading
@docs overline, supportingText, toggleIcon, items, build
-}


import M3e.Build.Internal
import M3e.Cem.Attr.Internal
import M3e.Cem.ExpandableListItem
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-expandable-list-item>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | expandableListItem : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , open : M3e.Build.Internal.Available
    , onOpening : M3e.Build.Internal.Available
    , onOpened : M3e.Build.Internal.Available
    , onClosing : M3e.Build.Internal.Available
    , onClosed : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { unnamed : M3e.Build.Internal.Available
    , leading : M3e.Build.Internal.Available
    , overline : M3e.Build.Internal.Available
    , supportingText : M3e.Build.Internal.Available
    , toggleIcon : M3e.Build.Internal.Available
    , items : M3e.Build.Internal.Available
    }


{-| Seed a `Builder` for `<m3e-expandable-list-item>`. -}
expandableListItem : Builder AttrCaps SlotCaps msg kind
expandableListItem =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.ExpandableListItem.expandableListItem
                      (List.map M3e.Cem.Attr.Internal.forget erased_)
                      ch_
             )
             []
             []
        )


{-| Whether the element is disabled. (default: `false`) -}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg kind
disabled v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget
                  (M3e.Cem.ExpandableListItem.disabled v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether the item is expanded. (default: `false`) -}
open :
    Bool
    -> Builder { a | open : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | open : M3e.Build.Internal.Used } s msg kind
open v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.ExpandableListItem.open v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the item begins to open. -}
onOpening :
    msg
    -> Builder { a | onOpening : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onOpening : M3e.Build.Internal.Used } s msg kind
onOpening v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget
                  (M3e.Cem.ExpandableListItem.onOpening v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the item has opened. -}
onOpened :
    msg
    -> Builder { a | onOpened : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onOpened : M3e.Build.Internal.Used } s msg kind
onOpened v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget
                  (M3e.Cem.ExpandableListItem.onOpened v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the item begins to close. -}
onClosing :
    msg
    -> Builder { a | onClosing : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onClosing : M3e.Build.Internal.Used } s msg kind
onClosing v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget
                  (M3e.Cem.ExpandableListItem.onClosing v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the item has closed. -}
onClosed :
    msg
    -> Builder { a | onClosed : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onClosed : M3e.Build.Internal.Used } s msg kind
onClosed v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget
                  (M3e.Cem.ExpandableListItem.onClosed v_)
             )
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


{-| Place content in the `toggle-icon` slot. -}
toggleIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> Builder a { s | toggleIcon : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | toggleIcon : M3e.Build.Internal.Used } msg kind
toggleIcon el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Element.toNode (M3e.Element.withSlot "toggle-icon" el_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `items` slot. -}
items :
    M3e.Element.Element any msg
    -> Builder a { s | items : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | items : M3e.Build.Internal.Used } msg kind
items el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Element.toNode (M3e.Element.withSlot "items" el_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-expandable-list-item>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { expandableListItem : M3e.Value.Supported } msg
build b_ =
    M3e.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)