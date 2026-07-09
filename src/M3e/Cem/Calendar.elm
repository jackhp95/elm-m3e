module M3e.Cem.Calendar exposing
    ( calendar, date, maxDate, minDate, rangeEnd, rangeStart
    , startAt, startView, previousMonthLabel, nextMonthLabel, previousYearLabel, nextYearLabel, previousMultiYearLabel
    , nextMultiYearLabel, onChange
    )

{-|
Middle layer for `<m3e-calendar>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.Calendar` module for everyday use.

@docs calendar, date, maxDate, minDate, rangeEnd, rangeStart
@docs startAt, startView, previousMonthLabel, nextMonthLabel, previousYearLabel, nextYearLabel
@docs previousMultiYearLabel, nextMultiYearLabel, onChange
-}


import Html
import Json.Decode
import Json.Encode
import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.Html.Calendar
import M3e.Value


{-| A calendar used to select a date.

**Component Info:**
- **Extends:** `LitElement`

**Events:**
- `change`: Dispatched when the selected date changes.

**Slots:**
- `header`: Renders the header of the calendar.
-}
calendar :
    List (M3e.Cem.Attr.Attr { date : M3e.Value.Supported
    , maxDate : M3e.Value.Supported
    , minDate : M3e.Value.Supported
    , rangeEnd : M3e.Value.Supported
    , rangeStart : M3e.Value.Supported
    , startAt : M3e.Value.Supported
    , startView : M3e.Value.Supported
    , previousMonthLabel : M3e.Value.Supported
    , nextMonthLabel : M3e.Value.Supported
    , previousYearLabel : M3e.Value.Supported
    , nextYearLabel : M3e.Value.Supported
    , previousMultiYearLabel : M3e.Value.Supported
    , nextMultiYearLabel : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
calendar attributes children =
    M3e.Cem.Html.Calendar.calendar
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| The selected date. (default: `null`) -}
date : String -> M3e.Cem.Attr.Attr { c | date : M3e.Value.Supported } msg
date =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Calendar.date


{-| The maximum date that can be selected. (default: `null`) -}
maxDate : String -> M3e.Cem.Attr.Attr { c | maxDate : M3e.Value.Supported } msg
maxDate =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Calendar.maxDate


{-| The minimum date that can be selected. (default: `null`) -}
minDate : String -> M3e.Cem.Attr.Attr { c | minDate : M3e.Value.Supported } msg
minDate =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Calendar.minDate


{-| End of a date range. (default: `null`) -}
rangeEnd :
    String -> M3e.Cem.Attr.Attr { c | rangeEnd : M3e.Value.Supported } msg
rangeEnd =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Calendar.rangeEnd


{-| Start of a date range. (default: `null`) -}
rangeStart :
    String -> M3e.Cem.Attr.Attr { c | rangeStart : M3e.Value.Supported } msg
rangeStart =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Calendar.rangeStart


{-| A date specifying the period (month or year) to start the calendar in. (default: `null`) -}
startAt : String -> M3e.Cem.Attr.Attr { c | startAt : M3e.Value.Supported } msg
startAt =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Calendar.startAt


{-| The initial view used to select a date. (default: `"month"`) -}
startView :
    M3e.Value.Value { month : M3e.Value.Supported
    , multiYear : M3e.Value.Supported
    , year : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | startView : M3e.Value.Supported } msg
startView v_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.Calendar.startView
        (M3e.Value.toString v_)


{-| The accessible label given to the button used to move to the previous month. (default: `"Previous month"`) -}
previousMonthLabel :
    String
    -> M3e.Cem.Attr.Attr { c | previousMonthLabel : M3e.Value.Supported } msg
previousMonthLabel =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Calendar.previousMonthLabel


{-| The accessible label given to the button used to move to the next month. (default: `"Next month"`) -}
nextMonthLabel :
    String -> M3e.Cem.Attr.Attr { c | nextMonthLabel : M3e.Value.Supported } msg
nextMonthLabel =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Calendar.nextMonthLabel


{-| The accessible label given to the button used to move to the previous year. (default: `"Previous year"`) -}
previousYearLabel :
    String
    -> M3e.Cem.Attr.Attr { c | previousYearLabel : M3e.Value.Supported } msg
previousYearLabel =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Calendar.previousYearLabel


{-| The accessible label given to the button used to move to the next year. (default: `"Next year"`) -}
nextYearLabel :
    String -> M3e.Cem.Attr.Attr { c | nextYearLabel : M3e.Value.Supported } msg
nextYearLabel =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Calendar.nextYearLabel


{-| The accessible label given to the button used to move to the previous 24 years. (default: `"Previous 24 years"`) -}
previousMultiYearLabel :
    String
    -> M3e.Cem.Attr.Attr { c
        | previousMultiYearLabel : M3e.Value.Supported
    } msg
previousMultiYearLabel =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Calendar.previousMultiYearLabel


{-| The accessible label given to the button used to move to the next 24 years. (default: `"Next 24 years"`) -}
nextMultiYearLabel :
    String
    -> M3e.Cem.Attr.Attr { c | nextMultiYearLabel : M3e.Value.Supported } msg
nextMultiYearLabel =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Calendar.nextMultiYearLabel


{-| Listen for `change` events. -}
onChange :
    (String -> msg)
    -> M3e.Cem.Attr.Attr { c | onChange : M3e.Value.Supported } msg
onChange f_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.Calendar.onChange
        (Json.Decode.map
             f_
             (Json.Decode.andThen
                  (\v_ ->
                       case
                           Json.Decode.decodeString
                               Json.Decode.string
                               (Json.Encode.encode 0 v_)
                       of
                           Ok s_ ->
                               Json.Decode.succeed s_
                       
                           Err e_ ->
                               Json.Decode.fail "expected a Date value"
                  )
                  (Json.Decode.at [ "target", "date" ] Json.Decode.value)
             )
        )