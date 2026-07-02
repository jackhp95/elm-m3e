module M3e.Slider exposing
    ( view, disabled, discrete, labelled, max, min
    , step, size, onBeforeinput, onInput, onChange, child, children
    )

{-|
Allows for the selection of numeric values from a range.

**Events:**
- `beforeinput`: Dispatched before the value of a thumb changes.
- `input`: Dispatched when the value of a thumb changes.
- `change`: Dispatched when the value of a thumb changes.

@docs view, disabled, discrete, labelled, max, min
@docs step, size, onBeforeinput, onInput, onChange, child
@docs children
-}


import M3e.Cem.Attr
import M3e.Cem.Slider
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-slider>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , discrete : M3e.Value.Supported
    , labelled : M3e.Value.Supported
    , max : M3e.Value.Supported
    , min : M3e.Value.Supported
    , step : M3e.Value.Supported
    , size : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | slider : M3e.Value.Supported } msg
view attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.Slider.slider (List.map M3e.Cem.Attr.forget erased) ch
             )
             (List.map M3e.Cem.Attr.forget attributes)
             (List.map M3e.Content.toNode content_)
        )


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.Slider.disabled


{-| Whether to show tick marks. (default: `false`) -}
discrete : Bool -> M3e.Cem.Attr.Attr { c | discrete : M3e.Value.Supported } msg
discrete =
    M3e.Cem.Slider.discrete


{-| Whether to show value labels when activated. (default: `false`) -}
labelled : Bool -> M3e.Cem.Attr.Attr { c | labelled : M3e.Value.Supported } msg
labelled =
    M3e.Cem.Slider.labelled


{-| The maximum allowable value. (default: `100`) -}
max : Float -> M3e.Cem.Attr.Attr { c | max : M3e.Value.Supported } msg
max =
    M3e.Cem.Slider.max


{-| The minimum allowable value. (default: `0`) -}
min : Float -> M3e.Cem.Attr.Attr { c | min : M3e.Value.Supported } msg
min =
    M3e.Cem.Slider.min


{-| The value at which the thumb will snap. (default: `1`) -}
step : Float -> M3e.Cem.Attr.Attr { c | step : M3e.Value.Supported } msg
step =
    M3e.Cem.Slider.step


{-| The size of the slider. (default: `"extra-small"`) -}
size :
    M3e.Value.Value { extraLarge : M3e.Value.Supported
    , extraSmall : M3e.Value.Supported
    , large : M3e.Value.Supported
    , medium : M3e.Value.Supported
    , small : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | size : M3e.Value.Supported } msg
size =
    M3e.Cem.Slider.size


{-| Listen for `beforeinput` events. -}
onBeforeinput :
    msg -> M3e.Cem.Attr.Attr { c | onBeforeinput : M3e.Value.Supported } msg
onBeforeinput =
    M3e.Cem.Slider.onBeforeinput


{-| Listen for `input` events. -}
onInput : msg -> M3e.Cem.Attr.Attr { c | onInput : M3e.Value.Supported } msg
onInput =
    M3e.Cem.Slider.onInput


{-| Listen for `change` events. -}
onChange : msg -> M3e.Cem.Attr.Attr { c | onChange : M3e.Value.Supported } msg
onChange =
    M3e.Cem.Slider.onChange


{-| Place content in the `(default)` slot. -}
child :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
child el =
    M3e.Content.slot "" el


{-| Place many elements in the default slot. -}
children :
    List (M3e.Element.Element any msg)
    -> List (M3e.Content.Content { r | default : M3e.Value.Supported } msg)
children els =
    List.map (M3e.Content.slot "") els