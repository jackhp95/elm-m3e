module M3e.List exposing ( view, variant, child, children )

{-|
A list of items.

**Component Info:**
- **Extends:** `LitElement`

<!-- elm-cem:docmeta category=Layout & style -->

## Examples

### Examples

<!-- elm-cem:example title="Anatomy" -->
```elm
M3e.List.view [] [ M3e.List.child (M3e.ListItem.view [] [ M3e.ListItem.leading (M3e.Icon.view [ M3e.Icon.name "person" ] []), M3e.ListItem.overline (Native.span [] [ Kit.text "Overline" ]), M3e.ListItem.supportingText (Native.span [] [ Kit.text "Supporting text" ]), M3e.ListItem.trailing (Native.span [] [ Kit.text "100+" ]), M3e.ListItem.child (Kit.text "Headline") ]) ]
```

<!-- elm-cem:example title="Variants" -->
```elm
M3e.List.view [] [ M3e.List.child (M3e.ListItem.view [] [ M3e.ListItem.child (Kit.text "Item 1") ]) ]
```

<!-- elm-cem:example title="Variants (2)" -->
```elm
M3e.List.view [ M3e.List.variant M3e.Value.segmented ] [ M3e.List.child (M3e.ListItem.view [] [ M3e.ListItem.child (Kit.text "Item 1") ]) ]
```

<!-- elm-cem:example title="Multiline items" -->
```elm
M3e.List.view [] (M3e.List.children [ M3e.ListItem.view [] [ M3e.ListItem.child (Kit.text "Label text") ], M3e.ListItem.view [] [ M3e.ListItem.supportingText (Native.span [] [ Kit.text "Supporting text" ]), M3e.ListItem.child (Kit.text "Label text") ], M3e.ListItem.view [] [ M3e.ListItem.overline (Native.span [] [ Kit.text "Overline" ]), M3e.ListItem.supportingText (Native.span [] [ Kit.text "Supporting text" ]), M3e.ListItem.child (Kit.text "Label text") ] ])
```

<!-- elm-cem:example title="Media content" -->
```elm
M3e.List.view [] [ M3e.List.child (M3e.ListItem.view [] [ M3e.ListItem.leading (M3e.Icon.view [ M3e.Icon.name "stars" ] []), M3e.ListItem.trailing (M3e.Icon.view [ M3e.Icon.name "arrow_right" ] []), M3e.ListItem.child (Kit.text "Label text") ]) ]
```

<!-- elm-cem:example title="Media content (2)" -->
```elm
M3e.List.view [] [ M3e.List.child (M3e.ListItem.view [] [ M3e.ListItem.leading (M3e.Avatar.view [] [ M3e.Avatar.child (Kit.text "AB") ]), M3e.ListItem.trailing (M3e.Icon.view [ M3e.Icon.name "arrow_right" ] []), M3e.ListItem.child (Kit.text "Label text") ]) ]
```

<!-- elm-cem:example title="Media content (3)" -->
```elm
M3e.List.view [] [ M3e.List.child (M3e.ListItem.view [] [ M3e.ListItem.leading (Native.img []), M3e.ListItem.trailing (M3e.Icon.view [ M3e.Icon.name "arrow_right" ] []), M3e.ListItem.child (Kit.text "Label text") ]) ]
```

<!-- elm-cem:example title="Media content (4)" -->
```elm
M3e.List.view [] [ M3e.List.child (M3e.ListItem.view [] [ M3e.ListItem.leading (Native.node Html.video [] [ Native.node Html.source [] [] ]), M3e.ListItem.trailing (M3e.Icon.view [ M3e.Icon.name "arrow_right" ] []), M3e.ListItem.child (Kit.text "Label text") ]) ]
```

<!-- elm-cem:example title="Dividers" -->
```elm
M3e.List.view [] (M3e.List.children [ M3e.ListItem.view [] [ M3e.ListItem.child (Kit.text "Item 1") ], M3e.Divider.view [] [], M3e.ListItem.view [] [ M3e.ListItem.child (Kit.text "Item 2") ], M3e.Divider.view [] [], M3e.ListItem.view [] [ M3e.ListItem.child (Kit.text "Item 3") ] ])
```

<!-- elm-cem:example title="Dividers (2)" -->
```elm
M3e.List.view [] (M3e.List.children [ M3e.ListItem.view [] [ M3e.ListItem.child (Kit.text "Item 1") ], M3e.Divider.view [ M3e.Divider.inset True ] [] ])
```

<!-- elm-cem:example title="Action lists" -->
```elm
M3e.ActionList.view [] [ M3e.ActionList.child (M3e.ListAction.view [] [ M3e.ListAction.child (Kit.text "Action 1") ]) ]
```

<!-- elm-cem:example title="Action lists (2)" -->
```elm
M3e.ActionList.view [ M3e.ActionList.variant M3e.Value.segmented ] [ M3e.ActionList.child (M3e.ListAction.view [] [ M3e.ListAction.child (Kit.text "Action 1") ]) ]
```

<!-- elm-cem:example title="Disabling" -->
```elm
M3e.ActionList.view [] [ M3e.ActionList.child (M3e.ListAction.view [ M3e.ListAction.disabled True ] [ M3e.ListAction.child (Kit.text "Disabled action 1") ]) ]
```

<!-- elm-cem:example title="Disabling (2)" -->
```elm
M3e.ActionList.view [ M3e.ActionList.variant M3e.Value.segmented ] [ M3e.ActionList.child (M3e.ListAction.view [ M3e.ListAction.disabled True ] [ M3e.ListAction.child (Kit.text "Disabled action 1") ]) ]
```

<!-- elm-cem:example title="Links" -->
```elm
M3e.ActionList.view [] [ M3e.ActionList.child (M3e.ListAction.view [ M3e.ListAction.href "https://www.google.com", M3e.ListAction.target "_blank" ] [ M3e.ListAction.child (Kit.text "Google") ]) ]
```

<!-- elm-cem:example title="Nested lists" -->
```elm
M3e.ActionList.view [] [ M3e.ActionList.child (M3e.ExpandableListItem.view [] [ M3e.ExpandableListItem.leading (M3e.Icon.view [ M3e.Icon.name "stars" ] []), M3e.ExpandableListItem.items (Native.div [] [ M3e.ListAction.view [] [ M3e.ListAction.leading (M3e.Icon.view [ M3e.Icon.name "stars" ] []), M3e.ListAction.child (Kit.text "List item") ] ]), M3e.ExpandableListItem.child (Kit.text "List item") ]) ]
```

<!-- elm-cem:example title="Nested lists (2)" -->
```elm
M3e.ActionList.view [ M3e.ActionList.variant M3e.Value.segmented ] [ M3e.ActionList.child (M3e.ExpandableListItem.view [] [ M3e.ExpandableListItem.leading (M3e.Icon.view [ M3e.Icon.name "stars" ] []), M3e.ExpandableListItem.items (Native.div [] [ M3e.ListAction.view [] [ M3e.ListAction.leading (M3e.Icon.view [ M3e.Icon.name "stars" ] []), M3e.ListAction.child (Kit.text "List item") ] ]), M3e.ExpandableListItem.child (Kit.text "List item") ]) ]
```

<!-- elm-cem:example title="Selection lists" -->
```elm
M3e.SelectionList.view [] [ M3e.SelectionList.child (M3e.ListOption.view [] [ M3e.ListOption.child (Kit.text "Option 1") ]) ]
```

<!-- elm-cem:example title="Selection lists (2)" -->
```elm
M3e.SelectionList.view [ M3e.SelectionList.variant M3e.Value.segmented ] [ M3e.SelectionList.child (M3e.ListOption.view [] [ M3e.ListOption.child (Kit.text "Option 1") ]) ]
```

<!-- elm-cem:example title="Multiple selection" -->
```elm
M3e.SelectionList.view [ M3e.SelectionList.multi True ] [ M3e.SelectionList.child (M3e.ListOption.view [] [ M3e.ListOption.child (Kit.text "Option 1") ]) ]
```

<!-- elm-cem:example title="Multiple selection (2)" -->
```elm
M3e.SelectionList.view [ M3e.SelectionList.variant M3e.Value.segmented, M3e.SelectionList.multi True ] [ M3e.SelectionList.child (M3e.ListOption.view [] [ M3e.ListOption.child (Kit.text "Option 1") ]) ]
```

<!-- elm-cem:example title="Hiding the selection indicator" -->
```elm
M3e.SelectionList.view [ M3e.SelectionList.multi True, M3e.SelectionList.hideSelectionIndicator True ] (M3e.SelectionList.children [ M3e.ListOption.view [ M3e.ListOption.selected True ] [ M3e.ListOption.trailing (M3e.Icon.view [ M3e.Icon.name "bookmark" ] []), M3e.ListOption.child (Kit.text "Option 1") ], M3e.ListOption.view [] [ M3e.ListOption.trailing (M3e.Icon.view [ M3e.Icon.name "bookmark" ] []), M3e.ListOption.child (Kit.text "Option 2") ], M3e.ListOption.view [] [ M3e.ListOption.trailing (M3e.Icon.view [ M3e.Icon.name "bookmark" ] []), M3e.ListOption.child (Kit.text "Option 3") ] ])
```

<!-- elm-cem:example title="Disabling (3)" -->
```elm
M3e.SelectionList.view [ M3e.SelectionList.multi True ] (M3e.SelectionList.children [ M3e.ListOption.view [ M3e.ListOption.disabled True ] [ M3e.ListOption.child (Kit.text "Option 1") ], M3e.ListOption.view [ M3e.ListOption.selected True, M3e.ListOption.disabled True ] [ M3e.ListOption.child (Kit.text "Option 1") ] ])
```

<!-- elm-cem:example title="Disabling (4)" -->
```elm
M3e.SelectionList.view [ M3e.SelectionList.variant M3e.Value.segmented, M3e.SelectionList.multi True ] (M3e.SelectionList.children [ M3e.ListOption.view [ M3e.ListOption.disabled True ] [ M3e.ListOption.child (Kit.text "Option 1") ], M3e.ListOption.view [ M3e.ListOption.selected True, M3e.ListOption.disabled True ] [ M3e.ListOption.child (Kit.text "Option 1") ] ])
```

<!-- elm-cem:example title="Density" -->
```elm
M3e.SelectionList.view [ M3e.SelectionList.variant M3e.Value.segmented, M3e.SelectionList.multi True ] []
```

@docs view, variant, child, children
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.List
import M3e.Content
import M3e.Content.Internal
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-list>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { variant : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | list : M3e.Value.Supported } msg
view attributes content_ =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.List.list
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Content.toNode content_)
        )


{-| The appearance variant of the list. (default: `"standard"`) -}
variant :
    M3e.Value.Value { segmented : M3e.Value.Supported
    , standard : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variant =
    M3e.Cem.List.variant


{-| Place content in the `(default)` slot. -}
child :
    M3e.Element.Element { listItem : M3e.Value.Supported
    , listAction : M3e.Value.Supported
    , expandableListItem : M3e.Value.Supported
    , listOption : M3e.Value.Supported
    , divider : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
child el =
    M3e.Content.Internal.slot "" el


{-| Place many elements in the default slot. -}
children :
    List (M3e.Element.Element { listItem : M3e.Value.Supported
    , listAction : M3e.Value.Supported
    , expandableListItem : M3e.Value.Supported
    , listOption : M3e.Value.Supported
    , divider : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { r | default : M3e.Value.Supported } msg)
children els =
    List.map (M3e.Content.Internal.slot "") els