module Cem.M3e.SelectionList exposing
    ( component, hideSelectionIndicator, multi, variant, name, disabled
    , dirty, pristine, touched, untouched, onChange, onBeforeinput
    , onInput
    )

{-| A list of selectable options.

@docs component, hideSelectionIndicator, multi, variant, name, disabled
@docs dirty, pristine, touched, untouched, onChange, onBeforeinput
@docs onInput

-}

import Cem.M3e.Common
import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| A list of selectable options.

**Component Info:**

  - **Extends:** `M3eListElement` from `/src/list/ListElement`

**Events:**

  - `change`: Dispatched when the selected state of an option changes.
  - `beforeinput`: Dispatched before the selected state of an option changes.
  - `input`: Dispatched when the selected state of an option changes.

**CSS Custom Properties:**

  - `--m3e-list-divider-inset-start-size`: Start inset for dividers within the list.
  - `--m3e-list-divider-inset-end-size`: End inset for dividers within the list.
  - `--m3e-segmented-list-segment-gap`: Gap between list items in segmented variant.
  - `--m3e-segmented-list-container-shape`: Border radius of the segmented list container.
  - `--m3e-segmented-list-item-container-color`: Background color of items in segmented variant.
  - `--m3e-segmented-list-item-disabled-container-color`: Background color of disabled items in segmented variant.
  - `--m3e-segmented-list-item-container-shape`: Border radius of items in segmented variant.
  - `--m3e-segmented-list-item-hover-container-shape`: Border radius of items in segmented variant on hover.
  - `--m3e-segmented-list-item-focus-container-shape`: Border radius of items in segmented variant on focus.
  - `--m3e-segmented-list-item-selected-container-shape`: Border radius of items in segmented variant when selected.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-selection-list" attributes children


{-| Whether to hide the selection indicator. (default: `false`)
-}
hideSelectionIndicator : Bool -> Html.Attribute msg
hideSelectionIndicator val_ =
    Html.Attributes.property "hide-selection-indicator" (Json.Encode.bool val_)


{-| Whether multiple items can be selected. (default: `false`)
-}
multi : Bool -> Html.Attribute msg
multi val_ =
    Html.Attributes.property "multi" (Json.Encode.bool val_)


{-| The appearance variant of the list. (default: `"standard"`)
-}
variant :
    Cem.M3e.Common.Value
        { segmented : Cem.M3e.Common.Supported
        , standard : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
variant =
    Cem.M3e.Common.variant


{-| The name that identifies the element when submitting the associated form.
-}
name : String -> Html.Attribute msg
name val_ =
    Html.Attributes.attribute "name" val_


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


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


{-| Dispatched when the selected state of an option changes.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `Cem.M3e.Common`, e.g. `onChange (Json.Decode.map ValueChanged Cem.M3e.Common.targetValue)`.

-}
onChange : Json.Decode.Decoder msg -> Html.Attribute msg
onChange decoder =
    Html.Events.on "change" decoder


{-| Dispatched before the selected state of an option changes.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `Cem.M3e.Common`, e.g. `onBeforeinput (Json.Decode.map ValueChanged Cem.M3e.Common.targetValue)`.

-}
onBeforeinput : Json.Decode.Decoder msg -> Html.Attribute msg
onBeforeinput decoder =
    Html.Events.on "beforeinput" decoder


{-| Dispatched when the selected state of an option changes.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `Cem.M3e.Common`, e.g. `onInput (Json.Decode.map ValueChanged Cem.M3e.Common.targetValue)`.

-}
onInput : Json.Decode.Decoder msg -> Html.Attribute msg
onInput decoder =
    Html.Events.on "input" decoder
