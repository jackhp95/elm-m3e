module Cem.M3e.Switch exposing
    ( component, checked, disabled, icons, name, value
    , dirty, pristine, touched, untouched, willvalidate, validationmessage
    , onBeforeinput, onInput, onChange, onClick
    )

{-| An on/off control that can be toggled by clicking.

@docs component, checked, disabled, icons, name, value
@docs dirty, pristine, touched, untouched, willvalidate, validationmessage
@docs onBeforeinput, onInput, onChange, onClick

-}

import Cem.M3e.Common
import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| An on/off control that can be toggled by clicking.

**Events:**

  - `beforeinput`: Dispatched before the checked state changes.
  - `input`: Dispatched when the checked state changes.
  - `change`: Dispatched when the checked state changes.
  - `click`: Dispatched when the element is clicked.

**CSS Custom Properties:**

  - `--m3e-switch-selected-icon-color`: Color of the icon when the switch is selected.
  - `--m3e-switch-selected-icon-size`: Size of the icon in the selected state.
  - `--m3e-switch-unselected-icon-color`: Color of the icon when the switch is unselected.
  - `--m3e-switch-unselected-icon-size`: Size of the icon in the unselected state.
  - `--m3e-switch-track-height`: Height of the switch track.
  - `--m3e-switch-track-width`: Width of the switch track.
  - `--m3e-switch-track-outline-color`: Color of the track's outline.
  - `--m3e-switch-track-outline-width`: Thickness of the track's outline.
  - `--m3e-switch-track-shape`: Corner shape of the track.
  - `--m3e-switch-selected-track-color`: Track color when selected.
  - `--m3e-switch-unselected-track-color`: Track color when unselected.
  - `--m3e-switch-unselected-handle-height`: Height of the handle when unselected.
  - `--m3e-switch-unselected-handle-width`: Width of the handle when unselected.
  - `--m3e-switch-with-icon-handle-height`: Height of the handle when icons are present.
  - `--m3e-switch-with-icon-handle-width`: Width of the handle when icons are present.
  - `--m3e-switch-selected-handle-height`: Height of the handle when selected.
  - `--m3e-switch-selected-handle-width`: Width of the handle when selected.
  - `--m3e-switch-pressed-handle-height`: Height of the handle during press.
  - `--m3e-switch-pressed-handle-width`: Width of the handle during press.
  - `--m3e-switch-handle-shape`: Corner shape of the handle.
  - `--m3e-switch-selected-handle-color`: Handle color when selected.
  - `--m3e-switch-unselected-handle-color`: Handle color when unselected.
  - `--m3e-switch-state-layer-size`: Diameter of the state layer overlay.
  - `--m3e-switch-state-layer-shape`: Corner shape of the state layer.
  - `--m3e-switch-disabled-selected-icon-color`: Icon color when selected and disabled.
  - `--m3e-switch-disabled-selected-icon-opacity`: Icon opacity when selected and disabled.
  - `--m3e-switch-disabled-unselected-icon-color`: Icon color when unselected and disabled.
  - `--m3e-switch-disabled-unselected-icon-opacity`: Icon opacity when unselected and disabled.
  - `--m3e-switch-disabled-track-opacity`: Track opacity when disabled.
  - `--m3e-switch-disabled-selected-track-color`: Track color when selected and disabled.
  - `--m3e-switch-disabled-unselected-track-color`: Track color when unselected and disabled.
  - `--m3e-switch-disabled-unselected-track-outline-color`: Outline color when unselected and disabled.
  - `--m3e-switch-disabled-unselected-handle-opacity`: Handle opacity when unselected and disabled.
  - `--m3e-switch-disabled-selected-handle-opacity`: Handle opacity when selected and disabled.
  - `--m3e-switch-disabled-selected-handle-color`: Handle color when selected and disabled.
  - `--m3e-switch-disabled-unselected-handle-color`: Handle color when unselected and disabled.
  - `--m3e-switch-selected-hover-icon-color`: Icon color when selected and hovered.
  - `--m3e-switch-unselected-hover-icon-color`: Icon color when unselected and hovered.
  - `--m3e-switch-selected-hover-track-color`: Track color when selected and hovered.
  - `--m3e-switch-selected-hover-state-layer-color`: State layer color when selected and hovered.
  - `--m3e-switch-selected-hover-state-layer-opacity`: State layer opacity when selected and hovered.
  - `--m3e-switch-unselected-hover-track-color`: Track color when unselected and hovered.
  - `--m3e-switch-unselected-hover-track-outline-color`: Outline color when unselected and hovered.
  - `--m3e-switch-unselected-hover-state-layer-color`: State layer color when unselected and hovered.
  - `--m3e-switch-unselected-hover-state-layer-opacity`: State layer opacity when unselected and hovered.
  - `--m3e-switch-selected-hover-handle-color`: Handle color when selected and hovered.
  - `--m3e-switch-unselected-hover-handle-color`: Handle color when unselected and hovered.
  - `--m3e-switch-selected-focus-icon-color`: Icon color when selected and focused.
  - `--m3e-switch-unselected-focus-icon-color`: Icon color when unselected and focused.
  - `--m3e-switch-selected-focus-track-color`: Track color when selected and focused.
  - `--m3e-switch-selected-focus-state-layer-color`: State layer color when selected and focused.
  - `--m3e-switch-selected-focus-state-layer-opacity`: State layer opacity when selected and focused.
  - `--m3e-switch-unselected-focus-track-color`: Track color when unselected and focused.
  - `--m3e-switch-unselected-focus-track-outline-color`: Outline color when unselected and focused.
  - `--m3e-switch-unselected-focus-state-layer-color`: State layer color when unselected and focused.
  - `--m3e-switch-unselected-focus-state-layer-opacity`: State layer opacity when unselected and focused.
  - `--m3e-switch-selected-focus-handle-color`: Handle color when selected and focused.
  - `--m3e-switch-unselected-focus-handle-color`: Handle color when unselected and focused.
  - `--m3e-switch-selected-pressed-icon-color`: Icon color when selected and pressed.
  - `--m3e-switch-unselected-pressed-icon-color`: Icon color when unselected and pressed.
  - `--m3e-switch-selected-pressed-track-color`: Track color when selected and pressed.
  - `--m3e-switch-selected-pressed-state-layer-color`: State layer color when selected and pressed.
  - `--m3e-switch-selected-pressed-state-layer-opacity`: State layer opacity when selected and pressed.
  - `--m3e-switch-unselected-pressed-track-color`: Track color when unselected and pressed.
  - `--m3e-switch-unselected-pressed-track-outline-color`: Outline color when unselected and pressed.
  - `--m3e-switch-unselected-pressed-state-layer-color`: State layer color when unselected and pressed.
  - `--m3e-switch-unselected-pressed-state-layer-opacity`: State layer opacity when unselected and pressed.
  - `--m3e-switch-selected-pressed-handle-color`: Handle color when selected and pressed.
  - `--m3e-switch-unselected-pressed-handle-color`: Handle color when unselected and pressed.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-switch" attributes children


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


{-| The icons to present. (default: `"none"`)
-}
icons :
    Cem.M3e.Common.Value
        { both : Cem.M3e.Common.Supported
        , none : Cem.M3e.Common.Supported
        , selected : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
icons =
    Cem.M3e.Common.icons


{-| The name that identifies the element when submitting the associated form.
-}
name : String -> Html.Attribute msg
name val_ =
    Html.Attributes.attribute "name" val_


{-| A string representing the value of the switch. (default: `"on"`)
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


{-| Whether the element is a submittable element that is a candidate for constraint validation.
-}
willvalidate : Bool -> Html.Attribute msg
willvalidate val_ =
    Html.Attributes.property "willValidate" (Json.Encode.bool val_)


{-| The error message that would be displayed if the user submits the form, or an empty string if no error message.
-}
validationmessage : String -> Html.Attribute msg
validationmessage val_ =
    Html.Attributes.property "validationMessage" (Json.Encode.string val_)


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

**Payload type:** `MouseEvent`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

-}
onClick : Json.Decode.Decoder msg -> Html.Attribute msg
onClick decoder =
    Html.Events.on "click" decoder
