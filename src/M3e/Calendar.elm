module M3e.Calendar exposing
    ( StartView(..)
    , Option
    , view
    , withId, withDate, withMinDate, withMaxDate
    , withRangeStart, withRangeEnd
    , withStartView, withStartAt
    , withPreviousMonthLabel, withNextMonthLabel
    , withPreviousYearLabel, withNextYearLabel
    , withPreviousMultiYearLabel, withNextMultiYearLabel
    , onChange
    )

{-| `<m3e-calendar>` — an always-visible date-selection surface.

Spec (per docs/CONVENTIONS.md):

  - Required: none (the calendar is usable without any options)
  - Options: id, date (ISO seed), min-date, max-date, range-start, range-end,
    start-view, start-at, nav labels, onChange
  - Properties: none (dates are set via ATTRIBUTES, the element converts them
    internally via its `dateConverter`)
  - Events: `onChange` — fires when the user selects a date (see ⚠️ below)
  - Tag: `calendar`

**Fix #14 — change event channel:**

`m3e-calendar` dispatches a plain `Event("change")` when the user picks a
date.  The selection lives on `this.date` (a JavaScript `Date` object), NOT on
`event.target.value` (which the old `Ui.Calendar.changeListener` tried to read
— that was bug #14).

The `date` property on `<m3e-calendar>` is decorated with Lit's
`@property({ converter: dateConverter })` WITHOUT `reflect: true`, so the
attribute is NOT updated on selection — `getAttribute("date")` still returns
the seed value we set, not the user's pick.

**Change-event decoding — roundabout pure-Elm path:**

`event.target.date` is a JS `Date` object; `Json.Decode.string` cannot decode
it directly.  We exploit the fact that Elm's `Json.Encode.encode 0 value`
calls `JSON.stringify` on the underlying JS object, and `JSON.stringify(date)`
invokes `Date.prototype.toJSON()` which returns a quoted ISO string — then we
re-parse that JSON string with `Decode.decodeString Decode.string`.

This works with Elm 0.19 / elm/json 1.1.4 and is the closest faithful pure-Elm
path.  **If it ever breaks** (e.g. after an elm/json internals change), the
authoritative fix is a tiny JS shim that listens to `change` and re-fires:

    elem.addEventListener('change', e => {
      elem.dispatchEvent(new CustomEvent('m3e-date-change', {
        detail: { date: e.target.date?.toISOString() ?? '' },
        bubbles: true
      }));
    });

...with a matching `Node.on "m3e-date-change" (Decode.at ["detail","date"] Decode.string)`.

-}

import Json.Decode as Decode
import Json.Encode as Encode
import M3e.Node as Node
import M3e.Renderable as Renderable exposing (Renderable, Supported)
import M3e.Internal as Internal


-- TYPES -----------------------------------------------------------------------


{-| The view the calendar opens to. -}
type StartView
    = MonthView
    | YearView
    | MultiYearView


type alias Option msg =
    Internal.Option (Config msg) msg


type alias Config msg =
    { id : Maybe String
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
    }


defaultConfig : Config msg
defaultConfig =
    { id = Nothing
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
    }


-- OPTION CONSTRUCTORS ---------------------------------------------------------


{-| Set the `id` attribute on `<m3e-calendar>`. -}
withId : String -> Option msg
withId s =
    Internal.option (\c -> { c | id = Just s })


{-| Seed the calendar with an initially selected date (ISO-8601 string). -}
withDate : String -> Option msg
withDate s =
    Internal.option (\c -> { c | date = Just s })


{-| Earliest selectable date (ISO-8601). -}
withMinDate : String -> Option msg
withMinDate s =
    Internal.option (\c -> { c | minDate = Just s })


{-| Latest selectable date (ISO-8601). -}
withMaxDate : String -> Option msg
withMaxDate s =
    Internal.option (\c -> { c | maxDate = Just s })


{-| Start of a highlighted date range (ISO-8601). -}
withRangeStart : String -> Option msg
withRangeStart s =
    Internal.option (\c -> { c | rangeStart = Just s })


{-| End of a highlighted date range (ISO-8601). -}
withRangeEnd : String -> Option msg
withRangeEnd s =
    Internal.option (\c -> { c | rangeEnd = Just s })


{-| Set the initial view (`MonthView`, `YearView`, `MultiYearView`). -}
withStartView : StartView -> Option msg
withStartView sv =
    Internal.option (\c -> { c | startView = Just sv })


{-| Set the initial period to display (ISO-8601). -}
withStartAt : String -> Option msg
withStartAt s =
    Internal.option (\c -> { c | startAt = Just s })


{-| Accessible label for the "previous month" button. -}
withPreviousMonthLabel : String -> Option msg
withPreviousMonthLabel s =
    Internal.option (\c -> { c | previousMonthLabel = Just s })


{-| Accessible label for the "next month" button. -}
withNextMonthLabel : String -> Option msg
withNextMonthLabel s =
    Internal.option (\c -> { c | nextMonthLabel = Just s })


{-| Accessible label for the "previous year" button. -}
withPreviousYearLabel : String -> Option msg
withPreviousYearLabel s =
    Internal.option (\c -> { c | previousYearLabel = Just s })


{-| Accessible label for the "next year" button. -}
withNextYearLabel : String -> Option msg
withNextYearLabel s =
    Internal.option (\c -> { c | nextYearLabel = Just s })


{-| Accessible label for the "previous 24 years" button. -}
withPreviousMultiYearLabel : String -> Option msg
withPreviousMultiYearLabel s =
    Internal.option (\c -> { c | previousMultiYearLabel = Just s })


{-| Accessible label for the "next 24 years" button. -}
withNextMultiYearLabel : String -> Option msg
withNextMultiYearLabel s =
    Internal.option (\c -> { c | nextMultiYearLabel = Just s })


{-| Handle date selection. Receives the selected date as an ISO-8601 string.

See module documentation (⚠️) for the exact decoding channel used.

-}
onChange : (String -> msg) -> Option msg
onChange f =
    Internal.option (\c -> { c | onChange = Just f })


-- VIEW ------------------------------------------------------------------------


{-| Render the calendar.

    M3e.Calendar.view
        [ M3e.Calendar.withDate "2026-06-25"
        , M3e.Calendar.withMinDate todayIso
        , M3e.Calendar.onChange DateSelected
        ]

-}
view : List (Option msg) -> Renderable { s | calendar : Supported } msg
view opts =
    let
        c =
            Internal.applyOptions opts defaultConfig
    in
    Internal.fromNode
        (Node.element "m3e-calendar"
            (List.filterMap identity
                [ Maybe.map (Node.attribute "id") c.id
                , Maybe.map (Node.attribute "date") c.date
                , Maybe.map (Node.attribute "min-date") c.minDate
                , Maybe.map (Node.attribute "max-date") c.maxDate
                , Maybe.map (Node.attribute "range-start") c.rangeStart
                , Maybe.map (Node.attribute "range-end") c.rangeEnd
                , Maybe.map
                    (\sv -> Node.attribute "start-view" (startViewString sv))
                    c.startView
                , Maybe.map (Node.attribute "start-at") c.startAt
                , Maybe.map (Node.attribute "previous-month-label") c.previousMonthLabel
                , Maybe.map (Node.attribute "next-month-label") c.nextMonthLabel
                , Maybe.map (Node.attribute "previous-year-label") c.previousYearLabel
                , Maybe.map (Node.attribute "next-year-label") c.nextYearLabel
                , Maybe.map (Node.attribute "previous-multi-year-label") c.previousMultiYearLabel
                , Maybe.map (Node.attribute "next-multi-year-label") c.nextMultiYearLabel
                , Maybe.map
                    (\handler -> Node.on "change" (datePropertyDecoder |> Decode.map handler))
                    c.onChange
                ]
            )
            []
        )


-- INTERNAL --------------------------------------------------------------------


startViewString : StartView -> String
startViewString sv =
    case sv of
        MonthView ->
            "month"

        YearView ->
            "year"

        MultiYearView ->
            "multi-year"


{-| Decode the ISO string from `event.target.date` (a JS Date object).

See module doc for the full rationale. Short version: `Encode.encode 0` calls
`JSON.stringify` on the raw JS value, which for a Date returns a quoted ISO
string; we re-parse that with `Decode.decodeString Decode.string`.

-}
datePropertyDecoder : Decode.Decoder String
datePropertyDecoder =
    Decode.at [ "target", "date" ] Decode.value
        |> Decode.andThen
            (\val ->
                case Decode.decodeString Decode.string (Encode.encode 0 val) of
                    Ok iso ->
                        Decode.succeed iso

                    Err e ->
                        Decode.fail (Decode.errorToString e)
            )
