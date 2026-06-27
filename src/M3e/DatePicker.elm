module M3e.DatePicker exposing
    ( Option
    , StartView(..)
    , Variant(..)
    , clearable
    , confirmLabel
    , date
    , dismissLabel
    , id
    , label
    , maxDate
    , minDate
    , onChange
    , range
    , startAt
    , startView
    , variant
    , view
    )

{-| `<m3e-datepicker>` — a text field that opens a pop-up calendar for picking
a date (or a date range). Material 3 Date Picker.

Spec (per docs/CONVENTIONS.md):

  - Required: none (the picker carries its own label)
  - Options: id, date (ISO seed), variant, range, minDate, maxDate, clearable,
    label, confirmLabel, dismissLabel, startAt, startView, onChange
  - Properties: range, clearable (boolean DOM properties)
  - Events: `onChange` — fires when the user confirms a selection (see ⚠️)
  - Tag: `datePicker`

**Fix #15 — change event channel (identical to #14 on Calendar):**

`m3e-datepicker` dispatches `Event("change")` after the user confirms a pick.
The selected date lives on `this.date` (a JS `Date` object) — NOT on
`event.target.value`. `Ui.DatePicker` read `target.value` via
`Cem.M3e.Common.targetValue` — that was always a silent no-op.

`M3e.DatePicker.onChange` uses the same roundabout pure-Elm decoder as
`M3e.Calendar.onChange`: capture `target.date` as a raw `Json.Encode.Value`
(which wraps the JS Date), then `Encode.encode 0` calls `JSON.stringify(date)`
→ `Date.prototype.toJSON()` returns a quoted ISO string, and
`Decode.decodeString Decode.string` unwraps it.

This works with Elm 0.19 / elm/json 1.1.4. If it breaks, the fix is:

    elem.dispatchEvent(new CustomEvent('m3e-date-change', {
      detail: { date: e.target.date?.toISOString() ?? '' }, bubbles: true
    }));

...decoded with `Node.on "m3e-date-change" (Decode.at ["detail","date"] Decode.string)`.

-}

import Json.Decode as Decode
import Json.Encode as Encode
import M3e.Internal as Internal
import M3e.Node as Node
import M3e.Renderable as Renderable exposing (Renderable, Supported)



-- TYPES -----------------------------------------------------------------------


{-| Appearance of the picker panel.

  - `Auto` — the element picks `Docked` or `Modal` based on viewport size.
  - `Docked` — the calendar anchors beneath the text field.
  - `Modal` — the calendar opens as a centered overlay.

-}
type Variant
    = Auto
    | Docked
    | Modal


{-| Which view the embedded calendar opens to.
-}
type StartView
    = MonthView
    | YearView
    | MultiYearView


type alias Option msg =
    Internal.Option (Config msg) msg


type alias Config msg =
    { id : Maybe String
    , date : Maybe String
    , variant : Maybe Variant
    , range : Maybe Bool
    , minDate : Maybe String
    , maxDate : Maybe String
    , clearable : Maybe Bool
    , label : Maybe String
    , confirmLabel : Maybe String
    , dismissLabel : Maybe String
    , startAt : Maybe String
    , startView : Maybe StartView
    , onChange : Maybe (String -> msg)
    }


defaultConfig : Config msg
defaultConfig =
    { id = Nothing
    , date = Nothing
    , variant = Nothing
    , range = Nothing
    , minDate = Nothing
    , maxDate = Nothing
    , clearable = Nothing
    , label = Nothing
    , confirmLabel = Nothing
    , dismissLabel = Nothing
    , startAt = Nothing
    , startView = Nothing
    , onChange = Nothing
    }



-- OPTION CONSTRUCTORS ---------------------------------------------------------


{-| Set the `id` attribute.
-}
id : String -> Option msg
id s =
    Internal.option (\c -> { c | id = Just s })


{-| Seed the picker with an initially selected date (ISO-8601).
-}
date : String -> Option msg
date s =
    Internal.option (\c -> { c | date = Just s })


