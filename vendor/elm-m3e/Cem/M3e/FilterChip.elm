module Cem.M3e.FilterChip exposing
    ( component, disabled, disabledInteractive, selected, value, variant
    , onBeforeinput, onInput, onChange, onClick, iconSlot, trailingIconSlot
    )

{-| A chip users interact with to select/deselect options.

@docs component, disabled, disabledInteractive, selected, value, variant
@docs onBeforeinput, onInput, onChange, onClick, iconSlot, trailingIconSlot

-}

import Cem.M3e.Common
import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| A chip users interact with to select/deselect options.

**Component Info:**

  - **Extends:** `M3eChipElement` from `/src/chips/ChipElement`

**Events:**

  - `beforeinput`: Dispatched before the selected state changes.
  - `input`: Dispatched when the selected state changes.
  - `change`: Dispatched when the selected state changes.
  - `click`: Dispatched when the element is clicked.

**Slots:**

  - `icon`: Renders an icon before the chip's label.
  - `trailing-icon`: Renders an icon after the chip's label.

**CSS Custom Properties:**

  - `--m3e-chip-container-shape`: Border radius of the chip container.
  - `--m3e-chip-container-height`: Base height of the chip container before density adjustment.
  - `--m3e-chip-label-text-font-size`: Font size of the chip label text.
  - `--m3e-chip-label-text-font-weight`: Font weight of the chip label text.
  - `--m3e-chip-label-text-line-height`: Line height of the chip label text.
  - `--m3e-chip-label-text-tracking`: Letter spacing of the chip label text.
  - `--m3e-chip-icon-size`: Font size of leading/trailing icons.
  - `--m3e-chip-spacing`: Horizontal gap between chip content elements.
  - `--m3e-chip-padding-start`: Default start padding when no icon is present.
  - `--m3e-chip-padding-end`: Default end padding when no trailing icon is present.
  - `--m3e-chip-with-icon-padding-start`: Start padding when leading icon is present.
  - `--m3e-chip-with-icon-padding-end`: End padding when trailing icon is present.
  - `--m3e-chip-disabled-label-text-color`: Base color for disabled label text.
  - `--m3e-chip-disabled-label-text-opacity`: Opacity applied to disabled label text.
  - `--m3e-chip-disabled-icon-color`: Base color for disabled icons.
  - `--m3e-chip-disabled-icon-opacity`: Opacity applied to disabled icons.
  - `--m3e-elevated-chip-container-color`: Background color for elevated variant.
  - `--m3e-elevated-chip-elevation`: Elevation level for elevated variant.
  - `--m3e-elevated-chip-hover-elevation`: Elevation level on hover.
  - `--m3e-elevated-chip-disabled-container-color`: Background color for disabled elevated variant.
  - `--m3e-elevated-chip-disabled-container-opacity`: Opacity applied to disabled elevated background.
  - `--m3e-elevated-chip-disabled-elevation`: Elevation level for disabled elevated variant.
  - `--m3e-outlined-chip-outline-thickness`: Outline thickness for outlined variant.
  - `--m3e-outlined-chip-outline-color`: Outline color for outlined variant.
  - `--m3e-outlined-chip-disabled-outline-color`: Outline color for disabled outlined variant.
  - `--m3e-outlined-chip-disabled-outline-opacity`: Opacity applied to disabled outline.
  - `--m3e-chip-selected-outline-thickness`: Outline thickness for selected state.
  - `--m3e-chip-selected-label-text-color`: Text color in selected state.
  - `--m3e-chip-selected-container-color`: Background color in selected state.
  - `--m3e-chip-selected-container-hover-color`: Hover state layer color in selected state.
  - `--m3e-chip-selected-container-focus-color`: Focus state layer color in selected state.
  - `--m3e-chip-selected-hover-elevation`: Elevation on hover in selected state.
  - `--m3e-chip-selected-ripple-color`: Ripple color in selected state.
  - `--m3e-chip-selected-state-layer-focus-color`: Focus state layer color in selected state.
  - `--m3e-chip-selected-state-layer-hover-color`: Hover state layer color in selected state.
  - `--m3e-chip-selected-leading-icon-color`: Leading icon color in selected state.
  - `--m3e-chip-selected-trailing-icon-color`: Trailing icon color in selected state.
  - `--m3e-chip-unselected-label-text-color`: Text color in unselected state.
  - `--m3e-chip-unselected-ripple-color`: Ripple color in unselected state.
  - `--m3e-chip-unselected-state-layer-focus-color`: Focus state layer color in unselected state.
  - `--m3e-chip-unselected-state-layer-hover-color`: Hover state layer color in unselected state.
  - `--m3e-chip-unselected-leading-icon-color`: Leading icon color in unselected state.
  - `--m3e-chip-unselected-trailing-icon-color`: Trailing icon color in unselected state.
  - `--m3e-chip-label-text-color`: Label text color in default state.
  - `--m3e-chip-icon-color`: Icon color in default state.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-filter-chip" attributes children


{-| A value indicating whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| A value indicating whether the element is disabled and interactive. (default: `false`)
-}
disabledInteractive : Bool -> Html.Attribute msg
disabledInteractive val_ =
    Html.Attributes.property "disabled-interactive" (Json.Encode.bool val_)


{-| A value indicating whether the element is selected. (default: `false`)
-}
selected : Bool -> Html.Attribute msg
selected =
    Html.Attributes.selected


{-| A string representing the value of the chip.
-}
value : String -> Html.Attribute msg
value =
    Html.Attributes.value


{-| The appearance variant of the chip. (default: `"outlined"`)
-}
variant :
    Cem.M3e.Common.Value
        { elevated : Cem.M3e.Common.Supported
        , outlined : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
variant =
    Cem.M3e.Common.variant


{-| Dispatched before the selected state changes.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `Cem.M3e.Common`, e.g. `onBeforeinput (Json.Decode.map ValueChanged Cem.M3e.Common.targetValue)`.

-}
onBeforeinput : Json.Decode.Decoder msg -> Html.Attribute msg
onBeforeinput decoder =
    Html.Events.on "beforeinput" decoder


{-| Dispatched when the selected state changes.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `Cem.M3e.Common`, e.g. `onInput (Json.Decode.map ValueChanged Cem.M3e.Common.targetValue)`.

-}
onInput : Json.Decode.Decoder msg -> Html.Attribute msg
onInput decoder =
    Html.Events.on "input" decoder


{-| Dispatched when the selected state changes.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `Cem.M3e.Common`, e.g. `onChange (Json.Decode.map ValueChanged Cem.M3e.Common.targetValue)`.

-}
onChange : Json.Decode.Decoder msg -> Html.Attribute msg
onChange decoder =
    Html.Events.on "change" decoder


{-| Dispatched when the element is clicked.

**Payload type:** `MouseEvent`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

-}
onClick : Json.Decode.Decoder msg -> Html.Attribute msg
onClick decoder =
    Html.Events.on "click" decoder


{-| Renders an icon before the chip's label.
-}
iconSlot : Html.Attribute msg
iconSlot =
    Html.Attributes.attribute "slot" "icon"


{-| Renders an icon after the chip's label.
-}
trailingIconSlot : Html.Attribute msg
trailingIconSlot =
    Html.Attributes.attribute "slot" "trailing-icon"
