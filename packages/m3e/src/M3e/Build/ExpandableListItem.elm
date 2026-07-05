module M3e.Build.ExpandableListItem exposing
    ( Builder, AttrCaps, SlotCaps, expandableListItem, disabled, open
    , onOpening, onOpened, onClosing, onClosed
    )

{-|
The ⑤ Build shape for `<m3e-expandable-list-item>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.ExpandableListItem as ExpandableListItem`.

@docs Builder, AttrCaps, SlotCaps, expandableListItem, disabled, open
@docs onOpening, onOpened, onClosing, onClosed
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.ExpandableListItem
import M3e.Cem.Html.ExpandableListItem
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
    { default : M3e.Build.Internal.Available
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
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             []
             []
        )


{-| Whether the element is disabled. (default: `false`) -}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg kind
    -> Builder { disabled : M3e.Build.Internal.Used } s msg kind
disabled v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.ExpandableListItem.disabled v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether the item is expanded. (default: `false`) -}
open :
    Bool
    -> Builder { a | open : M3e.Build.Internal.Available } s msg kind
    -> Builder { open : M3e.Build.Internal.Used } s msg kind
open v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.ExpandableListItem.open v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the item begins to open. -}
onOpening :
    Json.Decode.Decoder msg
    -> Builder { a | onOpening : M3e.Build.Internal.Available } s msg kind
    -> Builder { onOpening : M3e.Build.Internal.Used } s msg kind
onOpening v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.Attr.attribute
                       M3e.Cem.Html.ExpandableListItem.onOpening
                       v_
                  )
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the item has opened. -}
onOpened :
    Json.Decode.Decoder msg
    -> Builder { a | onOpened : M3e.Build.Internal.Available } s msg kind
    -> Builder { onOpened : M3e.Build.Internal.Used } s msg kind
onOpened v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.Attr.attribute
                       M3e.Cem.Html.ExpandableListItem.onOpened
                       v_
                  )
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the item begins to close. -}
onClosing :
    Json.Decode.Decoder msg
    -> Builder { a | onClosing : M3e.Build.Internal.Available } s msg kind
    -> Builder { onClosing : M3e.Build.Internal.Used } s msg kind
onClosing v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.Attr.attribute
                       M3e.Cem.Html.ExpandableListItem.onClosing
                       v_
                  )
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the item has closed. -}
onClosed :
    Json.Decode.Decoder msg
    -> Builder { a | onClosed : M3e.Build.Internal.Available } s msg kind
    -> Builder { onClosed : M3e.Build.Internal.Used } s msg kind
onClosed v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.Attr.attribute
                       M3e.Cem.Html.ExpandableListItem.onClosed
                       v_
                  )
             )
             (M3e.Build.Internal.node_ b_)
        )