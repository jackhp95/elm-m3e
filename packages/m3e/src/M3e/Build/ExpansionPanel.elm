module M3e.Build.ExpansionPanel exposing
    ( Builder, AttrCaps, SlotCaps, expansionPanel, disabled, hideToggle
    , open, toggleDirection, togglePosition, onOpening, onOpened, onClosing, onClosed
    )

{-|
The ⑤ Build shape for `<m3e-expansion-panel>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.ExpansionPanel as ExpansionPanel`.

@docs Builder, AttrCaps, SlotCaps, expansionPanel, disabled, hideToggle
@docs open, toggleDirection, togglePosition, onOpening, onOpened, onClosing
@docs onClosed
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.ExpansionPanel
import M3e.Cem.Html.ExpansionPanel
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-expansion-panel>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | expansionPanel : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , hideToggle : M3e.Build.Internal.Available
    , open : M3e.Build.Internal.Available
    , toggleDirection : M3e.Build.Internal.Available
    , togglePosition : M3e.Build.Internal.Available
    , onOpening : M3e.Build.Internal.Available
    , onOpened : M3e.Build.Internal.Available
    , onClosing : M3e.Build.Internal.Available
    , onClosed : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { default : M3e.Build.Internal.Available
    , header : M3e.Build.Internal.Available
    , toggleIcon : M3e.Build.Internal.Available
    }


{-| Seed a `Builder` for `<m3e-expansion-panel>`. -}
expansionPanel : Builder AttrCaps SlotCaps msg kind
expansionPanel =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.ExpansionPanel.expansionPanel
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
             (M3e.Cem.Attr.forget (M3e.Cem.ExpansionPanel.disabled v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether to hide the expansion toggle. (default: `false`) -}
hideToggle :
    Bool
    -> Builder { a | hideToggle : M3e.Build.Internal.Available } s msg kind
    -> Builder { hideToggle : M3e.Build.Internal.Used } s msg kind
hideToggle v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.ExpansionPanel.hideToggle v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether the panel is expanded. (default: `false`) -}
open :
    Bool
    -> Builder { a | open : M3e.Build.Internal.Available } s msg kind
    -> Builder { open : M3e.Build.Internal.Used } s msg kind
open v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.ExpansionPanel.open v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The direction of the expansion toggle. (default: `"vertical"`) -}
toggleDirection :
    M3e.Value.Value { horizontal : M3e.Value.Supported
    , vertical : M3e.Value.Supported
    }
    -> Builder { a | toggleDirection : M3e.Build.Internal.Available } s msg kind
    -> Builder { toggleDirection : M3e.Build.Internal.Used } s msg kind
toggleDirection v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.ExpansionPanel.toggleDirection v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The position of the expansion toggle. (default: `"after"`) -}
togglePosition :
    M3e.Value.Value { after : M3e.Value.Supported
    , before : M3e.Value.Supported
    }
    -> Builder { a | togglePosition : M3e.Build.Internal.Available } s msg kind
    -> Builder { togglePosition : M3e.Build.Internal.Used } s msg kind
togglePosition v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.ExpansionPanel.togglePosition v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the expansion panel begins to open. -}
onOpening :
    Json.Decode.Decoder msg
    -> Builder { a | onOpening : M3e.Build.Internal.Available } s msg kind
    -> Builder { onOpening : M3e.Build.Internal.Used } s msg kind
onOpening v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.Attr.attribute
                       M3e.Cem.Html.ExpansionPanel.onOpening
                       v_
                  )
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the expansion panel has opened. -}
onOpened :
    Json.Decode.Decoder msg
    -> Builder { a | onOpened : M3e.Build.Internal.Available } s msg kind
    -> Builder { onOpened : M3e.Build.Internal.Used } s msg kind
onOpened v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.Attr.attribute
                       M3e.Cem.Html.ExpansionPanel.onOpened
                       v_
                  )
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the expansion panel begins to close. -}
onClosing :
    Json.Decode.Decoder msg
    -> Builder { a | onClosing : M3e.Build.Internal.Available } s msg kind
    -> Builder { onClosing : M3e.Build.Internal.Used } s msg kind
onClosing v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.Attr.attribute
                       M3e.Cem.Html.ExpansionPanel.onClosing
                       v_
                  )
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the expansion panel has closed. -}
onClosed :
    Json.Decode.Decoder msg
    -> Builder { a | onClosed : M3e.Build.Internal.Available } s msg kind
    -> Builder { onClosed : M3e.Build.Internal.Used } s msg kind
onClosed v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.Attr.attribute
                       M3e.Cem.Html.ExpansionPanel.onClosed
                       v_
                  )
             )
             (M3e.Build.Internal.node_ b_)
        )