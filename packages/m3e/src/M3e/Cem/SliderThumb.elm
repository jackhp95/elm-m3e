module M3e.Cem.SliderThumb exposing
    ( sliderThumb, disabled, name, value, onValueChange, onBeforeinput
    , onInput, onChange, onClick
    )

{-|
Middle layer for `<m3e-slider-thumb>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.SliderThumb` module for everyday use.

@docs sliderThumb, disabled, name, value, onValueChange, onBeforeinput
@docs onInput, onChange, onClick
-}


import Html
import Json.Decode
import M3e.Cem.Attr
import M3e.Cem.Html.SliderThumb
import M3e.Value


{-| A thumb used to select a value in a slider.

**Component Info:**
- **Extends:** `LitElement`

**Events:**
- `value-change`: No description
- `beforeinput`: Dispatched before the value changes.
- `input`: Dispatched when the value changes.
- `change`: Dispatched when the value changes.
- `click`: Dispatched when the element is clicked.
-}
sliderThumb :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , name : M3e.Value.Supported
    , value : M3e.Value.Supported
    , onValueChange : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
sliderThumb attributes children =
    M3e.Cem.Html.SliderThumb.sliderThumb
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.Attr.attribute M3e.Cem.Html.SliderThumb.disabled


{-| The name that identifies the element when submitting the associated form. -}
name : String -> M3e.Cem.Attr.Attr { c | name : M3e.Value.Supported } msg
name =
    M3e.Cem.Attr.attribute M3e.Cem.Html.SliderThumb.name


{-| The value of the thumb. (default: `null`) -}
value : Float -> M3e.Cem.Attr.Attr { c | value : M3e.Value.Supported } msg
value =
    M3e.Cem.Attr.attribute M3e.Cem.Html.SliderThumb.value


{-| Listen for `value-change` events. -}
onValueChange :
    msg -> M3e.Cem.Attr.Attr { c | onValueChange : M3e.Value.Supported } msg
onValueChange f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.SliderThumb.onValueChange
        (Json.Decode.succeed f_)


{-| Listen for `beforeinput` events. -}
onBeforeinput :
    msg -> M3e.Cem.Attr.Attr { c | onBeforeinput : M3e.Value.Supported } msg
onBeforeinput f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.SliderThumb.onBeforeinput
        (Json.Decode.succeed f_)


{-| Listen for `input` events. -}
onInput : msg -> M3e.Cem.Attr.Attr { c | onInput : M3e.Value.Supported } msg
onInput f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.SliderThumb.onInput
        (Json.Decode.succeed f_)


{-| Listen for `change` events. -}
onChange : msg -> M3e.Cem.Attr.Attr { c | onChange : M3e.Value.Supported } msg
onChange f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.SliderThumb.onChange
        (Json.Decode.succeed f_)


{-| Listen for `click` events. -}
onClick : msg -> M3e.Cem.Attr.Attr { c | onClick : M3e.Value.Supported } msg
onClick f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.SliderThumb.onClick
        (Json.Decode.succeed f_)