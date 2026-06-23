module Ui.DatePicker exposing
    ( DatePicker, Single, RangeKind
    , Variant(..)
    , single, range
    , withId, withVariant, withMin, withMax, withClearable, withDisabled
    , withHelp, withError
    , view
    )

{-| Typed builder for `<m3e-datepicker>` — a calendar control for
selecting a date or a date range. Mirrors the Material 3
[Date pickers][m3] surface.

[m3]: https://m3.material.io/components/date-pickers/overview


# Two kinds, gated by the type system

  - **Single** (`single`) — selects one `Maybe Date`.
  - **Range** (`range`) — selects a `{ start, end }` pair, each a
    `Maybe Date` so the user can leave either end unset.


# Variants

m3 documents three types: docked (in-flow), modal (overlay), and modal
input (an input field that opens a modal). m3e exposes them via the
`variant` attribute (`Docked` / `Modal` / `Auto`). Auto picks docked or
modal based on viewport.


# Required-by-design

`single` and `range` both require:

  - `label` — visible adjacent text.
  - the selected date(s) (each as `Maybe Date`).
  - `onChange` — handler receiving the new selection.


# Quick examples

A single-date picker bounded to a window:

    Ui.DatePicker.single
        { label = "Visit date"
        , value = state.visitDate
        , onChange = VisitDateChanged
        }
        |> Ui.DatePicker.withMin todaysDate
        |> Ui.DatePicker.withMax oneMonthAhead
        |> Ui.DatePicker.view

A date-range picker:

    Ui.DatePicker.range
        { label = "Engagement window"
        , value = { start = state.engStart, end = state.engEnd }
        , onChange = EngagementWindowChanged
        }
        |> Ui.DatePicker.view


# Type

@docs DatePicker, Single, RangeKind


# Configuration

@docs Variant


# Constructors

@docs single, range


# Modifiers

@docs withId, withVariant, withMin, withMax, withClearable, withDisabled
@docs withHelp, withError


# Render

@docs view

-}

import Date exposing (Date)
import Html exposing (Html)
import Html.Attributes as Attr
import Json.Decode as Decode
import M3e.Datepicker
import M3e.FormField



-- TYPES ------------------------------------------------------------------


{-| A date picker, parameterized by its kind tag and the message type.
-}
type DatePicker kind msg
    = DatePicker (Config msg)


{-| Phantom tag for single-date pickers. Has no values.
-}
type Single
    = SinglePhantomTag Never


{-| Phantom tag for date-range pickers. Has no values.

(Named `RangeKind` rather than `Range` to avoid colliding with the
common record-field name `range` at call sites.)

-}
type RangeKind
    = RangePhantomTag Never


{-| Layout variant. `Docked` renders inline as part of the form; `Modal`
opens an overlay; `Auto` picks based on viewport.
-}
type Variant
    = Docked
    | Modal
    | Auto


type alias Config msg =
    { id : Maybe String
    , label : String
    , selection : Selection msg
    , variant : Variant
    , min : Maybe Date
    , max : Maybe Date
    , clearable : Bool
    , disabled : Bool
    , help : Maybe (Html msg)
    , error : Maybe (Html msg)
    }


type Selection msg
    = SingleSelection
        { value : Maybe Date
        , onChange : Maybe Date -> msg
        }
    | RangeSelection
        { start : Maybe Date
        , end : Maybe Date
        , onChange : { start : Maybe Date, end : Maybe Date } -> msg
        }



-- CONSTRUCTORS -----------------------------------------------------------


{-| Construct a single-date picker.
-}
single :
    { label : String, value : Maybe Date, onChange : Maybe Date -> msg }
    -> DatePicker Single msg
single c =
    DatePicker
        (baseConfig c.label
            (SingleSelection { value = c.value, onChange = c.onChange })
        )


{-| Construct a date-range picker.
-}
range :
    { label : String
    , value : { start : Maybe Date, end : Maybe Date }
    , onChange : { start : Maybe Date, end : Maybe Date } -> msg
    }
    -> DatePicker RangeKind msg
range c =
    DatePicker
        (baseConfig c.label
            (RangeSelection
                { start = c.value.start
                , end = c.value.end
                , onChange = c.onChange
                }
            )
        )


baseConfig : String -> Selection msg -> Config msg
baseConfig label selection =
    { id = Nothing
    , label = label
    , selection = selection
    , variant = Auto
    , min = Nothing
    , max = Nothing
    , clearable = True
    , disabled = False
    , help = Nothing
    , error = Nothing
    }



-- MODIFIERS --------------------------------------------------------------


{-| Set the `id` attribute.
-}
withId : String -> DatePicker kind msg -> DatePicker kind msg
withId id (DatePicker cfg) =
    DatePicker { cfg | id = Just id }


