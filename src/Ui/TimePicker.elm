module Ui.TimePicker exposing
    ( TimePicker
    , new
    , withAttributes
    , withId, withMin, withMax, withStep, withRequired, withDisabled
    , withHelp, withError
    , view
    )

{-| Builder for a time-input field. Mirrors the Material 3
[Time pickers][m3] surface (dial / input types) — though `@m3e/web`
does **not** ship a `<m3e-time-picker>` custom element yet, so this
module renders a native `<input type=time>` inside `<m3e-form-field>`
chrome.

[m3]: https://m3.material.io/components/time-pickers/overview

The value is exchanged as an `"HH:MM"` (24-hour) string — the native
HTML format. When m3e adds a first-class time-picker element, this
module will graduate to using it without changing its public surface.


# Required-by-design

`new` requires:

  - `label` — visible adjacent text.
  - `value` — current time as `"HH:MM"` (empty string for unset).
  - `onChange` — handler receiving the new time string.


# Quick example

    Ui.TimePicker.new
        { label = "Meeting time"
        , value = state.meetingTime
        , onChange = MeetingTimeChanged
        }
        |> Ui.TimePicker.withMin "09:00"
        |> Ui.TimePicker.withMax "17:00"
        |> Ui.TimePicker.view


# Type

@docs TimePicker


# Constructor

@docs new


# Host attributes

@docs withAttributes


# Modifiers

@docs withId, withMin, withMax, withStep, withRequired, withDisabled
@docs withHelp, withError


# Render

@docs view

-}

import Html exposing (Attribute, Html)
import Html.Attributes as Attr
import Html.Events as HtmlEvents
import Ui.Field



-- TYPES ------------------------------------------------------------------


{-| A time picker.
-}
type TimePicker msg
    = TimePicker (Config msg)


type alias Config msg =
    { id : Maybe String
    , attributes : List (Attribute msg)
    , label : String
    , value : String
    , onChange : String -> msg
    , min : Maybe String
    , max : Maybe String
    , step : Maybe Int
    , required : Bool
    , disabled : Bool
    , help : Maybe (Html msg)
    , error : Maybe (Html msg)
    }



-- CONSTRUCTOR ------------------------------------------------------------


{-| Construct a time picker.
-}
new :
    { label : String, value : String, onChange : String -> msg }
    -> TimePicker msg
new c =
    TimePicker
        { id = Nothing
        , attributes = []
        , label = c.label
        , value = c.value
        , onChange = c.onChange
        , min = Nothing
        , max = Nothing
        , step = Nothing
        , required = False
        , disabled = False
        , help = Nothing
        , error = Nothing
        }



-- MODIFIERS --------------------------------------------------------------


{-| Append attributes to the underlying `<m3e-form-field>` host element — the
escape hatch for styling the component itself. Structural attributes are emitted
after these, so callers can't clobber them.
-}
withAttributes : List (Attribute msg) -> TimePicker msg -> TimePicker msg
withAttributes attributes (TimePicker cfg) =
    TimePicker { cfg | attributes = cfg.attributes ++ attributes }


{-| Set the `id` on the underlying input.
-}
withId : String -> TimePicker msg -> TimePicker msg
withId id (TimePicker cfg) =
    TimePicker { cfg | id = Just id }


{-| Earliest allowed time, `"HH:MM"` — the native input's `min`
attribute. Earlier times fail validation.
-}
withMin : String -> TimePicker msg -> TimePicker msg
withMin s (TimePicker cfg) =
    TimePicker { cfg | min = Just s }


{-| Latest allowed time, `"HH:MM"` — the native input's `max`
attribute. Later times fail validation.
-}
withMax : String -> TimePicker msg -> TimePicker msg
withMax s (TimePicker cfg) =
    TimePicker { cfg | max = Just s }


{-| Granularity in seconds. Native browsers use `60` for minute
resolution (the default) and `1` to expose seconds.
-}
withStep : Int -> TimePicker msg -> TimePicker msg
withStep n (TimePicker cfg) =
    TimePicker { cfg | step = Just n }


{-| Mark the field as required (default `False`). Sets the native input's
`required` attribute, which the surrounding form-field reflects as a
required marker.
-}
withRequired : Bool -> TimePicker msg -> TimePicker msg
withRequired b (TimePicker cfg) =
    TimePicker { cfg | required = b }


{-| Disable the field — non-interactive (default `False`).
-}
withDisabled : Bool -> TimePicker msg -> TimePicker msg
withDisabled b (TimePicker cfg) =
    TimePicker { cfg | disabled = b }


{-| Set hint text, shown in the form-field's subscript while the input is
valid.
-}
withHelp : Html msg -> TimePicker msg -> TimePicker msg
withHelp h (TimePicker cfg) =
    TimePicker { cfg | help = Just h }


{-| Set error text for the form-field's subscript. Takes precedence over
hint text from `withHelp`.
-}
withError : Html msg -> TimePicker msg -> TimePicker msg
withError e (TimePicker cfg) =
    TimePicker { cfg | error = Just e }



-- RENDER -----------------------------------------------------------------


{-| Render to `Html` — a native `<input type=time>` placed in the default
slot of `<m3e-form-field>`, with the label, hint, and error wired into
the field's subscript.
-}
view : TimePicker msg -> Html msg
view (TimePicker cfg) =
    Ui.Field.new cfg.label
        |> Ui.Field.withId (controlId cfg)
        |> maybeWith Ui.Field.withHint cfg.help
        |> maybeWith Ui.Field.withError cfg.error
        |> Ui.Field.withAttributes cfg.attributes
        |> Ui.Field.view (inputElement cfg)


maybeWith :
    (a -> Ui.Field.Field msg -> Ui.Field.Field msg)
    -> Maybe a
    -> Ui.Field.Field msg
    -> Ui.Field.Field msg
maybeWith f maybe field =
    case maybe of
        Just v ->
            f v field

        Nothing ->
            field


controlId : Config msg -> String
controlId cfg =
    case cfg.id of
        Just id ->
            id

        Nothing ->
            slugify cfg.label


inputElement : Config msg -> Html msg
inputElement cfg =
    Html.input
        (List.filterMap identity
            [ Just (Attr.id (controlId cfg))
            , Just (Attr.type_ "time")
            , Just (Attr.value cfg.value)
            , Maybe.map (Attr.attribute "min") cfg.min
            , Maybe.map (Attr.attribute "max") cfg.max
            , Maybe.map (\n -> Attr.attribute "step" (String.fromInt n)) cfg.step
            , Just (Attr.required cfg.required)
            , Just (Attr.disabled cfg.disabled)
            , Just (HtmlEvents.onInput cfg.onChange)
            ]
        )
        []


{-| Derive a stable, deterministic control id from the label text so the
`<label slot="label" for="...">` can anchor the control even when the
caller hasn't supplied an explicit `withId`.
-}
slugify : String -> String
slugify label =
    let
        slug : String
        slug =
            label
                |> String.toLower
                |> String.toList
                |> List.map
                    (\c ->
                        if Char.isAlphaNum c then
                            c

                        else
                            '-'
                    )
                |> String.fromList
                |> String.split "-"
                |> List.filter (not << String.isEmpty)
                |> String.join "-"
    in
    "uif-" ++ slug
