module Cem.M3e.ListOption exposing
    ( component, disabled, selected, value, onBeforeinput, onInput
    , onChange, onClick, leadingSlot, overlineSlot, supportingTextSlot, trailingSlot
    )

{-| A selectable option in a list.

@docs component, disabled, selected, value, onBeforeinput, onInput
@docs onChange, onClick, leadingSlot, overlineSlot, supportingTextSlot, trailingSlot

-}

import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| A selectable option in a list.

**Component Info:**

  - **Extends:** `M3eListItemElement` from `/src/list/ListItemElement`

**Events:**

  - `beforeinput`: Dispatched before the selected state changes.
  - `input`: Dispatched when the selected state changes.
  - `change`: Dispatched when the selected state changes.
  - `click`: Dispatched when the element is clicked.

**Slots:**

  - `leading`: Renders the leading content of the list item.
  - `overline`: Renders the overline of the list item.
  - `supporting-text`: Renders the supporting text of the list item.
  - `trailing`: Renders the trailing content of the list item.

**CSS Custom Properties:**

  - `--m3e-list-item-between-space`: Horizontal gap between elements.
  - `--m3e-list-item-padding-inline`: Horizontal padding for the list item.
  - `--m3e-list-item-padding-block`: Vertical padding for the list item.
  - `--m3e-list-item-height`: Minimum height of the list item.
  - `--m3e-list-item-font-size`: Font size for main content.
  - `--m3e-list-item-font-weight`: Font weight for main content.
  - `--m3e-list-item-line-height`: Line height for main content.
  - `--m3e-list-item-tracking`: Letter spacing for main content.
  - `--m3e-list-item-overline-font-size`: Font size for overline slot.
  - `--m3e-list-item-overline-font-weight`: Font weight for overline slot.
  - `--m3e-list-item-overline-line-height`: Line height for overline slot.
  - `--m3e-list-item-overline-tracking`: Letter spacing for overline slot.
  - `--m3e-list-item-supporting-text-font-size`: Font size for supporting text slot.
  - `--m3e-list-item-supporting-text-font-weight`: Font weight for supporting text slot.
  - `--m3e-list-item-supporting-text-line-height`: Line height for supporting text slot.
  - `--m3e-list-item-supporting-text-tracking`: Letter spacing for supporting text slot.
  - `--m3e-list-item-trailing-text-font-size`: Font size for trailing supporting text slot.
  - `--m3e-list-item-trailing-text-font-weight`: Font weight for trailing supporting text slot.
  - `--m3e-list-item-trailing-text-line-height`: Line height for trailing supporting text slot.
  - `--m3e-list-item-trailing-text-tracking`: Letter spacing for trailing supporting text slot.
  - `--m3e-list-item-icon-size`: Size for leading/trailing icons.
  - `--m3e-list-item-label-text-color`: Color for the main content.
  - `--m3e-list-item-overline-color`: Color for the overline slot.
  - `--m3e-list-item-supporting-text-color`: Color for the supporting text slot.
  - `--m3e-list-item-leading-color`: Color for the leading content.
  - `--m3e-list-item-trailing-color`: Color for the trailing content.
  - `--m3e-list-item-container-color`: Background color of the list item.
  - `--m3e-list-item-container-shape`: Border radius of the list item.
  - `--m3e-list-item-hover-container-shape`: Border radius of the list item on hover.
  - `--m3e-list-item-focus-container-shape`: Border radius of the list item on focus.
  - `--m3e-list-item-video-width`: Width of the video slot.
  - `--m3e-list-item-video-height`: Height of the video slot.
  - `--m3e-list-item-video-shape`: Border radius of the video slot.
  - `--m3e-list-item-image-width`: Width of the image slot.
  - `--m3e-list-item-image-height`: Height of the image slot.
  - `--m3e-list-item-image-shape`: Border radius of the image slot.
  - `--m3e-list-item-disabled-container-color`: Background color of the list item when disabled.
  - `--m3e-list-item-disabled-label-text-color`: Color for the main content when disabled.
  - `--m3e-list-item-disabled-label-text-opacity`: Opacity for the main content when disabled.
  - `--m3e-list-item-disabled-overline-color`: Color for the overline slot when disabled.
  - `--m3e-list-item-disabled-overline-opacity`: Opacity for the overline slot when disabled.
  - `--m3e-list-item-disabled-supporting-text-color`: Color for the supporting text slot when disabled.
  - `--m3e-list-item-disabled-supporting-text-opacity`: Opacity for the supporting text slot when disabled.
  - `--m3e-list-item-disabled-leading-color`: Color for the leading icon when disabled.
  - `--m3e-list-item-disabled-leading-opacity`: Opacity for the leading icon when disabled.
  - `--m3e-list-item-disabled-trailing-color`: Color for the trailing icon when disabled.
  - `--m3e-list-item-disabled-trailing-opacity`: Opacity for the trailing icon when disabled.
  - `--m3e-list-item-hover-state-layer-color`: Color for the hover state layer.
  - `--m3e-list-item-hover-state-layer-opacity`: Opacity for the hover state layer.
  - `--m3e-list-item-focus-state-layer-color`: Color for the focus state layer.
  - `--m3e-list-item-focus-state-layer-opacity`: Opacity for the focus state layer.
  - `--m3e-list-item-pressed-state-layer-color`: Color for the pressed state layer.
  - `--m3e-list-item-pressed-state-layer-opacity`: Opacity for the pressed state layer.
  - `--m3e-list-item-selected-label-text-color`: Selected color for the main content.
  - `--m3e-list-item-selected-overline-color`: Selected color for the overline slot.
  - `--m3e-list-item-selected-supporting-text-color`: Selected color for the supporting text slot.
  - `--m3e-list-item-selected-leading-color`: Selected color for the leading content.
  - `--m3e-list-item-selected-trailing-color`: Selected color for the trailing content.
  - `--m3e-list-item-selected-container-color`: Selected background color of the list item.
  - `--m3e-list-item-selected-container-shape`: Selected border radius of the list item.
  - `--m3e-list-item-selected-disabled-container-color`: Selected background color when disabled.
  - `--m3e-list-item-selected-disabled-container-opacity`: Selected opacity when disabled.
  - `--m3e-list-item-selected-hover-state-layer-color`: Color for the hover state layer when selected.
  - `--m3e-list-item-selected-hover-state-layer-opacity`: Opacity for the hover state layer when selected.
  - `--m3e-list-item-selected-focus-state-layer-color`: Color for the focus state layer when selected.
  - `--m3e-list-item-selected-focus-state-layer-opacity`: Opacity for the focus state layer when selected.
  - `--m3e-list-item-selected-pressed-state-layer-color`: Color for the pressed state layer when selected.
  - `--m3e-list-item-selected-pressed-state-layer-opacity`: Opacity for the pressed state layer when selected.
  - `--m3e-list-item-three-line-top-offset`: Top offset for media in three line items.
  - `--m3e-list-item-disabled-media-opacity`: Opacity for media when disabled.
  - `--m3e-list-item-leading-space`: Horizontal padding for the leading side.
  - `--m3e-list-item-trailing-space`: Horizontal padding for the trailing side.
  - `--m3e-list-item-one-line-top-space`: Top padding for one-line items.
  - `--m3e-list-item-one-line-bottom-space`: Bottom padding for one-line items.
  - `--m3e-list-item-two-line-top-space`: Top padding for two-line items.
  - `--m3e-list-item-two-line-bottom-space`: Bottom padding for two-line items.
  - `--m3e-list-item-three-line-top-space`: Top padding for three-line items.
  - `--m3e-list-item-three-line-bottom-space`: Bottom padding for three-line items.
  - `--m3e-list-item-one-line-height`: Minimum height of a one line list item.
  - `--m3e-list-item-two-line-height`: Minimum height of a two line list item.
  - `--m3e-list-item-three-line-height`: Minimum height of a three line list item.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-list-option" attributes children


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| Whether the element is selected. (default: `false`)
-}
selected : Bool -> Html.Attribute msg
selected =
    Html.Attributes.selected


{-| A string representing the value of the option.
-}
value : String -> Html.Attribute msg
value =
    Html.Attributes.value


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


{-| Renders the leading content of the list item.
-}
leadingSlot : Html.Attribute msg
leadingSlot =
    Html.Attributes.attribute "slot" "leading"


{-| Renders the overline of the list item.
-}
overlineSlot : Html.Attribute msg
overlineSlot =
    Html.Attributes.attribute "slot" "overline"


{-| Renders the supporting text of the list item.
-}
supportingTextSlot : Html.Attribute msg
supportingTextSlot =
    Html.Attributes.attribute "slot" "supporting-text"


{-| Renders the trailing content of the list item.
-}
trailingSlot : Html.Attribute msg
trailingSlot =
    Html.Attributes.attribute "slot" "trailing"
