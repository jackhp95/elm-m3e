module M3e.Select exposing
    ( view, disabled, hideSelectionIndicator, multi, name, panelClass
    , required, onChange, onToggle, onBeforeinput, onInput, arrow, value
    )

{-|
A form control that allows users to select a value from a set of predefined options.

**Component Info:**
- **Extends:** `LitElement`

**Events:**
- `change`: Dispatched when the selected state changes.
- `toggle`: No description
- `beforeinput`: Dispatched before the selected state changes.
- `input`: Dispatched when the selected state changes.

**Slots:**
- `arrow`: Renders the dropdown arrow.
- `value`: Renders the selected value(s).

<!-- elm-cem:docmeta category=Text inputs -->

## Examples

### Examples

<!-- elm-cem:example title="Basic usage" -->
```elm
M3e.FormField.view [] [ M3e.FormField.label "select1" (Native.node Html.label [ Native.attribute "for" "select1" ] [ Kit.text "Favorite fruit" ]), M3e.FormField.control "select1" (M3e.Select.view [] [ M3e.Option.view [] [ Kit.text "Apples" ], M3e.Option.view [] [ Kit.text "Oranges" ], M3e.Option.view [] [ Kit.text "Bananas" ], M3e.Option.view [] [ Kit.text "Grapes" ] ]) ]
```

<!-- elm-cem:example title="Empty options" -->
```elm
M3e.FormField.view [] [ M3e.FormField.label "select2" (Native.node Html.label [ Native.attribute "for" "select2" ] [ Kit.text "Favorite fruit" ]), M3e.FormField.control "select2" (M3e.Select.view [] [ M3e.Option.view [ M3e.Option.value "" ] [ Kit.text "None" ], M3e.Option.view [] [ Kit.text "Apples" ], M3e.Option.view [] [ Kit.text "Oranges" ], M3e.Option.view [] [ Kit.text "Bananas" ], M3e.Option.view [] [ Kit.text "Grapes" ] ]) ]
```

<!-- elm-cem:example title="Selection" -->
```elm
M3e.FormField.view [] [ M3e.FormField.label "select4" (Native.node Html.label [ Native.attribute "for" "select4" ] [ Kit.text "Toppings" ]), M3e.FormField.control "select4" (M3e.Select.view [ M3e.Select.multi True ] [ M3e.Option.view [ M3e.Option.selected True ] [ Kit.text "Extra cheese" ], M3e.Option.view [ M3e.Option.selected True ] [ Kit.text "Mushroom" ], M3e.Option.view [] [ Kit.text "Onion" ], M3e.Option.view [] [ Kit.text "Pepperoni" ], M3e.Option.view [] [ Kit.text "Sausage" ], M3e.Option.view [] [ Kit.text "Tomato" ] ]) ]
```

<!-- elm-cem:example title="Disabling" -->
```elm
M3e.FormField.view [] [ M3e.FormField.label "select5" (Native.node Html.label [ Native.attribute "for" "select5" ] [ Kit.text "Favorite fruit" ]), M3e.FormField.control "select5" (M3e.Select.view [ M3e.Select.disabled True ] [ M3e.Option.view [ M3e.Option.selected True ] [ Kit.text "Apples" ], M3e.Option.view [] [ Kit.text "Oranges" ], M3e.Option.view [] [ Kit.text "Bananas" ], M3e.Option.view [] [ Kit.text "Grapes" ] ]) ]
```

<!-- elm-cem:example title="Disabling (2)" -->
```elm
M3e.FormField.view [] [ M3e.FormField.label "select6" (Native.node Html.label [ Native.attribute "for" "select6" ] [ Kit.text "Favorite fruit" ]), M3e.FormField.control "select6" (M3e.Select.view [] [ M3e.Option.view [ M3e.Option.disabled True ] [ Kit.text "Apples" ], M3e.Option.view [] [ Kit.text "Oranges" ], M3e.Option.view [] [ Kit.text "Bananas" ], M3e.Option.view [] [ Kit.text "Grapes" ] ]) ]
```

<!-- elm-cem:example title="Required" -->
```elm
M3e.FormField.view [] [ M3e.FormField.label "select7" (Native.node Html.label [ Native.attribute "for" "select7" ] [ Kit.text "Favorite fruit" ]), M3e.FormField.control "select7" (M3e.Select.view [ M3e.Select.required True ] [ M3e.Option.view [ M3e.Option.value "" ] [ Kit.text "None" ], M3e.Option.view [] [ Kit.text "Apples" ], M3e.Option.view [] [ Kit.text "Oranges" ], M3e.Option.view [] [ Kit.text "Bananas" ], M3e.Option.view [] [ Kit.text "Grapes" ] ]) ]
```

<!-- elm-cem:example title="Density" -->
```elm
[ M3e.FormField.view [] [ M3e.FormField.label "ds1" (Native.node Html.label [ Native.attribute "for" "ds1" ] [ Kit.text "Density -3" ]), M3e.FormField.control "ds1" (M3e.Select.view [ M3e.Select.panelClass "density-3" ] [ M3e.Option.view [] [ Kit.text "Apples" ], M3e.Option.view [] [ Kit.text "Oranges" ], M3e.Option.view [] [ Kit.text "Bananas" ], M3e.Option.view [] [ Kit.text "Grapes" ] ]) ]
    , M3e.FormField.view [] [ M3e.FormField.label "ds2" (Native.node Html.label [ Native.attribute "for" "ds2" ] [ Kit.text "Density -2" ]), M3e.FormField.control "ds2" (M3e.Select.view [ M3e.Select.panelClass "density-2" ] [ M3e.Option.view [] [ Kit.text "Apples" ], M3e.Option.view [] [ Kit.text "Oranges" ], M3e.Option.view [] [ Kit.text "Bananas" ], M3e.Option.view [] [ Kit.text "Grapes" ] ]) ]
    , M3e.FormField.view [] [ M3e.FormField.label "ds3" (Native.node Html.label [ Native.attribute "for" "ds3" ] [ Kit.text "Density -1" ]), M3e.FormField.control "ds3" (M3e.Select.view [ M3e.Select.panelClass "density-1" ] [ M3e.Option.view [] [ Kit.text "Apples" ], M3e.Option.view [] [ Kit.text "Oranges" ], M3e.Option.view [] [ Kit.text "Bananas" ], M3e.Option.view [] [ Kit.text "Grapes" ] ]) ]
    , M3e.FormField.view [] [ M3e.FormField.label "ds4" (Native.node Html.label [ Native.attribute "for" "ds4" ] [ Kit.text "Density 0" ]), M3e.FormField.control "ds4" (M3e.Select.view [ M3e.Select.panelClass "density-0" ] [ M3e.Option.view [] [ Kit.text "Apples" ], M3e.Option.view [] [ Kit.text "Oranges" ], M3e.Option.view [] [ Kit.text "Bananas" ], M3e.Option.view [] [ Kit.text "Grapes" ] ]) ]
    ]
```

@docs view, disabled, hideSelectionIndicator, multi, name, panelClass
@docs required, onChange, onToggle, onBeforeinput, onInput, arrow
@docs value
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.Select
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-select>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , hideSelectionIndicator : M3e.Value.Supported
    , multi : M3e.Value.Supported
    , name : M3e.Value.Supported
    , panelClass : M3e.Value.Supported
    , required : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onToggle : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element { option : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | select : M3e.Value.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.Select.select
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Element.toNode children)
        )


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.Select.disabled


