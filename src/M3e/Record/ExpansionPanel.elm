module M3e.Record.ExpansionPanel exposing
    ( view, disabled, hideToggle, open, toggleDirection, togglePosition
    , onOpening, onOpened, onClosing, onClosed, actions, toggleIcon
    )

{-| An expandable details-summary view.

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
M3e.ExpansionPanel.view [] [ M3e.ExpansionPanel.header (Native.span [] [ Kit.text "Panel header" ]), Kit.text "Panel contents" ]
```

<!-- elm-cem:example title="Standalone panels (2)" -->
```elm
M3e.ExpansionPanel.view [ M3e.ExpansionPanel.open True ] [ M3e.ExpansionPanel.header (Native.span [] [ Kit.text "Panel header" ]), Kit.text "Panel contents" ]
```

<!-- elm-cem:example title="Toggles" -->
```elm
M3e.ExpansionPanel.view [ M3e.ExpansionPanel.togglePosition M3e.Token.before, M3e.ExpansionPanel.toggleDirection M3e.Token.horizontal ] [ M3e.ExpansionPanel.header (Native.span [] [ Kit.text "Panel header" ]), Kit.text "Panel contents" ]
```

<!-- elm-cem:example title="Toggles (2)" -->
```elm
M3e.ExpansionPanel.view [ M3e.ExpansionPanel.hideToggle True ] [ M3e.ExpansionPanel.header (Native.span [] [ Kit.text "Panel header" ]), Kit.text "Panel contents" ]
```

<!-- elm-cem:example title="Accordion" -->
```elm
M3e.Accordion.view [] [ M3e.ExpansionPanel.view [ M3e.ExpansionPanel.open True ] [ M3e.ExpansionPanel.header (Native.span [] [ Kit.text "Panel 1" ]), Kit.text "I am content for the first panel" ], M3e.ExpansionPanel.view [] [ M3e.ExpansionPanel.header (Native.span [] [ Kit.text "Panel 2" ]), Kit.text "I am content for the second panel" ], M3e.ExpansionPanel.view [] [ M3e.ExpansionPanel.header (Native.span [] [ Kit.text "Panel 3" ]), Kit.text "I am content for the third panel" ] ]
```

<!-- elm-cem:example title="Accordion (2)" -->
```elm
M3e.Accordion.view [ M3e.Accordion.multi True ] [ M3e.ExpansionPanel.view [ M3e.ExpansionPanel.open True ] [ M3e.ExpansionPanel.header (Native.span [] [ Kit.text "Panel 1" ]), Kit.text "I am content for the first panel" ], M3e.ExpansionPanel.view [ M3e.ExpansionPanel.open True ] [ M3e.ExpansionPanel.header (Native.span [] [ Kit.text "Panel 2" ]), Kit.text "I am content for the second panel" ], M3e.ExpansionPanel.view [ M3e.ExpansionPanel.open True ] [ M3e.ExpansionPanel.header (Native.span [] [ Kit.text "Panel 3" ]), Kit.text "I am content for the third panel" ] ]
```

@docs view, disabled, hideToggle, open, toggleDirection, togglePosition
@docs onOpening, onOpened, onClosing, onClosed, actions, toggleIcon

-}

import M3e.Html.ExpansionPanel
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Kind
import Markup.Node


{-| Build the `<m3e-expansion-panel>` element (lazy IR).
-}
view :
    { header : Markup.Element.Element any msg }
    ->
        List
            (Markup.Html.Attr.Attr
                { disabled : M3e.Token.Supported
                , hideToggle : M3e.Token.Supported
                , open : M3e.Token.Supported
                , toggleDirection : M3e.Token.Supported
                , togglePosition : M3e.Token.Supported
                , onOpening : M3e.Token.Supported
                , onOpened : M3e.Token.Supported
                , onClosing : M3e.Token.Supported
                , onClosed : M3e.Token.Supported
                , slot : M3e.Token.Supported
                }
                msg
            )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | expansionPanel : M3e.Kind.Brand } msg
view req_ attributes content_ =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.ExpansionPanel.expansionPanel
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.append
                [ Markup.Element.toNode
                    (Markup.Element.withSlot "header" req_.header)
                ]
                (List.map Markup.Element.toNode content_)
            )
        )


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Markup.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    M3e.Html.ExpansionPanel.disabled


{-| Whether to hide the expansion toggle. (default: `false`)
-}
hideToggle : Bool -> Markup.Html.Attr.Attr { c | hideToggle : M3e.Token.Supported } msg
hideToggle =
    M3e.Html.ExpansionPanel.hideToggle


{-| Whether the panel is expanded. (default: `false`)
-}
open : Bool -> Markup.Html.Attr.Attr { c | open : M3e.Token.Supported } msg
open =
    M3e.Html.ExpansionPanel.open


{-| The direction of the expansion toggle. (default: `"vertical"`)
-}
toggleDirection :
    M3e.Token.Value
        { horizontal : M3e.Token.Supported
        , vertical : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | toggleDirection : M3e.Token.Supported } msg
toggleDirection =
    M3e.Html.ExpansionPanel.toggleDirection


{-| The position of the expansion toggle. (default: `"after"`)
-}
togglePosition :
    M3e.Token.Value
        { after : M3e.Token.Supported
        , before : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | togglePosition : M3e.Token.Supported } msg
togglePosition =
    M3e.Html.ExpansionPanel.togglePosition


{-| Listen for `opening` events.
-}
onOpening : msg -> Markup.Html.Attr.Attr { c | onOpening : M3e.Token.Supported } msg
onOpening =
    M3e.Html.ExpansionPanel.onOpening


{-| Listen for `opened` events.
-}
onOpened : msg -> Markup.Html.Attr.Attr { c | onOpened : M3e.Token.Supported } msg
onOpened =
    M3e.Html.ExpansionPanel.onOpened


{-| Listen for `closing` events.
-}
onClosing : msg -> Markup.Html.Attr.Attr { c | onClosing : M3e.Token.Supported } msg
onClosing =
    M3e.Html.ExpansionPanel.onClosing


{-| Listen for `closed` events.
-}
onClosed : msg -> Markup.Html.Attr.Attr { c | onClosed : M3e.Token.Supported } msg
onClosed =
    M3e.Html.ExpansionPanel.onClosed


{-| Place content in the `actions` slot.
-}
actions : Markup.Element.Element any msg -> Markup.Element.Element k msg
actions el =
    Markup.Element.Internal.placeSlot "actions" el


{-| Place content in the `toggle-icon` slot.
-}
toggleIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
toggleIcon el =
    Markup.Element.Internal.placeSlot "toggle-icon" el
