module M3e.Calendar exposing (StartView(..), component, date, headerSlot, maxDate, minDate, nextMonthLabel, nextMultiYearLabel, nextYearLabel, onChange, previousMonthLabel, previousMultiYearLabel, previousYearLabel, rangeEnd, rangeStart, startAt, startView)

{-| 
A calendar used to select a date.

## Component

@docs component

### Attributes

@docs date, maxDate, minDate, rangeEnd, rangeStart, startAt, StartView, startView, previousMonthLabel, nextMonthLabel, previousYearLabel, nextYearLabel, previousMultiYearLabel, nextMultiYearLabel

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


{-| The selected date. (default: `null`) -}
date : String -> Html.Attribute msg
date val_ =
    Html.Attributes.attribute "date" val_


{-| The maximum date that can be selected. (default: `null`) -}
maxDate : String -> Html.Attribute msg
maxDate val_ =
    Html.Attributes.attribute "max-date" val_


{-| The minimum date that can be selected. (default: `null`) -}
minDate : String -> Html.Attribute msg
minDate val_ =
    Html.Attributes.attribute "min-date" val_


{-| End of a date range. (default: `null`) -}
rangeEnd : String -> Html.Attribute msg
rangeEnd val_ =
    Html.Attributes.attribute "range-end" val_


{-| Start of a date range. (default: `null`) -}
rangeStart : String -> Html.Attribute msg
rangeStart val_ =
    Html.Attributes.attribute "range-start" val_


{-| A date specifying the period (month or year) to start the calendar in. (default: `null`) -}
startAt : String -> Html.Attribute msg
startAt val_ =
    Html.Attributes.attribute "start-at" val_


{-| Values for the `start-view` attribute. -}
type StartView
    = Month
    | MultiYear
    | Year


{-| The initial view used to select a date. (default: `"month"`) -}
startView : StartView -> Html.Attribute msg
startView val_ =
    Html.Attributes.attribute "start-view" (startViewToString val_)


startViewToString : StartView -> String
startViewToString val_ =
    case val_ of
        Month ->
            "month"
    
        MultiYear ->
            "multi-year"
    
        Year ->
            "year"


{-| The accessible label given to the button used to move to the previous month. (default: `"Previous month"`) -}
previousMonthLabel : String -> Html.Attribute msg
previousMonthLabel val_ =
    Html.Attributes.attribute "previous-month-label" val_


{-| The accessible label given to the button used to move to the next month. (default: `"Next month"`) -}
nextMonthLabel : String -> Html.Attribute msg
nextMonthLabel val_ =
    Html.Attributes.attribute "next-month-label" val_


{-| The accessible label given to the button used to move to the previous year. (default: `"Previous year"`) -}
previousYearLabel : String -> Html.Attribute msg
previousYearLabel val_ =
    Html.Attributes.attribute "previous-year-label" val_


{-| The accessible label given to the button used to move to the next year. (default: `"Next year"`) -}
nextYearLabel : String -> Html.Attribute msg
nextYearLabel val_ =
    Html.Attributes.attribute "next-year-label" val_


{-| The accessible label given to the button used to move to the previous 24 years. (default: `"Previous 24 years"`) -}
previousMultiYearLabel : String -> Html.Attribute msg
previousMultiYearLabel val_ =
    Html.Attributes.attribute "previous-multi-year-label" val_


{-| The accessible label given to the button used to move to the next 24 years. (default: `"Next 24 years"`) -}
nextMultiYearLabel : String -> Html.Attribute msg
nextMultiYearLabel val_ =
    Html.Attributes.attribute "next-multi-year-label" val_


{-| Dispatched when the selected date changes.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `M3e.Common`, e.g. `onChange (Json.Decode.map ValueChanged M3e.Common.targetValue)`.
-}
onChange : Json.Decode.Decoder msg -> Html.Attribute msg
onChange decoder =
    Html.Events.on "change" decoder


{-| Renders the header of the calendar. -}
headerSlot : Html.Attribute msg
headerSlot =
    Html.Attributes.attribute "slot" "header"