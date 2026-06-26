module Ui.DatePicker exposing
    ( DatePicker, new
    , Variant(..)
    , withAttributes
    , withId, withVariant, withRange
    , withMin, withMax
    , withClearable
    , withLabel, withConfirmLabel, withDismissLabel
    , view
    )

{-| Typed builder for `<m3e-datepicker>` — a date-selection control for
forms: a text field that opens a pop-up calendar for picking a single
date (or a date range). Mirrors the Material 3 [Date pickers][m3]
surface.

[m3]: https://m3.material.io/components/date-pickers/overview

Reach for this for date entry in a form. For an always-visible inline
month/year surface, use [`Ui.Calendar`](Ui-Calendar) instead.

This is a thin wrapper over what `Cem.M3e.Datepicker` actually exposes. The
selected value is **not** a typed attribute: it rides the element's
`change` event, so `withOnChange` hands you the current value as an
ISO-8601 (`"YYYY-MM-DD"`) string. Optional `min`/`max` bounds are passed
as ISO-8601 strings too.

    Ui.DatePicker.new DateChanged
        |> Ui.DatePicker.withLabel "Visit date"
        |> Ui.DatePicker.withMin todayIso
        |> Ui.DatePicker.withMax oneMonthAheadIso
        |> Ui.DatePicker.view

A date-range picker:

    Ui.DatePicker.new WindowChanged
        |> Ui.DatePicker.withLabel "Engagement window"
        |> Ui.DatePicker.withRange True
        |> Ui.DatePicker.view


# Type

@docs DatePicker, new


# Configuration

@docs Variant


# Host attributes

@docs withAttributes


# Modifiers

@docs withId, withVariant, withRange
@docs withMin, withMax
@docs withClearable
@docs withLabel, withConfirmLabel, withDismissLabel


# Render

@docs view

-}

import Html exposing (Attribute, Html)
import Html.Attributes as Attr
import Json.Decode
import Cem.M3e.Common
import Cem.M3e.Datepicker



-- TYPES ------------------------------------------------------------------


{-| A date picker, parameterized by its message type.
-}
type DatePicker msg
    = DatePicker (Config msg)


{-| Appearance variant, the `variant` attribute. `Docked` anchors the
calendar to the field; `Modal` opens it as a centered overlay; `Auto`
(`"auto"`) lets the element pick. m3e's own default is `Docked`
(`"docked"`); this builder defaults to `Auto`.
-}
type Variant
    = Docked
    | Modal
    | Auto


type alias Config msg =
    { id : Maybe String
    , attributes : List (Attribute msg)
    , onChange : String -> msg
    , variant : Variant
    , range : Bool
    , min : Maybe String
    , max : Maybe String
    , clearable : Bool
    , label : Maybe String
    , confirmLabel : Maybe String
    , dismissLabel : Maybe String
    }



-- CONSTRUCTOR ------------------------------------------------------------


{-| Construct a date picker. The handler receives the current selection
as an ISO-8601 string from the element's `change` event.
-}
new : (String -> msg) -> DatePicker msg
new onChange =
    DatePicker
        { id = Nothing
        , attributes = []
        , onChange = onChange
        , variant = Auto
        , range = False
        , min = Nothing
        , max = Nothing
        , clearable = True
        , label = Nothing
        , confirmLabel = Nothing
        , dismissLabel = Nothing
        }



-- MODIFIERS --------------------------------------------------------------


{-| Append attributes to the underlying `<m3e-datepicker>` host element — the
escape hatch for styling the component itself. Structural attributes are emitted
after these, so callers can't clobber them.
-}
withAttributes : List (Attribute msg) -> DatePicker msg -> DatePicker msg
withAttributes attributes (DatePicker cfg) =
    DatePicker { cfg | attributes = cfg.attributes ++ attributes }


{-| Set the `id` attribute.
-}
withId : String -> DatePicker msg -> DatePicker msg
withId id (DatePicker cfg) =
    DatePicker { cfg | id = Just id }


{-| Choose the appearance variant (this builder defaults to `Auto`).
-}
withVariant : Variant -> DatePicker msg -> DatePicker msg
withVariant v (DatePicker cfg) =
    DatePicker { cfg | variant = v }


{-| The `range` attribute — whether a start/end range of dates can be
selected rather than a single date (default `False`).
-}
withRange : Bool -> DatePicker msg -> DatePicker msg
withRange b (DatePicker cfg) =
    DatePicker { cfg | range = b }


{-| Earliest selectable date, the `min-date` attribute, as an ISO-8601
(`"YYYY-MM-DD"`) string. Dates before it are disabled.
-}
withMin : String -> DatePicker msg -> DatePicker msg
withMin d (DatePicker cfg) =
    DatePicker { cfg | min = Just d }


{-| Latest selectable date, the `max-date` attribute, as an ISO-8601
(`"YYYY-MM-DD"`) string. Dates after it are disabled.
-}
withMax : String -> DatePicker msg -> DatePicker msg
withMax d (DatePicker cfg) =
    DatePicker { cfg | max = Just d }


{-| The `clearable` attribute — whether the user can clear the selected
date and close the picker. m3e defaults this to `False`; this builder
defaults it to `True`.
-}
withClearable : Bool -> DatePicker msg -> DatePicker msg
withClearable b (DatePicker cfg) =
    DatePicker { cfg | clearable = b }


{-| Set the picker's `label` (default `"Select date"`).
-}
withLabel : String -> DatePicker msg -> DatePicker msg
withLabel s (DatePicker cfg) =
    DatePicker { cfg | label = Just s }


{-| Set the `confirm-label` — the button that applies the selection and
closes the picker (default `"OK"`).
-}
withConfirmLabel : String -> DatePicker msg -> DatePicker msg
withConfirmLabel s (DatePicker cfg) =
    DatePicker { cfg | confirmLabel = Just s }


{-| Set the `dismiss-label` — the button that discards the selection and
closes the picker (default `"Cancel"`).
-}
withDismissLabel : String -> DatePicker msg -> DatePicker msg
withDismissLabel s (DatePicker cfg) =
    DatePicker { cfg | dismissLabel = Just s }



-- RENDER -----------------------------------------------------------------


{-| Render the date picker to `Html`.
-}
view : DatePicker msg -> Html msg
view (DatePicker cfg) =
    Cem.M3e.Datepicker.component
        (cfg.attributes
            ++ List.filterMap identity
                [ Maybe.map Attr.id cfg.id
                , Just (Cem.M3e.Datepicker.variant (toVariant cfg.variant))
                , Just (Cem.M3e.Datepicker.range cfg.range)
                , Just (Cem.M3e.Datepicker.clearable cfg.clearable)
                , Maybe.map Cem.M3e.Datepicker.minDate cfg.min
                , Maybe.map Cem.M3e.Datepicker.maxDate cfg.max
                , Maybe.map Cem.M3e.Datepicker.label cfg.label
                , Maybe.map Cem.M3e.Datepicker.confirmLabel cfg.confirmLabel
                , Maybe.map Cem.M3e.Datepicker.dismissLabel cfg.dismissLabel
                , Just (Cem.M3e.Datepicker.onChange (Json.Decode.map cfg.onChange Cem.M3e.Common.targetValue))
                ]
        )
        []


toVariant : Variant -> Cem.M3e.Datepicker.Variant
toVariant v =
    case v of
        Docked ->
            Cem.M3e.Datepicker.Docked

        Modal ->
            Cem.M3e.Datepicker.Modal

        Auto ->
            Cem.M3e.Datepicker.Auto
