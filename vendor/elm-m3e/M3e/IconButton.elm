module M3e.IconButton exposing
    ( component
    , value, width
    , onBeforeinput, onInput, onChange, onClick
    , selectedSlot
    )

{-| An icon button users interact with to perform a supplementary action.


## Component

@docs component


### Attributes

@docs value, width


### Events

@docs onBeforeinput, onInput, onChange, onClick


### Slots

@docs selectedSlot

-}

import Html
import Html.Attributes
import Html.Events
import Json.Decode


{-| An icon button users interact with to perform a supplementary action.

**Events:**

  - `beforeinput`: Dispatched before a toggle button's selected state changes.
  - `input`: Dispatched when a toggle button's selected state changes.
  - `change`: Dispatched when a toggle button's selected state changes.
  - `click`: Dispatched when the element is clicked.

**Slots:**

  - `selected`: Renders an icon, when selected.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-icon-button" attributes children


{-| The value associated with the element's name when it's submitted with form data.
-}
value : String -> Html.Attribute msg
value =
    Html.Attributes.value


{-| The width of the button. (default: `"default"`)
-}
width : String -> Html.Attribute msg
width val_ =
    Html.Attributes.attribute "width" val_


{-| Dispatched before a toggle button's selected state changes.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `M3e.Common`, e.g. `onBeforeinput (Json.Decode.map ValueChanged M3e.Common.targetValue)`.

-}
onBeforeinput : Json.Decode.Decoder msg -> Html.Attribute msg
onBeforeinput decoder =
    Html.Events.on "beforeinput" decoder


{-| Dispatched when a toggle button's selected state changes.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `M3e.Common`, e.g. `onInput (Json.Decode.map ValueChanged M3e.Common.targetValue)`.

-}
onInput : Json.Decode.Decoder msg -> Html.Attribute msg
onInput decoder =
    Html.Events.on "input" decoder


{-| Dispatched when a toggle button's selected state changes.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `M3e.Common`, e.g. `onChange (Json.Decode.map ValueChanged M3e.Common.targetValue)`.

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


{-| Renders an icon, when selected.
-}
selectedSlot : Html.Attribute msg
selectedSlot =
    Html.Attributes.attribute "slot" "selected"
