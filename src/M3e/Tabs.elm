module M3e.Tabs exposing
    ( view, disablePagination, headerPosition, nextPageLabel, previousPageLabel, stretch
    , variant, onChange, onBeforeinput, onInput, panel, nextIcon
    , prevIcon
    )

{-| Organizes content into separate views where only one view can be visible at a time.

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
M3e.Tabs.view [ M3e.Tabs.variant M3e.Token.primary ] [ M3e.Tab.view [ M3e.Tab.selected True, M3e.Tab.for "tab1" ] [ M3e.Tab.icon (M3e.Icon.view [ M3e.Icon.name "videocam" ] []), Kit.text "Video" ], M3e.Tab.view [ M3e.Tab.for "tab2" ] [ M3e.Tab.icon (M3e.Icon.view [ M3e.Icon.name "photo" ] []), Kit.text "Photos" ], M3e.Tab.view [ M3e.Tab.for "tab3" ] [ M3e.Tab.icon (M3e.Icon.view [ M3e.Icon.name "music_note" ] []), Kit.text "Audio" ], M3e.Tabs.panel (M3e.TabPanel.view [ M3e.Attributes.id "tab1" ] [ Kit.text "Videos" ]), M3e.Tabs.panel (M3e.TabPanel.view [ M3e.Attributes.id "tab2" ] [ Kit.text "Photos" ]), M3e.Tabs.panel (M3e.TabPanel.view [ M3e.Attributes.id "tab3" ] [ Kit.text "Audio" ]) ]
```

<!-- elm-cem:example title="Stretching" -->
```elm
M3e.Tabs.view [ M3e.Tabs.stretch True ] [ M3e.Tab.view [ M3e.Tab.selected True, M3e.Tab.for "tab7" ] [ M3e.Tab.icon (M3e.Icon.view [ M3e.Icon.name "videocam" ] []), Kit.text "Video" ], M3e.Tab.view [ M3e.Tab.for "tab8" ] [ M3e.Tab.icon (M3e.Icon.view [ M3e.Icon.name "photo" ] []), Kit.text "Photos" ], M3e.Tab.view [ M3e.Tab.for "tab9" ] [ M3e.Tab.icon (M3e.Icon.view [ M3e.Icon.name "music_note" ] []), Kit.text "Audio" ], M3e.Tabs.panel (M3e.TabPanel.view [ M3e.Attributes.id "tab7" ] [ Kit.text "Videos" ]), M3e.Tabs.panel (M3e.TabPanel.view [ M3e.Attributes.id "tab8" ] [ Kit.text "Photos" ]), M3e.Tabs.panel (M3e.TabPanel.view [ M3e.Attributes.id "tab9" ] [ Kit.text "Audio" ]) ]
```

<!-- elm-cem:example title="Header positions" -->
```elm
M3e.Tabs.view [ M3e.Tabs.headerPosition M3e.Token.after ] [ M3e.Tab.view [ M3e.Tab.selected True, M3e.Tab.for "tab4" ] [ M3e.Tab.icon (M3e.Icon.view [ M3e.Icon.name "videocam" ] []), Kit.text "Video" ], M3e.Tab.view [ M3e.Tab.for "tab5" ] [ M3e.Tab.icon (M3e.Icon.view [ M3e.Icon.name "photo" ] []), Kit.text "Photos" ], M3e.Tab.view [ M3e.Tab.for "tab6" ] [ M3e.Tab.icon (M3e.Icon.view [ M3e.Icon.name "music_note" ] []), Kit.text "Audio" ], M3e.Tabs.panel (M3e.TabPanel.view [ M3e.Attributes.id "tab4" ] [ Kit.text "Videos" ]), M3e.Tabs.panel (M3e.TabPanel.view [ M3e.Attributes.id "tab5" ] [ Kit.text "Photos" ]), M3e.Tabs.panel (M3e.TabPanel.view [ M3e.Attributes.id "tab6" ] [ Kit.text "Audio" ]) ]
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

import M3e.Html.Tabs
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Kind
import Markup.Node


{-| Build the `<m3e-tabs>` element (lazy IR).
-}
view :
    List
        (Markup.Html.Attr.Attr
            { disablePagination : M3e.Token.Supported
            , headerPosition : M3e.Token.Supported
            , nextPageLabel : M3e.Token.Supported
            , previousPageLabel : M3e.Token.Supported
            , stretch : M3e.Token.Supported
            , variant : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , onBeforeinput : M3e.Token.Supported
            , onInput : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element { tab : M3e.Kind.Brand } msg)
    -> Markup.Element.Element { s | tabs : M3e.Kind.Brand } msg
view attributes children =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.Tabs.tabs
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.map Markup.Element.toNode children)
        )


{-| Whether scroll buttons are disabled.
-}
disablePagination :
    M3e.Token.Value
        { true : M3e.Token.Supported
        , false : M3e.Token.Supported
        , auto : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | disablePagination : M3e.Token.Supported } msg
disablePagination =
    M3e.Html.Tabs.disablePagination


{-| The position of the tab headers. (default: `"before"`)
-}
headerPosition :
    M3e.Token.Value
        { after : M3e.Token.Supported
        , before : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | headerPosition : M3e.Token.Supported } msg
headerPosition =
    M3e.Html.Tabs.headerPosition


{-| The accessible label given to the button used to move to the next page. (default: `"Next page"`)
-}
nextPageLabel :
    String
    -> Markup.Html.Attr.Attr { c | nextPageLabel : M3e.Token.Supported } msg
nextPageLabel =
    M3e.Html.Tabs.nextPageLabel


{-| The accessible label given to the button used to move to the previous page. (default: `"Previous page"`)
-}
previousPageLabel :
    String
    -> Markup.Html.Attr.Attr { c | previousPageLabel : M3e.Token.Supported } msg
previousPageLabel =
    M3e.Html.Tabs.previousPageLabel


{-| Whether tabs are stretched to fill the header. (default: `false`)
-}
stretch : Bool -> Markup.Html.Attr.Attr { c | stretch : M3e.Token.Supported } msg
stretch =
    M3e.Html.Tabs.stretch


{-| The appearance variant of the tabs. (default: `"secondary"`)
-}
variant :
    M3e.Token.Value
        { primary : M3e.Token.Supported
        , secondary : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variant =
    M3e.Html.Tabs.variant


{-| Listen for `change` events.
-}
onChange : msg -> Markup.Html.Attr.Attr { c | onChange : M3e.Token.Supported } msg
onChange =
    M3e.Html.Tabs.onChange


{-| Listen for `beforeinput` events.
-}
onBeforeinput : msg -> Markup.Html.Attr.Attr { c | onBeforeinput : M3e.Token.Supported } msg
onBeforeinput =
    M3e.Html.Tabs.onBeforeinput


{-| Listen for `input` events.
-}
onInput : msg -> Markup.Html.Attr.Attr { c | onInput : M3e.Token.Supported } msg
onInput =
    M3e.Html.Tabs.onInput


{-| Place content in the `panel` slot.
-}
panel :
    Markup.Element.Element { tabPanel : M3e.Kind.Brand } msg
    -> Markup.Element.Element k msg
panel el =
    Markup.Element.Internal.placeSlot "panel" el


{-| Place content in the `next-icon` slot.
-}
nextIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
nextIcon el =
    Markup.Element.Internal.placeSlot "next-icon" el


{-| Place content in the `prev-icon` slot.
-}
prevIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
prevIcon el =
    Markup.Element.Internal.placeSlot "prev-icon" el
