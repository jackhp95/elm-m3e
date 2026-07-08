module M3e.Record.IconButton exposing
    ( view, disabled, disabledInteractive, name, selected, shape
    , size, toggle, type_, value, variant, width, onBeforeinput
    , onInput, onChange, selectedSlot
    )

{-|
An icon button users interact with to perform a supplementary action.

**Component Info:**
- **Extends:** `LitElement`

**Events:**
- `beforeinput`: Dispatched before a toggle button's selected state changes.
- `input`: Dispatched when a toggle button's selected state changes.
- `change`: Dispatched when a toggle button's selected state changes.
- `click`: Dispatched when the element is clicked.

**Slots:**
- `selected`: Renders an icon, when selected.

<!-- elm-cem:docmeta category=Actions -->

## Examples

### Variants

<!-- elm-cem:example title="Variants" -->
```elm
[ M3e.IconButton.view [ M3e.IconButton.variant M3e.Value.filled ] [ M3e.Icon.view [ M3e.Icon.name "check" ] [] ]
    , M3e.IconButton.view [ M3e.IconButton.variant M3e.Value.tonal ] [ M3e.Icon.view [ M3e.Icon.name "add" ] [] ]
    , M3e.IconButton.view [ M3e.IconButton.variant M3e.Value.outlined ] [ M3e.Icon.view [ M3e.Icon.name "search" ] [] ]
    , M3e.IconButton.view [ M3e.IconButton.variant M3e.Value.standard ] [ M3e.Icon.view [ M3e.Icon.name "settings" ] [] ]
    ]
```

<!-- elm-cem:example title="Shapes" -->
```elm
[ M3e.IconButton.view [ M3e.IconButton.variant M3e.Value.filled, M3e.IconButton.shape M3e.Value.square ] [ M3e.Icon.view [ M3e.Icon.name "check" ] [] ]
    , M3e.IconButton.view [ M3e.IconButton.variant M3e.Value.tonal, M3e.IconButton.shape M3e.Value.square ] [ M3e.Icon.view [ M3e.Icon.name "add" ] [] ]
    , M3e.IconButton.view [ M3e.IconButton.variant M3e.Value.outlined, M3e.IconButton.shape M3e.Value.square ] [ M3e.Icon.view [ M3e.Icon.name "search" ] [] ]
    , M3e.IconButton.view [ M3e.IconButton.variant M3e.Value.standard, M3e.IconButton.shape M3e.Value.square ] [ M3e.Icon.view [ M3e.Icon.name "settings" ] [] ]
    ]
```

<!-- elm-cem:example title="Toggle" -->
```elm
[ M3e.IconButton.view [ M3e.IconButton.variant M3e.Value.filled, M3e.IconButton.toggle True ] [ M3e.Icon.view [ M3e.Icon.name "check" ] [] ]
    , M3e.IconButton.view [ M3e.IconButton.variant M3e.Value.tonal, M3e.IconButton.toggle True ] [ M3e.Icon.view [ M3e.Icon.name "add" ] [] ]
    , M3e.IconButton.view [ M3e.IconButton.variant M3e.Value.outlined, M3e.IconButton.toggle True ] [ M3e.Icon.view [ M3e.Icon.name "search" ] [] ]
    , M3e.IconButton.view [ M3e.IconButton.variant M3e.Value.standard, M3e.IconButton.toggle True ] [ M3e.Icon.view [ M3e.Icon.name "settings" ] [] ]
    ]
```

### Sizes

<!-- elm-cem:example title="Sizes" -->
```elm
[ M3e.IconButton.view [ M3e.IconButton.variant M3e.Value.tonal, M3e.IconButton.size M3e.Value.extraSmall ] [ M3e.Icon.view [ M3e.Icon.name "add" ] [] ]
    , M3e.IconButton.view [ M3e.IconButton.variant M3e.Value.tonal, M3e.IconButton.size M3e.Value.small ] [ M3e.Icon.view [ M3e.Icon.name "add" ] [] ]
    , M3e.IconButton.view [ M3e.IconButton.variant M3e.Value.tonal, M3e.IconButton.size M3e.Value.medium ] [ M3e.Icon.view [ M3e.Icon.name "add" ] [] ]
    , M3e.IconButton.view [ M3e.IconButton.variant M3e.Value.tonal, M3e.IconButton.size M3e.Value.large ] [ M3e.Icon.view [ M3e.Icon.name "add" ] [] ]
    , M3e.IconButton.view [ M3e.IconButton.variant M3e.Value.tonal, M3e.IconButton.size M3e.Value.extraLarge ] [ M3e.Icon.view [ M3e.Icon.name "add" ] [] ]
    ]
```

### Width

<!-- elm-cem:example title="Widths" -->
```elm
[ M3e.IconButton.view [ M3e.IconButton.variant M3e.Value.tonal, M3e.IconButton.width M3e.Value.narrow ] [ M3e.Icon.view [ M3e.Icon.name "add" ] [] ]
    , M3e.IconButton.view [ M3e.IconButton.variant M3e.Value.tonal, M3e.IconButton.width M3e.Value.wide ] [ M3e.Icon.view [ M3e.Icon.name "add" ] [] ]
    ]
```

### Examples

<!-- elm-cem:example title="Toggle (2)" -->
```elm
M3e.IconButton.view [ M3e.IconButton.variant M3e.Value.tonal, M3e.IconButton.toggle True ] [ M3e.Icon.view [ M3e.Icon.name "close" ] [], M3e.IconButton.selectedSlot (M3e.Icon.view [ M3e.Icon.name "check" ] []) ]
```

<!-- elm-cem:example title="Toggle (3)" -->
```elm
[ M3e.IconButton.view [ M3e.IconButton.variant M3e.Value.filled, M3e.IconButton.shape M3e.Value.rounded, M3e.IconButton.toggle True, M3e.IconButton.selected True ] [ M3e.Icon.view [ M3e.Icon.name "check" ] [] ]
    , M3e.IconButton.view [ M3e.IconButton.variant M3e.Value.tonal, M3e.IconButton.shape M3e.Value.rounded, M3e.IconButton.toggle True, M3e.IconButton.selected True ] [ M3e.Icon.view [ M3e.Icon.name "add" ] [] ]
    , M3e.IconButton.view [ M3e.IconButton.variant M3e.Value.outlined, M3e.IconButton.shape M3e.Value.rounded, M3e.IconButton.toggle True, M3e.IconButton.selected True ] [ M3e.Icon.view [ M3e.Icon.name "search" ] [] ]
    , M3e.IconButton.view [ M3e.IconButton.variant M3e.Value.standard, M3e.IconButton.shape M3e.Value.rounded, M3e.IconButton.toggle True, M3e.IconButton.selected True ] [ M3e.Icon.view [ M3e.Icon.name "settings" ] [] ]
    , Native.br
    , Native.br
    , M3e.IconButton.view [ M3e.IconButton.variant M3e.Value.filled, M3e.IconButton.shape M3e.Value.square, M3e.IconButton.toggle True, M3e.IconButton.selected True ] [ M3e.Icon.view [ M3e.Icon.name "check" ] [] ]
    , M3e.IconButton.view [ M3e.IconButton.variant M3e.Value.tonal, M3e.IconButton.shape M3e.Value.square, M3e.IconButton.toggle True, M3e.IconButton.selected True ] [ M3e.Icon.view [ M3e.Icon.name "add" ] [] ]
    , M3e.IconButton.view [ M3e.IconButton.variant M3e.Value.outlined, M3e.IconButton.shape M3e.Value.square, M3e.IconButton.toggle True, M3e.IconButton.selected True ] [ M3e.Icon.view [ M3e.Icon.name "search" ] [] ]
    , M3e.IconButton.view [ M3e.IconButton.variant M3e.Value.standard, M3e.IconButton.shape M3e.Value.square, M3e.IconButton.toggle True, M3e.IconButton.selected True ] [ M3e.Icon.view [ M3e.Icon.name "settings" ] [] ]
    ]
```

<!-- elm-cem:example title="Disabling" -->
```elm
[ M3e.IconButton.view [ M3e.IconButton.variant M3e.Value.filled, M3e.IconButton.disabled True ] [ M3e.Icon.view [ M3e.Icon.name "check" ] [] ]
    , M3e.IconButton.view [ M3e.IconButton.variant M3e.Value.filled, M3e.IconButton.disabledInteractive True ] [ M3e.Icon.view [ M3e.Icon.name "check" ] [] ]
    ]
```

<!-- elm-cem:example title="Links" -->
```elm
M3e.IconButton.view [ M3e.IconButton.variant M3e.Value.tonal, M3e.IconButton.href "https://www.google.com", M3e.IconButton.target "_blank" ] [ M3e.Icon.view [ M3e.Icon.name "open_in_new_window" ] [] ]
```

<!-- elm-cem:example title="Density" -->
```elm
[ M3e.IconButton.view [ M3e.IconButton.variant M3e.Value.filled, M3e.IconButton.size M3e.Value.extraSmall ] [ M3e.Icon.view [ M3e.Icon.name "check" ] [] ]
    , M3e.IconButton.view [ M3e.IconButton.variant M3e.Value.filled, M3e.IconButton.size M3e.Value.extraSmall ] [ M3e.Icon.view [ M3e.Icon.name "check" ] [] ]
    , M3e.IconButton.view [ M3e.IconButton.variant M3e.Value.filled, M3e.IconButton.size M3e.Value.extraSmall ] [ M3e.Icon.view [ M3e.Icon.name "check" ] [] ]
    , M3e.IconButton.view [ M3e.IconButton.variant M3e.Value.filled, M3e.IconButton.size M3e.Value.extraSmall ] [ M3e.Icon.view [ M3e.Icon.name "check" ] [] ]
    ]
```

<!-- elm-cem:example title="Density (2)" -->
```elm
[ M3e.IconButton.view [ M3e.IconButton.variant M3e.Value.filled, M3e.IconButton.size M3e.Value.small ] [ M3e.Icon.view [ M3e.Icon.name "check" ] [] ]
    , M3e.IconButton.view [ M3e.IconButton.variant M3e.Value.filled, M3e.IconButton.size M3e.Value.small ] [ M3e.Icon.view [ M3e.Icon.name "check" ] [] ]
    , M3e.IconButton.view [ M3e.IconButton.variant M3e.Value.filled, M3e.IconButton.size M3e.Value.small ] [ M3e.Icon.view [ M3e.Icon.name "check" ] [] ]
    , M3e.IconButton.view [ M3e.IconButton.variant M3e.Value.filled, M3e.IconButton.size M3e.Value.small ] [ M3e.Icon.view [ M3e.Icon.name "check" ] [] ]
    ]
```

@docs view, disabled, disabledInteractive, name, selected, shape
@docs size, toggle, type_, value, variant, width
@docs onBeforeinput, onInput, onChange, selectedSlot
-}


