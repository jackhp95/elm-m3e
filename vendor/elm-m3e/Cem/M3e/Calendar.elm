module Cem.M3e.Calendar exposing
    ( component, date, maxDate, minDate, rangeEnd, rangeStart
    , startAt, startView, previousMonthLabel, nextMonthLabel, previousYearLabel, nextYearLabel
    , previousMultiYearLabel, nextMultiYearLabel, periodlabel, canmovepreviousperiod, canmovenextperiod, onChange
    , headerSlot
    )

{-| A calendar used to select a date.

@docs component, date, maxDate, minDate, rangeEnd, rangeStart
@docs startAt, startView, previousMonthLabel, nextMonthLabel, previousYearLabel, nextYearLabel
@docs previousMultiYearLabel, nextMultiYearLabel, periodlabel, canmovepreviousperiod, canmovenextperiod, onChange
@docs headerSlot

-}

import Cem.M3e.Common
import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| A calendar used to select a date.

**Events:**

  - `change`: Dispatched when the selected date changes.

**Slots:**

  - `header`: Renders the header of the calendar.

**CSS Custom Properties:**

  - `--m3e-calendar-container-color`: Background color of the container surface.
  - `--m3e-calendar-container-elevation`: Elevation shadow applied to the container surface.
  - `--m3e-calendar-container-shape`: Corner radius of the container surface.
  - `--m3e-calendar-padding`: Padding applied to the calendar header and body.
  - `--m3e-calendar-period-button-text-color`: Text color used for the period‑navigation buttons in the header.
  - `--m3e-calendar-weekday-font-size`: Font size of weekday labels in month view.
  - `--m3e-calendar-weekday-font-weight`: Font weight of weekday labels in month view.
  - `--m3e-calendar-weekday-line-height`: Line height of weekday labels in month view.
  - `--m3e-calendar-weekday-tracking`: Letter spacing of weekday labels in month view.
  - `--m3e-calendar-weekday-color`: Text color for weekday labels in month view.
  - `--m3e-calendar-date-font-size`: Font size of date cells in month view.
  - `--m3e-calendar-date-font-weight`: Font weight of date cells in month view.
  - `--m3e-calendar-date-line-height`: Line height of date cells in month view.
  - `--m3e-calendar-date-tracking`: Letter spacing of date cells in month view.
  - `--m3e-calendar-item-font-size`: Font size of items in year and multi‑year views.
  - `--m3e-calendar-item-font-weight`: Font weight of items in year and multi‑year views.
  - `--m3e-calendar-item-line-height`: Line height of items in year and multi‑year views.
  - `--m3e-calendar-item-tracking`: Letter spacing of items in year and multi‑year views.
  - `--m3e-calendar-item-color`: Text color for date items.
  - `--m3e-calendar-item-selected-color`: Text color for selected date items.
  - `--m3e-calendar-item-selected-container-color`: Background color for selected date items.
  - `--m3e-calendar-item-selected-ripple-color`: Ripple color used when interacting with selected date items.
  - `--m3e-calendar-item-selected-hover-color`: Hover color used when interacting with selected date items.
  - `--m3e-calendar-item-selected-focus-color`: Focus color used when interacting with selected date items.
  - `--m3e-calendar-item-current-outline-thickness`: Outline thickness used to indicate the current date.
  - `--m3e-calendar-item-current-outline-color`: Outline color used to indicate the current date.
  - `--m3e-calendar-item-special-color`: Text color for dates marked as special.
  - `--m3e-calendar-item-special-container-color`: Background color for dates marked as special.
  - `--m3e-calendar-item-special-ripple-color`: Ripple color used when interacting with dates marked as special.
  - `--m3e-calendar-item-special-hover-color`: Hover color used when interacting with dates marked as special.
  - `--m3e-calendar-item-special-focus-color`: Focus color used when interacting with dates marked as special.
  - `--m3e-calendar-range-container-color`: Background color applied to the selected date range.
  - `--m3e-calendar-range-color`: Text color for dates within a selected range.
  - `--m3e-calendar-item-disabled-color`: Color used for disabled date items.
  - `--m3e-calendar-item-disabled-color-opacity`: Opacity applied to the disabled item color.
  - `--m3e-calendar-slide-animation-duration`: Duration of slide transitions between calendar views.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-calendar" attributes children


