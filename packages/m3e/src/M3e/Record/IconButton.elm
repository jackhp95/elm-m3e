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

### Examples

<!-- elm-cem:example title="Icon button wrapping an icon" -->
```elm
M3e.IconButton.view [ M3e.Aria.label "Toggle theme" ] [ M3e.IconButton.child (M3e.Icon.view [ M3e.Icon.name "dark_mode" ] []) ]
```

<!-- elm-cem:example title="Link icon buttons in a toolbar" -->
```elm
Native.div [] [ M3e.IconButton.view [ M3e.IconButton.href "/rss.xml", M3e.Aria.label "RSS Feed" ] [ M3e.IconButton.child (M3e.Icon.view [ M3e.Icon.name "rss_feed" ] []) ], M3e.IconButton.view [ M3e.IconButton.href "/feed.json", M3e.Aria.label "JSON Feed" ] [ M3e.IconButton.child (M3e.Icon.view [ M3e.Icon.name "data_object" ] []) ] ]
```

<!-- elm-cem:example title="Icon buttons grouped in a media control bar" -->
```elm
[ M3e.IconButton.view [ M3e.Aria.label "Previous" ] [ M3e.IconButton.child (M3e.Icon.view [ M3e.Icon.name "skip_previous" ] []) ]
    , M3e.IconButton.view [ M3e.Aria.label "Play/Pause" ] [ M3e.IconButton.child (M3e.Icon.view [ M3e.Icon.name "play_arrow" ] []) ]
    ]
```

@docs view, disabled, disabledInteractive, name, selected, shape
@docs size, toggle, type_, value, variant, width
@docs onBeforeinput, onInput, onChange, selectedSlot
-}


import M3e.Action
import M3e.Cem.Attr
import M3e.Cem.IconButton
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-icon-button>` element (lazy IR). -}
view :
    { content : M3e.Element.Element { icon : M3e.Value.Supported } msg
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
    , width : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { selected : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | iconButton : M3e.Value.Supported } msg
view req_ attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.IconButton.iconButton
                      (List.map M3e.Cem.Attr.forget erased)
                      ch
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
    -> M3e.Content.Content { r | selected : M3e.Value.Supported } msg
selectedSlot el =
    M3e.Content.slot "selected" el