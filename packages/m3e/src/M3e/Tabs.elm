module M3e.Tabs exposing
    ( view, disablePagination, headerPosition, nextPageLabel, previousPageLabel, stretch
    , variant, onChange, onBeforeinput, onInput, child, panel, nextIcon
    , prevIcon, children
    )

{-|
Organizes content into separate views where only one view can be visible at a time.

**Component Info:**
- **Extends:** `LitElement`

**Events:**
- `change`: Dispatched when the selected tab changes.
- `beforeinput`: Dispatched before the selected state of a tab changes.
- `input`: Dispatched when the selected state of a tab changes.

**Slots:**
- `panel`: Renders the panels of the tabs.
- `next-icon`: Renders the icon to present for the next button used to paginate.
- `prev-icon`: Renders the icon to present for the previous button used to paginate.

<!-- elm-cem:docmeta category=Navigation -->

## Examples

### Examples

<!-- elm-cem:example title="Tabs with icons and panels" -->
```elm
M3e.Tabs.view [] (M3e.Tabs.children [ M3e.Tab.view [ M3e.Tab.selected True, M3e.Tab.for "tab-photos" ] [ M3e.Tab.icon (M3e.Icon.view [ M3e.Icon.name "photo_library" ] []), M3e.Tab.child (Kit.text "Photos") ], M3e.Tab.view [ M3e.Tab.for "tab-facts" ] [ M3e.Tab.icon (M3e.Icon.view [ M3e.Icon.name "psychology" ] []), M3e.Tab.child (Kit.text "Facts") ] ] ++ [ M3e.Tabs.panel (M3e.TabPanel.view [] [ M3e.TabPanel.child (Native.p [] [ Kit.text "Photo grid goes here." ]) ]), M3e.Tabs.panel (M3e.TabPanel.view [] [ M3e.TabPanel.child (Native.p [] [ Kit.text "Facts go here." ]) ]) ])
```

@docs view, disablePagination, headerPosition, nextPageLabel, previousPageLabel, stretch
@docs variant, onChange, onBeforeinput, onInput, child, panel
@docs nextIcon, prevIcon, children
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.Tabs
import M3e.Content
import M3e.Content.Internal
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-tabs>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { disablePagination : M3e.Value.Supported
    , headerPosition : M3e.Value.Supported
    , nextPageLabel : M3e.Value.Supported
    , previousPageLabel : M3e.Value.Supported
    , stretch : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , panel : M3e.Value.Supported
    , nextIcon : M3e.Value.Supported
    , prevIcon : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | tabs : M3e.Value.Supported } msg
view attributes content_ =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.Tabs.tabs
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Content.toNode content_)
        )


{-| Whether scroll buttons are disabled. -}
disablePagination :
    M3e.Value.Value { true : M3e.Value.Supported
    , false : M3e.Value.Supported
    , auto : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | disablePagination : M3e.Value.Supported } msg
disablePagination =
    M3e.Cem.Tabs.disablePagination


{-| The position of the tab headers. (default: `"before"`) -}
headerPosition :
    M3e.Value.Value { after : M3e.Value.Supported
    , before : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | headerPosition : M3e.Value.Supported } msg
headerPosition =
    M3e.Cem.Tabs.headerPosition


{-| The accessible label given to the button used to move to the next page. (default: `"Next page"`) -}
nextPageLabel :
    String -> M3e.Cem.Attr.Attr { c | nextPageLabel : M3e.Value.Supported } msg
nextPageLabel =
    M3e.Cem.Tabs.nextPageLabel


{-| The accessible label given to the button used to move to the previous page. (default: `"Previous page"`) -}
previousPageLabel :
    String
    -> M3e.Cem.Attr.Attr { c | previousPageLabel : M3e.Value.Supported } msg
previousPageLabel =
    M3e.Cem.Tabs.previousPageLabel


{-| Whether tabs are stretched to fill the header. (default: `false`) -}
stretch : Bool -> M3e.Cem.Attr.Attr { c | stretch : M3e.Value.Supported } msg
stretch =
    M3e.Cem.Tabs.stretch


{-| The appearance variant of the tabs. (default: `"secondary"`) -}
variant :
    M3e.Value.Value { primary : M3e.Value.Supported
    , secondary : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variant =
    M3e.Cem.Tabs.variant


{-| Listen for `change` events. -}
onChange : msg -> M3e.Cem.Attr.Attr { c | onChange : M3e.Value.Supported } msg
onChange =
    M3e.Cem.Tabs.onChange


{-| Listen for `beforeinput` events. -}
onBeforeinput :
    msg -> M3e.Cem.Attr.Attr { c | onBeforeinput : M3e.Value.Supported } msg
onBeforeinput =
    M3e.Cem.Tabs.onBeforeinput


{-| Listen for `input` events. -}
onInput : msg -> M3e.Cem.Attr.Attr { c | onInput : M3e.Value.Supported } msg
onInput =
    M3e.Cem.Tabs.onInput


{-| Place content in the `(default)` slot. -}
child :
    M3e.Element.Element { tab : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
child el =
    M3e.Content.Internal.slot "" el


{-| Place content in the `panel` slot. -}
panel :
    M3e.Element.Element { tabPanel : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | panel : M3e.Value.Supported } msg
panel el =
    M3e.Content.Internal.slot "panel" el


{-| Place content in the `next-icon` slot. -}
nextIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | nextIcon : M3e.Value.Supported } msg
nextIcon el =
    M3e.Content.Internal.slot "next-icon" el


{-| Place content in the `prev-icon` slot. -}
prevIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | prevIcon : M3e.Value.Supported } msg
prevIcon el =
    M3e.Content.Internal.slot "prev-icon" el


{-| Place many elements in the default slot. -}
children :
    List (M3e.Element.Element { tab : M3e.Value.Supported } msg)
    -> List (M3e.Content.Content { r | default : M3e.Value.Supported } msg)
children els =
    List.map (M3e.Content.Internal.slot "") els