{-| The selected date. (default: `null`)
-}
date : String -> Html.Attribute msg
date val_ =
    Html.Attributes.attribute "date" val_


{-| The maximum date that can be selected. (default: `null`)
-}
maxDate : String -> Html.Attribute msg
maxDate val_ =
    Html.Attributes.attribute "max-date" val_


{-| The minimum date that can be selected. (default: `null`)
-}
minDate : String -> Html.Attribute msg
minDate val_ =
    Html.Attributes.attribute "min-date" val_


{-| End of a date range. (default: `null`)
-}
rangeEnd : String -> Html.Attribute msg
rangeEnd val_ =
    Html.Attributes.attribute "range-end" val_


{-| Start of a date range. (default: `null`)
-}
rangeStart : String -> Html.Attribute msg
rangeStart val_ =
    Html.Attributes.attribute "range-start" val_


{-| A date specifying the period (month or year) to start the calendar in. (default: `null`)
-}
startAt : String -> Html.Attribute msg
startAt val_ =
    Html.Attributes.attribute "start-at" val_


{-| The initial view used to select a date. (default: `"month"`)
-}
startView :
    Cem.M3e.Common.Value
        { month : Cem.M3e.Common.Supported
        , multiYear : Cem.M3e.Common.Supported
        , year : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
startView =
    Cem.M3e.Common.startView


{-| The accessible label given to the button used to move to the previous month. (default: `"Previous month"`)
-}
previousMonthLabel : String -> Html.Attribute msg
previousMonthLabel val_ =
    Html.Attributes.attribute "previous-month-label" val_


{-| The accessible label given to the button used to move to the next month. (default: `"Next month"`)
-}
nextMonthLabel : String -> Html.Attribute msg
nextMonthLabel val_ =
    Html.Attributes.attribute "next-month-label" val_


{-| The accessible label given to the button used to move to the previous year. (default: `"Previous year"`)
-}
previousYearLabel : String -> Html.Attribute msg
previousYearLabel val_ =
    Html.Attributes.attribute "previous-year-label" val_


{-| The accessible label given to the button used to move to the next year. (default: `"Next year"`)
-}
nextYearLabel : String -> Html.Attribute msg
nextYearLabel val_ =
    Html.Attributes.attribute "next-year-label" val_


{-| The accessible label given to the button used to move to the previous 24 years. (default: `"Previous 24 years"`)
-}
previousMultiYearLabel : String -> Html.Attribute msg
previousMultiYearLabel val_ =
    Html.Attributes.attribute "previous-multi-year-label" val_


{-| The accessible label given to the button used to move to the next 24 years. (default: `"Next 24 years"`)
-}
nextMultiYearLabel : String -> Html.Attribute msg
nextMultiYearLabel val_ =
    Html.Attributes.attribute "next-multi-year-label" val_


{-| The label to present for the current period.
-}
periodlabel : String -> Html.Attribute msg
periodlabel val_ =
    Html.Attributes.property "periodLabel" (Json.Encode.string val_)


{-| Whether the calendar can move to the previous period.
-}
canmovepreviousperiod : Bool -> Html.Attribute msg
canmovepreviousperiod val_ =
    Html.Attributes.property "canMovePreviousPeriod" (Json.Encode.bool val_)


{-| Whether the calendar can move to the next period.
-}
canmovenextperiod : Bool -> Html.Attribute msg
canmovenextperiod val_ =
    Html.Attributes.property "canMoveNextPeriod" (Json.Encode.bool val_)


{-| Dispatched when the selected date changes.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `Cem.M3e.Common`, e.g. `onChange (Json.Decode.map ValueChanged Cem.M3e.Common.targetValue)`.

-}
onChange : Json.Decode.Decoder msg -> Html.Attribute msg
onChange decoder =
    Html.Events.on "change" decoder


{-| Renders the header of the calendar.
-}
headerSlot : Html.Attribute msg
headerSlot =
    Html.Attributes.attribute "slot" "header"
