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

{-| Typed builder for `<m3e-datepicker>` — a calendar control for
selecting a date (or a date range) on a temporary surface. Mirrors the
Material 3 [Date pickers][m3] surface.

[m3]: https://m3.material.io/components/date-pickers/overview

This is a thin wrapper over what `M3e.Datepicker` actually exposes. The
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
import M3e.Common
import M3e.Datepicker



-- TYPES ------------------------------------------------------------------


{-| A date picker, parameterized by its message type.
-}
type DatePicker msg
    = DatePicker (Config msg)


{-| Layout variant. `Docked` renders inline; `Modal` opens an overlay;
`Auto` picks based on viewport.
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


{-| Choose the layout variant (default `Auto`).
-}
withVariant : Variant -> DatePicker msg -> DatePicker msg
withVariant v (DatePicker cfg) =
    DatePicker { cfg | variant = v }


{-| Whether a range of dates can be selected (default `False`).
-}
withRange : Bool -> DatePicker msg -> DatePicker msg
withRange b (DatePicker cfg) =
    DatePicker { cfg | range = b }


{-| Constrain selectable dates to ≥ this ISO-8601 date.
-}
withMin : String -> DatePicker msg -> DatePicker msg
withMin d (DatePicker cfg) =
    DatePicker { cfg | min = Just d }


{-| Constrain selectable dates to ≤ this ISO-8601 date.
-}
withMax : String -> DatePicker msg -> DatePicker msg
withMax d (DatePicker cfg) =
    DatePicker { cfg | max = Just d }


{-| Toggle the clear button (default `True`).
-}
withClearable : Bool -> DatePicker msg -> DatePicker msg
withClearable b (DatePicker cfg) =
    DatePicker { cfg | clearable = b }


{-| Set the picker's accessible label.
-}
withLabel : String -> DatePicker msg -> DatePicker msg
withLabel s (DatePicker cfg) =
    DatePicker { cfg | label = Just s }


{-| Set the label of the confirm button (default `"OK"`).
-}
withConfirmLabel : String -> DatePicker msg -> DatePicker msg
withConfirmLabel s (DatePicker cfg) =
    DatePicker { cfg | confirmLabel = Just s }


{-| Set the label of the dismiss button (default `"Cancel"`).
-}
withDismissLabel : String -> DatePicker msg -> DatePicker msg
withDismissLabel s (DatePicker cfg) =
    DatePicker { cfg | dismissLabel = Just s }



-- RENDER -----------------------------------------------------------------


{-| Render the date picker to `Html`.
-}
view : DatePicker msg -> Html msg
view (DatePicker cfg) =
    M3e.Datepicker.component
        (cfg.attributes
            ++ List.filterMap identity
                [ Maybe.map Attr.id cfg.id
                , Just (M3e.Datepicker.variant (toVariant cfg.variant))
                , Just (M3e.Datepicker.range cfg.range)
                , Just (M3e.Datepicker.clearable cfg.clearable)
                , Maybe.map M3e.Datepicker.minDate cfg.min
                , Maybe.map M3e.Datepicker.maxDate cfg.max
                , Maybe.map M3e.Datepicker.label cfg.label
                , Maybe.map M3e.Datepicker.confirmLabel cfg.confirmLabel
                , Maybe.map M3e.Datepicker.dismissLabel cfg.dismissLabel
                , Just (M3e.Datepicker.onChange (Json.Decode.map cfg.onChange M3e.Common.targetValue))
                ]
        )
        []


toVariant : Variant -> M3e.Datepicker.Variant
toVariant v =
    case v of
        Docked ->
            M3e.Datepicker.Docked

        Modal ->
            M3e.Datepicker.Modal

        Auto ->
            M3e.Datepicker.Auto
