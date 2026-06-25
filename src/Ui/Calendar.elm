module Ui.Calendar exposing
    ( Calendar, new
    , withAttributes
    , withId
    , withDate, withMinDate, withMaxDate
    , withRangeStart, withRangeEnd
    , StartView(..), withStartView, withStartAt
    , withOnChange
    , withHeader
    , view
    )

{-| Typed builder for an M3 calendar widget. Wraps `M3e.Calendar`.

A standalone date-selection calendar with month, year, and multi-year
views. Use this when you want a calendar surface without a text field.

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
import M3e.Calendar
import M3e.Common


{-| The calendar opaque type. Build via `new`.
-}
type Calendar msg
    = Calendar (Config msg)


{-| Which view the calendar opens to.
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
    , onChange : Maybe (String -> msg)
    , header : Maybe (Html msg)
    }


{-| Construct a fresh calendar with no selection or constraints.
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


{-| Set the earliest selectable date as an ISO-8601 string.
-}
withMinDate : String -> Calendar msg -> Calendar msg
withMinDate d (Calendar cfg) =
    Calendar { cfg | minDate = Just d }


{-| Set the latest selectable date as an ISO-8601 string.
-}
withMaxDate : String -> Calendar msg -> Calendar msg
withMaxDate d (Calendar cfg) =
    Calendar { cfg | maxDate = Just d }


{-| Set the start of a highlighted date range as an ISO-8601 string.
-}
withRangeStart : String -> Calendar msg -> Calendar msg
withRangeStart d (Calendar cfg) =
    Calendar { cfg | rangeStart = Just d }


{-| Set the end of a highlighted date range as an ISO-8601 string.
-}
withRangeEnd : String -> Calendar msg -> Calendar msg
withRangeEnd d (Calendar cfg) =
    Calendar { cfg | rangeEnd = Just d }


{-| Set which view the calendar opens to. Default is `MonthView`.
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


{-| Handler called when the user selects a date. Receives the selected
date as an ISO-8601 string from the element's `change` event.
-}
withOnChange : (String -> msg) -> Calendar msg -> Calendar msg
withOnChange handler (Calendar cfg) =
    Calendar { cfg | onChange = Just handler }


{-| Custom header content rendered in the calendar's header slot.
-}
withHeader : Html msg -> Calendar msg -> Calendar msg
withHeader h (Calendar cfg) =
    Calendar { cfg | header = Just h }


{-| Render the calendar.
-}
view : Calendar msg -> Html msg
view (Calendar cfg) =
    M3e.Calendar.component
        (cfg.attributes
            ++ List.filterMap identity
                [ Maybe.map Attr.id cfg.id
                , Maybe.map M3e.Calendar.date cfg.date
                , Maybe.map M3e.Calendar.minDate cfg.minDate
                , Maybe.map M3e.Calendar.maxDate cfg.maxDate
                , Maybe.map M3e.Calendar.rangeStart cfg.rangeStart
                , Maybe.map M3e.Calendar.rangeEnd cfg.rangeEnd
                , Maybe.map (toStartView >> M3e.Calendar.startView) cfg.startView
                , Maybe.map M3e.Calendar.startAt cfg.startAt
                , Maybe.map changeListener cfg.onChange
                ]
        )
        (headerChildren cfg)


headerChildren : Config msg -> List (Html msg)
headerChildren cfg =
    case cfg.header of
        Just h ->
            [ Html.span [ M3e.Calendar.headerSlot ] [ h ] ]

        Nothing ->
            []


changeListener : (String -> msg) -> Html.Attribute msg
changeListener onChange =
    M3e.Calendar.onChange (Json.Decode.map onChange M3e.Common.targetValue)


toStartView : StartView -> M3e.Calendar.StartView
toStartView sv =
    case sv of
        MonthView ->
            M3e.Calendar.Month

        YearView ->
            M3e.Calendar.Year

        MultiYearView ->
            M3e.Calendar.MultiYear
