module Ui.Calendar exposing
    ( Calendar, new
    , withAttributes
    , withId
    , withDate, withMinDate, withMaxDate
    , withRangeStart, withRangeEnd
    , StartView(..), withStartView, withStartAt
    , withPreviousMonthLabel, withNextMonthLabel
    , withPreviousYearLabel, withNextYearLabel
    , withPreviousMultiYearLabel, withNextMultiYearLabel
    , withOnChange
    , withHeader
    , view
    )

{-| Typed builder for an M3 calendar widget. Wraps `Cem.M3e.Calendar`.

A standalone, always-visible date-selection surface with month, year, and
multi-year views, supporting single-date and range selection plus min/max
constraints. Use this when you want the calendar inline; for a text field
that opens a calendar popup in a form, use `Ui.DatePicker` instead.

    Ui.Calendar.new
        |> Ui.Calendar.withId "event-cal"
        |> Ui.Calendar.withDate "2026-06-22"
        |> Ui.Calendar.withMinDate todayIso
        |> Ui.Calendar.withOnChange DateSelected
        |> Ui.Calendar.view

Dates are exchanged as ISO-8601 (`"YYYY-MM-DD"`) strings: each `with*`
date setter takes a string, and `withOnChange` receives the selected
date's ISO string from the element's `change` event.


# Construction

@docs Calendar, new


# Host attributes

@docs withAttributes


# Identity

@docs withId


# Date selection

@docs withDate, withMinDate, withMaxDate


# Range

@docs withRangeStart, withRangeEnd


# View control

@docs StartView, withStartView, withStartAt


# Navigation labels

@docs withPreviousMonthLabel, withNextMonthLabel
@docs withPreviousYearLabel, withNextYearLabel
@docs withPreviousMultiYearLabel, withNextMultiYearLabel


# Events

@docs withOnChange


# Header

@docs withHeader


# Render

@docs view

-}

import Html exposing (Attribute, Html)
import Html.Attributes as Attr
import Json.Decode
import Cem.M3e.Calendar
import Cem.M3e.Common


{-| The calendar opaque type. Build via `new`.
-}
type Calendar msg
    = Calendar (Config msg)


{-| Which view the calendar opens to.

  - **MonthView** — the day grid for a single month (the m3e default).
  - **YearView** — the months of a single year.
  - **MultiYearView** — a grid of years (24 at a time) for jumping far.

-}
type StartView
    = MonthView
    | YearView
    | MultiYearView


type alias Config msg =
    { id : Maybe String
    , attributes : List (Attribute msg)
    , date : Maybe String
    , minDate : Maybe String
    , maxDate : Maybe String
    , rangeStart : Maybe String
    , rangeEnd : Maybe String
    , startView : Maybe StartView
    , startAt : Maybe String
    , previousMonthLabel : Maybe String
    , nextMonthLabel : Maybe String
    , previousYearLabel : Maybe String
    , nextYearLabel : Maybe String
    , previousMultiYearLabel : Maybe String
    , nextMultiYearLabel : Maybe String
    , onChange : Maybe (String -> msg)
    , header : Maybe (Html msg)
    }


{-| Construct a fresh calendar with no selection, no date constraints, and
no range. It opens to the month view at the current month.
-}
new : Calendar msg
new =
    Calendar
        { id = Nothing
        , attributes = []
        , date = Nothing
        , minDate = Nothing
        , maxDate = Nothing
        , rangeStart = Nothing
        , rangeEnd = Nothing
        , startView = Nothing
        , startAt = Nothing
        , previousMonthLabel = Nothing
        , nextMonthLabel = Nothing
        , previousYearLabel = Nothing
        , nextYearLabel = Nothing
        , previousMultiYearLabel = Nothing
        , nextMultiYearLabel = Nothing
        , onChange = Nothing
        , header = Nothing
        }


{-| Append attributes to the underlying `<m3e-calendar>` host element — the
escape hatch for styling the component itself. Structural attributes are emitted
after these, so callers can't clobber them.
-}
withAttributes : List (Attribute msg) -> Calendar msg -> Calendar msg
withAttributes attributes (Calendar cfg) =
    Calendar { cfg | attributes = cfg.attributes ++ attributes }


{-| Set the `id` attribute.
-}
withId : String -> Calendar msg -> Calendar msg
withId id (Calendar cfg) =
    Calendar { cfg | id = Just id }


{-| Set the currently selected date as an ISO-8601 string.
-}
withDate : String -> Calendar msg -> Calendar msg
withDate d (Calendar cfg) =
    Calendar { cfg | date = Just d }


{-| Set the earliest selectable date as an ISO-8601 string. Earlier dates
are rendered disabled. Unset by default (no lower bound).
-}
withMinDate : String -> Calendar msg -> Calendar msg
withMinDate d (Calendar cfg) =
    Calendar { cfg | minDate = Just d }


{-| Set the latest selectable date as an ISO-8601 string. Later dates are
rendered disabled. Unset by default (no upper bound).
-}
withMaxDate : String -> Calendar msg -> Calendar msg
withMaxDate d (Calendar cfg) =
    Calendar { cfg | maxDate = Just d }


{-| Set the start of a highlighted date range as an ISO-8601 string. Pair
with `withRangeEnd` to render a range selection between the two dates.
-}
withRangeStart : String -> Calendar msg -> Calendar msg
withRangeStart d (Calendar cfg) =
    Calendar { cfg | rangeStart = Just d }


{-| Set the end of a highlighted date range as an ISO-8601 string. Pair
with `withRangeStart` to render a range selection between the two dates.
-}
withRangeEnd : String -> Calendar msg -> Calendar msg
withRangeEnd d (Calendar cfg) =
    Calendar { cfg | rangeEnd = Just d }