import M3e.Action
import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.IconButton
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-icon-button>` element (lazy IR). -}
view :
    { content :
        M3e.Element.Element { icon : M3e.Value.Supported
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
        } msg
    , action :
        M3e.Action.Action { click : M3e.Value.Supported
        , link : M3e.Value.Supported
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
        } msg
    }
    -> List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , disabledInteractive : M3e.Value.Supported
    , name : M3e.Value.Supported
    , selected : M3e.Value.Supported
    , shape : M3e.Value.Supported
    , size : M3e.Value.Supported
    , toggle : M3e.Value.Supported
    , type_ : M3e.Value.Supported
    , value : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , width : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | iconButton : M3e.Value.Supported } msg
view req_ attributes content_ =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.IconButton.iconButton
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.append
                  (List.map
                       M3e.Cem.Attr.Internal.forget
                       (M3e.Action.toAttrs req_.action)
                  )
                  (List.map M3e.Cem.Attr.Internal.forget attributes)
             )
             (List.append
                  [ M3e.Action.wrapContent
                      req_.action
                      (M3e.Element.toNode req_.content)
                  ]
                  (List.map M3e.Element.toNode content_)
             )
        )


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.IconButton.disabled


{-| Whether the element is disabled and interactive. (default: `false`) -}
disabledInteractive :
    Bool
    -> M3e.Cem.Attr.Attr { c | disabledInteractive : M3e.Value.Supported } msg
disabledInteractive =
    M3e.Cem.IconButton.disabledInteractive


{-| The name of the element, submitted as a pair with the element's `value` as part of form data, when the element is used to submit a form. -}
name : String -> M3e.Cem.Attr.Attr { c | name : M3e.Value.Supported } msg
name =
    M3e.Cem.IconButton.name


{-| Whether the toggle button is selected. (default: `false`) -}
selected : Bool -> M3e.Cem.Attr.Attr { c | selected : M3e.Value.Supported } msg
selected =
    M3e.Cem.IconButton.selected


{-| The shape of the button. (default: `"rounded"`) -}
shape :
    M3e.Value.Value { rounded : M3e.Value.Supported
    , square : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | shape : M3e.Value.Supported } msg
shape =
    M3e.Cem.IconButton.shape


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
    M3e.Cem.IconButton.size


{-| Whether the button will toggle between selected and unselected states. (default: `false`) -}
toggle : Bool -> M3e.Cem.Attr.Attr { c | toggle : M3e.Value.Supported } msg
toggle =
    M3e.Cem.IconButton.toggle


{-| The type of the element. (default: `"button"`) -}
type_ :
    M3e.Value.Value { button : M3e.Value.Supported
    , reset : M3e.Value.Supported
    , submit : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | type_ : M3e.Value.Supported } msg
type_ =
    M3e.Cem.IconButton.type_


{-| The value associated with the element's name when it's submitted with form data. -}
value : String -> M3e.Cem.Attr.Attr { c | value : M3e.Value.Supported } msg
value =
    M3e.Cem.IconButton.value


{-| The appearance variant of the button. (default: `"standard"`) -}
variant :
    M3e.Value.Value { filled : M3e.Value.Supported
    , outlined : M3e.Value.Supported
    , standard : M3e.Value.Supported
    , tonal : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variant =
    M3e.Cem.IconButton.variant


{-| The width of the button. (default: `"default"`) -}
width :
    M3e.Value.Value { default : M3e.Value.Supported
    , narrow : M3e.Value.Supported
    , wide : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | width : M3e.Value.Supported } msg
width =
    M3e.Cem.IconButton.width


{-| Listen for `beforeinput` events. -}
onBeforeinput :
    (Bool -> msg)
    -> M3e.Cem.Attr.Attr { c | onBeforeinput : M3e.Value.Supported } msg
onBeforeinput =
    M3e.Cem.IconButton.onBeforeinput


{-| Listen for `input` events. -}
onInput :
    (Bool -> msg) -> M3e.Cem.Attr.Attr { c | onInput : M3e.Value.Supported } msg
onInput =
    M3e.Cem.IconButton.onInput


{-| Listen for `change` events. -}
onChange :
    (Bool -> msg)
    -> M3e.Cem.Attr.Attr { c | onChange : M3e.Value.Supported } msg
onChange =
    M3e.Cem.IconButton.onChange


{-| Place content in the `selected` slot. -}
selectedSlot :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Element.Element k msg
selectedSlot el =
    M3e.Element.Internal.placeSlot "selected" el