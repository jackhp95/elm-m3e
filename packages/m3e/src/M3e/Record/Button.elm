module M3e.Record.Button exposing
    ( view, disabled, disabledInteractive, name, selected, shape
    , size, toggle, type_, value, variant, onBeforeinput, onInput
    , onChange, icon, selectedSlot, selectedIcon, trailingIcon
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

<!-- elm-cem:example title="Five button variants in an action row" -->
```elm
[ M3e.Button.view { content = Kit.text "New", action = M3e.Action.none } [ M3e.Button.variant M3e.Value.filled ] [ M3e.Button.icon (M3e.Icon.view [ M3e.Icon.name "add" ] []) ]
    , M3e.Button.view { content = Kit.text "Tonal", action = M3e.Action.none } [ M3e.Button.variant M3e.Value.tonal ] []
    , M3e.Button.view { content = Kit.text "Elevated", action = M3e.Action.none } [ M3e.Button.variant M3e.Value.elevated ] []
    , M3e.Button.view { content = Kit.text "Outlined", action = M3e.Action.none } [ M3e.Button.variant M3e.Value.outlined ] []
    , M3e.Button.view { content = Kit.text "Text", action = M3e.Action.none } [ M3e.Button.variant M3e.Value.text ] []
    ]
```

<!-- elm-cem:example title="Toggle button and link button with icons" -->
```elm
[ M3e.Button.view { content = Kit.text "Save", action = M3e.Action.none } [ M3e.Button.variant M3e.Value.outlined, M3e.Button.toggle True ] [ M3e.Button.icon (M3e.Icon.view [ M3e.Icon.name "favorite_border" ] []), M3e.Button.selectedIcon (M3e.Icon.view [ M3e.Icon.name "favorite", M3e.Icon.filled True ] []), M3e.Button.selectedSlot (Kit.text "Saved") ]
    , M3e.Button.view { content = Kit.text "Download", action = M3e.Action.linkWith { href = "/download", target = Nothing, rel = Nothing, download = Just "" } } [ M3e.Button.variant M3e.Value.filled, M3e.Button.size M3e.Value.large ] [ M3e.Button.icon (M3e.Icon.view [ M3e.Icon.name "download" ] []) ]
    ]
```

@docs view, disabled, disabledInteractive, name, selected, shape
@docs size, toggle, type_, value, variant, onBeforeinput
@docs onInput, onChange, icon, selectedSlot, selectedIcon, trailingIcon
-}


import M3e.Action
import M3e.Cem.Attr
import M3e.Cem.Button
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-button>` element (lazy IR). -}
view :
    { content :
        M3e.Element.Element { text : M3e.Value.Supported
        , icon : M3e.Value.Supported
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
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { icon : M3e.Value.Supported
    , selected : M3e.Value.Supported
    , selectedIcon : M3e.Value.Supported
    , trailingIcon : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | button : M3e.Value.Supported } msg
view req_ attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.Button.button (List.map M3e.Cem.Attr.forget erased) ch
             )
             (List.append
                  (List.map M3e.Cem.Attr.forget (M3e.Action.toAttrs req_.action)
                  )
                  (List.map M3e.Cem.Attr.forget attributes)
             )
             (List.append
                  [ M3e.Action.wrapContent
                      req_.action
                      (M3e.Element.toNode req_.content)
                  ]
                  (List.map M3e.Content.toNode content_)
             )
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


{-| Place content in the `icon` slot. -}
icon :
    M3e.Element.Element { icon : M3e.Value.Supported
    , loadingIndicator : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | icon : M3e.Value.Supported } msg
icon el =
    M3e.Content.slot "icon" el


{-| Place content in the `selected` slot. -}
selectedSlot :
    M3e.Element.Element { text : M3e.Value.Supported
    , icon : M3e.Value.Supported
    } msg
    -> M3e.Content.Content { r | selected : M3e.Value.Supported } msg
selectedSlot el =
    M3e.Content.slot "selected" el


{-| Place content in the `selected-icon` slot. -}
selectedIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | selectedIcon : M3e.Value.Supported } msg
selectedIcon el =
    M3e.Content.slot "selected-icon" el


{-| Place content in the `trailing-icon` slot. -}
trailingIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | trailingIcon : M3e.Value.Supported } msg
trailingIcon el =
    M3e.Content.slot "trailing-icon" el