{-| Set which view the calendar opens to (the m3e `start-view` attribute).
Defaults to `MonthView`.
-}
withStartView : StartView -> Calendar msg -> Calendar msg
withStartView sv (Calendar cfg) =
    Calendar { cfg | startView = Just sv }


{-| Set the initial period (month/year) the calendar displays, without
selecting that date, as an ISO-8601 string.
-}
withStartAt : String -> Calendar msg -> Calendar msg
withStartAt d (Calendar cfg) =
    Calendar { cfg | startAt = Just d }


{-| Set the accessible label for the previous-month navigation button (the
m3e `previous-month-label` attribute, default `"Previous month"`). Use to
localise the calendar's screen-reader labels.
-}
withPreviousMonthLabel : String -> Calendar msg -> Calendar msg
withPreviousMonthLabel label (Calendar cfg) =
    Calendar { cfg | previousMonthLabel = Just label }


{-| Set the accessible label for the next-month navigation button (the m3e
`next-month-label` attribute, default `"Next month"`). Use to localise the
calendar's screen-reader labels.
-}
withNextMonthLabel : String -> Calendar msg -> Calendar msg
withNextMonthLabel label (Calendar cfg) =
    Calendar { cfg | nextMonthLabel = Just label }


{-| Set the accessible label for the previous-year navigation button (the
m3e `previous-year-label` attribute, default `"Previous year"`). Use to
localise the calendar's screen-reader labels.
-}
withPreviousYearLabel : String -> Calendar msg -> Calendar msg
withPreviousYearLabel label (Calendar cfg) =
    Calendar { cfg | previousYearLabel = Just label }


{-| Set the accessible label for the next-year navigation button (the m3e
`next-year-label` attribute, default `"Next year"`). Use to localise the
calendar's screen-reader labels.
-}
withNextYearLabel : String -> Calendar msg -> Calendar msg
withNextYearLabel label (Calendar cfg) =
    Calendar { cfg | nextYearLabel = Just label }


{-| Set the accessible label for the button that pages to the previous span
of years in the multi-year view (the m3e `previous-multi-year-label`
attribute, default `"Previous 24 years"`). Use to localise the calendar's
screen-reader labels.
-}
withPreviousMultiYearLabel : String -> Calendar msg -> Calendar msg
withPreviousMultiYearLabel label (Calendar cfg) =
    Calendar { cfg | previousMultiYearLabel = Just label }


{-| Set the accessible label for the button that pages to the next span of
years in the multi-year view (the m3e `next-multi-year-label` attribute,
default `"Next 24 years"`). Use to localise the calendar's screen-reader
labels.
-}
withNextMultiYearLabel : String -> Calendar msg -> Calendar msg
withNextMultiYearLabel label (Calendar cfg) =
    Calendar { cfg | nextMultiYearLabel = Just label }


{-| Handler called when the user selects a date. Receives the selected
date as an ISO-8601 string from the element's `change` event.
-}
withOnChange : (String -> msg) -> Calendar msg -> Calendar msg
withOnChange handler (Calendar cfg) =
    Calendar { cfg | onChange = Just handler }


{-| Custom content for the calendar's `header` slot, rendered above the
view-switching and navigation controls.
-}
withHeader : Html msg -> Calendar msg -> Calendar msg
withHeader h (Calendar cfg) =
    Calendar { cfg | header = Just h }


{-| Render the calendar.
-}
view : Calendar msg -> Html msg
view (Calendar cfg) =
    Cem.M3e.Calendar.component
        (cfg.attributes
            ++ List.filterMap identity
                [ Maybe.map Attr.id cfg.id
                , Maybe.map Cem.M3e.Calendar.date cfg.date
                , Maybe.map Cem.M3e.Calendar.minDate cfg.minDate
                , Maybe.map Cem.M3e.Calendar.maxDate cfg.maxDate
                , Maybe.map Cem.M3e.Calendar.rangeStart cfg.rangeStart
                , Maybe.map Cem.M3e.Calendar.rangeEnd cfg.rangeEnd
                , Maybe.map (toStartView >> Cem.M3e.Calendar.startView) cfg.startView
                , Maybe.map Cem.M3e.Calendar.startAt cfg.startAt
                , Maybe.map Cem.M3e.Calendar.previousMonthLabel cfg.previousMonthLabel
                , Maybe.map Cem.M3e.Calendar.nextMonthLabel cfg.nextMonthLabel
                , Maybe.map Cem.M3e.Calendar.previousYearLabel cfg.previousYearLabel
                , Maybe.map Cem.M3e.Calendar.nextYearLabel cfg.nextYearLabel
                , Maybe.map Cem.M3e.Calendar.previousMultiYearLabel cfg.previousMultiYearLabel
                , Maybe.map Cem.M3e.Calendar.nextMultiYearLabel cfg.nextMultiYearLabel
                , Maybe.map changeListener cfg.onChange
                ]
        )
        (headerChildren cfg)


headerChildren : Config msg -> List (Html msg)
headerChildren cfg =
    case cfg.header of
        Just h ->
            [ Html.span [ Cem.M3e.Calendar.headerSlot ] [ h ] ]

        Nothing ->
            []


changeListener : (String -> msg) -> Html.Attribute msg
changeListener onChange =
    Cem.M3e.Calendar.onChange (Json.Decode.map onChange Cem.M3e.Common.targetValue)


toStartView : StartView -> Cem.M3e.Calendar.StartView
toStartView sv =
    case sv of
        MonthView ->
            Cem.M3e.Calendar.Month

        YearView ->
            Cem.M3e.Calendar.Year

        MultiYearView ->
            Cem.M3e.Calendar.MultiYear
