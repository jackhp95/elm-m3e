module M3e.List exposing ( view, variant )

{-|
A list of items.

**Component Info:**
- **Extends:** `LitElement`

<!-- elm-cem:docmeta category=Layout & style -->

## Examples

### Examples

<!-- elm-cem:example title="Anatomy" -->
```elm
M3e.List.view [] [ M3e.ListItem.view [] [ M3e.ListItem.leading (M3e.Icon.view [ M3e.Icon.name "person" ] []), M3e.ListItem.overline (Native.span [] [ Kit.text "Overline" ]), M3e.ListItem.supportingText (Native.span [] [ Kit.text "Supporting text" ]), M3e.ListItem.trailing (Native.span [] [ Kit.text "100+" ]), Kit.text "Headline" ] ]
```

<!-- elm-cem:example title="Variants (2)" -->
```elm
M3e.List.view [ M3e.List.variant M3e.Value.segmented ] [ M3e.ListItem.view [] [ Kit.text "Item 1" ], M3e.ListItem.view [] [ Kit.text "Item 2" ], M3e.ListItem.view [] [ Kit.text "Item 3" ] ]
```

<!-- elm-cem:example title="Multiline items" -->
```elm
M3e.List.view [] [ M3e.ListItem.view [] [ Kit.text "Label text" ], M3e.ListItem.view [] [ M3e.ListItem.supportingText (Native.span [] [ Kit.text "Supporting text" ]), Kit.text "Label text" ], M3e.ListItem.view [] [ M3e.ListItem.overline (Native.span [] [ Kit.text "Overline" ]), M3e.ListItem.supportingText (Native.span [] [ Kit.text "Supporting text" ]), Kit.text "Label text" ] ]
```

<!-- elm-cem:example title="Media content" -->
```elm
M3e.List.view [] [ M3e.ListItem.view [] [ M3e.ListItem.leading (M3e.Icon.view [ M3e.Icon.name "stars" ] []), M3e.ListItem.trailing (M3e.Icon.view [ M3e.Icon.name "arrow_right" ] []), Kit.text "Label text" ], M3e.ListItem.view [] [ M3e.ListItem.leading (M3e.Icon.view [ M3e.Icon.name "stars" ] []), M3e.ListItem.supportingText (Native.span [] [ Kit.text "Supporting text" ]), M3e.ListItem.trailing (M3e.Icon.view [ M3e.Icon.name "arrow_right" ] []), Kit.text "Label text" ], M3e.ListItem.view [] [ M3e.ListItem.leading (M3e.Icon.view [ M3e.Icon.name "stars" ] []), M3e.ListItem.overline (Native.span [] [ Kit.text "Overline" ]), M3e.ListItem.supportingText (Native.span [] [ Kit.text "Supporting text" ]), M3e.ListItem.trailing (M3e.Icon.view [ M3e.Icon.name "arrow_right" ] []), Kit.text "Label text" ], M3e.ListItem.view [] [ Kit.text "Label text" ] ]
```

<!-- elm-cem:example title="Media content (2)" -->
```elm
M3e.List.view [] [ M3e.ListItem.view [] [ M3e.ListItem.leading (M3e.Avatar.view [] [ Kit.text "AB" ]), M3e.ListItem.trailing (M3e.Icon.view [ M3e.Icon.name "arrow_right" ] []), Kit.text "Label text" ], M3e.ListItem.view [] [ M3e.ListItem.leading (M3e.Avatar.view [] [ Kit.text "AB" ]), M3e.ListItem.supportingText (Native.span [] [ Kit.text "Supporting text" ]), M3e.ListItem.trailing (M3e.Icon.view [ M3e.Icon.name "arrow_right" ] []), Kit.text "Label text" ], M3e.ListItem.view [] [ M3e.ListItem.leading (M3e.Avatar.view [] [ Kit.text "AB" ]), M3e.ListItem.overline (Native.span [] [ Kit.text "Overline" ]), M3e.ListItem.supportingText (Native.span [] [ Kit.text "Supporting text" ]), M3e.ListItem.trailing (M3e.Icon.view [ M3e.Icon.name "arrow_right" ] []), Kit.text "Label text" ], M3e.ListItem.view [] [ Kit.text "Label text" ] ]
```

<!-- elm-cem:example title="Media content (3)" -->
```elm
M3e.List.view [] [ M3e.ListItem.view [] [ M3e.ListItem.leading (Native.img []), M3e.ListItem.trailing (M3e.Icon.view [ M3e.Icon.name "arrow_right" ] []), Kit.text "Label text" ], M3e.ListItem.view [] [ M3e.ListItem.leading (Native.img []), M3e.ListItem.supportingText (Native.span [] [ Kit.text "Supporting text" ]), M3e.ListItem.trailing (M3e.Icon.view [ M3e.Icon.name "arrow_right" ] []), Kit.text "Label text" ], M3e.ListItem.view [] [ M3e.ListItem.leading (Native.img []), M3e.ListItem.overline (Native.span [] [ Kit.text "Overline" ]), M3e.ListItem.supportingText (Native.span [] [ Kit.text "Supporting text" ]), M3e.ListItem.trailing (M3e.Icon.view [ M3e.Icon.name "arrow_right" ] []), Kit.text "Label text" ], M3e.ListItem.view [] [ Kit.text "Label text" ] ]
```

<!-- elm-cem:example title="Media content (4)" -->
```elm
M3e.List.view [] [ M3e.ListItem.view [] [ M3e.ListItem.leading (Native.node Html.video [] [ Native.node Html.source [] [], Native.node Html.source [] [] ]), M3e.ListItem.trailing (M3e.Icon.view [ M3e.Icon.name "arrow_right" ] []), Kit.text "Label text" ], M3e.ListItem.view [] [ M3e.ListItem.leading (Native.node Html.video [] [ Native.node Html.source [] [], Native.node Html.source [] [] ]), M3e.ListItem.supportingText (Native.span [] [ Kit.text "Supporting text" ]), M3e.ListItem.trailing (M3e.Icon.view [ M3e.Icon.name "arrow_right" ] []), Kit.text "Label text" ], M3e.ListItem.view [] [ M3e.ListItem.leading (Native.node Html.video [] [ Native.node Html.source [] [], Native.node Html.source [] [] ]), M3e.ListItem.overline (Native.span [] [ Kit.text "Overline" ]), M3e.ListItem.supportingText (Native.span [] [ Kit.text "Supporting text" ]), M3e.ListItem.trailing (M3e.Icon.view [ M3e.Icon.name "arrow_right" ] []), Kit.text "Label text" ], M3e.ListItem.view [] [ Kit.text "Label text" ] ]
```

<!-- elm-cem:example title="Dividers" -->
```elm
M3e.List.view [] [ M3e.ListItem.view [] [ Kit.text "Item 1" ], M3e.Divider.view [] [], M3e.ListItem.view [] [ Kit.text "Item 2" ], M3e.Divider.view [] [], M3e.ListItem.view [] [ Kit.text "Item 3" ] ]
```

<!-- elm-cem:example title="Dividers (2)" -->
```elm
M3e.List.view [] [ M3e.ListItem.view [] [ Kit.text "Item 1" ], M3e.Divider.view [ M3e.Divider.inset True ] [], M3e.ListItem.view [] [ Kit.text "Item 2" ], M3e.Divider.view [ M3e.Divider.inset True ] [], M3e.ListItem.view [] [ Kit.text "Item 3" ] ]
```

<!-- elm-cem:example title="Action lists" -->
```elm
M3e.ActionList.view [] [ M3e.ListAction.view [] [ Kit.text "Action 1" ], M3e.ListAction.view [] [ Kit.text "Action 2" ], M3e.ListAction.view [] [ Kit.text "Action 3" ] ]
```

<!-- elm-cem:example title="Action lists (2)" -->
```elm
M3e.ActionList.view [ M3e.ActionList.variant M3e.Value.segmented ] [ M3e.ListAction.view [] [ Kit.text "Action 1" ], M3e.ListAction.view [] [ Kit.text "Action 2" ], M3e.ListAction.view [] [ Kit.text "Action 3" ] ]
```

<!-- elm-cem:example title="Disabling" -->
```elm
M3e.ActionList.view [] [ M3e.ListAction.view [ M3e.ListAction.disabled True ] [ Kit.text "Disabled action 1" ], M3e.ListAction.view [] [ Kit.text "Action 2" ], M3e.ListAction.view [] [ Kit.text "Action 3" ] ]
```

<!-- elm-cem:example title="Disabling (2)" -->
```elm
M3e.ActionList.view [ M3e.ActionList.variant M3e.Value.segmented ] [ M3e.ListAction.view [ M3e.ListAction.disabled True ] [ Kit.text "Disabled action 1" ], M3e.ListAction.view [] [ Kit.text "Action 2" ], M3e.ListAction.view [] [ Kit.text "Action 3" ] ]
```

<!-- elm-cem:example title="Links" -->
```elm
M3e.ActionList.view [] [ M3e.ListAction.view [ M3e.ListAction.href "https://www.google.com", M3e.ListAction.target "_blank" ] [ Kit.text "Google" ] ]
```

<!-- elm-cem:example title="Nested lists" -->
```elm
M3e.ActionList.view [] [ M3e.ExpandableListItem.view [] [ M3e.ExpandableListItem.leading (M3e.Icon.view [ M3e.Icon.name "stars" ] []), M3e.ExpandableListItem.items (Native.div [] [ M3e.ListAction.view [] [ M3e.ListAction.leading (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "List item" ], M3e.ListAction.view [] [ M3e.ListAction.leading (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "List item" ], M3e.ListAction.view [] [ M3e.ListAction.leading (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "List item" ] ]), Kit.text "List item" ], M3e.ExpandableListItem.view [] [ M3e.ExpandableListItem.leading (M3e.Icon.view [ M3e.Icon.name "stars" ] []), M3e.ExpandableListItem.items (Native.div [] [ M3e.ListAction.view [] [ M3e.ListAction.leading (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "List item" ], M3e.ListAction.view [] [ M3e.ListAction.leading (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "List item" ], M3e.ListAction.view [] [ M3e.ListAction.leading (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "List item" ] ]), Kit.text "List item" ], M3e.ExpandableListItem.view [] [ M3e.ExpandableListItem.leading (M3e.Icon.view [ M3e.Icon.name "stars" ] []), M3e.ExpandableListItem.items (Native.div [] [ M3e.ListAction.view [] [ M3e.ListAction.leading (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "List item" ], M3e.ListAction.view [] [ M3e.ListAction.leading (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "List item" ], M3e.ListAction.view [] [ M3e.ListAction.leading (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "List item" ] ]), Kit.text "List item" ] ]
```

<!-- elm-cem:example title="Nested lists (2)" -->
```elm
M3e.ActionList.view [ M3e.ActionList.variant M3e.Value.segmented ] [ M3e.ExpandableListItem.view [] [ M3e.ExpandableListItem.leading (M3e.Icon.view [ M3e.Icon.name "stars" ] []), M3e.ExpandableListItem.items (Native.div [] [ M3e.ListAction.view [] [ M3e.ListAction.leading (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "List item" ], M3e.ListAction.view [] [ M3e.ListAction.leading (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "List item" ], M3e.ListAction.view [] [ M3e.ListAction.leading (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "List item" ] ]), Kit.text "List item" ], M3e.ExpandableListItem.view [] [ M3e.ExpandableListItem.leading (M3e.Icon.view [ M3e.Icon.name "stars" ] []), M3e.ExpandableListItem.items (Native.div [] [ M3e.ListAction.view [] [ M3e.ListAction.leading (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "List item" ], M3e.ListAction.view [] [ M3e.ListAction.leading (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "List item" ], M3e.ListAction.view [] [ M3e.ListAction.leading (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "List item" ] ]), Kit.text "List item" ], M3e.ExpandableListItem.view [] [ M3e.ExpandableListItem.leading (M3e.Icon.view [ M3e.Icon.name "stars" ] []), M3e.ExpandableListItem.items (Native.div [] [ M3e.ListAction.view [] [ M3e.ListAction.leading (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "List item" ], M3e.ListAction.view [] [ M3e.ListAction.leading (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "List item" ], M3e.ListAction.view [] [ M3e.ListAction.leading (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "List item" ] ]), Kit.text "List item" ] ]
```

<!-- elm-cem:example title="Selection lists" -->
```elm
M3e.SelectionList.view [] [ M3e.ListOption.view [] [ Kit.text "Option 1" ], M3e.ListOption.view [] [ Kit.text "Option 2" ], M3e.ListOption.view [] [ Kit.text "Option 3" ] ]
```

<!-- elm-cem:example title="Selection lists (2)" -->
```elm
M3e.SelectionList.view [ M3e.SelectionList.variant M3e.Value.segmented ] [ M3e.ListOption.view [] [ Kit.text "Option 1" ], M3e.ListOption.view [] [ Kit.text "Option 2" ], M3e.ListOption.view [] [ Kit.text "Option 3" ] ]
```

<!-- elm-cem:example title="Multiple selection" -->
```elm
M3e.SelectionList.view [ M3e.SelectionList.multi True ] [ M3e.ListOption.view [] [ Kit.text "Option 1" ], M3e.ListOption.view [] [ Kit.text "Option 2" ], M3e.ListOption.view [] [ Kit.text "Option 3" ] ]
```

<!-- elm-cem:example title="Multiple selection (2)" -->
```elm
M3e.SelectionList.view [ M3e.SelectionList.variant M3e.Value.segmented, M3e.SelectionList.multi True ] [ M3e.ListOption.view [] [ Kit.text "Option 1" ], M3e.ListOption.view [] [ Kit.text "Option 2" ], M3e.ListOption.view [] [ Kit.text "Option 3" ] ]
```

<!-- elm-cem:example title="Hiding the selection indicator" -->
```elm
M3e.SelectionList.view [ M3e.SelectionList.multi True, M3e.SelectionList.hideSelectionIndicator True ] [ M3e.ListOption.view [ M3e.ListOption.selected True ] [ M3e.ListOption.trailing (M3e.Icon.view [ M3e.Icon.name "bookmark" ] []), Kit.text "Option 1" ], M3e.ListOption.view [] [ M3e.ListOption.trailing (M3e.Icon.view [ M3e.Icon.name "bookmark" ] []), Kit.text "Option 2" ], M3e.ListOption.view [] [ M3e.ListOption.trailing (M3e.Icon.view [ M3e.Icon.name "bookmark" ] []), Kit.text "Option 3" ] ]
```

<!-- elm-cem:example title="Disabling (3)" -->
```elm
M3e.SelectionList.view [ M3e.SelectionList.multi True ] [ M3e.ListOption.view [ M3e.ListOption.disabled True ] [ Kit.text "Option 1" ], M3e.ListOption.view [ M3e.ListOption.selected True, M3e.ListOption.disabled True ] [ Kit.text "Option 2" ], M3e.ListOption.view [] [ Kit.text "Option 3" ] ]
```

<!-- elm-cem:example title="Disabling (4)" -->
```elm
M3e.SelectionList.view [ M3e.SelectionList.variant M3e.Value.segmented, M3e.SelectionList.multi True ] [ M3e.ListOption.view [ M3e.ListOption.disabled True ] [ Kit.text "Option 1" ], M3e.ListOption.view [ M3e.ListOption.selected True, M3e.ListOption.disabled True ] [ Kit.text "Option 2" ], M3e.ListOption.view [] [ Kit.text "Option 3" ] ]
```

<!-- elm-cem:example title="Density" -->
```elm
M3e.SelectionList.view [ M3e.SelectionList.variant M3e.Value.segmented, M3e.SelectionList.multi True ] [ M3e.ListOption.view [] [ Kit.text "Option 1" ], M3e.ListOption.view [] [ Kit.text "Option 2" ], M3e.ListOption.view [] [ Kit.text "Option 3" ] ]
```

@docs view, variant
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.List
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-list>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { variant : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element { listItem : M3e.Value.Supported
    , listAction : M3e.Value.Supported
    , expandableListItem : M3e.Value.Supported
    , listOption : M3e.Value.Supported
    , divider : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | list : M3e.Value.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.List.list
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Element.toNode children)
        )


{-| The appearance variant of the list. (default: `"standard"`) -}
variant :
    M3e.Value.Value { segmented : M3e.Value.Supported
    , standard : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variant =
    M3e.Cem.List.variant