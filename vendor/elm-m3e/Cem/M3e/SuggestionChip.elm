module Cem.M3e.SuggestionChip exposing
    ( component, disabled, disabledInteractive, download, href, name
    , rel, target, type_, value, variant, onClick
    , iconSlot, trailingIconSlot
    )

{-| A chip used to help narrow a user's intent by presenting dynamically generated suggestions, such as
suggested responses or search filters.

@docs component, disabled, disabledInteractive, download, href, name
@docs rel, target, type_, value, variant, onClick
@docs iconSlot, trailingIconSlot

-}

import Cem.M3e.Common
import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| A chip used to help narrow a user's intent by presenting dynamically generated suggestions, such as
suggested responses or search filters.

**Component Info:**

  - **Extends:** `M3eChipElement` from `/src/chips/ChipElement`

**Events:**

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

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-suggestion-chip" attributes children


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


{-| The name of the element, submitted as a pair with the element's `value` as part of form data, when the element is used to submit a form.
-}
name : String -> Html.Attribute msg
name val_ =
    Html.Attributes.attribute "name" val_


{-| The relationship between the `target` of the link button and the document. (default: `""`)
-}
rel : String -> Html.Attribute msg
rel val_ =
    Html.Attributes.attribute "rel" val_


{-| The target of the link button. (default: `""`)
-}
target : String -> Html.Attribute msg
target val_ =
    Html.Attributes.attribute "target" val_


{-| The type of the element. (default: `"button"`)
-}
type_ :
    Cem.M3e.Common.Value
        { button : Cem.M3e.Common.Supported
        , reset : Cem.M3e.Common.Supported
        , submit : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
type_ =
    Cem.M3e.Common.type_


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
