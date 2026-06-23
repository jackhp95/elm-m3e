module M3e.Button exposing
    ( component
    , value
    , onBeforeinput, onInput, onChange, onClick
    , iconSlot, selectedSlot, selectedIconSlot, trailingIconSlot
    )

{-| A button users interact with to perform an action.


## Component

@docs component


### Attributes

@docs value


### Events

@docs onBeforeinput, onInput, onChange, onClick


### Slots

@docs iconSlot, selectedSlot, selectedIconSlot, trailingIconSlot

-}

import Html
import Html.Attributes
import Html.Events
import Json.Decode


{-| A button users interact with to perform an action.

**Events:**

  - `beforeinput`: Dispatched before a toggle button's selected state changes.
  - `input`: Dispatched when a toggle button's selected state changes.
  - `change`: Dispatched when a toggle button's selected state changes.
  - `click`: Dispatched when the element is clicked.

**Slots:**

  - `icon`: Renders an icon before the button's label.
  - `selected`: Renders the label of the button, when selected.
  - `selected-icon`: Renders an icon before the button's label, when selected.
  - `trailing-icon`: Renders an icon after the button's label.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-button" attributes children


{-| The value associated with the element's name when it's submitted with form data.
-}
value : String -> Html.Attribute msg
value =
    Html.Attributes.value


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


{-| Renders an icon before the button's label.
-}
iconSlot : Html.Attribute msg
iconSlot =
    Html.Attributes.attribute "slot" "icon"


{-| Renders the label of the button, when selected.
-}
selectedSlot : Html.Attribute msg
selectedSlot =
    Html.Attributes.attribute "slot" "selected"


{-| Renders an icon before the button's label, when selected.
-}
selectedIconSlot : Html.Attribute msg
selectedIconSlot =
    Html.Attributes.attribute "slot" "selected-icon"


{-| Renders an icon after the button's label.
-}
trailingIconSlot : Html.Attribute msg
trailingIconSlot =
    Html.Attributes.attribute "slot" "trailing-icon"
