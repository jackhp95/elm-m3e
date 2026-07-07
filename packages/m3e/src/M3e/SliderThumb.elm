module M3e.SliderThumb exposing
    ( view, disabled, name, value, onValueChange, onBeforeinput
    , onInput, onChange, onClick
    )

{-|
A thumb used to select a value in a slider.

**Component Info:**
- **Extends:** `LitElement`

**Events:**
- `value-change`: No description
- `beforeinput`: Dispatched before the value changes.
- `input`: Dispatched when the value changes.
- `change`: Dispatched when the value changes.
- `click`: Dispatched when the element is clicked.

@docs view, disabled, name, value, onValueChange, onBeforeinput
@docs onInput, onChange, onClick
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.SliderThumb
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-slider-thumb>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , name : M3e.Value.Supported
    , valueFloat : M3e.Value.Supported
    , onValueChange : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | sliderThumb : M3e.Value.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.SliderThumb.sliderThumb
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Element.toNode children)
        )


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.SliderThumb.disabled


{-| The name that identifies the element when submitting the associated form. -}
name : String -> M3e.Cem.Attr.Attr { c | name : M3e.Value.Supported } msg
name =
    M3e.Cem.SliderThumb.name


{-| The value of the thumb. (default: `null`) -}
value : Float -> M3e.Cem.Attr.Attr { c | valueFloat : M3e.Value.Supported } msg
value =
    M3e.Cem.SliderThumb.value


{-| Listen for `value-change` events. -}
onValueChange :
    msg -> M3e.Cem.Attr.Attr { c | onValueChange : M3e.Value.Supported } msg
onValueChange =
    M3e.Cem.SliderThumb.onValueChange


{-| Listen for `beforeinput` events. -}
onBeforeinput :
    msg -> M3e.Cem.Attr.Attr { c | onBeforeinput : M3e.Value.Supported } msg
onBeforeinput =
    M3e.Cem.SliderThumb.onBeforeinput


{-| Listen for `input` events. -}
onInput : msg -> M3e.Cem.Attr.Attr { c | onInput : M3e.Value.Supported } msg
onInput =
    M3e.Cem.SliderThumb.onInput


{-| Listen for `change` events. -}
onChange : msg -> M3e.Cem.Attr.Attr { c | onChange : M3e.Value.Supported } msg
onChange =
    M3e.Cem.SliderThumb.onChange


{-| Listen for `click` events. -}
onClick : msg -> M3e.Cem.Attr.Attr { c | onClick : M3e.Value.Supported } msg
onClick =
    M3e.Cem.SliderThumb.onClick