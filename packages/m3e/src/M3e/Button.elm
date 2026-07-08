module M3e.Button exposing
    ( view, disabled, disabledInteractive, name, selected, shape
    , size, toggle, type_, value, variant, onBeforeinput, onInput
    , onChange, onClick, href, target, rel, download, icon
    , selectedSlot, selectedIcon, trailingIcon
    )

{-|
A button users interact with to perform an action.

**Component Info:**
- **Extends:** `LitElement`

**Events:**
- `beforeinput`: Dispatched before a toggle button's selected state changes.
- `input`: Dispatched when a toggle button's selected state changes.
- `change`: Dispatched when a toggle button's selected state changes.
- `click`: Dispatched when the element is clicked.

**Slots:**
- `icon`: Renders an icon before the button's label.
- `selected`: Renders the label of the button, when selected.
- `selected-icon`: Renders an icon before the button's label, when selected.
- `trailing-icon`: Renders an icon after the button's label.

<!-- elm-cem:docmeta category=Actions -->

## Examples

### Variants

<!-- elm-cem:example title="Variants" -->
```elm
[ M3e.Button.view [ M3e.Button.variant M3e.Value.elevated ] [ Kit.text "Elevated" ]
    , M3e.Button.view [ M3e.Button.variant M3e.Value.filled ] [ Kit.text "Filled" ]
    , M3e.Button.view [ M3e.Button.variant M3e.Value.tonal ] [ Kit.text "Tonal" ]
    , M3e.Button.view [ M3e.Button.variant M3e.Value.outlined ] [ Kit.text "Outlined" ]
    , M3e.Button.view [ M3e.Button.variant M3e.Value.text ] [ Kit.text "Text" ]
    ]
```

<!-- elm-cem:example title="Shapes" -->
```elm
[ M3e.Button.view [ M3e.Button.variant M3e.Value.elevated, M3e.Button.shape M3e.Value.square ] [ Kit.text "Square Elevated" ]
    , M3e.Button.view [ M3e.Button.variant M3e.Value.filled, M3e.Button.shape M3e.Value.square ] [ Kit.text "Square Filled" ]
    , M3e.Button.view [ M3e.Button.variant M3e.Value.tonal, M3e.Button.shape M3e.Value.square ] [ Kit.text "Square Tonal" ]
    , M3e.Button.view [ M3e.Button.variant M3e.Value.outlined, M3e.Button.shape M3e.Value.square ] [ Kit.text "Square Outlined" ]
    , M3e.Button.view [ M3e.Button.variant M3e.Value.text, M3e.Button.shape M3e.Value.square ] [ Kit.text "Square Text" ]
    ]
```

<!-- elm-cem:example title="Toggle" -->
```elm
[ M3e.Button.view [ M3e.Button.variant M3e.Value.elevated, M3e.Button.toggle True ] [ Kit.text "Elevated Toggle" ]
    , M3e.Button.view [ M3e.Button.variant M3e.Value.filled, M3e.Button.toggle True ] [ Kit.text "Filled Toggle" ]
    , M3e.Button.view [ M3e.Button.variant M3e.Value.tonal, M3e.Button.toggle True ] [ Kit.text "Tonal Toggle" ]
    , M3e.Button.view [ M3e.Button.variant M3e.Value.outlined, M3e.Button.toggle True ] [ Kit.text "Outlined Toggle" ]
    ]
```

### Sizes

<!-- elm-cem:example title="Sizes" -->
```elm
[ M3e.Button.view [ M3e.Button.variant M3e.Value.tonal, M3e.Button.size M3e.Value.extraSmall ] [ Kit.text "Extra Small" ]
    , M3e.Button.view [ M3e.Button.variant M3e.Value.tonal, M3e.Button.size M3e.Value.small ] [ Kit.text "Small" ]
    , M3e.Button.view [ M3e.Button.variant M3e.Value.tonal, M3e.Button.size M3e.Value.medium ] [ Kit.text "Medium" ]
    , M3e.Button.view [ M3e.Button.variant M3e.Value.tonal, M3e.Button.size M3e.Value.large ] [ Kit.text "Large" ]
    , M3e.Button.view [ M3e.Button.variant M3e.Value.tonal, M3e.Button.size M3e.Value.extraLarge ] [ Kit.text "Extra Large" ]
    ]
```

### Examples

<!-- elm-cem:example title="Icons" -->
```elm
[ M3e.Button.view [ M3e.Button.variant M3e.Value.tonal ] [ M3e.Button.icon (M3e.Icon.view [ M3e.Icon.name "send" ] []), Kit.text "Send" ]
    , M3e.Button.view [ M3e.Button.variant M3e.Value.tonal ] [ M3e.Button.trailingIcon (M3e.Icon.view [ M3e.Icon.name "open_in_new_window" ] []), Kit.text "Open" ]
    ]
```

<!-- elm-cem:example title="Disabling" -->
```elm
[ M3e.Button.view [ M3e.Button.variant M3e.Value.filled, M3e.Button.disabled True ] [ Kit.text "Disabled" ]
    , M3e.Button.view [ M3e.Button.variant M3e.Value.filled, M3e.Button.disabledInteractive True ] [ Kit.text "Disabled Interactive" ]
    ]
```

<!-- elm-cem:example title="Links" -->
```elm
M3e.Button.view [ M3e.Button.variant M3e.Value.tonal, M3e.Button.href "https://www.google.com", M3e.Button.target "_blank" ] [ Kit.text "Google", M3e.Button.trailingIcon (M3e.Icon.view [ M3e.Icon.name "open_in_new_window" ] []) ]
```

<!-- elm-cem:example title="Density" -->
```elm
[ M3e.Button.view [ M3e.Button.variant M3e.Value.filled, M3e.Button.size M3e.Value.extraSmall ] [ M3e.Button.icon (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "Density -3" ]
    , M3e.Button.view [ M3e.Button.variant M3e.Value.filled, M3e.Button.size M3e.Value.extraSmall ] [ M3e.Button.icon (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "Density -2" ]
    , M3e.Button.view [ M3e.Button.variant M3e.Value.filled, M3e.Button.size M3e.Value.extraSmall ] [ M3e.Button.icon (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "Density -1" ]
    , M3e.Button.view [ M3e.Button.variant M3e.Value.filled, M3e.Button.size M3e.Value.extraSmall ] [ M3e.Button.icon (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "Density 0" ]
    ]
```

<!-- elm-cem:example title="Density (2)" -->
```elm
[ M3e.Button.view [ M3e.Button.variant M3e.Value.filled ] [ M3e.Button.icon (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "Density -3" ]
    , M3e.Button.view [ M3e.Button.variant M3e.Value.filled ] [ M3e.Button.icon (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "Density -2" ]
    , M3e.Button.view [ M3e.Button.variant M3e.Value.filled ] [ M3e.Button.icon (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "Density -1" ]
    , M3e.Button.view [ M3e.Button.variant M3e.Value.filled ] [ M3e.Button.icon (M3e.Icon.view [ M3e.Icon.name "stars" ] []), Kit.text "Density 0" ]
    ]
```

@docs view, disabled, disabledInteractive, name, selected, shape
@docs size, toggle, type_, value, variant, onBeforeinput
@docs onInput, onChange, onClick, href, target, rel
@docs download, icon, selectedSlot, selectedIcon, trailingIcon
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.Button
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-button>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , disabledInteractive : M3e.Value.Supported
    , download : M3e.Value.Supported
    , href : M3e.Value.Supported
    , name : M3e.Value.Supported
    , rel : M3e.Value.Supported
    , selected : M3e.Value.Supported
    , shape : M3e.Value.Supported
    , size : M3e.Value.Supported
    , target : M3e.Value.Supported
    , toggle : M3e.Value.Supported
    , type_ : M3e.Value.Supported
    , value : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element { text : M3e.Value.Supported
    , icon : M3e.Value.Supported
    , menuTrigger : M3e.Value.Supported
    , dialogTrigger : M3e.Value.Supported
    , fabMenuTrigger : M3e.Value.Supported
    , bottomSheetTrigger : M3e.Value.Supported
    , navRailToggle : M3e.Value.Supported
    , drawerToggle : M3e.Value.Supported
    , datepickerToggle : M3e.Value.Supported
    , dialogAction : M3e.Value.Supported
    , bottomSheetAction : M3e.Value.Supported
    , richTooltipAction : M3e.Value.Supported
    , stepperReset : M3e.Value.Supported
    , stepperPrevious : M3e.Value.Supported
    , stepperNext : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | button : M3e.Value.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.Button.button
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Element.toNode children)
        )


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.Button.disabled


