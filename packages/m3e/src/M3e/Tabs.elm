module M3e.Tabs exposing
    ( view, disablePagination, headerPosition, nextPageLabel, previousPageLabel, stretch
    , variant, onChange, onBeforeinput, onInput, panel, nextIcon, prevIcon
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

<!-- elm-cem:example title="Basic usage" -->
```elm
M3e.Tabs.view [] [ M3e.Tab.view [ M3e.Tab.selected True, M3e.Tab.for "videos" ] [ M3e.Tab.icon (M3e.Icon.view [ M3e.Icon.name "videocam" ] []), Kit.text "Video" ], M3e.Tab.view [ M3e.Tab.for "photos" ] [ M3e.Tab.icon (M3e.Icon.view [ M3e.Icon.name "photo" ] []), Kit.text "Photos" ], M3e.Tab.view [ M3e.Tab.for "audio" ] [ M3e.Tab.icon (M3e.Icon.view [ M3e.Icon.name "music_note" ] []), Kit.text "Audio" ], M3e.Tabs.panel (M3e.TabPanel.view [ M3e.Attributes.id "videos" ] [ Kit.text "Videos" ]), M3e.Tabs.panel (M3e.TabPanel.view [ M3e.Attributes.id "photos" ] [ Kit.text "Photos" ]), M3e.Tabs.panel (M3e.TabPanel.view [ M3e.Attributes.id "audio" ] [ Kit.text "Audio" ]) ]
```

<!-- elm-cem:example title="Variants" -->
```elm
M3e.Tabs.view [ M3e.Tabs.variant M3e.Value.primary ] [ M3e.Tab.view [ M3e.Tab.selected True, M3e.Tab.for "tab1" ] [ M3e.Tab.icon (M3e.Icon.view [ M3e.Icon.name "videocam" ] []), Kit.text "Video" ], M3e.Tab.view [ M3e.Tab.for "tab2" ] [ M3e.Tab.icon (M3e.Icon.view [ M3e.Icon.name "photo" ] []), Kit.text "Photos" ], M3e.Tab.view [ M3e.Tab.for "tab3" ] [ M3e.Tab.icon (M3e.Icon.view [ M3e.Icon.name "music_note" ] []), Kit.text "Audio" ], M3e.Tabs.panel (M3e.TabPanel.view [ M3e.Attributes.id "tab1" ] [ Kit.text "Videos" ]), M3e.Tabs.panel (M3e.TabPanel.view [ M3e.Attributes.id "tab2" ] [ Kit.text "Photos" ]), M3e.Tabs.panel (M3e.TabPanel.view [ M3e.Attributes.id "tab3" ] [ Kit.text "Audio" ]) ]
```

<!-- elm-cem:example title="Stretching" -->
```elm
M3e.Tabs.view [ M3e.Tabs.stretch True ] [ M3e.Tab.view [ M3e.Tab.selected True, M3e.Tab.for "tab7" ] [ M3e.Tab.icon (M3e.Icon.view [ M3e.Icon.name "videocam" ] []), Kit.text "Video" ], M3e.Tab.view [ M3e.Tab.for "tab8" ] [ M3e.Tab.icon (M3e.Icon.view [ M3e.Icon.name "photo" ] []), Kit.text "Photos" ], M3e.Tab.view [ M3e.Tab.for "tab9" ] [ M3e.Tab.icon (M3e.Icon.view [ M3e.Icon.name "music_note" ] []), Kit.text "Audio" ], M3e.Tabs.panel (M3e.TabPanel.view [ M3e.Attributes.id "tab7" ] [ Kit.text "Videos" ]), M3e.Tabs.panel (M3e.TabPanel.view [ M3e.Attributes.id "tab8" ] [ Kit.text "Photos" ]), M3e.Tabs.panel (M3e.TabPanel.view [ M3e.Attributes.id "tab9" ] [ Kit.text "Audio" ]) ]
```

<!-- elm-cem:example title="Header positions" -->
```elm
M3e.Tabs.view [ M3e.Tabs.headerPosition M3e.Value.after ] [ M3e.Tab.view [ M3e.Tab.selected True, M3e.Tab.for "tab4" ] [ M3e.Tab.icon (M3e.Icon.view [ M3e.Icon.name "videocam" ] []), Kit.text "Video" ], M3e.Tab.view [ M3e.Tab.for "tab5" ] [ M3e.Tab.icon (M3e.Icon.view [ M3e.Icon.name "photo" ] []), Kit.text "Photos" ], M3e.Tab.view [ M3e.Tab.for "tab6" ] [ M3e.Tab.icon (M3e.Icon.view [ M3e.Icon.name "music_note" ] []), Kit.text "Audio" ], M3e.Tabs.panel (M3e.TabPanel.view [ M3e.Attributes.id "tab4" ] [ Kit.text "Videos" ]), M3e.Tabs.panel (M3e.TabPanel.view [ M3e.Attributes.id "tab5" ] [ Kit.text "Photos" ]), M3e.Tabs.panel (M3e.TabPanel.view [ M3e.Attributes.id "tab6" ] [ Kit.text "Audio" ]) ]
```

<!-- elm-cem:example title="Disabling" -->
```elm
M3e.Tabs.view [] [ M3e.Tab.view [ M3e.Tab.selected True, M3e.Tab.for "tab10" ] [ M3e.Tab.icon (M3e.Icon.view [ M3e.Icon.name "videocam" ] []), Kit.text "Video" ], M3e.Tab.view [ M3e.Tab.disabled True, M3e.Tab.for "tab11" ] [ M3e.Tab.icon (M3e.Icon.view [ M3e.Icon.name "photo" ] []), Kit.text "Photos" ], M3e.Tab.view [ M3e.Tab.for "tab12" ] [ M3e.Tab.icon (M3e.Icon.view [ M3e.Icon.name "music_note" ] []), Kit.text "Audio" ], M3e.Tabs.panel (M3e.TabPanel.view [ M3e.Attributes.id "tab10" ] [ Kit.text "Videos" ]), M3e.Tabs.panel (M3e.TabPanel.view [ M3e.Attributes.id "tab11" ] [ Kit.text "Photos" ]), M3e.Tabs.panel (M3e.TabPanel.view [ M3e.Attributes.id "tab12" ] [ Kit.text "Audio" ]) ]
```

<!-- elm-cem:example title="Pagination" -->
```elm
M3e.Tabs.view [] [ M3e.Tab.view [ M3e.Tab.selected True ] [ Kit.text "Tab 1" ], M3e.Tab.view [] [ Kit.text "Tab 2" ], M3e.Tab.view [] [ Kit.text "Tab 3" ], M3e.Tab.view [] [ Kit.text "Tab 4" ], M3e.Tab.view [] [ Kit.text "Tab 5" ], M3e.Tab.view [] [ Kit.text "Tab 6" ], M3e.Tab.view [] [ Kit.text "Tab 7" ], M3e.Tab.view [] [ Kit.text "Tab 8" ], M3e.Tab.view [] [ Kit.text "Tab 9" ], M3e.Tab.view [] [ Kit.text "Tab 10" ], M3e.Tab.view [] [ Kit.text "Tab 11" ], M3e.Tab.view [] [ Kit.text "Tab 12" ], M3e.Tab.view [] [ Kit.text "Tab 13" ], M3e.Tab.view [] [ Kit.text "Tab 14" ], M3e.Tab.view [] [ Kit.text "Tab 15" ], M3e.Tab.view [] [ Kit.text "Tab 16" ], M3e.Tab.view [] [ Kit.text "Tab 17" ], M3e.Tab.view [] [ Kit.text "Tab 18" ], M3e.Tab.view [] [ Kit.text "Tab 19" ], M3e.Tab.view [] [ Kit.text "Tab 20" ] ]
```

<!-- elm-cem:example title="Density" -->
```elm
M3e.Tabs.view [ M3e.Attributes.class "density-3" ] [ M3e.Tab.view [ M3e.Tab.selected True ] [ M3e.Tab.icon (M3e.Icon.view [ M3e.Icon.name "videocam" ] []), Kit.text "Video" ], M3e.Tab.view [] [ M3e.Tab.icon (M3e.Icon.view [ M3e.Icon.name "photo" ] []), Kit.text "Photos" ], M3e.Tab.view [] [ M3e.Tab.icon (M3e.Icon.view [ M3e.Icon.name "music_note" ] []), Kit.text "Audio" ] ]
```

@docs view, disablePagination, headerPosition, nextPageLabel, previousPageLabel, stretch
@docs variant, onChange, onBeforeinput, onInput, panel, nextIcon
@docs prevIcon
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.Tabs
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
    -> List (M3e.Element.Element { tab : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | tabs : M3e.Value.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.Tabs.tabs
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Element.toNode children)
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


{-| Place content in the `panel` slot. -}
panel :
    M3e.Element.Element { tabPanel : M3e.Value.Supported } msg
    -> M3e.Element.Element k msg
panel el =
    M3e.Element.Internal.placeSlot "panel" el


{-| Place content in the `next-icon` slot. -}
nextIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Element.Element k msg
nextIcon el =
    M3e.Element.Internal.placeSlot "next-icon" el


{-| Place content in the `prev-icon` slot. -}
prevIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Element.Element k msg
prevIcon el =
    M3e.Element.Internal.placeSlot "prev-icon" el