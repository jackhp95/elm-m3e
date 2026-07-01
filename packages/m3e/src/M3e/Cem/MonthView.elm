module M3e.Cem.MonthView exposing (activeDate, date, maxDate, minDate, monthView, onActiveChange, onChange, rangeEnd, rangeStart, today)

{-| 
@docs monthView, rangeStart, rangeEnd, today, date, activeDate, minDate, maxDate, onChange, onActiveChange
-}


import Html
import Json.Decode
import M3e.Cem.Attr
import M3e.Cem.Html.MonthView
import M3e.Value


{-| An internal component used to display a single month in a calendar.

**Component Info:**
- **Extends:** `CalendarViewElementBase` from `/src/calendar/CalendarViewElementBase`

**Events:**
- `change`: No description
- `active-change`: No description
-}
monthView :
    List (M3e.Cem.Attr.Attr { rangeStart : M3e.Value.Supported
    , rangeEnd : M3e.Value.Supported
    , today : M3e.Value.Supported
    , date : M3e.Value.Supported
    , activeDate : M3e.Value.Supported
    , minDate : M3e.Value.Supported
    , maxDate : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onActiveChange : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
monthView attributes children =
    M3e.Cem.Html.MonthView.monthView
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| Start of a date range. (default: `null`) -}
rangeStart :
    String -> M3e.Cem.Attr.Attr { c | rangeStart : M3e.Value.Supported } msg
rangeStart =
    M3e.Cem.Attr.attribute M3e.Cem.Html.MonthView.rangeStart


{-| End of a date range. (default: `null`) -}
rangeEnd :
    String -> M3e.Cem.Attr.Attr { c | rangeEnd : M3e.Value.Supported } msg
rangeEnd =
    M3e.Cem.Attr.attribute M3e.Cem.Html.MonthView.rangeEnd


{-| Today's date. (default: `new Date()`) -}
today : String -> M3e.Cem.Attr.Attr { c | today : M3e.Value.Supported } msg
today =
    M3e.Cem.Attr.attribute M3e.Cem.Html.MonthView.today


{-| The selected date. (default: `null`) -}
date : String -> M3e.Cem.Attr.Attr { c | date : M3e.Value.Supported } msg
date =
    M3e.Cem.Attr.attribute M3e.Cem.Html.MonthView.date


{-| The active date. (default: `new Date()`) -}
activeDate :
    String -> M3e.Cem.Attr.Attr { c | activeDate : M3e.Value.Supported } msg
activeDate =
    M3e.Cem.Attr.attribute M3e.Cem.Html.MonthView.activeDate


{-| The minimum date that can be selected. (default: `null`) -}
minDate : String -> M3e.Cem.Attr.Attr { c | minDate : M3e.Value.Supported } msg
minDate =
    M3e.Cem.Attr.attribute M3e.Cem.Html.MonthView.minDate


{-| The maximum date that can be selected. (default: `null`) -}
maxDate : String -> M3e.Cem.Attr.Attr { c | maxDate : M3e.Value.Supported } msg
maxDate =
    M3e.Cem.Attr.attribute M3e.Cem.Html.MonthView.maxDate


{-| Listen for `change` events. -}
onChange : msg -> M3e.Cem.Attr.Attr { c | onChange : M3e.Value.Supported } msg
onChange f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.MonthView.onChange
        (Json.Decode.succeed f_)


{-| Listen for `active-change` events. -}
onActiveChange :
    msg -> M3e.Cem.Attr.Attr { c | onActiveChange : M3e.Value.Supported } msg
onActiveChange f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.MonthView.onActiveChange
        (Json.Decode.succeed f_)