module M3e.Html.Slider exposing
    ( slider, disabled, discrete, labelled, max, min
    , step, size, onBeforeinput, onInput, onChange
    )

{-| Middle layer for `<m3e-slider>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.Slider` module for everyday use.

@docs slider, disabled, discrete, labelled, max, min
@docs step, size, onBeforeinput, onInput, onChange

-}

import Html
import Json.Decode
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Raw.Slider
import M3e.Token


{-| Allows for the selection of numeric values from a range.

**Component Info:**

  - **Extends:** `LitElement`

**Events:**

  - `beforeinput`: Dispatched before the value of a thumb changes.
  - `input`: Dispatched when the value of a thumb changes.
  - `change`: Dispatched when the value of a thumb changes.

-}
slider :
    List
        (M3e.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , discrete : M3e.Token.Supported
            , labelled : M3e.Token.Supported
            , max : M3e.Token.Supported
            , min : M3e.Token.Supported
            , step : M3e.Token.Supported
            , size : M3e.Token.Supported
            , onBeforeinput : M3e.Token.Supported
            , onInput : M3e.Token.Supported
            , onChange : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
slider attributes children =
    M3e.Raw.Slider.slider
        (List.map M3e.Html.Attr.toAttribute attributes)
        children


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> M3e.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Slider.disabled


{-| Whether to show tick marks. (default: `false`)
-}
discrete : Bool -> M3e.Html.Attr.Attr { c | discrete : M3e.Token.Supported } msg
discrete =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Slider.discrete


{-| Whether to show value labels when activated. (default: `false`)
-}
labelled : Bool -> M3e.Html.Attr.Attr { c | labelled : M3e.Token.Supported } msg
labelled =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Slider.labelled


{-| The maximum allowable value. (default: `100`)
-}
max : Float -> M3e.Html.Attr.Attr { c | max : M3e.Token.Supported } msg
max =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Slider.max


{-| The minimum allowable value. (default: `0`)
-}
min : Float -> M3e.Html.Attr.Attr { c | min : M3e.Token.Supported } msg
min =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Slider.min


{-| The value at which the thumb will snap. (default: `1`)
-}
step : Float -> M3e.Html.Attr.Attr { c | step : M3e.Token.Supported } msg
step =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Slider.step


{-| The size of the slider. (default: `"extra-small"`)
-}
size :
    M3e.Token.Value
        { extraLarge : M3e.Token.Supported
        , extraSmall : M3e.Token.Supported
        , large : M3e.Token.Supported
        , medium : M3e.Token.Supported
        , small : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | size : M3e.Token.Supported } msg
size v_ =
    M3e.Html.Attr.Internal.attribute M3e.Raw.Slider.size (M3e.Token.toString v_)


{-| Listen for `beforeinput` events.
-}
onBeforeinput : msg -> M3e.Html.Attr.Attr { c | onBeforeinput : M3e.Token.Supported } msg
onBeforeinput f_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Slider.onBeforeinput
        (Json.Decode.succeed f_)


{-| Listen for `input` events.
-}
onInput : msg -> M3e.Html.Attr.Attr { c | onInput : M3e.Token.Supported } msg
onInput f_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Slider.onInput
        (Json.Decode.succeed f_)


{-| Listen for `change` events.
-}
onChange : msg -> M3e.Html.Attr.Attr { c | onChange : M3e.Token.Supported } msg
onChange f_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.Slider.onChange
        (Json.Decode.succeed f_)
