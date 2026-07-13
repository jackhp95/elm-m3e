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
import M3e.Raw.SliderThumb
import M3e.Token
import Markup.Html.Attr
import Markup.Html.Attr.Internal


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
        (Markup.Html.Attr.Attr
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
        (List.map Markup.Html.Attr.toAttribute attributes)
        children


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Markup.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    Markup.Html.Attr.Internal.attribute M3e.Raw.SliderThumb.disabled


{-| The name that identifies the element when submitting the associated form.
-}
name : String -> Markup.Html.Attr.Attr { c | name : M3e.Token.Supported } msg
name =
    Markup.Html.Attr.Internal.attribute M3e.Raw.SliderThumb.name


{-| The value of the thumb. (default: `null`)
-}
value : Float -> Markup.Html.Attr.Attr { c | valueFloat : M3e.Token.Supported } msg
value =
    Markup.Html.Attr.Internal.attribute M3e.Raw.SliderThumb.value


{-| Listen for `value-change` events.
-}
onValueChange : msg -> Markup.Html.Attr.Attr { c | onValueChange : M3e.Token.Supported } msg
onValueChange f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.SliderThumb.onValueChange
        (Json.Decode.succeed f_)


{-| Listen for `beforeinput` events.
-}
onBeforeinput : msg -> Markup.Html.Attr.Attr { c | onBeforeinput : M3e.Token.Supported } msg
onBeforeinput f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.SliderThumb.onBeforeinput
        (Json.Decode.succeed f_)


{-| Listen for `input` events.
-}
onInput : msg -> Markup.Html.Attr.Attr { c | onInput : M3e.Token.Supported } msg
onInput f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.SliderThumb.onInput
        (Json.Decode.succeed f_)


{-| Listen for `change` events.
-}
onChange : msg -> Markup.Html.Attr.Attr { c | onChange : M3e.Token.Supported } msg
onChange f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.SliderThumb.onChange
        (Json.Decode.succeed f_)


{-| Listen for `click` events.
-}
onClick : msg -> Markup.Html.Attr.Attr { c | onClick : M3e.Token.Supported } msg
onClick f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.SliderThumb.onClick
        (Json.Decode.succeed f_)
