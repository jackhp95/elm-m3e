module Cem.M3e.NavItem exposing
    ( component, disabled, disabledInteractive, download, href, orientation
    , rel, selected, target, onBeforeinput, onInput, onChange
    , onClick, iconSlot, selectedIconSlot
    )

{-| An item, placed in a navigation bar or rail, used to navigate to destinations in an application.

@docs component, disabled, disabledInteractive, download, href, orientation
@docs rel, selected, target, onBeforeinput, onInput, onChange
@docs onClick, iconSlot, selectedIconSlot

-}

import Cem.M3e.Common
import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| An item, placed in a navigation bar or rail, used to navigate to destinations in an application.

**Events:**

  - `beforeinput`: Dispatched before the selected state changes.
  - `input`: Dispatched when the selected state changes.
  - `change`: Dispatched when the selected state changes.
  - `click`: Dispatched when the element is clicked.

**Slots:**

  - `icon`: Renders the icon of the item.
  - `selected-icon`: Renders the icon of the item when selected.

**CSS Custom Properties:**

  - `--m3e-nav-item-label-text-font-size`: Font size for the label text.
  - `--m3e-nav-item-label-text-font-weight`: Font weight for the label text.
  - `--m3e-nav-item-label-text-line-height`: Line height for the label text.
  - `--m3e-nav-item-label-text-tracking`: Letter spacing for the label text.
  - `--m3e-nav-item-shape`: Border radius of the nav item.
  - `--m3e-nav-item-icon-size`: Size of the icon.
  - `--m3e-nav-item-spacing`: Spacing between icon and label.
  - `--m3e-nav-item-inactive-label-text-color`: Color of the label text when inactive.
  - `--m3e-nav-item-inactive-icon-color`: Color of the icon when inactive.
  - `--m3e-nav-item-inactive-hover-state-layer-color`: State layer color on hover when inactive.
  - `--m3e-nav-item-inactive-focus-state-layer-color`: State layer color on focus when inactive.
  - `--m3e-nav-item-inactive-pressed-state-layer-color`: State layer color on press when inactive.
  - `--m3e-nav-item-active-label-text-color`: Color of the label text when active/selected.
  - `--m3e-nav-item-active-icon-color`: Color of the icon when active/selected.
  - `--m3e-nav-item-active-container-color`: Container color when active/selected.
  - `--m3e-nav-item-active-hover-state-layer-color`: State layer color on hover when active.
  - `--m3e-nav-item-active-focus-state-layer-color`: State layer color on focus when active.
  - `--m3e-nav-item-active-pressed-state-layer-color`: State layer color on press when active.
  - `--m3e-nav-item-focus-ring-shape`: Border radius for the focus ring.
  - `--m3e-nav-item-disabled-label-text-color`: Color of the label text when disabled.
  - `--m3e-nav-item-disabled-label-text-opacity`: Opacity of the label text when disabled.
  - `--m3e-nav-item-disabled-icon-color`: Color of the icon when disabled.
  - `--m3e-nav-item-disabled-icon-opacity`: Opacity of the icon when disabled.
  - `--m3e-horizontal-nav-item-padding`: Padding for horizontal orientation.
  - `--m3e-horizontal-nav-item-active-indicator-height`: Height of the active indicator in horizontal orientation.
  - `--m3e-vertical-nav-item-active-indicator-width`: Width of the active indicator in vertical orientation.
  - `--m3e-vertical-nav-item-active-indicator-height`: Height of the active indicator in vertical orientation.
  - `--m3e-vertical-nav-item-active-indicator-margin`: Margin for the active indicator in vertical orientation.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-nav-item" attributes children


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


{-| A value indicating whether the `target` of the link button will be downloaded, optionally specifying the new name of the file. (default: `null`)
-}
download : String -> Html.Attribute msg
download val_ =
    Html.Attributes.attribute "download" val_


{-| The URL to which the link button points. (default: `""`)
-}
href : String -> Html.Attribute msg
href val_ =
    Html.Attributes.attribute "href" val_


{-| The layout orientation of the item. (default: `"vertical"`)
-}
orientation :
    Cem.M3e.Common.Value
        { horizontal : Cem.M3e.Common.Supported
        , vertical : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
orientation =
    Cem.M3e.Common.orientation


{-| The relationship between the `target` of the link button and the document. (default: `""`)
-}
rel : String -> Html.Attribute msg
rel val_ =
    Html.Attributes.attribute "rel" val_


{-| A value indicating whether the element is selected. (default: `false`)
-}
selected : Bool -> Html.Attribute msg
selected =
    Html.Attributes.selected


{-| The target of the link button. (default: `""`)
-}
target : String -> Html.Attribute msg
target val_ =
    Html.Attributes.attribute "target" val_


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


{-| Renders the icon of the item.
-}
iconSlot : Html.Attribute msg
iconSlot =
    Html.Attributes.attribute "slot" "icon"


{-| Renders the icon of the item when selected.
-}
selectedIconSlot : Html.Attribute msg
selectedIconSlot =
    Html.Attributes.attribute "slot" "selected-icon"
