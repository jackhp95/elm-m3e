module M3e.DatePicker exposing
    ( Variant(..), StartView(..)
    , Option
    , view
    , withId, withDate, withVariant, withRange
    , withMinDate, withMaxDate, withClearable
    , withLabel, withConfirmLabel, withDismissLabel
    , withStartAt, withStartView
    , onChange
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
`event.target.value`.  `Ui.DatePicker` read `target.value` via
`Cem.M3e.Common.targetValue` — that was always a silent no-op.

`M3e.DatePicker.onChange` uses the same roundabout pure-Elm decoder as
`M3e.Calendar.onChange`: capture `target.date` as a raw `Json.Encode.Value`
(which wraps the JS Date), then `Encode.encode 0` calls `JSON.stringify(date)`
→ `Date.prototype.toJSON()` returns a quoted ISO string, and
`Decode.decodeString Decode.string` unwraps it.

This works with Elm 0.19 / elm/json 1.1.4.  If it breaks, the fix is:

    elem.dispatchEvent(new CustomEvent('m3e-date-change', {
      detail: { date: e.target.date?.toISOString() ?? '' }, bubbles: true
    }));

...decoded with `Node.on "m3e-date-change" (Decode.at ["detail","date"] Decode.string)`.

-}

import Json.Decode as Decode
import Json.Encode as Encode
import M3e.Node as Node
import M3e.Renderable as Renderable exposing (Renderable, Supported)
import M3e.Internal as Internal


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


{-| Which view the embedded calendar opens to. -}
type StartView
    = MonthView
    | YearView
    | MultiYearView


type Option msg
    = WithId String
    | WithDate String
    | WithVariant Variant
    | WithRange Bool
    | WithMinDate String
    | WithMaxDate String
    | WithClearable Bool
    | WithLabel String
    | WithConfirmLabel String
    | WithDismissLabel String
    | WithStartAt String
    | WithStartView StartView
    | OnChange (String -> msg)


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


{-| Set the `id` attribute. -}
withId : String -> Option msg
withId =
    WithId


{-| Seed the picker with an initially selected date (ISO-8601). -}
withDate : String -> Option msg
withDate =
    WithDate


{-| Choose the appearance variant. -}
withVariant : Variant -> Option msg
withVariant =
    WithVariant


{-| Enable range selection (the user can pick a start and an end date). -}
withRange : Bool -> Option msg
withRange =
    WithRange


{-| Earliest selectable date (ISO-8601). -}
withMinDate : String -> Option msg
withMinDate =
    WithMinDate


{-| Latest selectable date (ISO-8601). -}
withMaxDate : String -> Option msg
withMaxDate =
    WithMaxDate


{-| Allow the user to clear the selected date and close without picking. -}
withClearable : Bool -> Option msg
withClearable =
    WithClearable


{-| Set the picker's displayed label (default "Select date"). -}
withLabel : String -> Option msg
withLabel =
    WithLabel


{-| Label for the confirm button (default "OK"). -}
withConfirmLabel : String -> Option msg
withConfirmLabel =
    WithConfirmLabel


{-| Label for the dismiss / cancel button (default "Cancel"). -}
withDismissLabel : String -> Option msg
withDismissLabel =
    WithDismissLabel


{-| Set the initial period to display (ISO-8601). -}
withStartAt : String -> Option msg
withStartAt =
    WithStartAt


{-| Set the initial view of the embedded calendar. -}
withStartView : StartView -> Option msg
withStartView =
    WithStartView


{-| Handle date confirmation. Receives the selected date as an ISO-8601 string.

See module documentation (⚠️) for the exact decoding channel used.

-}
onChange : (String -> msg) -> Option msg
onChange =
    OnChange


-- VIEW ------------------------------------------------------------------------


{-| Render the date picker.

    M3e.DatePicker.view
        [ M3e.DatePicker.withLabel "Visit date"
        , M3e.DatePicker.withMinDate todayIso
        , M3e.DatePicker.withVariant M3e.DatePicker.Docked
        , M3e.DatePicker.onChange DateSelected
        ]

-}
view : List (Option msg) -> Renderable { s | datePicker : Supported } msg
view opts =
    let
        c =
            List.foldl apply defaultConfig opts
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


apply : Option msg -> Config msg -> Config msg
apply opt c =
    case opt of
        WithId s ->
            { c | id = Just s }

        WithDate s ->
            { c | date = Just s }

        WithVariant v ->
            { c | variant = Just v }

        WithRange b ->
            { c | range = Just b }

        WithMinDate s ->
            { c | minDate = Just s }

        WithMaxDate s ->
            { c | maxDate = Just s }

        WithClearable b ->
            { c | clearable = Just b }

        WithLabel s ->
            { c | label = Just s }

        WithConfirmLabel s ->
            { c | confirmLabel = Just s }

        WithDismissLabel s ->
            { c | dismissLabel = Just s }

        WithStartAt s ->
            { c | startAt = Just s }

        WithStartView sv ->
            { c | startView = Just sv }

        OnChange f ->
            { c | onChange = Just f }


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
