module M3e.RadioGroup exposing
    ( view, ariaInvalid, disabled, name, required, onBeforeinput
    , onInput, onChange
    )

{-|
A container for a set of radio buttons.

**Component Info:**
- **Extends:** `LitElement`

**Events:**
- `beforeinput`: Dispatched before the checked state of a radio button changes.
- `input`: Dispatched when the checked state of a radio button changes.
- `change`: Dispatched when the checked state of a radio button changes.

<!-- elm-cem:docmeta category=Selection -->

## Examples

### Examples

<!-- elm-cem:example title="Radio groups" -->
```elm
M3e.RadioGroup.view [] (M3e.RadioGroup.children [ Native.node Html.label [] [ M3e.Radio.view [ M3e.Radio.value "1" ] [], Kit.text "Option 1" ], Native.node Html.label [] [ M3e.Radio.view [ M3e.Radio.value "2" ] [], Kit.text "Option 2" ], Native.node Html.label [] [ M3e.Radio.view [ M3e.Radio.value "3" ] [], Kit.text "Option 3" ], Native.node Html.label [] [ M3e.Radio.view [ M3e.Radio.value "4" ] [], Kit.text "Option 4" ] ])
```

<!-- elm-cem:example title="Labels" -->
```elm
[ Native.node Html.label [] [ Kit.text "Select an option" ]
    , Native.br
    , M3e.RadioGroup.view [] (M3e.RadioGroup.children [ Native.node Html.label [] [ M3e.Radio.view [ M3e.Radio.value "1" ] [], Kit.text "Option 1" ], Native.node Html.label [] [ M3e.Radio.view [ M3e.Radio.value "2" ] [], Kit.text "Option 2" ], Native.node Html.label [] [ M3e.Radio.view [ M3e.Radio.value "3" ] [], Kit.text "Option 3" ], Native.node Html.label [] [ M3e.Radio.view [ M3e.Radio.value "4" ] [], Kit.text "Option 4" ] ])
    ]
```

<!-- elm-cem:example title="Disabling" -->
```elm
[ Native.node Html.label [] [ Kit.text "Select an option" ]
    , Native.br
    , M3e.RadioGroup.view [] (M3e.RadioGroup.children [ Native.node Html.label [] [ M3e.Radio.view [ M3e.Radio.disabled True, M3e.Radio.value "1" ] [], Kit.text "Option 1" ], Native.node Html.label [] [ M3e.Radio.view [ M3e.Radio.value "2" ] [], Kit.text "Option 2" ], Native.node Html.label [] [ M3e.Radio.view [ M3e.Radio.value "3" ] [], Kit.text "Option 3" ], Native.node Html.label [] [ M3e.Radio.view [ M3e.Radio.value "4" ] [], Kit.text "Option 4" ] ])
    ]
```

<!-- elm-cem:example title="Disabling (2)" -->
```elm
[ Native.node Html.label [] [ Kit.text "Select an option" ]
    , Native.br
    , M3e.RadioGroup.view [ M3e.RadioGroup.disabled True ] (M3e.RadioGroup.children [ Native.node Html.label [] [ M3e.Radio.view [ M3e.Radio.value "1" ] [], Kit.text "Option 1" ], Native.node Html.label [] [ M3e.Radio.view [ M3e.Radio.value "2" ] [], Kit.text "Option 2" ], Native.node Html.label [] [ M3e.Radio.view [ M3e.Radio.value "3" ] [], Kit.text "Option 3" ], Native.node Html.label [] [ M3e.Radio.view [ M3e.Radio.value "4" ] [], Kit.text "Option 4" ] ])
    ]
```

<!-- elm-cem:example title="Required" -->
```elm
[ Native.node Html.label [] [ Kit.text "Select an option" ]
    , Native.br
    , M3e.RadioGroup.view [ M3e.RadioGroup.required True ] (M3e.RadioGroup.children [ Native.node Html.label [] [ M3e.Radio.view [ M3e.Radio.value "1" ] [], Kit.text "Option 1" ], Native.node Html.label [] [ M3e.Radio.view [ M3e.Radio.value "2" ] [], Kit.text "Option 2" ], Native.node Html.label [] [ M3e.Radio.view [ M3e.Radio.value "3" ] [], Kit.text "Option 3" ], Native.node Html.label [] [ M3e.Radio.view [ M3e.Radio.value "4" ] [], Kit.text "Option 4" ] ])
    ]
```

<!-- elm-cem:example title="Density" -->
```elm
[ Native.node Html.label [] [ M3e.Radio.view [] [], Kit.text "Density -3" ]
    , Native.node Html.label [] [ M3e.Radio.view [] [], Kit.text "Density -2" ]
    , Native.node Html.label [] [ M3e.Radio.view [] [], Kit.text "Density -1" ]
    , Native.node Html.label [] [ M3e.Radio.view [] [], Kit.text "Density 0" ]
    ]
```

@docs view, ariaInvalid, disabled, name, required, onBeforeinput
@docs onInput, onChange
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.RadioGroup
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-radio-group>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { ariaInvalid : M3e.Value.Supported
    , disabled : M3e.Value.Supported
    , name : M3e.Value.Supported
    , required : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | radioGroup : M3e.Value.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.RadioGroup.radioGroup
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Element.toNode children)
        )


{-| Set the `aria-invalid` attribute. -}
ariaInvalid :
    String -> M3e.Cem.Attr.Attr { c | ariaInvalid : M3e.Value.Supported } msg
ariaInvalid =
    M3e.Cem.RadioGroup.ariaInvalid


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.RadioGroup.disabled


{-| The name that identifies the element when submitting the associated form. -}
name : String -> M3e.Cem.Attr.Attr { c | name : M3e.Value.Supported } msg
name =
    M3e.Cem.RadioGroup.name


{-| Whether the element is required. (default: `false`) -}
required : Bool -> M3e.Cem.Attr.Attr { c | required : M3e.Value.Supported } msg
required =
    M3e.Cem.RadioGroup.required


{-| Listen for `beforeinput` events. -}
onBeforeinput :
    msg -> M3e.Cem.Attr.Attr { c | onBeforeinput : M3e.Value.Supported } msg
onBeforeinput =
    M3e.Cem.RadioGroup.onBeforeinput


{-| Listen for `input` events. -}
onInput : msg -> M3e.Cem.Attr.Attr { c | onInput : M3e.Value.Supported } msg
onInput =
    M3e.Cem.RadioGroup.onInput


{-| Listen for `change` events. -}
onChange : msg -> M3e.Cem.Attr.Attr { c | onChange : M3e.Value.Supported } msg
onChange =
    M3e.Cem.RadioGroup.onChange