{-| Choose the layout variant (default `Auto`).
-}
withVariant : Variant -> DatePicker kind msg -> DatePicker kind msg
withVariant v (DatePicker cfg) =
    DatePicker { cfg | variant = v }


{-| Constrain selectable dates to ≥ this date.
-}
withMin : Date -> DatePicker kind msg -> DatePicker kind msg
withMin d (DatePicker cfg) =
    DatePicker { cfg | min = Just d }


{-| Constrain selectable dates to ≤ this date.
-}
withMax : Date -> DatePicker kind msg -> DatePicker kind msg
withMax d (DatePicker cfg) =
    DatePicker { cfg | max = Just d }


{-| Toggle the clear button (default `True`).
-}
withClearable : Bool -> DatePicker kind msg -> DatePicker kind msg
withClearable b (DatePicker cfg) =
    DatePicker { cfg | clearable = b }


{-| Disable the picker.
-}
withDisabled : Bool -> DatePicker kind msg -> DatePicker kind msg
withDisabled b (DatePicker cfg) =
    DatePicker { cfg | disabled = b }


{-| Set help text.
-}
withHelp : Html msg -> DatePicker kind msg -> DatePicker kind msg
withHelp h (DatePicker cfg) =
    DatePicker { cfg | help = Just h }


{-| Set an error message (replaces help text).
-}
withError : Html msg -> DatePicker kind msg -> DatePicker kind msg
withError e (DatePicker cfg) =
    DatePicker { cfg | error = Just e }



-- RENDER -----------------------------------------------------------------


{-| Render the date picker to `Html`.
-}
view : DatePicker kind msg -> Html msg
view (DatePicker cfg) =
    M3e.FormField.component
        []
        (List.concat
            [ [ pickerElement cfg
              , labelElement cfg
              ]
            , subscriptElements cfg
            ]
        )


pickerElement : Config msg -> Html msg
pickerElement cfg =
    M3e.Datepicker.component
        (List.filterMap identity
            ([ Maybe.map Attr.id cfg.id
             , Just (variantAttr cfg.variant)
             , Maybe.map (isoAttr "min-date") cfg.min
             , Maybe.map (isoAttr "max-date") cfg.max
             , Just (M3e.Datepicker.clearable cfg.clearable)
             , Just (Attr.disabled cfg.disabled)
             , Just (M3e.Datepicker.onChange (changeDecoder cfg.selection))
             ]
                ++ selectionAttrs cfg.selection
            )
        )
        []


selectionAttrs : Selection msg -> List (Maybe (Html.Attribute msg))
selectionAttrs selection =
    case selection of
        SingleSelection s ->
            [ Maybe.map (isoAttr "date") s.value ]

        RangeSelection r ->
            [ Maybe.map (isoAttr "range-start") r.start
            , Maybe.map (isoAttr "range-end") r.end
            ]


isoAttr : String -> Date -> Html.Attribute msg
isoAttr name d =
    Attr.attribute name (Date.toIsoString d)


changeDecoder : Selection msg -> Decode.Decoder msg
changeDecoder selection =
    case selection of
        SingleSelection s ->
            Decode.at [ "target", "date" ] decodeMaybeDate
                |> Decode.map s.onChange

        RangeSelection r ->
            Decode.map2
                (\start end -> r.onChange { start = start, end = end })
                (Decode.at [ "target", "rangeStart" ] decodeMaybeDate)
                (Decode.at [ "target", "rangeEnd" ] decodeMaybeDate)


decodeMaybeDate : Decode.Decoder (Maybe Date)
decodeMaybeDate =
    Decode.oneOf
        [ Decode.null Nothing
        , Decode.string |> Decode.map (Date.fromIsoString >> Result.toMaybe)
        ]


variantAttr : Variant -> Html.Attribute msg
variantAttr v =
    case v of
        Docked ->
            Attr.attribute "variant" "docked"

        Modal ->
            Attr.attribute "variant" "modal"

        Auto ->
            Attr.attribute "variant" "auto"


labelElement : Config msg -> Html msg
labelElement cfg =
    Html.label
        (List.filterMap identity
            [ Just M3e.FormField.labelSlot
            , Maybe.map Attr.for cfg.id
            ]
        )
        [ Html.text cfg.label ]


subscriptElements : Config msg -> List (Html msg)
subscriptElements cfg =
    case ( cfg.error, cfg.help ) of
        ( Just err, _ ) ->
            [ Html.span [ M3e.FormField.errorSlot ] [ err ] ]

        ( Nothing, Just help ) ->
            [ Html.span [ M3e.FormField.hintSlot ] [ help ] ]

        ( Nothing, Nothing ) ->
            []
