module M3e.Build.NavMenuItem exposing
    ( Builder, AttrCaps, SlotCaps, navMenuItem, disabled, open
    , selected, onOpening, onOpened, onClosing, onClosed, onClick
    )

{-|
The ⑤ Build shape for `<m3e-nav-menu-item>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.NavMenuItem as NavMenuItem`.

@docs Builder, AttrCaps, SlotCaps, navMenuItem, disabled, open
@docs selected, onOpening, onOpened, onClosing, onClosed, onClick
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.Html.NavMenuItem
import M3e.Cem.NavMenuItem
import M3e.Element
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-nav-menu-item>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | navMenuItem : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , open : M3e.Build.Internal.Available
    , selected : M3e.Build.Internal.Available
    , onOpening : M3e.Build.Internal.Available
    , onOpened : M3e.Build.Internal.Available
    , onClosing : M3e.Build.Internal.Available
    , onClosed : M3e.Build.Internal.Available
    , onClick : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { icon : M3e.Build.Internal.Available
    , badge : M3e.Build.Internal.Available
    , selectedIcon : M3e.Build.Internal.Available
    , toggleIcon : M3e.Build.Internal.Available
    }


{-| Seed a `Builder` for `<m3e-nav-menu-item>` with the required fields. -}
navMenuItem :
    { label :
        M3e.Element.Element { text : M3e.Value.Supported
        , link : M3e.Value.Supported
        } msg
    }
    -> Builder AttrCaps SlotCaps msg kind
navMenuItem req_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.NavMenuItem.navMenuItem
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             (List.map M3e.Cem.Attr.forget [])
             [ M3e.Element.toNode (M3e.Element.withSlot "label" req_.label) ]
        )


{-| Whether the element is disabled. (default: `false`) -}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg kind
    -> Builder { disabled : M3e.Build.Internal.Used } s msg kind
disabled v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.NavMenuItem.disabled v_))
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
             (M3e.Cem.Attr.forget (M3e.Cem.NavMenuItem.open v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether the item is selected. (default: `false`) -}
selected :
    Bool
    -> Builder { a | selected : M3e.Build.Internal.Available } s msg kind
    -> Builder { selected : M3e.Build.Internal.Used } s msg kind
selected v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.NavMenuItem.selected v_))
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
                  (M3e.Cem.Attr.attribute M3e.Cem.Html.NavMenuItem.onOpening v_)
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
                  (M3e.Cem.Attr.attribute M3e.Cem.Html.NavMenuItem.onOpened v_)
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
                  (M3e.Cem.Attr.attribute M3e.Cem.Html.NavMenuItem.onClosing v_)
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
                  (M3e.Cem.Attr.attribute M3e.Cem.Html.NavMenuItem.onClosed v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the element is clicked. -}
onClick :
    Json.Decode.Decoder msg
    -> Builder { a | onClick : M3e.Build.Internal.Available } s msg kind
    -> Builder { onClick : M3e.Build.Internal.Used } s msg kind
onClick v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.Attr.attribute M3e.Cem.Html.NavMenuItem.onClick v_)
             )
             (M3e.Build.Internal.node_ b_)
        )