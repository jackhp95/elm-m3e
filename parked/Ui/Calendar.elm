module Ui.Calendar exposing
    ( Calendar, new
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
views. Use this when you want a calendar surface without the text field
input that `Ui.Field.date` provides.

    Ui.Calendar.new
        |> Ui.Calendar.withId "event-cal"
        |> Ui.Calendar.withDate model.selectedDate
        |> Ui.Calendar.withMinDate model.today
        |> Ui.Calendar.withOnChange DateSelected
        |> Ui.Calendar.view

Dates are `justinmimbs/date` `Date` values, serialized as ISO strings
to the web component and decoded back from `detail.value` on change.


# Construction

@docs Calendar, new


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

import Date exposing (Date)
import Html exposing (Html)
import Html.Attributes as Attr
import Json.Decode as Decode
import M3e.Calendar


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
    , date : Maybe Date
    , minDate : Maybe Date
    , maxDate : Maybe Date
    , rangeStart : Maybe Date
    , rangeEnd : Maybe Date
    , startView : Maybe StartView
    , startAt : Maybe Date
    , onChange : Maybe (Date -> msg)
    , header : Maybe (Html msg)
    }


new : Calendar msg
new =
    Calendar
        { id = Nothing
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


withId : String -> Calendar msg -> Calendar msg
withId id (Calendar cfg) =
    Calendar { cfg | id = Just id }


{-| Set the currently selected date.
-}
withDate : Date -> Calendar msg -> Calendar msg
withDate d (Calendar cfg) =
    Calendar { cfg | date = Just d }


{-| Set the earliest selectable date.
-}
withMinDate : Date -> Calendar msg -> Calendar msg
withMinDate d (Calendar cfg) =
    Calendar { cfg | minDate = Just d }


{-| Set the latest selectable date.
-}
withMaxDate : Date -> Calendar msg -> Calendar msg
withMaxDate d (Calendar cfg) =
    Calendar { cfg | maxDate = Just d }


{-| Set the start of a highlighted date range.
-}
withRangeStart : Date -> Calendar msg -> Calendar msg
withRangeStart d (Calendar cfg) =
    Calendar { cfg | rangeStart = Just d }


{-| Set the end of a highlighted date range.
-}
withRangeEnd : Date -> Calendar msg -> Calendar msg
withRangeEnd d (Calendar cfg) =
    Calendar { cfg | rangeEnd = Just d }


{-| Set which view the calendar opens to. Default is `MonthView`.
-}
withStartView : StartView -> Calendar msg -> Calendar msg
withStartView sv (Calendar cfg) =
    Calendar { cfg | startView = Just sv }


{-| Set the initial period (month/year) the calendar displays, without
selecting that date. Useful for scrolling the calendar to a specific
month on open.
-}
withStartAt : Date -> Calendar msg -> Calendar msg
withStartAt d (Calendar cfg) =
    Calendar { cfg | startAt = Just d }


{-| Handler called when the user selects a date.
-}
withOnChange : (Date -> msg) -> Calendar msg -> Calendar msg
withOnChange handler (Calendar cfg) =
    Calendar { cfg | onChange = Just handler }


{-| Custom header content rendered in the calendar's header slot.
-}
withHeader : Html msg -> Calendar msg -> Calendar msg
withHeader h (Calendar cfg) =
    Calendar { cfg | header = Just h }


view : Calendar msg -> Html msg
view (Calendar cfg) =
    M3e.Calendar.component
        (List.filterMap identity
            [ Maybe.map Attr.id cfg.id
            , Maybe.map (Date.toIsoString >> dateAttr) cfg.date
            , Maybe.map (Date.toIsoString >> minDateAttr) cfg.minDate
            , Maybe.map (Date.toIsoString >> maxDateAttr) cfg.maxDate
            , Maybe.map (Date.toIsoString >> rangeStartAttr) cfg.rangeStart
            , Maybe.map (Date.toIsoString >> rangeEndAttr) cfg.rangeEnd
            , Maybe.map (startViewToString >> M3e.Calendar.startView) cfg.startView
            , Maybe.map (Date.toIsoString >> startAtAttr) cfg.startAt
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


dateAttr : String -> Html.Attribute msg
dateAttr iso =
    Attr.attribute "date" iso


minDateAttr : String -> Html.Attribute msg
minDateAttr iso =
    Attr.attribute "min-date" iso


maxDateAttr : String -> Html.Attribute msg
maxDateAttr iso =
    Attr.attribute "max-date" iso


rangeStartAttr : String -> Html.Attribute msg
rangeStartAttr iso =
    Attr.attribute "range-start" iso


rangeEndAttr : String -> Html.Attribute msg
rangeEndAttr iso =
    Attr.attribute "range-end" iso


startAtAttr : String -> Html.Attribute msg
startAtAttr iso =
    Attr.attribute "start-at" iso


changeListener : (Date -> msg) -> Html.Attribute msg
changeListener onChange =
    M3e.Calendar.onChange
        (Decode.at [ "detail", "value" ] Decode.string
            |> Decode.andThen
                (\iso ->
                    case Date.fromIsoString iso of
                        Ok d ->
                            Decode.succeed (onChange d)

                        Err _ ->
                            Decode.fail "invalid iso date from calendar"
                )
        )


startViewToString : StartView -> String
startViewToString sv =
    case sv of
        MonthView ->
            "month"

        YearView ->
            "year"

        MultiYearView ->
            "multi-year"
