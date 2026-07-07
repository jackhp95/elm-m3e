module M3e.Tree exposing ( view, multi, cascade, onChange )

{-|
Presents hierarchical data in a tree structure.

**Component Info:**
- **Extends:** `LitElement`

**Events:**
- `change`: Dispatched when the selected state changes.

<!-- elm-cem:docmeta category=Layout & style -->

## Examples

### Examples

<!-- elm-cem:example title="Basic usage" -->
```elm
M3e.Tree.view [] (M3e.Tree.children [ M3e.TreeItem.view [ M3e.TreeItem.open True ] ([ M3e.TreeItem.label (Kit.text "Getting Started") ] ++ M3e.TreeItem.children [ M3e.TreeItem.view [] [ M3e.TreeItem.label (Kit.text "Overview") ], M3e.TreeItem.view [] [ M3e.TreeItem.label (Kit.text "Installation") ] ]), M3e.TreeItem.view [] ([ M3e.TreeItem.label (Kit.text "Components") ] ++ M3e.TreeItem.children [ M3e.TreeItem.view [] [ M3e.TreeItem.label (Kit.text "Button") ], M3e.TreeItem.view [] [ M3e.TreeItem.label (Kit.text "Card") ] ]) ])
```

<!-- elm-cem:example title="Selection" -->
```elm
M3e.Tree.view [] (M3e.Tree.children [ M3e.TreeItem.view [ M3e.TreeItem.open True ] ([ M3e.TreeItem.label (Kit.text "Getting Started") ] ++ M3e.TreeItem.children [ M3e.TreeItem.view [ M3e.TreeItem.selected True ] [ M3e.TreeItem.label (Kit.text "Overview") ], M3e.TreeItem.view [] [ M3e.TreeItem.label (Kit.text "Installation") ] ]), M3e.TreeItem.view [] ([ M3e.TreeItem.label (Kit.text "Components") ] ++ M3e.TreeItem.children [ M3e.TreeItem.view [] [ M3e.TreeItem.label (Kit.text "Button") ], M3e.TreeItem.view [] [ M3e.TreeItem.label (Kit.text "Card") ] ]) ])
```

<!-- elm-cem:example title="Multiple selection" -->
```elm
M3e.Tree.view [ M3e.Tree.multi True ] (M3e.Tree.children [ M3e.TreeItem.view [] ([ M3e.TreeItem.label (Kit.text "Fruits") ] ++ M3e.TreeItem.children [ M3e.TreeItem.view [] [ M3e.TreeItem.label (Kit.text "Apples") ], M3e.TreeItem.view [] [ M3e.TreeItem.label (Kit.text "Oranges") ], M3e.TreeItem.view [] [ M3e.TreeItem.label (Kit.text "Bananas") ] ]), M3e.TreeItem.view [] ([ M3e.TreeItem.label (Kit.text "Vegetables") ] ++ M3e.TreeItem.children [ M3e.TreeItem.view [] [ M3e.TreeItem.label (Kit.text "Carrots") ], M3e.TreeItem.view [] [ M3e.TreeItem.label (Kit.text "Broccoli") ], M3e.TreeItem.view [] [ M3e.TreeItem.label (Kit.text "Spinach") ] ]) ])
```

<!-- elm-cem:example title="Cascade selection" -->
```elm
M3e.Tree.view [ M3e.Tree.multi True, M3e.Tree.cascade True ] (M3e.Tree.children [ M3e.TreeItem.view [] ([ M3e.TreeItem.label (Kit.text "Fruits") ] ++ M3e.TreeItem.children [ M3e.TreeItem.view [] [ M3e.TreeItem.label (Kit.text "Apples") ], M3e.TreeItem.view [] [ M3e.TreeItem.label (Kit.text "Oranges") ], M3e.TreeItem.view [] [ M3e.TreeItem.label (Kit.text "Bananas") ] ]), M3e.TreeItem.view [] ([ M3e.TreeItem.label (Kit.text "Vegetables") ] ++ M3e.TreeItem.children [ M3e.TreeItem.view [] [ M3e.TreeItem.label (Kit.text "Carrots") ], M3e.TreeItem.view [] [ M3e.TreeItem.label (Kit.text "Broccoli") ], M3e.TreeItem.view [] [ M3e.TreeItem.label (Kit.text "Spinach") ] ]) ])
```

<!-- elm-cem:example title="Icons" -->
```elm
M3e.Tree.view [] [ M3e.Tree.child (M3e.TreeItem.view [ M3e.TreeItem.open True ] ([ M3e.TreeItem.label (Kit.text "Getting Started"), M3e.TreeItem.icon (M3e.Icon.view [ M3e.Icon.name "rocket_launch" ] []) ] ++ M3e.TreeItem.children [ M3e.TreeItem.view [] [ M3e.TreeItem.label (Kit.text "Overview"), M3e.TreeItem.icon (M3e.Icon.view [ M3e.Icon.name "near_me" ] []) ], M3e.TreeItem.view [] [ M3e.TreeItem.label (Kit.text "Installation"), M3e.TreeItem.icon (M3e.Icon.view [ M3e.Icon.name "package_2" ] []) ] ])) ]
```

<!-- elm-cem:example title="Toggle icons" -->
```elm
M3e.Tree.view [] [ M3e.Tree.child (M3e.TreeItem.view [ M3e.TreeItem.open True ] ([ M3e.TreeItem.label (Kit.text "Getting Started"), M3e.TreeItem.toggleIcon (M3e.Icon.view [ M3e.Icon.name "add_box" ] []), M3e.TreeItem.openToggleIcon (M3e.Icon.view [ M3e.Icon.name "indeterminate_check_box" ] []) ] ++ M3e.TreeItem.children [ M3e.TreeItem.view [] [ M3e.TreeItem.label (Kit.text "Overview") ], M3e.TreeItem.view [] [ M3e.TreeItem.label (Kit.text "Installation") ] ])) ]
```

<!-- elm-cem:example title="Density" -->
```elm
M3e.Tree.view [] [ M3e.Tree.child (M3e.TreeItem.view [ M3e.TreeItem.open True ] ([ M3e.TreeItem.label (Kit.text "Getting Started"), M3e.TreeItem.icon (M3e.Icon.view [ M3e.Icon.name "rocket_launch" ] []) ] ++ M3e.TreeItem.children [ M3e.TreeItem.view [] [ M3e.TreeItem.label (Kit.text "Overview"), M3e.TreeItem.icon (M3e.Icon.view [ M3e.Icon.name "near_me" ] []) ], M3e.TreeItem.view [] [ M3e.TreeItem.label (Kit.text "Installation"), M3e.TreeItem.icon (M3e.Icon.view [ M3e.Icon.name "package_2" ] []) ] ])) ]
```

@docs view, multi, cascade, onChange
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.Tree
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
    -> List (M3e.Element.Element { treeItem : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | tree : M3e.Value.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.Tree.tree
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Element.toNode children)
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