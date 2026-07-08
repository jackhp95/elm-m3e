module M3e.Menu exposing
    ( view, positionX, positionY, variant, submenu, onBeforetoggle
    , onToggle
    )

{-|
Presents a list of choices on a temporary surface.

**Component Info:**
- **Extends:** `LitElement`

**Events:**
- `beforetoggle`: Dispatched before the toggle state changes.
- `toggle`: Dispatched after the toggle state has changed.

<!-- elm-cem:docmeta category=Navigation -->

## Examples

### Examples

<!-- elm-cem:example title="Basic usage" -->
```elm
[ M3e.Button.view [] [ M3e.MenuTrigger.view [ M3e.MenuTrigger.for "menu1" ] [ Kit.text "Menu" ] ]
    , M3e.Menu.view [ M3e.Attributes.id "menu1" ] [ M3e.MenuItem.view [] [ Kit.text "Item 1" ], M3e.MenuItem.view [] [ Kit.text "Item 2" ] ]
    ]
```

<!-- elm-cem:example title="Variants" -->
```elm
[ M3e.Button.view [] [ M3e.MenuTrigger.view [ M3e.MenuTrigger.for "vmenu1" ] [ Kit.text "Vibrant menu" ] ]
    , M3e.Menu.view [ M3e.Attributes.id "vmenu1", M3e.Menu.variant M3e.Value.vibrant ] [ M3e.MenuItem.view [] [ Kit.text "Item 1" ], M3e.MenuItem.view [] [ Kit.text "Item 2" ] ]
    ]
```

<!-- elm-cem:example title="Icons" -->
```elm
[ M3e.Button.view [] [ M3e.MenuTrigger.view [ M3e.MenuTrigger.for "menu8" ] [ Kit.text "Menu items with icons" ] ]
    , M3e.Menu.view [ M3e.Attributes.id "menu8" ] [ M3e.MenuItem.view [] [ M3e.MenuItem.icon (M3e.Icon.view [ M3e.Icon.name "dialpad" ] []), Kit.text "Redial" ], M3e.MenuItem.view [] [ M3e.MenuItem.icon (M3e.Icon.view [ M3e.Icon.name "voicemail" ] []), Kit.text "Check voice mail" ], M3e.MenuItem.view [] [ M3e.MenuItem.icon (M3e.Icon.view [ M3e.Icon.name "notifications_off" ] []), Kit.text "Disable alerts" ] ]
    ]
```

<!-- elm-cem:example title="Disabling" -->
```elm
[ M3e.Button.view [] [ M3e.MenuTrigger.view [ M3e.MenuTrigger.for "menu9" ] [ Kit.text "Menu with disabled items" ] ]
    , M3e.Menu.view [ M3e.Attributes.id "menu9" ] [ M3e.MenuItem.view [ M3e.MenuItem.disabled True ] [ M3e.MenuItem.icon (M3e.Icon.view [ M3e.Icon.name "dialpad" ] []), Kit.text "Redial" ], M3e.MenuItem.view [] [ M3e.MenuItem.icon (M3e.Icon.view [ M3e.Icon.name "voicemail" ] []), Kit.text "Check voice mail" ], M3e.MenuItem.view [] [ M3e.MenuItem.icon (M3e.Icon.view [ M3e.Icon.name "notifications_off" ] []), Kit.text "Disable alerts" ] ]
    ]
```

<!-- elm-cem:example title="Checkboxes" -->
```elm
[ M3e.Button.view [] [ M3e.MenuTrigger.view [ M3e.MenuTrigger.for "menu2" ] [ Kit.text "Menu with checkboxes" ] ]
    , M3e.Menu.view [ M3e.Attributes.id "menu2" ] [ M3e.MenuItemCheckbox.view [ M3e.MenuItemCheckbox.checked True ] [ M3e.MenuItemCheckbox.icon (M3e.Icon.view [ M3e.Icon.name "format_bold" ] []), Kit.text "Bold" ], M3e.MenuItemCheckbox.view [] [ M3e.MenuItemCheckbox.icon (M3e.Icon.view [ M3e.Icon.name "format_italic" ] []), Kit.text "Italic" ], M3e.MenuItemCheckbox.view [] [ M3e.MenuItemCheckbox.icon (M3e.Icon.view [ M3e.Icon.name "format_underlined" ] []), Kit.text "Underline" ] ]
    ]
```

<!-- elm-cem:example title="Radios" -->
```elm
[ M3e.Button.view [] [ M3e.MenuTrigger.view [ M3e.MenuTrigger.for "menu3" ] [ Kit.text "Menu with radios" ] ]
    , M3e.Menu.view [ M3e.Attributes.id "menu3" ] [ M3e.MenuItemRadio.view [ M3e.MenuItemRadio.checked True ] [ Kit.text "Ascending" ], M3e.MenuItemRadio.view [] [ Kit.text "Descending" ] ]
    ]
```

<!-- elm-cem:example title="Radios (2)" -->
```elm
[ M3e.Button.view [] [ M3e.MenuTrigger.view [ M3e.MenuTrigger.for "menu4" ] [ Kit.text "Menu with radio groups" ] ]
    , M3e.Menu.view [ M3e.Attributes.id "menu4" ] [ M3e.MenuItemGroup.view [] [ M3e.MenuItemRadio.view [ M3e.MenuItemRadio.checked True ] [ Kit.text "Ascending" ], M3e.MenuItemRadio.view [] [ Kit.text "Descending" ] ], M3e.Divider.view [] [], M3e.MenuItemGroup.view [] [ M3e.MenuItemRadio.view [ M3e.MenuItemRadio.checked True ] [ Kit.text "Alphabetical" ], M3e.MenuItemRadio.view [] [ Kit.text "By Date" ] ] ]
    ]
```

<!-- elm-cem:example title="Submenus" -->
```elm
[ M3e.Button.view [] [ M3e.MenuTrigger.view [ M3e.MenuTrigger.for "menu5" ] [ Kit.text "Menu with submenus" ] ]
    , M3e.Menu.view [ M3e.Attributes.id "menu5" ] [ M3e.MenuItem.view [] [ M3e.MenuTrigger.view [ M3e.MenuTrigger.for "menu6" ] [ Kit.text "Fruits with A" ] ], M3e.MenuItem.view [] [ Kit.text "Grapes" ], M3e.MenuItem.view [] [ Kit.text "Olive" ], M3e.MenuItem.view [] [ Kit.text "Orange" ] ]
    , M3e.Menu.view [ M3e.Attributes.id "menu6" ] [ M3e.MenuItem.view [] [ Kit.text "Apricot" ], M3e.MenuItem.view [] [ Kit.text "Avocado" ], M3e.MenuItem.view [] [ M3e.MenuTrigger.view [ M3e.MenuTrigger.for "menu7" ] [ Kit.text "Apples" ] ] ]
    , M3e.Menu.view [ M3e.Attributes.id "menu7" ] [ M3e.MenuItem.view [] [ Kit.text "Fuji" ], M3e.MenuItem.view [] [ Kit.text "Granny Smith" ], M3e.MenuItem.view [] [ Kit.text "Red Delicious" ] ]
    ]
```

<!-- elm-cem:example title="Density" -->
```elm
[ M3e.Button.view [] [ M3e.MenuTrigger.view [ M3e.MenuTrigger.for "menu-density-3" ] [ Kit.text "Density -3" ] ]
    , M3e.Menu.view [ M3e.Attributes.id "menu-density-3", M3e.Attributes.class "density-3" ] [ M3e.MenuItem.view [] [ M3e.MenuItem.icon (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "Item 1" ], M3e.MenuItem.view [] [ M3e.MenuItem.icon (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "Item 2" ], M3e.MenuItem.view [] [ M3e.MenuItem.icon (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "Item 3" ] ]
    , M3e.Button.view [] [ M3e.MenuTrigger.view [ M3e.MenuTrigger.for "menu-density-2" ] [ Kit.text "Density -2" ] ]
    , M3e.Menu.view [ M3e.Attributes.id "menu-density-2", M3e.Attributes.class "density-2" ] [ M3e.MenuItem.view [] [ M3e.MenuItem.icon (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "Item 1" ], M3e.MenuItem.view [] [ M3e.MenuItem.icon (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "Item 2" ], M3e.MenuItem.view [] [ M3e.MenuItem.icon (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "Item 3" ] ]
    , M3e.Button.view [] [ M3e.MenuTrigger.view [ M3e.MenuTrigger.for "menu-density-1" ] [ Kit.text "Density -1" ] ]
    , M3e.Menu.view [ M3e.Attributes.id "menu-density-1", M3e.Attributes.class "density-1" ] [ M3e.MenuItem.view [] [ M3e.MenuItem.icon (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "Item 1" ], M3e.MenuItem.view [] [ M3e.MenuItem.icon (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "Item 2" ], M3e.MenuItem.view [] [ M3e.MenuItem.icon (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "Item 3" ] ]
    , M3e.Button.view [] [ M3e.MenuTrigger.view [ M3e.MenuTrigger.for "menu-density-0" ] [ Kit.text "Density 0" ] ]
    , M3e.Menu.view [ M3e.Attributes.id "menu-density-0", M3e.Attributes.class "density-0" ] [ M3e.MenuItem.view [] [ M3e.MenuItem.icon (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "Item 1" ], M3e.MenuItem.view [] [ M3e.MenuItem.icon (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "Item 2" ], M3e.MenuItem.view [] [ M3e.MenuItem.icon (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "Item 3" ] ]
    ]
```

@docs view, positionX, positionY, variant, submenu, onBeforetoggle
@docs onToggle
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.Menu
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-menu>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { positionX : M3e.Value.Supported
    , positionY : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , submenu : M3e.Value.Supported
    , onBeforetoggle : M3e.Value.Supported
    , onToggle : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element { menuItem : M3e.Value.Supported
    , menuItemCheckbox : M3e.Value.Supported
    , menuItemRadio : M3e.Value.Supported
    , menuItemGroup : M3e.Value.Supported
    , divider : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | menu : M3e.Value.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.Menu.menu
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Element.toNode children)
        )


{-| The position of the menu, on the x-axis. (default: `"after"`) -}
positionX :
    M3e.Value.Value { after : M3e.Value.Supported
    , before : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | positionX : M3e.Value.Supported } msg
positionX =
    M3e.Cem.Menu.positionX


{-| The position of the menu, on the y-axis. (default: `"below"`) -}
positionY :
    M3e.Value.Value { above : M3e.Value.Supported, below : M3e.Value.Supported }
    -> M3e.Cem.Attr.Attr { c | positionY : M3e.Value.Supported } msg
positionY =
    M3e.Cem.Menu.positionY


{-| The appearance variant of the menu. (default: `"standard"`) -}
variant :
    M3e.Value.Value { standard : M3e.Value.Supported
    , vibrant : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variant =
    M3e.Cem.Menu.variant


{-| A value indicating whether the menu is a submenu. (default: `false`) -}
submenu : Bool -> M3e.Cem.Attr.Attr { c | submenu : M3e.Value.Supported } msg
submenu =
    M3e.Cem.Menu.submenu


{-| Listen for `beforetoggle` events. -}
onBeforetoggle :
    msg -> M3e.Cem.Attr.Attr { c | onBeforetoggle : M3e.Value.Supported } msg
onBeforetoggle =
    M3e.Cem.Menu.onBeforetoggle


{-| Listen for `toggle` events. -}
onToggle :
    (String -> msg)
    -> M3e.Cem.Attr.Attr { c | onToggle : M3e.Value.Supported } msg
onToggle =
    M3e.Cem.Menu.onToggle