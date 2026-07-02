module M3e.Select exposing
    ( view, disabled, hideSelectionIndicator, multi, name, panelClass
    , required, onChange, onToggle, onBeforeinput, onInput, child, arrow
    , value, children
    )

{-|
A form control that allows users to select a value from a set of predefined options.

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

<!-- elm-cem:example title="Multi-select languages with custom arrow" -->
```elm
M3e.Select.view [ M3e.Select.multi True, M3e.Select.name "languages" ] ([ M3e.Select.arrow (M3e.Icon.view [ M3e.Icon.name "expand_more" ] []) ] ++ M3e.Select.children [ M3e.Option.view { content = Kit.text "JavaScript" } [ M3e.Option.value "javascript" ] [], M3e.Option.view { content = Kit.text "TypeScript" } [ M3e.Option.value "typescript" ] [], M3e.Option.view { content = Kit.text "Python" } [ M3e.Option.value "python" ] [], M3e.Option.view { content = Kit.text "Rust" } [ M3e.Option.value "rust" ] [] ])
```

@docs view, disabled, hideSelectionIndicator, multi, name, panelClass
@docs required, onChange, onToggle, onBeforeinput, onInput, child
@docs arrow, value, children
-}


import M3e.Cem.Attr
import M3e.Cem.Select
import M3e.Content
import M3e.Element
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
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.Select.select (List.map M3e.Cem.Attr.forget erased) ch
             )
             (List.map M3e.Cem.Attr.forget attributes)
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
onToggle : msg -> M3e.Cem.Attr.Attr { c | onToggle : M3e.Value.Supported } msg
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
    M3e.Content.slot "" el


{-| Place content in the `arrow` slot. -}
arrow :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | arrow : M3e.Value.Supported } msg
arrow el =
    M3e.Content.slot "arrow" el


{-| Place content in the `value` slot. -}
value :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | value : M3e.Value.Supported } msg
value el =
    M3e.Content.slot "value" el


{-| Place many elements in the default slot. -}
children :
    List (M3e.Element.Element { option : M3e.Value.Supported } msg)
    -> List (M3e.Content.Content { r | default : M3e.Value.Supported } msg)
children els =
    List.map (M3e.Content.slot "") els