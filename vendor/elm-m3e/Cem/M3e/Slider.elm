module Cem.M3e.Slider exposing
    ( component, disabled, discrete, labelled, maxAttr, minAttr
    , step, size, isrange, onBeforeinput, onInput, onChange
    )

{-| Allows for the selection of numeric values from a range.

@docs component, disabled, discrete, labelled, maxAttr, minAttr
@docs step, size, isrange, onBeforeinput, onInput, onChange

-}

import Cem.M3e.Common
import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| Allows for the selection of numeric values from a range.

**Events:**

  - `beforeinput`: Dispatched before the value of a thumb changes.
  - `input`: Dispatched when the value of a thumb changes.
  - `change`: Dispatched when the value of a thumb changes.

**CSS Custom Properties:**

  - `--m3e-slider-min-width`: Minimum inline size of the slider host.
  - `--m3e-slider-small-height`: Height of the slider when size is small or extra-small.
  - `--m3e-slider-medium-height`: Height of the slider when size is medium.
  - `--m3e-slider-large-height`: Height of the slider when size is large.
  - `--m3e-slider-extra-large-height`: Height of the slider when size is extra-large.
  - `--m3e-slider-small-active-track-shape`: Corner shape of the active track for small sliders.
  - `--m3e-slider-small-inactive-active-track-start-shape`: Corner shape of the inactive track start for small sliders.
  - `--m3e-slider-small-inactive-track-end-shape`: Corner shape of the inactive track end for small sliders.
  - `--m3e-slider-medium-active-track-shape`: Corner shape of the active track for medium sliders.
  - `--m3e-slider-medium-inactive-active-track-start-shape`: Corner shape of the inactive track start for medium sliders.
  - `--m3e-slider-medium-inactive-track-end-shape`: Corner shape of the inactive track end for medium sliders.
  - `--m3e-slider-large-active-track-shape`: Corner shape of the active track for large sliders.
  - `--m3e-slider-large-inactive-active-track-start-shape`: Corner shape of the inactive track start for large sliders.
  - `--m3e-slider-large-inactive-track-end-shape`: Corner shape of the inactive track end for large sliders.
  - `--m3e-slider-extra-large-active-track-shape`: Corner shape of the active track for extra-large sliders.
  - `--m3e-slider-extra-large-inactive-active-track-start-shape`: Corner shape of the inactive track start for extra-large sliders.
  - `--m3e-slider-extra-large-inactive-track-end-shape`: Corner shape of the inactive track end for extra-large sliders.
  - `--m3e-slider-extra-small-track-height`: Height of the track for extra-small sliders.
  - `--m3e-slider-small-track-height`: Height of the track for small sliders.
  - `--m3e-slider-medium-track-height`: Height of the track for medium sliders.
  - `--m3e-slider-large-track-height`: Height of the track for large sliders.
  - `--m3e-slider-extra-large-track-height`: Height of the track for extra-large sliders.
  - `--m3e-slider-tick-size`: Size of each tick mark.
  - `--m3e-slider-tick-shape`: Corner shape of each tick mark.
  - `--m3e-slider-inactive-track-color`: Background color of the inactive track when enabled.
  - `--m3e-slider-disabled-inactive-track-color`: Base color of the inactive track when disabled.
  - `--m3e-slider-disabled-inactive-track-opacity`: Opacity of the inactive track when disabled.
  - `--m3e-slider-active-track-color`: Background color of the active track when enabled.
  - `--m3e-slider-disabled-active-track-color`: Base color of the active track when disabled.
  - `--m3e-slider-disabled-active-track-opacity`: Opacity of the active track when disabled.
  - `--m3e-slider-tick-active-color`: Color of active ticks when enabled.
  - `--m3e-slider-disabled-tick-active-color`: Color of active ticks when disabled.
  - `--m3e-slider-tick-inactive-color`: Color of inactive ticks when enabled.
  - `--m3e-slider-disabled-tick-inactive-color`: Color of inactive ticks when disabled.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-slider" attributes children


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| Whether to show tick marks. (default: `false`)
-}
discrete : Bool -> Html.Attribute msg
discrete val_ =
    Html.Attributes.property "discrete" (Json.Encode.bool val_)


{-| Whether to show value labels when activated. (default: `false`)
-}
labelled : Bool -> Html.Attribute msg
labelled val_ =
    Html.Attributes.property "labelled" (Json.Encode.bool val_)


{-| The maximum allowable value. (default: `100`)
-}
maxAttr : Float -> Html.Attribute msg
maxAttr val_ =
    Html.Attributes.property "max" (Json.Encode.float val_)


{-| The minimum allowable value. (default: `0`)
-}
minAttr : Float -> Html.Attribute msg
minAttr val_ =
    Html.Attributes.property "min" (Json.Encode.float val_)


{-| The value at which the thumb will snap. (default: `1`)
-}
step : Float -> Html.Attribute msg
step val_ =
    Html.Attributes.property "step" (Json.Encode.float val_)


{-| The size of the slider. (default: `"extra-small"`)
-}
size :
    Cem.M3e.Common.Value
        { extraLarge : Cem.M3e.Common.Supported
        , extraSmall : Cem.M3e.Common.Supported
        , large : Cem.M3e.Common.Supported
        , medium : Cem.M3e.Common.Supported
        , small : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
size =
    Cem.M3e.Common.size


{-| Whether the slider is a range slider.
-}
isrange : Bool -> Html.Attribute msg
isrange val_ =
    Html.Attributes.property "isRange" (Json.Encode.bool val_)


{-| Dispatched before the value of a thumb changes.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `Cem.M3e.Common`, e.g. `onBeforeinput (Json.Decode.map ValueChanged Cem.M3e.Common.targetValue)`.

-}
onBeforeinput : Json.Decode.Decoder msg -> Html.Attribute msg
onBeforeinput decoder =
    Html.Events.on "beforeinput" decoder


{-| Dispatched when the value of a thumb changes.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `Cem.M3e.Common`, e.g. `onInput (Json.Decode.map ValueChanged Cem.M3e.Common.targetValue)`.

-}
onInput : Json.Decode.Decoder msg -> Html.Attribute msg
onInput decoder =
    Html.Events.on "input" decoder


{-| Dispatched when the value of a thumb changes.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `Cem.M3e.Common`, e.g. `onChange (Json.Decode.map ValueChanged Cem.M3e.Common.targetValue)`.

-}
onChange : Json.Decode.Decoder msg -> Html.Attribute msg
onChange decoder =
    Html.Events.on "change" decoder
