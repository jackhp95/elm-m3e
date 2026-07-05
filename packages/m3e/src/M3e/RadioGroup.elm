module M3e.RadioGroup exposing
    ( view, ariaInvalid, disabled, name, required, onBeforeinput
    , onInput, onChange, child, children
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

<!-- elm-cem:example title="Single-choice shipping options" -->
```elm
[ Native.node Html.label [] [ Kit.text "Shipping method" ]
    , Native.br
    , M3e.RadioGroup.view [ M3e.RadioGroup.name "shipping", M3e.RadioGroup.required True ] (M3e.RadioGroup.children [ Native.node Html.label [] [ M3e.Radio.view [ M3e.Radio.value "standard", M3e.Radio.checked True ] [], Kit.text "Standard (5-7 days)" ], Native.node Html.label [] [ M3e.Radio.view [ M3e.Radio.value "express" ] [], Kit.text "Express (2 days)" ], Native.node Html.label [] [ M3e.Radio.view [ M3e.Radio.value "overnight" ] [], Kit.text "Overnight" ] ])
    ]
```

<!-- elm-cem:example title="Disabled radio group with one disabled option" -->
```elm
M3e.RadioGroup.view [ M3e.RadioGroup.name "plan", M3e.RadioGroup.disabled True ] (M3e.RadioGroup.children [ Native.node Html.label [] [ M3e.Radio.view [ M3e.Radio.value "free", M3e.Radio.checked True ] [], Kit.text "Free" ], Native.node Html.label [] [ M3e.Radio.view [ M3e.Radio.value "pro" ] [], Kit.text "Pro" ], Native.node Html.label [] [ M3e.Radio.view [ M3e.Radio.value "team", M3e.Radio.disabled True ] [], Kit.text "Team" ] ])
```

@docs view, ariaInvalid, disabled, name, required, onBeforeinput
@docs onInput, onChange, child, children
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.RadioGroup
import M3e.Content
import M3e.Content.Internal
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
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | radioGroup : M3e.Value.Supported } msg
view attributes content_ =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.RadioGroup.radioGroup
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Content.toNode content_)
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


{-| Place content in the `(default)` slot. -}
child :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
child el =
    M3e.Content.Internal.slot "" el


{-| Place many elements in the default slot. -}
children :
    List (M3e.Element.Element any msg)
    -> List (M3e.Content.Content { r | default : M3e.Value.Supported } msg)
children els =
    List.map (M3e.Content.Internal.slot "") els