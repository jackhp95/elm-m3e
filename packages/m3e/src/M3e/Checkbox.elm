module M3e.Checkbox exposing
    ( view, checked, disabled, indeterminate, name, required
    , value, onBeforeinput, onInput, onChange, onInvalid, onClick
    )

{-|
A checkbox that allows a user to select one or more options from a limited number of choices.

**Component Info:**
- **Extends:** `LitElement`

**Events:**
- `beforeinput`: Dispatched before the checked state changes.
- `input`: Dispatched when the checked state changes.
- `change`: Dispatched when the checked state changes.
- `invalid`: Dispatched when a form is submitted and the element fails constraint validation.
- `click`: Dispatched when the element is clicked.

<!-- elm-cem:docmeta category=Selection -->

## Examples

### Examples

<!-- elm-cem:example title="Notification preferences with required terms" -->
```elm
Native.section [] [ Native.p [] [ Kit.text "Email notifications" ], Native.node Html.label [] [ M3e.Checkbox.view [ M3e.Checkbox.checked True, M3e.Checkbox.name "news", M3e.Checkbox.value "newsletter" ] [], Kit.text "Product newsletter" ], Native.node Html.label [] [ M3e.Checkbox.view [ M3e.Checkbox.name "offers", M3e.Checkbox.value "offers" ] [], Kit.text "Special offers" ], Native.node Html.label [] [ M3e.Checkbox.view [ M3e.Checkbox.indeterminate True, M3e.Checkbox.name "digest", M3e.Checkbox.value "digest" ] [], Kit.text "Weekly digest" ], M3e.Divider.view [] [], Native.node Html.label [] [ M3e.Checkbox.view [ M3e.Checkbox.required True, M3e.Checkbox.name "terms", M3e.Checkbox.value "accepted" ] [], Kit.text "I accept the terms of service" ] ]
```

<!-- elm-cem:example title="Single checkbox with external label" -->
```elm
Native.div [] [ M3e.Checkbox.view [ M3e.Checkbox.checked True, M3e.Checkbox.name "remember", M3e.Checkbox.value "yes" ] [], Native.node Html.label [] [ Kit.text "Remember me on this device" ] ]
```

@docs view, checked, disabled, indeterminate, name, required
@docs value, onBeforeinput, onInput, onChange, onInvalid, onClick
-}


import M3e.Cem.Attr
import M3e.Cem.Checkbox
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-checkbox>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { checked : M3e.Value.Supported
    , disabled : M3e.Value.Supported
    , indeterminate : M3e.Value.Supported
    , name : M3e.Value.Supported
    , required : M3e.Value.Supported
    , value : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onInvalid : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content {} msg)
    -> M3e.Element.Element { s | checkbox : M3e.Value.Supported } msg
view attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.Checkbox.checkbox
                      (List.map M3e.Cem.Attr.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.forget attributes)
             (List.map M3e.Content.toNode content_)
        )


{-| Whether the element is checked. (default: `false`) -}
checked : Bool -> M3e.Cem.Attr.Attr { c | checked : M3e.Value.Supported } msg
checked =
    M3e.Cem.Checkbox.checked


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.Checkbox.disabled


{-| Whether the element's checked state is indeterminate. (default: `false`) -}
indeterminate :
    Bool -> M3e.Cem.Attr.Attr { c | indeterminate : M3e.Value.Supported } msg
indeterminate =
    M3e.Cem.Checkbox.indeterminate


{-| The name that identifies the element when submitting the associated form. -}
name : String -> M3e.Cem.Attr.Attr { c | name : M3e.Value.Supported } msg
name =
    M3e.Cem.Checkbox.name


{-| Whether the element is required. (default: `false`) -}
required : Bool -> M3e.Cem.Attr.Attr { c | required : M3e.Value.Supported } msg
required =
    M3e.Cem.Checkbox.required


{-| A string representing the value of the checkbox. (default: `"on"`) -}
value : String -> M3e.Cem.Attr.Attr { c | value : M3e.Value.Supported } msg
value =
    M3e.Cem.Checkbox.value


{-| Listen for `beforeinput` events. -}
onBeforeinput :
    (Bool -> msg)
    -> M3e.Cem.Attr.Attr { c | onBeforeinput : M3e.Value.Supported } msg
onBeforeinput =
    M3e.Cem.Checkbox.onBeforeinput


{-| Listen for `input` events. -}
onInput :
    (Bool -> msg) -> M3e.Cem.Attr.Attr { c | onInput : M3e.Value.Supported } msg
onInput =
    M3e.Cem.Checkbox.onInput


{-| Listen for `change` events. -}
onChange :
    (Bool -> msg)
    -> M3e.Cem.Attr.Attr { c | onChange : M3e.Value.Supported } msg
onChange =
    M3e.Cem.Checkbox.onChange


{-| Listen for `invalid` events. -}
onInvalid : msg -> M3e.Cem.Attr.Attr { c | onInvalid : M3e.Value.Supported } msg
onInvalid =
    M3e.Cem.Checkbox.onInvalid


{-| Listen for `click` events. -}
onClick : msg -> M3e.Cem.Attr.Attr { c | onClick : M3e.Value.Supported } msg
onClick =
    M3e.Cem.Checkbox.onClick