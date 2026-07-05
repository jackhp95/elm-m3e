module M3e.Radio exposing
    ( view, checked, disabled, name, required, value
    , onBeforeinput, onInput, onChange, onClick
    )

{-|
A radio button that allows a user to select one option from a set of options.

**Component Info:**
- **Extends:** `LitElement`

**Events:**
- `beforeinput`: Dispatched before the checked state changes.
- `input`: Dispatched when the checked state changes.
- `change`: Dispatched when the checked state changes.
- `click`: Dispatched when the element is clicked.

@docs view, checked, disabled, name, required, value
@docs onBeforeinput, onInput, onChange, onClick
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.Radio
import M3e.Content
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-radio>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { checked : M3e.Value.Supported
    , disabled : M3e.Value.Supported
    , name : M3e.Value.Supported
    , required : M3e.Value.Supported
    , value : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content {} msg)
    -> M3e.Element.Element { s | radio : M3e.Value.Supported } msg
view attributes content_ =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.Radio.radio
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Content.toNode content_)
        )


{-| Whether the element is checked. (default: `false`) -}
checked : Bool -> M3e.Cem.Attr.Attr { c | checked : M3e.Value.Supported } msg
checked =
    M3e.Cem.Radio.checked


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.Radio.disabled


{-| The name that identifies the element when submitting the associated form. -}
name : String -> M3e.Cem.Attr.Attr { c | name : M3e.Value.Supported } msg
name =
    M3e.Cem.Radio.name


{-| Whether the element is required. -}
required : Bool -> M3e.Cem.Attr.Attr { c | required : M3e.Value.Supported } msg
required =
    M3e.Cem.Radio.required


{-| A string representing the value of the radio. (default: `"on"`) -}
value : String -> M3e.Cem.Attr.Attr { c | value : M3e.Value.Supported } msg
value =
    M3e.Cem.Radio.value


{-| Listen for `beforeinput` events. -}
onBeforeinput :
    (Bool -> msg)
    -> M3e.Cem.Attr.Attr { c | onBeforeinput : M3e.Value.Supported } msg
onBeforeinput =
    M3e.Cem.Radio.onBeforeinput


{-| Listen for `input` events. -}
onInput :
    (Bool -> msg) -> M3e.Cem.Attr.Attr { c | onInput : M3e.Value.Supported } msg
onInput =
    M3e.Cem.Radio.onInput


{-| Listen for `change` events. -}
onChange :
    (Bool -> msg)
    -> M3e.Cem.Attr.Attr { c | onChange : M3e.Value.Supported } msg
onChange =
    M3e.Cem.Radio.onChange


{-| Listen for `click` events. -}
onClick : msg -> M3e.Cem.Attr.Attr { c | onClick : M3e.Value.Supported } msg
onClick =
    M3e.Cem.Radio.onClick