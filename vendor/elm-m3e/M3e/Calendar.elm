module M3e.Calendar exposing
    ( component
    , onChange
    , headerSlot
    )

{-| A calendar used to select a date.


## Component

@docs component


### Events

@docs onChange


### Slots

@docs headerSlot

-}

import Html
import Html.Attributes
import Html.Events
import Json.Decode


{-| A calendar used to select a date.

**Events:**

  - `change`: Dispatched when the selected date changes.

**Slots:**

  - `header`: Renders the header of the calendar.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-calendar" attributes children


{-| Dispatched when the selected date changes.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `M3e.Common`, e.g. `onChange (Json.Decode.map ValueChanged M3e.Common.targetValue)`.

-}
onChange : Json.Decode.Decoder msg -> Html.Attribute msg
onChange decoder =
    Html.Events.on "change" decoder


{-| Renders the header of the calendar.
-}
headerSlot : Html.Attribute msg
headerSlot =
    Html.Attributes.attribute "slot" "header"
