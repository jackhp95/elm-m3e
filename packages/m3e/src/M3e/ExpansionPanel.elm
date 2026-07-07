module M3e.ExpansionPanel exposing
    ( view, disabled, hideToggle, open, toggleDirection, togglePosition
    , onOpening, onOpened, onClosing, onClosed, actions, header, toggleIcon
    )

{-|
An expandable details-summary view.

**Component Info:**
- **Extends:** `LitElement`

**Events:**
- `opening`: Dispatched when the expansion panel begins to open.
- `opened`: Dispatched when the expansion panel has opened.
- `closing`: Dispatched when the expansion panel begins to close.
- `closed`: Dispatched when the expansion panel has closed.

**Slots:**
- `actions`: Renders the actions bar of the panel.
- `header`: Renders the header content.
- `toggle-icon`: Renders the expansion toggle icon.

<!-- elm-cem:docmeta category=Containment -->

## Examples

### Examples

<!-- elm-cem:example title="Standalone panels" -->
```elm
M3e.ExpansionPanel.view [] [ M3e.ExpansionPanel.header (Native.span [] [ Kit.text "Panel header" ]), M3e.ExpansionPanel.child (Kit.text "Panel contents") ]
```

<!-- elm-cem:example title="Standalone panels (2)" -->
```elm
M3e.ExpansionPanel.view [ M3e.ExpansionPanel.open True ] [ M3e.ExpansionPanel.header (Native.span [] [ Kit.text "Panel header" ]), M3e.ExpansionPanel.child (Kit.text "Panel contents") ]
```

<!-- elm-cem:example title="Toggles" -->
```elm
M3e.ExpansionPanel.view [ M3e.ExpansionPanel.togglePosition M3e.Value.before, M3e.ExpansionPanel.toggleDirection M3e.Value.horizontal ] [ M3e.ExpansionPanel.header (Native.span [] [ Kit.text "Panel header" ]), M3e.ExpansionPanel.child (Kit.text "Panel contents") ]
```

<!-- elm-cem:example title="Toggles (2)" -->
```elm
M3e.ExpansionPanel.view [ M3e.ExpansionPanel.hideToggle True ] [ M3e.ExpansionPanel.header (Native.span [] [ Kit.text "Panel header" ]), M3e.ExpansionPanel.child (Kit.text "Panel contents") ]
```

<!-- elm-cem:example title="Accordion" -->
```elm
M3e.Accordion.view [] (M3e.Accordion.children [ M3e.ExpansionPanel.view [ M3e.ExpansionPanel.open True ] [ M3e.ExpansionPanel.header (Native.span [] [ Kit.text "Panel 1" ]), M3e.ExpansionPanel.child (Kit.text "I am content for the first panel") ], M3e.ExpansionPanel.view [] [ M3e.ExpansionPanel.header (Native.span [] [ Kit.text "Panel 2" ]), M3e.ExpansionPanel.child (Kit.text "I am content for the second panel") ], M3e.ExpansionPanel.view [] [ M3e.ExpansionPanel.header (Native.span [] [ Kit.text "Panel 3" ]), M3e.ExpansionPanel.child (Kit.text "I am content for the third panel") ] ])
```

<!-- elm-cem:example title="Accordion (2)" -->
```elm
M3e.Accordion.view [ M3e.Accordion.multi True ] (M3e.Accordion.children [ M3e.ExpansionPanel.view [ M3e.ExpansionPanel.open True ] [ M3e.ExpansionPanel.header (Native.span [] [ Kit.text "Panel 1" ]), M3e.ExpansionPanel.child (Kit.text "I am content for the first panel") ], M3e.ExpansionPanel.view [ M3e.ExpansionPanel.open True ] [ M3e.ExpansionPanel.header (Native.span [] [ Kit.text "Panel 2" ]), M3e.ExpansionPanel.child (Kit.text "I am content for the second panel") ], M3e.ExpansionPanel.view [ M3e.ExpansionPanel.open True ] [ M3e.ExpansionPanel.header (Native.span [] [ Kit.text "Panel 3" ]), M3e.ExpansionPanel.child (Kit.text "I am content for the third panel") ] ])
```

@docs view, disabled, hideToggle, open, toggleDirection, togglePosition
@docs onOpening, onOpened, onClosing, onClosed, actions, header
@docs toggleIcon
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.ExpansionPanel
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-expansion-panel>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , hideToggle : M3e.Value.Supported
    , open : M3e.Value.Supported
    , toggleDirection : M3e.Value.Supported
    , togglePosition : M3e.Value.Supported
    , onOpening : M3e.Value.Supported
    , onOpened : M3e.Value.Supported
    , onClosing : M3e.Value.Supported
    , onClosed : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | expansionPanel : M3e.Value.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.ExpansionPanel.expansionPanel
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Element.toNode children)
        )


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.ExpansionPanel.disabled


{-| Whether to hide the expansion toggle. (default: `false`) -}
hideToggle :
    Bool -> M3e.Cem.Attr.Attr { c | hideToggle : M3e.Value.Supported } msg
hideToggle =
    M3e.Cem.ExpansionPanel.hideToggle


{-| Whether the panel is expanded. (default: `false`) -}
open : Bool -> M3e.Cem.Attr.Attr { c | open : M3e.Value.Supported } msg
open =
    M3e.Cem.ExpansionPanel.open


{-| The direction of the expansion toggle. (default: `"vertical"`) -}
toggleDirection :
    M3e.Value.Value { horizontal : M3e.Value.Supported
    , vertical : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | toggleDirection : M3e.Value.Supported } msg
toggleDirection =
    M3e.Cem.ExpansionPanel.toggleDirection


{-| The position of the expansion toggle. (default: `"after"`) -}
togglePosition :
    M3e.Value.Value { after : M3e.Value.Supported
    , before : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | togglePosition : M3e.Value.Supported } msg
togglePosition =
    M3e.Cem.ExpansionPanel.togglePosition


{-| Listen for `opening` events. -}
onOpening : msg -> M3e.Cem.Attr.Attr { c | onOpening : M3e.Value.Supported } msg
onOpening =
    M3e.Cem.ExpansionPanel.onOpening


{-| Listen for `opened` events. -}
onOpened : msg -> M3e.Cem.Attr.Attr { c | onOpened : M3e.Value.Supported } msg
onOpened =
    M3e.Cem.ExpansionPanel.onOpened


{-| Listen for `closing` events. -}
onClosing : msg -> M3e.Cem.Attr.Attr { c | onClosing : M3e.Value.Supported } msg
onClosing =
    M3e.Cem.ExpansionPanel.onClosing


{-| Listen for `closed` events. -}
onClosed : msg -> M3e.Cem.Attr.Attr { c | onClosed : M3e.Value.Supported } msg
onClosed =
    M3e.Cem.ExpansionPanel.onClosed


{-| Place content in the `actions` slot. -}
actions : M3e.Element.Element any msg -> M3e.Element.Element k msg
actions el =
    M3e.Element.Internal.placeSlot "actions" el


{-| Place content in the `header` slot. -}
header : M3e.Element.Element any msg -> M3e.Element.Element k msg
header el =
    M3e.Element.Internal.placeSlot "header" el


{-| Place content in the `toggle-icon` slot. -}
toggleIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Element.Element k msg
toggleIcon el =
    M3e.Element.Internal.placeSlot "toggle-icon" el