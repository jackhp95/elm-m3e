module M3e.Build.ExpansionPanel exposing
    ( Builder, AttrCaps, SlotCaps, expansionPanel, disabled, hideToggle
    , open, toggleDirection, togglePosition, onOpening, onOpened, onClosing, onClosed
    , child, header, toggleIcon, build
    )

{-|
The ⑤ Build shape for `<m3e-expansion-panel>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.ExpansionPanel as ExpansionPanel`.

@docs Builder, AttrCaps, SlotCaps, expansionPanel, disabled, hideToggle
@docs open, toggleDirection, togglePosition, onOpening, onOpened, onClosing
@docs onClosed, child, header, toggleIcon, build
-}


import M3e.Build.Internal
import M3e.Cem.Attr.Internal
import M3e.Cem.ExpansionPanel
import M3e.Element
import M3e.Element.Internal
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
    { unnamed : M3e.Build.Internal.Available
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
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.ExpansionPanel.disabled v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether to hide the expansion toggle. (default: `false`) -}
hideToggle :
    Bool
    -> Builder { a | hideToggle : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | hideToggle : M3e.Build.Internal.Used } s msg kind
hideToggle v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget
                  (M3e.Cem.ExpansionPanel.hideToggle v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether the panel is expanded. (default: `false`) -}
open :
    Bool
    -> Builder { a | open : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | open : M3e.Build.Internal.Used } s msg kind
open v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.ExpansionPanel.open v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The direction of the expansion toggle. (default: `"vertical"`) -}
toggleDirection :
    M3e.Value.Value { horizontal : M3e.Value.Supported
    , vertical : M3e.Value.Supported
    }
    -> Builder { a | toggleDirection : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | toggleDirection : M3e.Build.Internal.Used } s msg kind
toggleDirection v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget
                  (M3e.Cem.ExpansionPanel.toggleDirection v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| The position of the expansion toggle. (default: `"after"`) -}
togglePosition :
    M3e.Value.Value { after : M3e.Value.Supported
    , before : M3e.Value.Supported
    }
    -> Builder { a | togglePosition : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | togglePosition : M3e.Build.Internal.Used } s msg kind
togglePosition v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget
                  (M3e.Cem.ExpansionPanel.togglePosition v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the expansion panel begins to open. -}
onOpening :
    msg
    -> Builder { a | onOpening : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onOpening : M3e.Build.Internal.Used } s msg kind
onOpening v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.ExpansionPanel.onOpening v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the expansion panel has opened. -}
onOpened :
    msg
    -> Builder { a | onOpened : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onOpened : M3e.Build.Internal.Used } s msg kind
onOpened v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.ExpansionPanel.onOpened v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the expansion panel begins to close. -}
onClosing :
    msg
    -> Builder { a | onClosing : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onClosing : M3e.Build.Internal.Used } s msg kind
onClosing v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.ExpansionPanel.onClosing v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the expansion panel has closed. -}
onClosed :
    msg
    -> Builder { a | onClosed : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onClosed : M3e.Build.Internal.Used } s msg kind
onClosed v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.ExpansionPanel.onClosed v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `(default)` slot. -}
child :
    M3e.Element.Element any msg
    -> Builder a { s | unnamed : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | unnamed : M3e.Build.Internal.Used } msg kind
child el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Element.toNode el_)
             (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `header` slot. -}
header :
    M3e.Element.Element any msg
    -> Builder a { s | header : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | header : M3e.Build.Internal.Used } msg kind
header el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Element.toNode (M3e.Element.withSlot "header" el_))
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


{-| Build the `<m3e-expansion-panel>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { expansionPanel : M3e.Value.Supported } msg
build b_ =
    M3e.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)