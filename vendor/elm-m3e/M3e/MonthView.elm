module M3e.MonthView exposing
    ( component
    , onChange, onActiveChange
    )

{-| An internal component used to display a single month in a calendar.


## Component

@docs component


### Events

@docs onChange, onActiveChange

-}

import Html
import Html.Events
import Json.Decode


{-| An internal component used to display a single month in a calendar.

**Component Info:**

  - **Extends:** `CalendarViewElementBase` from `/src/calendar/CalendarViewElementBase`

**Events:**

  - `change`: No description
  - `active-change`: No description

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-month-view" attributes children


{-| Listen for `change` events.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `M3e.Common`, e.g. `onChange (Json.Decode.map ValueChanged M3e.Common.targetValue)`.

-}
onChange : Json.Decode.Decoder msg -> Html.Attribute msg
onChange decoder =
    Html.Events.on "change" decoder


{-| Listen for `active-change` events.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `M3e.Common`, e.g. `onActiveChange (Json.Decode.map ValueChanged M3e.Common.targetValue)`.

-}
onActiveChange : Json.Decode.Decoder msg -> Html.Attribute msg
onActiveChange decoder =
    Html.Events.on "active-change" decoder
