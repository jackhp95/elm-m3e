module M3e.Record.SplitButton exposing ( view, variant, size )

{-|
A button used to show an action with a menu of related actions.

**Component Info:**
- **Extends:** `LitElement`

**Slots:**
- `leading-button`: The leading button used to perform the primary action.
- `trailing-button`: The trailing icon button used to open a menu of related actions.

<!-- elm-cem:docmeta category=Actions -->

## Examples

### Examples

<!-- elm-cem:example title="Anatomy" -->
```elm
[ M3e.SplitButton.view [] [ M3e.SplitButton.leadingButton (M3e.Button.view [] [ M3e.Button.icon (M3e.Icon.view [ M3e.Icon.name "edit" ] []), Kit.text "Edit" ]), M3e.SplitButton.trailingButton (M3e.IconButton.view [] [ M3e.Icon.view [ M3e.Icon.name "keyboard_arrow_down" ] [], M3e.MenuTrigger.view [ M3e.MenuTrigger.for "menu" ] [] ]) ]
    , M3e.Menu.view [ M3e.Attributes.id "menu", M3e.Menu.positionX M3e.Value.before ] [ M3e.MenuItem.view [] [ Kit.text "Rename" ], M3e.MenuItem.view [] [ Kit.text "Copy" ], M3e.MenuItem.view [] [ Kit.text "Delete" ] ]
    ]
```

<!-- elm-cem:example title="Variants" -->
```elm
[ M3e.SplitButton.view [ M3e.SplitButton.variant M3e.Value.filled ] [ M3e.SplitButton.leadingButton (M3e.Button.view [] [ M3e.Button.icon (M3e.Icon.view [ M3e.Icon.name "edit" ] []), Kit.text "Edit" ]), M3e.SplitButton.trailingButton (M3e.IconButton.view [] [ M3e.Icon.view [ M3e.Icon.name "keyboard_arrow_down" ] [], M3e.MenuTrigger.view [ M3e.MenuTrigger.for "menu1" ] [] ]) ]
    , M3e.SplitButton.view [ M3e.SplitButton.variant M3e.Value.tonal ] [ M3e.SplitButton.leadingButton (M3e.Button.view [] [ M3e.Button.icon (M3e.Icon.view [ M3e.Icon.name "edit" ] []), Kit.text "Edit" ]), M3e.SplitButton.trailingButton (M3e.IconButton.view [] [ M3e.Icon.view [ M3e.Icon.name "keyboard_arrow_down" ] [], M3e.MenuTrigger.view [ M3e.MenuTrigger.for "menu1" ] [] ]) ]
    , M3e.SplitButton.view [ M3e.SplitButton.variant M3e.Value.outlined ] [ M3e.SplitButton.leadingButton (M3e.Button.view [] [ M3e.Button.icon (M3e.Icon.view [ M3e.Icon.name "edit" ] []), Kit.text "Edit" ]), M3e.SplitButton.trailingButton (M3e.IconButton.view [] [ M3e.Icon.view [ M3e.Icon.name "keyboard_arrow_down" ] [], M3e.MenuTrigger.view [ M3e.MenuTrigger.for "menu1" ] [] ]) ]
    , M3e.SplitButton.view [ M3e.SplitButton.variant M3e.Value.elevated ] [ M3e.SplitButton.leadingButton (M3e.Button.view [] [ M3e.Button.icon (M3e.Icon.view [ M3e.Icon.name "edit" ] []), Kit.text "Edit" ]), M3e.SplitButton.trailingButton (M3e.IconButton.view [] [ M3e.Icon.view [ M3e.Icon.name "keyboard_arrow_down" ] [], M3e.MenuTrigger.view [ M3e.MenuTrigger.for "menu1" ] [] ]) ]
    , M3e.Menu.view [ M3e.Attributes.id "menu1", M3e.Menu.positionX M3e.Value.before ] [ M3e.MenuItem.view [] [ Kit.text "Rename" ], M3e.MenuItem.view [] [ Kit.text "Copy" ], M3e.MenuItem.view [] [ Kit.text "Delete" ] ]
    ]
```

<!-- elm-cem:example title="Sizes" -->
```elm
[ M3e.SplitButton.view [ M3e.SplitButton.size M3e.Value.extraSmall ] [ M3e.SplitButton.leadingButton (M3e.Button.view [] [ M3e.Button.icon (M3e.Icon.view [ M3e.Icon.name "edit" ] []), Kit.text "Edit" ]), M3e.SplitButton.trailingButton (M3e.IconButton.view [] [ M3e.Icon.view [ M3e.Icon.name "keyboard_arrow_down" ] [], M3e.MenuTrigger.view [ M3e.MenuTrigger.for "menu2" ] [] ]) ]
    , M3e.SplitButton.view [ M3e.SplitButton.size M3e.Value.small ] [ M3e.SplitButton.leadingButton (M3e.Button.view [] [ M3e.Button.icon (M3e.Icon.view [ M3e.Icon.name "edit" ] []), Kit.text "Edit" ]), M3e.SplitButton.trailingButton (M3e.IconButton.view [] [ M3e.Icon.view [ M3e.Icon.name "keyboard_arrow_down" ] [], M3e.MenuTrigger.view [ M3e.MenuTrigger.for "menu2" ] [] ]) ]
    , M3e.SplitButton.view [ M3e.SplitButton.size M3e.Value.medium ] [ M3e.SplitButton.leadingButton (M3e.Button.view [] [ M3e.Button.icon (M3e.Icon.view [ M3e.Icon.name "edit" ] []), Kit.text "Edit" ]), M3e.SplitButton.trailingButton (M3e.IconButton.view [] [ M3e.Icon.view [ M3e.Icon.name "keyboard_arrow_down" ] [], M3e.MenuTrigger.view [ M3e.MenuTrigger.for "menu2" ] [] ]) ]
    , M3e.SplitButton.view [ M3e.SplitButton.size M3e.Value.large ] [ M3e.SplitButton.leadingButton (M3e.Button.view [] [ M3e.Button.icon (M3e.Icon.view [ M3e.Icon.name "edit" ] []), Kit.text "Edit" ]), M3e.SplitButton.trailingButton (M3e.IconButton.view [] [ M3e.Icon.view [ M3e.Icon.name "keyboard_arrow_down" ] [], M3e.MenuTrigger.view [ M3e.MenuTrigger.for "menu2" ] [] ]) ]
    , M3e.SplitButton.view [ M3e.SplitButton.size M3e.Value.extraLarge ] [ M3e.SplitButton.leadingButton (M3e.Button.view [] [ M3e.Button.icon (M3e.Icon.view [ M3e.Icon.name "edit" ] []), Kit.text "Edit" ]), M3e.SplitButton.trailingButton (M3e.IconButton.view [] [ M3e.Icon.view [ M3e.Icon.name "keyboard_arrow_down" ] [], M3e.MenuTrigger.view [ M3e.MenuTrigger.for "menu2" ] [] ]) ]
    , M3e.Menu.view [ M3e.Attributes.id "menu2", M3e.Menu.positionX M3e.Value.before ] [ M3e.MenuItem.view [] [ Kit.text "Rename" ], M3e.MenuItem.view [] [ Kit.text "Copy" ], M3e.MenuItem.view [] [ Kit.text "Delete" ] ]
    ]
```

<!-- elm-cem:example title="Density" -->
```elm
[ M3e.SplitButton.view [ M3e.SplitButton.size M3e.Value.extraSmall, M3e.Attributes.class "density-3" ] [ M3e.SplitButton.leadingButton (M3e.Button.view [] [ M3e.Button.icon (M3e.Icon.view [ M3e.Icon.name "edit" ] []), Kit.text "Edit" ]), M3e.SplitButton.trailingButton (M3e.IconButton.view [] [ M3e.Icon.view [ M3e.Icon.name "keyboard_arrow_down" ] [], M3e.MenuTrigger.view [ M3e.MenuTrigger.for "menu3" ] [] ]) ]
    , M3e.Menu.view [ M3e.Attributes.id "menu3", M3e.Menu.positionX M3e.Value.before, M3e.Attributes.class "density-3" ] [ M3e.MenuItem.view [] [ Kit.text "Rename" ], M3e.MenuItem.view [] [ Kit.text "Copy" ], M3e.MenuItem.view [] [ Kit.text "Delete" ] ]
    ]
```

@docs view, variant, size
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.SplitButton
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-split-button>` element (lazy IR). -}
view :
    { leadingButton : M3e.Element.Element { button : M3e.Value.Supported } msg
    , trailingButton :
        M3e.Element.Element { iconButton : M3e.Value.Supported } msg
    }
    -> List (M3e.Cem.Attr.Attr { variant : M3e.Value.Supported
    , size : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | splitButton : M3e.Value.Supported } msg
view req_ attributes content_ =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.SplitButton.splitButton
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.append
                  [ M3e.Element.toNode
                      (M3e.Element.withSlot "leading-button" req_.leadingButton)
                  , M3e.Element.toNode
                      (M3e.Element.withSlot
                         "trailing-button"
                         req_.trailingButton
                      )
                  ]
                  (List.map M3e.Element.toNode content_)
             )
        )


{-| The appearance variant of the button. (default: `"filled"`) -}
variant :
    M3e.Value.Value { elevated : M3e.Value.Supported
    , filled : M3e.Value.Supported
    , outlined : M3e.Value.Supported
    , tonal : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variant =
    M3e.Cem.SplitButton.variant


{-| The size of the button. (default: `"small"`) -}
size :
    M3e.Value.Value { extraLarge : M3e.Value.Supported
    , extraSmall : M3e.Value.Supported
    , large : M3e.Value.Supported
    , medium : M3e.Value.Supported
    , small : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | size : M3e.Value.Supported } msg
size =
    M3e.Cem.SplitButton.size