{-| Choose the appearance variant.
-}
variant : Variant -> Option msg
variant v =
    Internal.option (\c -> { c | variant = Just v })


{-| Enable range selection (the user can pick a start and an end date).
-}
range : Bool -> Option msg
range b =
    Internal.option (\c -> { c | range = Just b })


{-| Earliest selectable date (ISO-8601).
-}
minDate : String -> Option msg
minDate s =
    Internal.option (\c -> { c | minDate = Just s })


{-| Latest selectable date (ISO-8601).
-}
maxDate : String -> Option msg
maxDate s =
    Internal.option (\c -> { c | maxDate = Just s })


{-| Allow the user to clear the selected date and close without picking.
-}
clearable : Bool -> Option msg
clearable b =
    Internal.option (\c -> { c | clearable = Just b })


{-| Set the picker's displayed label (default "Select date").
-}
label : String -> Option msg
label s =
    Internal.option (\c -> { c | label = Just s })


{-| Label for the confirm button (default "OK").
-}
confirmLabel : String -> Option msg
confirmLabel s =
    Internal.option (\c -> { c | confirmLabel = Just s })


{-| Label for the dismiss / cancel button (default "Cancel").
-}
dismissLabel : String -> Option msg
dismissLabel s =
    Internal.option (\c -> { c | dismissLabel = Just s })


{-| Set the initial period to display (ISO-8601).
-}
startAt : String -> Option msg
startAt s =
    Internal.option (\c -> { c | startAt = Just s })


{-| Set the initial view of the embedded calendar.
-}
startView : StartView -> Option msg
startView sv =
    Internal.option (\c -> { c | startView = Just sv })


{-| Handle date confirmation. Receives the selected date as an ISO-8601 string.

See module documentation (⚠️) for the exact decoding channel used.

-}
onChange : (String -> msg) -> Option msg
onChange f =
    Internal.option (\c -> { c | onChange = Just f })



-- VIEW ------------------------------------------------------------------------


{-| Render the date picker.

    M3e.DatePicker.view
        [ M3e.DatePicker.label "Visit date"
        , M3e.DatePicker.minDate todayIso
        , M3e.DatePicker.variant M3e.DatePicker.Docked
        , M3e.DatePicker.onChange DateSelected
        ]

-}
view : List (Option msg) -> Renderable { s | datePicker : Supported } msg
view opts =
    let
        c =
            Internal.applyOptions opts defaultConfig
    in
    Internal.fromNode
        (Node.element "m3e-datepicker"
            (List.filterMap identity
                [ Maybe.map (Node.attribute "id") c.id
                , Maybe.map (Node.attribute "date") c.date
                , Maybe.map
                    (\v -> Node.attribute "variant" (variantString v))
                    c.variant
                , Maybe.map
                    (\b -> Node.property "range" (Encode.bool b))
                    c.range
                , Maybe.map (Node.attribute "min-date") c.minDate
                , Maybe.map (Node.attribute "max-date") c.maxDate
                , Maybe.map
                    (\b -> Node.property "clearable" (Encode.bool b))
                    c.clearable
                , Maybe.map (Node.attribute "label") c.label
                , Maybe.map (Node.attribute "confirm-label") c.confirmLabel
                , Maybe.map (Node.attribute "dismiss-label") c.dismissLabel
                , Maybe.map (Node.attribute "start-at") c.startAt
                , Maybe.map
                    (\sv -> Node.attribute "start-view" (startViewString sv))
                    c.startView
                , Maybe.map
                    (\handler -> Node.on "change" (datePropertyDecoder |> Decode.map handler))
                    c.onChange
                ]
            )
            []
        )



-- INTERNAL --------------------------------------------------------------------


variantString : Variant -> String
variantString v =
    case v of
        Auto ->
            "auto"

        Docked ->
            "docked"

        Modal ->
            "modal"


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

Same approach as `M3e.Calendar`; see that module's documentation for the full
rationale.

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
