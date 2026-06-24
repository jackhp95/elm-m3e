module Ui.TimePicker exposing
    ( TimePicker
    , new
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


# Modifiers

@docs withId, withMin, withMax, withStep, withRequired, withDisabled
@docs withHelp, withError


# Render

@docs view

-}

import Html exposing (Html)
import Html.Attributes as Attr
import Html.Events as HtmlEvents
import M3e.FormField



-- TYPES ------------------------------------------------------------------


{-| A time picker.
-}
type TimePicker msg
    = TimePicker (Config msg)


type alias Config msg =
    { id : Maybe String
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


{-| Set the `id` on the underlying input.
-}
withId : String -> TimePicker msg -> TimePicker msg
withId id (TimePicker cfg) =
    TimePicker { cfg | id = Just id }


{-| Earliest allowed time, `"HH:MM"`.
-}
withMin : String -> TimePicker msg -> TimePicker msg
withMin s (TimePicker cfg) =
    TimePicker { cfg | min = Just s }


{-| Latest allowed time, `"HH:MM"`.
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


{-| Mark the field as required.
-}
withRequired : Bool -> TimePicker msg -> TimePicker msg
withRequired b (TimePicker cfg) =
    TimePicker { cfg | required = b }


{-| Disable the field.
-}
withDisabled : Bool -> TimePicker msg -> TimePicker msg
withDisabled b (TimePicker cfg) =
    TimePicker { cfg | disabled = b }


{-| Set help text.
-}
withHelp : Html msg -> TimePicker msg -> TimePicker msg
withHelp h (TimePicker cfg) =
    TimePicker { cfg | help = Just h }


{-| Set an error message (replaces help text).
-}
withError : Html msg -> TimePicker msg -> TimePicker msg
withError e (TimePicker cfg) =
    TimePicker { cfg | error = Just e }



-- RENDER -----------------------------------------------------------------


{-| Render to `Html`.
-}
view : TimePicker msg -> Html msg
view (TimePicker cfg) =
    M3e.FormField.component
        []
        (List.concat
            [ [ labelElement cfg
              , inputElement cfg
              ]
            , subscriptElements cfg
            ]
        )


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


labelElement : Config msg -> Html msg
labelElement cfg =
    Html.label
        [ Attr.attribute "slot" "label"
        , Attr.for (controlId cfg)
        ]
        [ Html.text cfg.label ]


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


subscriptElements : Config msg -> List (Html msg)
subscriptElements cfg =
    case ( cfg.error, cfg.help ) of
        ( Just err, _ ) ->
            [ Html.span [ M3e.FormField.errorSlot ] [ err ] ]

        ( Nothing, Just help ) ->
            [ Html.span [ M3e.FormField.hintSlot ] [ help ] ]

        ( Nothing, Nothing ) ->
            []
