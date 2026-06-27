module Cem.M3e.MonthView exposing
    ( component
    , rangeStart, rangeEnd, today, date, activeDate, minDate, maxDate
    , onChange, onActiveChange
    )

{-| An internal component used to display a single month in a calendar.


## Component

@docs component


### Attributes

@docs rangeStart, rangeEnd, today, date, activeDate, minDate, maxDate


### Events

@docs onChange, onActiveChange

-}

import Html
import Html.Attributes
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


{-| Start of a date range. (default: `null`)
-}
rangeStart : String -> Html.Attribute msg
rangeStart val_ =
    Html.Attributes.attribute "range-start" val_


{-| End of a date range. (default: `null`)
-}
rangeEnd : String -> Html.Attribute msg
rangeEnd val_ =
    Html.Attributes.attribute "range-end" val_


{-| Today's date. (default: `new Date()`)
-}
today : String -> Html.Attribute msg
today val_ =
    Html.Attributes.attribute "today" val_


{-| The selected date. (default: `null`)
-}
date : String -> Html.Attribute msg
date val_ =
    Html.Attributes.attribute "date" val_


{-| The active date. (default: `new Date()`)
-}
activeDate : String -> Html.Attribute msg
activeDate val_ =
    Html.Attributes.attribute "active-date" val_


{-| The minimum date that can be selected. (default: `null`)
-}
minDate : String -> Html.Attribute msg
minDate val_ =
    Html.Attributes.attribute "min-date" val_


{-| The maximum date that can be selected. (default: `null`)
-}
maxDate : String -> Html.Attribute msg
maxDate val_ =
    Html.Attributes.attribute "max-date" val_


{-| Listen for `change` events.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `Cem.M3e.Common`, e.g. `onChange (Json.Decode.map ValueChanged Cem.M3e.Common.targetValue)`.

-}
onChange : Json.Decode.Decoder msg -> Html.Attribute msg
onChange decoder =
    Html.Events.on "change" decoder


{-| Listen for `active-change` events.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `Cem.M3e.Common`, e.g. `onActiveChange (Json.Decode.map ValueChanged Cem.M3e.Common.targetValue)`.

-}
onActiveChange : Json.Decode.Decoder msg -> Html.Attribute msg
onActiveChange decoder =
    Html.Events.on "active-change" decoder
