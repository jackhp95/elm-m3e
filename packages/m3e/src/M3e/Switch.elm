module M3e.Switch exposing
    ( view, checked, disabled, icons, name, value
    , onBeforeinput, onInput, onChange, onClick
    )

{-|
An on/off control that can be toggled by clicking.

**Component Info:**
- **Extends:** `LitElement`

**Events:**
- `beforeinput`: Dispatched before the checked state changes.
- `input`: Dispatched when the checked state changes.
- `change`: Dispatched when the checked state changes.
- `click`: Dispatched when the element is clicked.

<!-- elm-cem:docmeta category=Selection -->

## Examples

### Examples

<!-- elm-cem:example title="Basic usage" -->
```elm
M3e.Switch.view [ M3e.Switch.checked True ] []
```

<!-- elm-cem:example title="Labels" -->
```elm
[ Native.node Html.label [] [ M3e.Switch.view [] [], Kit.text "Switch 1" ]
    , M3e.Switch.view [] []
    , Native.node Html.label [] [ Kit.text "Switch 2" ]
    ]
```

<!-- elm-cem:example title="Disabling" -->
```elm
[ Native.node Html.label [] [ M3e.Switch.view [ M3e.Switch.disabled True ] [], Kit.text "Disabled Switch 1" ]
    , M3e.Switch.view [ M3e.Switch.disabled True ] []
    , Native.node Html.label [] [ Kit.text "Disabled Switch 2" ]
    ]
```

<!-- elm-cem:example title="Density" -->
```elm
M3e.Switch.view [] []
```

### Icons

<!-- elm-cem:example title="Icons" -->
```elm
[ M3e.Switch.view [ M3e.Switch.icons M3e.Value.selected, M3e.Switch.checked True ] []
    , M3e.Switch.view [ M3e.Switch.icons M3e.Value.both ] []
    ]
```

@docs view, checked, disabled, icons, name, value
@docs onBeforeinput, onInput, onChange, onClick
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.Switch
import M3e.Content
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-switch>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { checked : M3e.Value.Supported
    , disabled : M3e.Value.Supported
    , icons : M3e.Value.Supported
    , name : M3e.Value.Supported
    , value : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content {} msg)
    -> M3e.Element.Element { s | switch : M3e.Value.Supported } msg
view attributes content_ =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.Switch.switch
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Content.toNode content_)
        )


{-| Whether the element is checked. (default: `false`) -}
checked : Bool -> M3e.Cem.Attr.Attr { c | checked : M3e.Value.Supported } msg
checked =
    M3e.Cem.Switch.checked


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.Switch.disabled


{-| The icons to present. (default: `"none"`) -}
icons :
    M3e.Value.Value { both : M3e.Value.Supported
    , none : M3e.Value.Supported
    , selected : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | icons : M3e.Value.Supported } msg
icons =
    M3e.Cem.Switch.icons


{-| The name that identifies the element when submitting the associated form. -}
name : String -> M3e.Cem.Attr.Attr { c | name : M3e.Value.Supported } msg
name =
    M3e.Cem.Switch.name


{-| A string representing the value of the switch. (default: `"on"`) -}
value : String -> M3e.Cem.Attr.Attr { c | value : M3e.Value.Supported } msg
value =
    M3e.Cem.Switch.value


{-| Listen for `beforeinput` events. -}
onBeforeinput :
    (Bool -> msg)
    -> M3e.Cem.Attr.Attr { c | onBeforeinput : M3e.Value.Supported } msg
onBeforeinput =
    M3e.Cem.Switch.onBeforeinput


{-| Listen for `input` events. -}
onInput :
    (Bool -> msg) -> M3e.Cem.Attr.Attr { c | onInput : M3e.Value.Supported } msg
onInput =
    M3e.Cem.Switch.onInput


{-| Listen for `change` events. -}
onChange :
    (Bool -> msg)
    -> M3e.Cem.Attr.Attr { c | onChange : M3e.Value.Supported } msg
onChange =
    M3e.Cem.Switch.onChange


{-| Listen for `click` events. -}
onClick : msg -> M3e.Cem.Attr.Attr { c | onClick : M3e.Value.Supported } msg
onClick =
    M3e.Cem.Switch.onClick