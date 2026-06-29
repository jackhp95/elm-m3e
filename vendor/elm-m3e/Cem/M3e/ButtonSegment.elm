module Cem.M3e.ButtonSegment exposing
    ( component, checked, disabled, value, dirty, pristine
    , touched, untouched, onBeforeinput, onInput, onChange, onClick
    , iconSlot
    )

{-| A option that can be selected within a segmented button.

@docs component, checked, disabled, value, dirty, pristine
@docs touched, untouched, onBeforeinput, onInput, onChange, onClick
@docs iconSlot

-}

import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| A option that can be selected within a segmented button.

**Events:**

  - `beforeinput`: Dispatched before the checked state changes.
  - `input`: Dispatched when the checked state changes.
  - `change`: Dispatched when the checked state changes.
  - `click`: Dispatched when the element is clicked.

**Slots:**

  - `icon`: Renders an icon before the option's label.

**CSS Custom Properties:**

  - `--m3e-segmented-button-height`: Total height of the segmented button.
  - `--m3e-segmented-button-outline-thickness`: Thickness of the button's border.
  - `--m3e-segmented-button-outline-color`: Color of the button's border.
  - `--m3e-segmented-button-padding-start`: Padding on the leading edge of the button content.
  - `--m3e-segmented-button-padding-end`: Padding on the trailing edge of the button content.
  - `--m3e-segmented-button-spacing`: Horizontal gap between icon and label.
  - `--m3e-segmented-button-font-size`: Font size of the label text.
  - `--m3e-segmented-button-font-weight`: Font weight of the label text.
  - `--m3e-segmented-button-line-height`: Line height of the label text.
  - `--m3e-segmented-button-tracking`: Letter spacing of the label text.
  - `--m3e-segmented-button-with-icon-padding-start`: Leading padding when an icon is present.
  - `--m3e-segmented-button-selected-container-color`: Background color of a selected segment.
  - `--m3e-segmented-button-selected-container-hover-color`: Hover state-layer color for selected segments.
  - `--m3e-segmented-button-selected-container-focus-color`: Focus state-layer color for selected segments.
  - `--m3e-segmented-button-selected-ripple-color`: Ripple color for selected segments.
  - `--m3e-segmented-button-selected-label-text-color`: Label text color for selected segments.
  - `--m3e-segmented-button-selected-icon-color`: Icon color for selected segments.
  - `--m3e-segmented-button-unselected-container-hover-color`: Hover state-layer color for unselected segments.
  - `--m3e-segmented-button-unselected-container-focus-color`: Focus state-layer color for unselected segments.
  - `--m3e-segmented-button-unselected-ripple-color`: Ripple color for unselected segments.
  - `--m3e-segmented-button-unselected-label-text-color`: Label text color for unselected segments.
  - `--m3e-segmented-button-unselected-icon-color`: Icon color for unselected segments.
  - `--m3e-segmented-button-icon-size`: Font size of the icon.
  - `--m3e-segmented-button-disabled-outline-color`: Base color for disabled segment borders.
  - `--m3e-segmented-button-disabled-outline-opacity`: Opacity applied to disabled segment borders.
  - `--m3e-segmented-button-disabled-label-text-color`: Base color for disabled label text.
  - `--m3e-segmented-button-disabled-label-text-opacity`: Opacity applied to disabled label text.
  - `--m3e-segmented-button-disabled-icon-color`: Base color for disabled icons.
  - `--m3e-segmented-button-disabled-icon-opacity`: Opacity applied to disabled icons.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-button-segment" attributes children


{-| Whether the element is checked. (default: `false`)
-}
checked : Bool -> Html.Attribute msg
checked =
    Html.Attributes.checked


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| A string representing the value of the segment. (default: `"on"`)
-}
value : String -> Html.Attribute msg
value =
    Html.Attributes.value


{-| Whether the user has modified the value of the element.
-}
dirty : Bool -> Html.Attribute msg
dirty val_ =
    Html.Attributes.property "dirty" (Json.Encode.bool val_)


{-| Whether the user has not modified the value of the element.
-}
pristine : Bool -> Html.Attribute msg
pristine val_ =
    Html.Attributes.property "pristine" (Json.Encode.bool val_)


{-| Whether the user has interacted when the element.
-}
touched : Bool -> Html.Attribute msg
touched val_ =
    Html.Attributes.property "touched" (Json.Encode.bool val_)


{-| Whether the user has not interacted when the element.
-}
untouched : Bool -> Html.Attribute msg
untouched val_ =
    Html.Attributes.property "untouched" (Json.Encode.bool val_)


{-| Dispatched before the checked state changes.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `Cem.M3e.Common`, e.g. `onBeforeinput (Json.Decode.map ValueChanged Cem.M3e.Common.targetValue)`.

-}
onBeforeinput : Json.Decode.Decoder msg -> Html.Attribute msg
onBeforeinput decoder =
    Html.Events.on "beforeinput" decoder


{-| Dispatched when the checked state changes.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `Cem.M3e.Common`, e.g. `onInput (Json.Decode.map ValueChanged Cem.M3e.Common.targetValue)`.

-}
onInput : Json.Decode.Decoder msg -> Html.Attribute msg
onInput decoder =
    Html.Events.on "input" decoder


{-| Dispatched when the checked state changes.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `Cem.M3e.Common`, e.g. `onChange (Json.Decode.map ValueChanged Cem.M3e.Common.targetValue)`.

-}
onChange : Json.Decode.Decoder msg -> Html.Attribute msg
onChange decoder =
    Html.Events.on "change" decoder


{-| Dispatched when the element is clicked.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

-}
onClick : Json.Decode.Decoder msg -> Html.Attribute msg
onClick decoder =
    Html.Events.on "click" decoder


{-| Renders an icon before the option's label.
-}
iconSlot : Html.Attribute msg
iconSlot =
    Html.Attributes.attribute "slot" "icon"