{-| Whether the element is disabled and interactive. (default: `false`) -}
disabledInteractive :
    Bool
    -> M3e.Cem.Attr.Attr { c | disabledInteractive : M3e.Value.Supported } msg
disabledInteractive =
    M3e.Cem.Button.disabledInteractive


{-| The name of the element, submitted as a pair with the element's `value` as part of form data, when the element is used to submit a form. -}
name : String -> M3e.Cem.Attr.Attr { c | name : M3e.Value.Supported } msg
name =
    M3e.Cem.Button.name


{-| Whether the toggle button is selected. (default: `false`) -}
selected : Bool -> M3e.Cem.Attr.Attr { c | selected : M3e.Value.Supported } msg
selected =
    M3e.Cem.Button.selected


{-| The shape of the button. (default: `"rounded"`) -}
shape :
    M3e.Value.Value { rounded : M3e.Value.Supported
    , square : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | shape : M3e.Value.Supported } msg
shape =
    M3e.Cem.Button.shape


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
    M3e.Cem.Button.size


{-| Whether the button will toggle between selected and unselected states. (default: `false`) -}
toggle : Bool -> M3e.Cem.Attr.Attr { c | toggle : M3e.Value.Supported } msg
toggle =
    M3e.Cem.Button.toggle


{-| The type of the element. (default: `"button"`) -}
type_ :
    M3e.Value.Value { button : M3e.Value.Supported
    , reset : M3e.Value.Supported
    , submit : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | type_ : M3e.Value.Supported } msg
type_ =
    M3e.Cem.Button.type_


{-| The value associated with the element's name when it's submitted with form data. -}
value : String -> M3e.Cem.Attr.Attr { c | value : M3e.Value.Supported } msg
value =
    M3e.Cem.Button.value


{-| The appearance variant of the button. (default: `"text"`) -}
variant :
    M3e.Value.Value { elevated : M3e.Value.Supported
    , filled : M3e.Value.Supported
    , outlined : M3e.Value.Supported
    , text : M3e.Value.Supported
    , tonal : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variant =
    M3e.Cem.Button.variant


{-| Listen for `beforeinput` events. -}
onBeforeinput :
    (Bool -> msg)
    -> M3e.Cem.Attr.Attr { c | onBeforeinput : M3e.Value.Supported } msg
onBeforeinput =
    M3e.Cem.Button.onBeforeinput


{-| Listen for `input` events. -}
onInput :
    (Bool -> msg) -> M3e.Cem.Attr.Attr { c | onInput : M3e.Value.Supported } msg
onInput =
    M3e.Cem.Button.onInput


{-| Listen for `change` events. -}
onChange :
    (Bool -> msg)
    -> M3e.Cem.Attr.Attr { c | onChange : M3e.Value.Supported } msg
onChange =
    M3e.Cem.Button.onChange


{-| Listen for `click` events. -}
onClick : msg -> M3e.Cem.Attr.Attr { c | onClick : M3e.Value.Supported } msg
onClick =
    M3e.Cem.Button.onClick


{-| The URL to which the link button points. (default: `""`) -}
href : String -> M3e.Cem.Attr.Attr { c | href : M3e.Value.Supported } msg
href =
    M3e.Cem.Button.href


{-| The target of the link button. (default: `""`) -}
target : String -> M3e.Cem.Attr.Attr { c | target : M3e.Value.Supported } msg
target =
    M3e.Cem.Button.target


{-| The relationship between the `target` of the link button and the document. (default: `""`) -}
rel : String -> M3e.Cem.Attr.Attr { c | rel : M3e.Value.Supported } msg
rel =
    M3e.Cem.Button.rel


{-| A value indicating whether the `target` of the link button will be downloaded, optionally specifying the new name of the file. (default: `null`) -}
download :
    String -> M3e.Cem.Attr.Attr { c | download : M3e.Value.Supported } msg
download =
    M3e.Cem.Button.download


{-| Place content in the `icon` slot. -}
icon :
    M3e.Element.Element { icon : M3e.Value.Supported
    , loadingIndicator : M3e.Value.Supported
    } msg
    -> M3e.Element.Element k msg
icon el =
    M3e.Element.Internal.placeSlot "icon" el


{-| Place content in the `selected` slot. -}
selectedSlot :
    M3e.Element.Element { text : M3e.Value.Supported
    , icon : M3e.Value.Supported
    } msg
    -> M3e.Element.Element k msg
selectedSlot el =
    M3e.Element.Internal.placeSlot "selected" el


{-| Place content in the `selected-icon` slot. -}
selectedIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Element.Element k msg
selectedIcon el =
    M3e.Element.Internal.placeSlot "selected-icon" el


{-| Place content in the `trailing-icon` slot. -}
trailingIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Element.Element k msg
trailingIcon el =
    M3e.Element.Internal.placeSlot "trailing-icon" el