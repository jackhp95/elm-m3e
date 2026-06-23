module M3e.SegmentedButton exposing (component, name, onBeforeinput, onChange, onInput)

{-| 
A button that allows a user to select from a limited set of options.

## Component

@docs component

### Attributes

@docs name

### Events

@docs onChange, onBeforeinput, onInput
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode


{-| A button that allows a user to select from a limited set of options.

**Events:**
- `change`: Dispatched when the checked state of a segment changes.
- `beforeinput`: Dispatched before the checked state of a segment changes.
- `input`: Dispatched when the checked state of a segment changes.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-segmented-button" attributes children


{-| The name that identifies the element when submitting the associated form. -}
name : String -> Html.Attribute msg
name val_ =
    Html.Attributes.attribute "name" val_


{-| Dispatched when the checked state of a segment changes.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `M3e.Common`, e.g. `onChange (Json.Decode.map ValueChanged M3e.Common.targetValue)`.
-}
onChange : Json.Decode.Decoder msg -> Html.Attribute msg
onChange decoder =
    Html.Events.on "change" decoder


{-| Dispatched before the checked state of a segment changes.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `M3e.Common`, e.g. `onBeforeinput (Json.Decode.map ValueChanged M3e.Common.targetValue)`.
-}
onBeforeinput : Json.Decode.Decoder msg -> Html.Attribute msg
onBeforeinput decoder =
    Html.Events.on "beforeinput" decoder


{-| Dispatched when the checked state of a segment changes.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `M3e.Common`, e.g. `onInput (Json.Decode.map ValueChanged M3e.Common.targetValue)`.
-}
onInput : Json.Decode.Decoder msg -> Html.Attribute msg
onInput decoder =
    Html.Events.on "input" decoder