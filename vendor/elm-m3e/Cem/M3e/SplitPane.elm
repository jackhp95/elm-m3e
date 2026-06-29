module Cem.M3e.SplitPane exposing
    ( component, label, maxAttr, minAttr, orientation, overshootLimit
    , step, value, wrapDetents, name, disabled, formvalue
    , onChange, onBeforeinput, onInput, startSlot, endSlot
    )

{-| A dual-view layout that separates content with a movable drag handle.


### Omitted Attributes

The following attribute setters were omitted because Elm cannot pass DOM element references:

  - `detents`: string[]

@docs component, label, maxAttr, minAttr, orientation, overshootLimit
@docs step, value, wrapDetents, name, disabled, formvalue
@docs onChange, onBeforeinput, onInput, startSlot, endSlot

-}

import Cem.M3e.Common
import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| A dual-view layout that separates content with a movable drag handle.

**Events:**

  - `change`: Dispatched when the user finishes adjusting the drag handle.
  - `beforeinput`: Dispatched continuously before the user adjusts the drag handle.
  - `input`: Dispatched continuously while the user adjusts the drag handle.

**Slots:**

  - `start`: Renders content at the logical start side of the pane.
  - `end`: Renders content at the logical end side of the pane.

**CSS Custom Properties:**

  - `--m3e-split-pane-drag-handle-hover-color`: Color used for the drag handle hover state.
  - `--m3e-split-pane-drag-handle-hover-opacity`: Opacity used for the drag handle hover state.
  - `--m3e-split-pane-drag-handle-focus-color`: Color used for the drag handle focus state.
  - `--m3e-split-pane-drag-handle-focus-opacity`: Opacity used for the drag handle focus state.
  - `--m3e-split-pane-drag-handle-color`: Background color of the drag handle when not pressed.
  - `--m3e-split-pane-drag-handle-shape`: Corner shape of the drag handle when not pressed.
  - `--m3e-split-pane-drag-handle-pressed-color`: Background color of the drag handle when pressed.
  - `--m3e-split-pane-drag-handle-pressed-shape`: Corner shape of the drag handle when pressed.
  - `--m3e-split-pane-drag-handle-container-width`: Width of the drag handle container.
  - `--m3e-split-pane-drag-handle-width`: Thickness of the drag handle when not pressed.
  - `--m3e-split-pane-drag-handle-height`: Length of the drag handle when not pressed.
  - `--m3e-split-pane-drag-handle-pressed-width`: Thickness of the drag handle when pressed.
  - `--m3e-split-pane-drag-handle-pressed-height`: Length of the drag handle when pressed.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-split-pane" attributes children


{-| The accessible label given to the movable drag handle. (default: `"Resize panes"`)
-}
label : String -> Html.Attribute msg
label val_ =
    Html.Attributes.attribute "label" val_


{-| A fractional value, between 0 and 100, indicating the maximum size of the start pane. (default: `100`)
-}
maxAttr : Float -> Html.Attribute msg
maxAttr val_ =
    Html.Attributes.property "max" (Json.Encode.float val_)


{-| A fractional value, between 0 and 100, indicating the minimum size of the start pane. (default: `0`)
-}
minAttr : Float -> Html.Attribute msg
minAttr val_ =
    Html.Attributes.property "min" (Json.Encode.float val_)


{-| The orientation of the split. (default: `"horizontal"`)
-}
orientation :
    Cem.M3e.Common.Value
        { auto : Cem.M3e.Common.Supported
        , horizontal : Cem.M3e.Common.Supported
        , vertical : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
orientation =
    Cem.M3e.Common.orientation


{-| A fractional value, between 0 and 100, indicating the maximum visual overshoot allowed when dragging past the minimum or maximum size. (default: `4`)
-}
overshootLimit : Float -> Html.Attribute msg
overshootLimit val_ =
    Html.Attributes.property "overshoot-limit" (Json.Encode.float val_)


{-| A fractional value, between 0 and 100, indicating the increment by which to adjust the value when resized via keyboard. (default: `1`)
-}
step : Float -> Html.Attribute msg
step val_ =
    Html.Attributes.property "step" (Json.Encode.float val_)


{-| A fractional value, between 0 and 100, indicating the size of the start pane. (default: `50`)
-}
value : String -> Html.Attribute msg
value =
    Html.Attributes.value


{-| Whether cycling through detents will wrap. (default: `false`)
-}
wrapDetents : Bool -> Html.Attribute msg
wrapDetents val_ =
    Html.Attributes.property "wrap-detents" (Json.Encode.bool val_)


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


{-| Set the `[formValue]` property.
-}
formvalue :
    Cem.M3e.Common.Value
        { file : Cem.M3e.Common.Supported
        , formdata : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
formvalue val_ =
    Html.Attributes.property
        "[formValue]"
        (Json.Encode.string (Cem.M3e.Common.toString val_))


{-| Dispatched when the user finishes adjusting the drag handle.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `Cem.M3e.Common`, e.g. `onChange (Json.Decode.map ValueChanged Cem.M3e.Common.targetValue)`.

-}
onChange : Json.Decode.Decoder msg -> Html.Attribute msg
onChange decoder =
    Html.Events.on "change" decoder


{-| Dispatched continuously before the user adjusts the drag handle.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `Cem.M3e.Common`, e.g. `onBeforeinput (Json.Decode.map ValueChanged Cem.M3e.Common.targetValue)`.

-}
onBeforeinput : Json.Decode.Decoder msg -> Html.Attribute msg
onBeforeinput decoder =
    Html.Events.on "beforeinput" decoder


{-| Dispatched continuously while the user adjusts the drag handle.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `Cem.M3e.Common`, e.g. `onInput (Json.Decode.map ValueChanged Cem.M3e.Common.targetValue)`.

-}
onInput : Json.Decode.Decoder msg -> Html.Attribute msg
onInput decoder =
    Html.Events.on "input" decoder


{-| Renders content at the logical start side of the pane.
-}
startSlot : Html.Attribute msg
startSlot =
    Html.Attributes.attribute "slot" "start"


{-| Renders content at the logical end side of the pane.
-}
endSlot : Html.Attribute msg
endSlot =
    Html.Attributes.attribute "slot" "end"
