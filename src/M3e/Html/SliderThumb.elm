module M3e.Html.SliderThumb exposing
    ( sliderThumb, disabled, name, value, onValueChange, onBeforeinput
    , onInput, onChange, onClick
    )

{-| Middle layer for `<m3e-slider-thumb>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.SliderThumb` module for everyday use.

@docs sliderThumb, disabled, name, value, onValueChange, onBeforeinput
@docs onInput, onChange, onClick

-}

import Html
import Json.Decode
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Raw.SliderThumb
import M3e.Token


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
    List
        (M3e.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , name : M3e.Token.Supported
            , valueFloat : M3e.Token.Supported
            , onValueChange : M3e.Token.Supported
            , onBeforeinput : M3e.Token.Supported
            , onInput : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , onClick : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
sliderThumb attributes children =
    M3e.Raw.SliderThumb.sliderThumb
        (List.map M3e.Html.Attr.toAttribute attributes)
        children


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> M3e.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    M3e.Html.Attr.Internal.attribute M3e.Raw.SliderThumb.disabled


{-| The name that identifies the element when submitting the associated form.
-}
name : String -> M3e.Html.Attr.Attr { c | name : M3e.Token.Supported } msg
name =
    M3e.Html.Attr.Internal.attribute M3e.Raw.SliderThumb.name


{-| The value of the thumb. (default: `null`)
-}
value : Float -> M3e.Html.Attr.Attr { c | valueFloat : M3e.Token.Supported } msg
value =
    M3e.Html.Attr.Internal.attribute M3e.Raw.SliderThumb.value


{-| Listen for `value-change` events.
-}
onValueChange : msg -> M3e.Html.Attr.Attr { c | onValueChange : M3e.Token.Supported } msg
onValueChange f_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.SliderThumb.onValueChange
        (Json.Decode.succeed f_)


{-| Listen for `beforeinput` events.
-}
onBeforeinput : msg -> M3e.Html.Attr.Attr { c | onBeforeinput : M3e.Token.Supported } msg
onBeforeinput f_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.SliderThumb.onBeforeinput
        (Json.Decode.succeed f_)


{-| Listen for `input` events.
-}
onInput : msg -> M3e.Html.Attr.Attr { c | onInput : M3e.Token.Supported } msg
onInput f_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.SliderThumb.onInput
        (Json.Decode.succeed f_)


{-| Listen for `change` events.
-}
onChange : msg -> M3e.Html.Attr.Attr { c | onChange : M3e.Token.Supported } msg
onChange f_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.SliderThumb.onChange
        (Json.Decode.succeed f_)


{-| Listen for `click` events.
-}
onClick : msg -> M3e.Html.Attr.Attr { c | onClick : M3e.Token.Supported } msg
onClick f_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.SliderThumb.onClick
        (Json.Decode.succeed f_)
