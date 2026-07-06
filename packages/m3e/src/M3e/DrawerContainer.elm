module M3e.DrawerContainer exposing
    ( view, end, endMode, endDivider, start, startMode
    , startDivider, onChange, child, startSlot, endSlot, children
    )

{-|
A container for one or two sliding drawers.

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
M3e.DrawerContainer.view [ M3e.DrawerContainer.start True, M3e.DrawerContainer.end True ] [ M3e.DrawerContainer.startSlot (Native.div [] [ Kit.text "Start drawer" ]), M3e.DrawerContainer.endSlot (Native.div [] [ Kit.text "End drawer" ]), M3e.DrawerContainer.child (Native.div [] [ Kit.text "Main content" ]) ]
```

<!-- elm-cem:example title="Sizes" -->
```elm
M3e.DrawerContainer.view [ M3e.DrawerContainer.start True ] [ M3e.DrawerContainer.startSlot (Native.div [] [ Kit.text "Start drawer" ]), M3e.DrawerContainer.child (Native.div [] [ Kit.text "Main content" ]) ]
```

<!-- elm-cem:example title="Modes" -->
```elm
M3e.DrawerContainer.view [ M3e.DrawerContainer.start True, M3e.DrawerContainer.startMode M3e.Value.push ] [ M3e.DrawerContainer.startSlot (Native.div [] [ Kit.text "Start drawer" ]), M3e.DrawerContainer.child (Native.div [] [ Kit.text "Main content" ]) ]
```

<!-- elm-cem:example title="Modes (2)" -->
```elm
M3e.DrawerContainer.view [ M3e.DrawerContainer.start True, M3e.DrawerContainer.startMode M3e.Value.over ] [ M3e.DrawerContainer.startSlot (Native.div [] [ Kit.text "Start drawer" ]), M3e.DrawerContainer.child (Native.div [] [ Kit.text "Main content" ]) ]
```

<!-- elm-cem:example title="Dividers" -->
```elm
M3e.DrawerContainer.view [ M3e.DrawerContainer.end True, M3e.DrawerContainer.endMode M3e.Value.side, M3e.DrawerContainer.endDivider True ] [ M3e.DrawerContainer.endSlot (Native.div [] [ Kit.text "End drawer" ]), M3e.DrawerContainer.child (Native.div [] [ Kit.text "Main content" ]) ]
```

<!-- elm-cem:example title="Accessibility" -->
```elm
M3e.DrawerContainer.view [] [ M3e.DrawerContainer.startSlot (Native.nav [] []), M3e.DrawerContainer.endSlot (Native.node Html.aside [] []), M3e.DrawerContainer.child (Native.node Html.main_ [] []) ]
```

@docs view, end, endMode, endDivider, start, startMode
@docs startDivider, onChange, child, startSlot, endSlot, children
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.DrawerContainer
import M3e.Content
import M3e.Content.Internal
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-drawer-container>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { end : M3e.Value.Supported
    , endMode : M3e.Value.Supported
    , endDivider : M3e.Value.Supported
    , start : M3e.Value.Supported
    , startMode : M3e.Value.Supported
    , startDivider : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , start : M3e.Value.Supported
    , end : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | drawerContainer : M3e.Value.Supported } msg
view attributes content_ =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.DrawerContainer.drawerContainer
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Content.toNode content_)
        )


{-| Whether the end drawer is open. (default: `false`) -}
end : Bool -> M3e.Cem.Attr.Attr { c | end : M3e.Value.Supported } msg
end =
    M3e.Cem.DrawerContainer.end


{-| The behavior mode of the end drawer. (default: `"side"`) -}
endMode :
    M3e.Value.Value { auto : M3e.Value.Supported
    , over : M3e.Value.Supported
    , push : M3e.Value.Supported
    , side : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | endMode : M3e.Value.Supported } msg
endMode =
    M3e.Cem.DrawerContainer.endMode


{-| Whether to show a divider between the end drawer and content for `side` mode. (default: `false`) -}
endDivider :
    Bool -> M3e.Cem.Attr.Attr { c | endDivider : M3e.Value.Supported } msg
endDivider =
    M3e.Cem.DrawerContainer.endDivider


{-| Whether the start drawer is open. (default: `false`) -}
start : Bool -> M3e.Cem.Attr.Attr { c | start : M3e.Value.Supported } msg
start =
    M3e.Cem.DrawerContainer.start


{-| The behavior mode of the start drawer. (default: `"side"`) -}
startMode :
    M3e.Value.Value { auto : M3e.Value.Supported
    , over : M3e.Value.Supported
    , push : M3e.Value.Supported
    , side : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | startMode : M3e.Value.Supported } msg
startMode =
    M3e.Cem.DrawerContainer.startMode


{-| Whether to show a divider between the start drawer and content for `side` mode. (default: `false`) -}
startDivider :
    Bool -> M3e.Cem.Attr.Attr { c | startDivider : M3e.Value.Supported } msg
startDivider =
    M3e.Cem.DrawerContainer.startDivider


{-| Listen for `change` events. -}
onChange : msg -> M3e.Cem.Attr.Attr { c | onChange : M3e.Value.Supported } msg
onChange =
    M3e.Cem.DrawerContainer.onChange


{-| Place content in the `(default)` slot. -}
child :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
child el =
    M3e.Content.Internal.slot "" el


{-| Place content in the `start` slot. -}
startSlot :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | start : M3e.Value.Supported } msg
startSlot el =
    M3e.Content.Internal.slot "start" el


{-| Place content in the `end` slot. -}
endSlot :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | end : M3e.Value.Supported } msg
endSlot el =
    M3e.Content.Internal.slot "end" el


{-| Place many elements in the default slot. -}
children :
    List (M3e.Element.Element any msg)
    -> List (M3e.Content.Content { r | default : M3e.Value.Supported } msg)
children els =
    List.map (M3e.Content.Internal.slot "") els