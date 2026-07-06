module M3e.Select exposing
    ( view, disabled, hideSelectionIndicator, multi, name, panelClass
    , required, onChange, onToggle, onBeforeinput, onInput, child, arrow
    , value, children
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
M3e.FormField.view [] [ M3e.FormField.label "select" (Native.node Html.label [] [ Kit.text "Favorite fruit" ]), M3e.FormField.child "select" (M3e.Select.view [] (M3e.Select.children [ M3e.Option.view [] [ M3e.Option.child (Kit.text "Apples") ], M3e.Option.view [] [ M3e.Option.child (Kit.text "Oranges") ], M3e.Option.view [] [ M3e.Option.child (Kit.text "Bananas") ], M3e.Option.view [] [ M3e.Option.child (Kit.text "Grapes") ] ])) ]
```

<!-- elm-cem:example title="Empty options" -->
```elm
M3e.FormField.view [] [ M3e.FormField.label "select" (Native.node Html.label [] [ Kit.text "Favorite fruit" ]), M3e.FormField.child "select" (M3e.Select.view [] (M3e.Select.children [ M3e.Option.view [ M3e.Option.value "" ] [ M3e.Option.child (Kit.text "None") ], M3e.Option.view [] [ M3e.Option.child (Kit.text "Apples") ], M3e.Option.view [] [ M3e.Option.child (Kit.text "Oranges") ], M3e.Option.view [] [ M3e.Option.child (Kit.text "Bananas") ], M3e.Option.view [] [ M3e.Option.child (Kit.text "Grapes") ] ])) ]
```

<!-- elm-cem:example title="Selection" -->
```elm
M3e.FormField.view [] [ M3e.FormField.label "select" (Native.node Html.label [] [ Kit.text "Toppings" ]), M3e.FormField.child "select" (M3e.Select.view [ M3e.Select.multi True ] (M3e.Select.children [ M3e.Option.view [ M3e.Option.selected True ] [ M3e.Option.child (Kit.text "Extra cheese") ], M3e.Option.view [ M3e.Option.selected True ] [ M3e.Option.child (Kit.text "Mushroom") ] ])) ]
```

<!-- elm-cem:example title="Disabling" -->
```elm
M3e.FormField.view [] [ M3e.FormField.label "select" (Native.node Html.label [] [ Kit.text "Favorite fruit" ]), M3e.FormField.child "select" (M3e.Select.view [ M3e.Select.disabled True ] [ M3e.Select.child (M3e.Option.view [ M3e.Option.selected True ] [ M3e.Option.child (Kit.text "Apples") ]) ]) ]
```

<!-- elm-cem:example title="Disabling (2)" -->
```elm
M3e.FormField.view [] [ M3e.FormField.label "select" (Native.node Html.label [] [ Kit.text "Favorite fruit" ]), M3e.FormField.child "select" (M3e.Select.view [] [ M3e.Select.child (M3e.Option.view [ M3e.Option.disabled True ] [ M3e.Option.child (Kit.text "Apples") ]) ]) ]
```

<!-- elm-cem:example title="Required" -->
```elm
M3e.FormField.view [] [ M3e.FormField.label "select" (Native.node Html.label [] [ Kit.text "Favorite fruit" ]), M3e.FormField.child "select" (M3e.Select.view [ M3e.Select.required True ] (M3e.Select.children [ M3e.Option.view [ M3e.Option.value "" ] [ M3e.Option.child (Kit.text "None") ], M3e.Option.view [] [ M3e.Option.child (Kit.text "Apples") ] ])) ]
```

<!-- elm-cem:example title="Density" -->
```elm
M3e.FormField.view [] [ M3e.FormField.label "select" (Native.node Html.label [] [ Kit.text "Density -3" ]), M3e.FormField.child "select" (M3e.Select.view [ M3e.Select.panelClass "density-3" ] []) ]
```

@docs view, disabled, hideSelectionIndicator, multi, name, panelClass
@docs required, onChange, onToggle, onBeforeinput, onInput, child
@docs arrow, value, children
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.Select
import M3e.Content
import M3e.Content.Internal
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
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , arrow : M3e.Value.Supported
    , value : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | select : M3e.Value.Supported } msg
view attributes content_ =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.Select.select
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Content.toNode content_)
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


{-| Place content in the `(default)` slot. -}
child :
    M3e.Element.Element { option : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
child el =
    M3e.Content.Internal.slot "" el


{-| Place content in the `arrow` slot. -}
arrow :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | arrow : M3e.Value.Supported } msg
arrow el =
    M3e.Content.Internal.slot "arrow" el


{-| Place content in the `value` slot. -}
value :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | value : M3e.Value.Supported } msg
value el =
    M3e.Content.Internal.slot "value" el


{-| Place many elements in the default slot. -}
children :
    List (M3e.Element.Element { option : M3e.Value.Supported } msg)
    -> List (M3e.Content.Content { r | default : M3e.Value.Supported } msg)
children els =
    List.map (M3e.Content.Internal.slot "") els