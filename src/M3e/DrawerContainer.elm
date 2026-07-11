module M3e.DrawerContainer exposing
    ( view, end, endMode, endDivider, start, startMode
    , startDivider, onChange, startSlot, endSlot
    )

{-| A container for one or two sliding drawers.

**Component Info:**

  - **Extends:** `LitElement`

**Events:**

  - `change`: Dispatched when the state of the start or end drawers change.

**Slots:**

  - `start`: Renders the start drawer.
  - `end`: Renders the end drawer.

<!-- elm-cem:docmeta category=Navigation -->


## Examples


### Examples

<!-- elm-cem:example title="Drawers" -->
```elm
M3e.DrawerContainer.view [ M3e.DrawerContainer.start True, M3e.DrawerContainer.end True ] [ M3e.DrawerContainer.startSlot (Native.div [] [ Kit.text "Start drawer" ]), Native.div [] [ Kit.text "Main content" ], M3e.DrawerContainer.endSlot (Native.div [] [ Kit.text "End drawer" ]) ]
```

<!-- elm-cem:example title="Sizes" -->
```elm
M3e.DrawerContainer.view [ M3e.DrawerContainer.start True ] [ M3e.DrawerContainer.startSlot (Native.div [ Native.attribute "style" "width: 200px" ] [ Kit.text "Start drawer" ]), Native.div [] [ Kit.text "Main content" ] ]
```

<!-- elm-cem:example title="Modes" -->
```elm
M3e.DrawerContainer.view [ M3e.DrawerContainer.start True, M3e.DrawerContainer.startMode M3e.Token.push ] [ M3e.DrawerContainer.startSlot (Native.div [] [ Kit.text "Start drawer" ]), Native.div [] [ Kit.text "Main content" ] ]
```

<!-- elm-cem:example title="Modes (2)" -->
```elm
M3e.DrawerContainer.view [ M3e.DrawerContainer.start True, M3e.DrawerContainer.startMode M3e.Token.over ] [ M3e.DrawerContainer.startSlot (Native.div [] [ Kit.text "Start drawer" ]), Native.div [] [ Kit.text "Main content" ] ]
```

<!-- elm-cem:example title="Dividers" -->
```elm
M3e.DrawerContainer.view [ M3e.DrawerContainer.end True, M3e.DrawerContainer.endMode M3e.Token.side, M3e.DrawerContainer.endDivider True ] [ Native.div [] [ Kit.text "Main content" ], M3e.DrawerContainer.endSlot (Native.div [] [ Kit.text "End drawer" ]) ]
```

<!-- elm-cem:example title="Toggle" -->
```elm
[ M3e.IconButton.view [ M3e.Aria.label "Menu", M3e.IconButton.toggle True ] [ M3e.Icon.view [ M3e.Icon.name "menu" ] [], M3e.IconButton.selectedSlot (M3e.Icon.view [ M3e.Icon.name "menu_open" ] []), M3e.DrawerToggle.view [ M3e.DrawerToggle.for "nav-drawer" ] [] ]
    , M3e.DrawerContainer.view [ M3e.DrawerContainer.startMode M3e.Token.over ] [ M3e.DrawerContainer.startSlot (Native.div [ Native.attribute "id" "nav-drawer" ] [ Kit.text "Start drawer" ]), Native.div [] [ Kit.text "Main content" ] ]
    ]
```

<!-- elm-cem:example title="Accessibility" -->
```elm
M3e.DrawerContainer.view [] [ M3e.DrawerContainer.startSlot (Native.nav [] []), Native.node Html.main_ [] [], M3e.DrawerContainer.endSlot (Native.node Html.aside [] []) ]
```

@docs view, end, endMode, endDivider, start, startMode
@docs startDivider, onChange, startSlot, endSlot

-}

import M3e.Element
import M3e.Element.Internal
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Html.DrawerContainer
import M3e.Node
import M3e.Token


{-| Build the `<m3e-drawer-container>` element (lazy IR).
-}
view :
    List
        (M3e.Html.Attr.Attr
            { end : M3e.Token.Supported
            , endMode : M3e.Token.Supported
            , endDivider : M3e.Token.Supported
            , start : M3e.Token.Supported
            , startMode : M3e.Token.Supported
            , startDivider : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | drawerContainer : M3e.Token.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Html.DrawerContainer.drawerContainer
                    (List.map M3e.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map M3e.Html.Attr.Internal.forget attributes)
            (List.map M3e.Element.toNode children)
        )


{-| Whether the end drawer is open. (default: `false`)
-}
end : Bool -> M3e.Html.Attr.Attr { c | end : M3e.Token.Supported } msg
end =
    M3e.Html.DrawerContainer.end


{-| The behavior mode of the end drawer. (default: `"side"`)
-}
endMode :
    M3e.Token.Value
        { auto : M3e.Token.Supported
        , over : M3e.Token.Supported
        , push : M3e.Token.Supported
        , side : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | endMode : M3e.Token.Supported } msg
endMode =
    M3e.Html.DrawerContainer.endMode


{-| Whether to show a divider between the end drawer and content for `side` mode. (default: `false`)
-}
endDivider : Bool -> M3e.Html.Attr.Attr { c | endDivider : M3e.Token.Supported } msg
endDivider =
    M3e.Html.DrawerContainer.endDivider


{-| Whether the start drawer is open. (default: `false`)
-}
start : Bool -> M3e.Html.Attr.Attr { c | start : M3e.Token.Supported } msg
start =
    M3e.Html.DrawerContainer.start


{-| The behavior mode of the start drawer. (default: `"side"`)
-}
startMode :
    M3e.Token.Value
        { auto : M3e.Token.Supported
        , over : M3e.Token.Supported
        , push : M3e.Token.Supported
        , side : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | startMode : M3e.Token.Supported } msg
startMode =
    M3e.Html.DrawerContainer.startMode


{-| Whether to show a divider between the start drawer and content for `side` mode. (default: `false`)
-}
startDivider : Bool -> M3e.Html.Attr.Attr { c | startDivider : M3e.Token.Supported } msg
startDivider =
    M3e.Html.DrawerContainer.startDivider


{-| Listen for `change` events.
-}
onChange : msg -> M3e.Html.Attr.Attr { c | onChange : M3e.Token.Supported } msg
onChange =
    M3e.Html.DrawerContainer.onChange


{-| Place content in the `start` slot.
-}
startSlot : M3e.Element.Element any msg -> M3e.Element.Element k msg
startSlot el =
    M3e.Element.Internal.placeSlot "start" el


{-| Place content in the `end` slot.
-}
endSlot : M3e.Element.Element any msg -> M3e.Element.Element k msg
endSlot el =
    M3e.Element.Internal.placeSlot "end" el
