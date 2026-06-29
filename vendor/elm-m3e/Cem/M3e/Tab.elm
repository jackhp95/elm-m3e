module Cem.M3e.Tab exposing
    ( component, disabled, for, selected, onBeforeinput, onInput
    , onChange, onClick, iconSlot
    )

{-| An interactive element that, when activated, presents an associated tab panel.

@docs component, disabled, for, selected, onBeforeinput, onInput
@docs onChange, onClick, iconSlot

-}

import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| An interactive element that, when activated, presents an associated tab panel.

**Events:**

  - `beforeinput`: Dispatched before the selected state changes.
  - `input`: Dispatched when the selected state changes.
  - `change`: Dispatched when the selected state changes.
  - `click`: Dispatched when the element is clicked.

**Slots:**

  - `icon`: Renders an icon before the tab's label.

**CSS Custom Properties:**

  - `--m3e-tab-font-size`: Font size for tab label.
  - `--m3e-tab-font-weight`: Font weight for tab label.
  - `--m3e-tab-line-height`: Line height for tab label.
  - `--m3e-tab-tracking`: Letter spacing for tab label.
  - `--m3e-tab-padding-start`: Padding on the inline start of the tab.
  - `--m3e-tab-padding-end`: Padding on the inline end of the tab.
  - `--m3e-tab-focus-ring-shape`: Border radius for the focus ring.
  - `--m3e-tab-selected-color`: Text color for selected tab.
  - `--m3e-tab-selected-container-hover-color`: Hover state-layer color for selected tab.
  - `--m3e-tab-selected-container-focus-color`: Focus state-layer color for selected tab.
  - `--m3e-tab-selected-ripple-color`: Ripple color for selected tab.
  - `--m3e-tab-unselected-color`: Text color for unselected tab.
  - `--m3e-tab-unselected-container-hover-color`: Hover state-layer color for unselected tab.
  - `--m3e-tab-unselected-container-focus-color`: Focus state-layer color for unselected tab.
  - `--m3e-tab-unselected-ripple-color`: Ripple color for unselected tab.
  - `--m3e-tab-disabled-color`: Text color for disabled tab.
  - `--m3e-tab-disabled-opacity`: Text opacity for disabled tab.
  - `--m3e-tab-spacing`: Column gap between icon and label.
  - `--m3e-tab-icon-size`: Font size for slotted icon.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-tab" attributes children


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for : String -> Html.Attribute msg
for val_ =
    Html.Attributes.attribute "for" val_


{-| Whether the element is selected. (default: `false`)
-}
selected : Bool -> Html.Attribute msg
selected =
    Html.Attributes.selected


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


{-| Renders an icon before the tab's label.
-}
iconSlot : Html.Attribute msg
iconSlot =
    Html.Attributes.attribute "slot" "icon"
