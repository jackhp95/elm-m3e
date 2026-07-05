module M3e.Tree exposing
    ( view, multi, cascade, onChange, child, children
    )

{-|
Presents hierarchical data in a tree structure.

**Component Info:**
- **Extends:** `LitElement`

**Events:**
- `change`: Dispatched when the selected state changes.

<!-- elm-cem:docmeta category=Layout & style -->

## Examples

### Examples

<!-- elm-cem:example title="Documentation navigation tree" -->
```elm
M3e.Tree.view [] (M3e.Tree.children [ M3e.TreeItem.view { label = Kit.text "Getting Started" } [ M3e.TreeItem.open True ] ([ M3e.TreeItem.icon (M3e.Icon.view [ M3e.Icon.name "folder" ] []) ] ++ M3e.TreeItem.children [ M3e.TreeItem.view [] [ M3e.TreeItem.child (Kit.text "Overview") ], M3e.TreeItem.view [] [ M3e.TreeItem.child (Kit.text "Installation") ] ]), M3e.TreeItem.view { label = Kit.text "Components" } [] ([ M3e.TreeItem.icon (M3e.Icon.view [ M3e.Icon.name "folder" ] []) ] ++ M3e.TreeItem.children [ M3e.TreeItem.view [] [ M3e.TreeItem.child (Kit.text "Button") ], M3e.TreeItem.view [] [ M3e.TreeItem.child (Kit.text "Card") ] ]) ])
```

<!-- elm-cem:example title="Multi-select tree with cascading checkboxes" -->
```elm
M3e.Tree.view [ M3e.Tree.multi True, M3e.Tree.cascade True ] (M3e.Tree.children [ M3e.TreeItem.view { label = Kit.text "Fruits" } [ M3e.TreeItem.open True ] (M3e.TreeItem.children [ M3e.TreeItem.view [ M3e.TreeItem.selected True ] [ M3e.TreeItem.child (Kit.text "Apples") ], M3e.TreeItem.view [] [ M3e.TreeItem.child (Kit.text "Oranges") ], M3e.TreeItem.view [ M3e.TreeItem.disabled True ] [ M3e.TreeItem.child (Kit.text "Bananas") ] ]), M3e.TreeItem.view { label = Kit.text "Vegetables" } [ M3e.TreeItem.indeterminate True ] (M3e.TreeItem.children [ M3e.TreeItem.view [ M3e.TreeItem.selected True ] [ M3e.TreeItem.child (Kit.text "Carrots") ], M3e.TreeItem.view [] [ M3e.TreeItem.child (Kit.text "Broccoli") ] ]) ])
```

@docs view, multi, cascade, onChange, child, children
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.Tree
import M3e.Content
import M3e.Content.Internal
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-tree>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { multi : M3e.Value.Supported
    , cascade : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | tree : M3e.Value.Supported } msg
view attributes content_ =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.Tree.tree
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Content.toNode content_)
        )


{-| Whether multiple items can be selected. (default: `false`) -}
multi : Bool -> M3e.Cem.Attr.Attr { c | multi : M3e.Value.Supported } msg
multi =
    M3e.Cem.Tree.multi


{-| Whether multiple item selection cascades to child items. (default: `false`) -}
cascade : Bool -> M3e.Cem.Attr.Attr { c | cascade : M3e.Value.Supported } msg
cascade =
    M3e.Cem.Tree.cascade


{-| Listen for `change` events. -}
onChange : msg -> M3e.Cem.Attr.Attr { c | onChange : M3e.Value.Supported } msg
onChange =
    M3e.Cem.Tree.onChange


{-| Place content in the `(default)` slot. -}
child :
    M3e.Element.Element { treeItem : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
child el =
    M3e.Content.Internal.slot "" el


{-| Place many elements in the default slot. -}
children :
    List (M3e.Element.Element { treeItem : M3e.Value.Supported } msg)
    -> List (M3e.Content.Content { r | default : M3e.Value.Supported } msg)
children els =
    List.map (M3e.Content.Internal.slot "") els