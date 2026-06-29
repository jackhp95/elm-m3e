module Cem.M3e.InputChip exposing
    ( component, disabled, disabledInteractive, removable, removeLabel, value
    , variant, onRemove, onClick, avatarSlot, iconSlot, removeIconSlot
    , trailingIconSlot
    )

{-| A chip which represents a discrete piece of information entered by a user.

@docs component, disabled, disabledInteractive, removable, removeLabel, value
@docs variant, onRemove, onClick, avatarSlot, iconSlot, removeIconSlot
@docs trailingIconSlot

-}

import Cem.M3e.Common
import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| A chip which represents a discrete piece of information entered by a user.

**Component Info:**

  - **Extends:** `M3eChipElement` from `/src/chips/ChipElement`

**Events:**

  - `remove`: Dispatched when the remove button is clicked or DELETE or BACKSPACE key is pressed.
  - `click`: Dispatched when the element is clicked.

**Slots:**

  - `avatar`: Renders an avatar before the chip's label.
  - `icon`: Renders an icon before the chip's label.
  - `remove-icon`: Renders the icon for the button used to remove the chip.
  - `trailing-icon`: Renders an icon after the chip's label.

**CSS Custom Properties:**

  - `--m3e-chip-container-shape`: Border radius of the chip container.
  - `--m3e-chip-container-height`: Base height of the chip container before density adjustment.
  - `--m3e-chip-label-text-font-size`: Font size of the chip label text.
  - `--m3e-chip-label-text-font-weight`: Font weight of the chip label text.
  - `--m3e-chip-label-text-line-height`: Line height of the chip label text.
  - `--m3e-chip-label-text-tracking`: Letter spacing of the chip label text.
  - `--m3e-chip-label-text-color`: Label text color in default state.
  - `--m3e-chip-icon-color`: Icon color in default state.
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
  - `--m3e-chip-avatar-size`: Font size of the avatar slot content.
  - `--m3e-chip-avatar-icon-size`: Size of the icon displayed inside the avatar when used in a chip.
  - `--m3e-chip-avatar-font-size`: Font size of text initials inside the avatar when used in a chip.
  - `--m3e-chip-avatar-font-weight`: Font weight of text initials inside the avatar when used in a chip.
  - `--m3e-chip-avatar-line-height`: Line height of text initials inside the avatar when used in a chip.
  - `--m3e-chip-avatar-tracking`: Letter spacing (tracking) of text initials inside the avatar when used in a chip.
  - `--m3e-chip-disabled-avatar-opacity`: Opacity applied to the avatar when disabled.
  - `--m3e-chip-with-avatar-padding-start`: Start padding when an avatar is present.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-input-chip" attributes children


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| Whether the element is disabled and interactive. (default: `false`)
-}
disabledInteractive : Bool -> Html.Attribute msg
disabledInteractive val_ =
    Html.Attributes.property "disabled-interactive" (Json.Encode.bool val_)


{-| Whether the chip is removable. (default: `false`)
-}
removable : Bool -> Html.Attribute msg
removable val_ =
    Html.Attributes.property "removable" (Json.Encode.bool val_)


{-| The accessible label given to the button used to remove the chip. (default: `"Remove"`)
-}
removeLabel : String -> Html.Attribute msg
removeLabel val_ =
    Html.Attributes.attribute "remove-label" val_


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


{-| Dispatched when the remove button is clicked or DELETE or BACKSPACE key is pressed.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

-}
onRemove : Json.Decode.Decoder msg -> Html.Attribute msg
onRemove decoder =
    Html.Events.on "remove" decoder


{-| Dispatched when the element is clicked.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

-}
onClick : Json.Decode.Decoder msg -> Html.Attribute msg
onClick decoder =
    Html.Events.on "click" decoder


{-| Renders an avatar before the chip's label.
-}
avatarSlot : Html.Attribute msg
avatarSlot =
    Html.Attributes.attribute "slot" "avatar"


{-| Renders an icon before the chip's label.
-}
iconSlot : Html.Attribute msg
iconSlot =
    Html.Attributes.attribute "slot" "icon"


{-| Renders the icon for the button used to remove the chip.
-}
removeIconSlot : Html.Attribute msg
removeIconSlot =
    Html.Attributes.attribute "slot" "remove-icon"


{-| Renders an icon after the chip's label.
-}
trailingIconSlot : Html.Attribute msg
trailingIconSlot =
    Html.Attributes.attribute "slot" "trailing-icon"