{-| Whether to hide the selection indicator for single select options. (default: `false`) -}
hideSelectionIndicator :
    Bool
    -> M3e.Cem.Attr.Attr { c
        | hideSelectionIndicator : M3e.Value.Supported
    } msg
hideSelectionIndicator =
    M3e.Cem.Select.hideSelectionIndicator


{-| Whether multiple options can be selected. (default: `false`) -}
multi : Bool -> M3e.Cem.Attr.Attr { c | multi : M3e.Value.Supported } msg
multi =
    M3e.Cem.Select.multi


{-| The name that identifies the element when submitting the associated form. -}
name : String -> M3e.Cem.Attr.Attr { c | name : M3e.Value.Supported } msg
name =
    M3e.Cem.Select.name


{-| Class or list of classes to be applied to the select's overlay panel. (default: `""`) -}
panelClass :
    String -> M3e.Cem.Attr.Attr { c | panelClass : M3e.Value.Supported } msg
panelClass =
    M3e.Cem.Select.panelClass


{-| Whether the element is required. (default: `false`) -}
required : Bool -> M3e.Cem.Attr.Attr { c | required : M3e.Value.Supported } msg
required =
    M3e.Cem.Select.required


{-| Listen for `change` events. -}
onChange : msg -> M3e.Cem.Attr.Attr { c | onChange : M3e.Value.Supported } msg
onChange =
    M3e.Cem.Select.onChange


{-| Listen for `toggle` events. -}
onToggle :
    (String -> msg)
    -> M3e.Cem.Attr.Attr { c | onToggle : M3e.Value.Supported } msg
onToggle =
    M3e.Cem.Select.onToggle


{-| Listen for `beforeinput` events. -}
onBeforeinput :
    msg -> M3e.Cem.Attr.Attr { c | onBeforeinput : M3e.Value.Supported } msg
onBeforeinput =
    M3e.Cem.Select.onBeforeinput


{-| Listen for `input` events. -}
onInput : msg -> M3e.Cem.Attr.Attr { c | onInput : M3e.Value.Supported } msg
onInput =
    M3e.Cem.Select.onInput


{-| Place content in the `arrow` slot. -}
arrow :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Element.Element k msg
arrow el =
    M3e.Element.Internal.placeSlot "arrow" el


{-| Place content in the `value` slot. -}
value : M3e.Element.Element any msg -> M3e.Element.Element k msg
value el =
    M3e.Element.Internal.placeSlot "value" el