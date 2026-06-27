module M3e.TimePicker exposing
    ( Option
    , view
    , withId, withValue, withMin, withMax, withStep
    , withRequired, withDisabled
    , withHint, withError
    , onChange
    )

{-| `<m3e-form-field>` wrapping a native `<input type=time>` — Material 3
time-picker surface.

Spec (per docs/CONVENTIONS.md):

  - Required: `{ label : String }`
  - Options: id, value (HH:MM), min, max, step, required, disabled, hint,
    error, onChange
  - Properties: `value`, `required`, `disabled` (native input DOM properties)
  - Events: `onChange` — native `input` event → HH:MM string via
    `event.target.value`
  - Tag: `timePicker`

**No `<m3e-time-picker>` yet:** `@m3e/web` does not ship a first-class
time-picker custom element. This module renders a native `<input type=time>`
inside `<m3e-form-field>` chrome, following the same approach as the old
`Ui.TimePicker`. When m3e adds a dedicated time-picker element, this module
can be upgraded without changing its public surface.

Values are exchanged as `"HH:MM"` (24-hour) strings — the native HTML time
format.

-}

import Html exposing (Html)
import Json.Decode as Decode
import Json.Encode as Encode
import M3e.Node as Node
import M3e.Renderable as Renderable exposing (Renderable, Supported)
import M3e.Internal as Internal


-- TYPES -----------------------------------------------------------------------


type Option msg
    = WithId String
    | WithValue String
    | WithMin String
    | WithMax String
    | WithStep Int
    | WithRequired Bool
    | WithDisabled Bool
    | WithHint (Html msg)
    | WithError (Html msg)
    | OnChange (String -> msg)


type alias Config msg =
    { id : Maybe String
    , value : Maybe String
    , min : Maybe String
    , max : Maybe String
    , step : Maybe Int
    , required : Bool
    , disabled : Bool
    , hint : Maybe (Html msg)
    , error : Maybe (Html msg)
    , onChange : Maybe (String -> msg)
    }


defaultConfig : Config msg
defaultConfig =
    { id = Nothing
    , value = Nothing
    , min = Nothing
    , max = Nothing
    , step = Nothing
    , required = False
    , disabled = False
    , hint = Nothing
    , error = Nothing
    , onChange = Nothing
    }


-- OPTION CONSTRUCTORS ---------------------------------------------------------


{-| Set the `id` attribute on the underlying `<input>` (and the matching `for`
on the `<label>`). Without this, an id is derived from the label.
-}
withId : String -> Option msg
withId =
    WithId


{-| Drive the time value (sets the DOM `value` property). Expects `"HH:MM"` in
24-hour format.
-}
withValue : String -> Option msg
withValue =
    WithValue


{-| Earliest allowed time (`"HH:MM"`). -}
withMin : String -> Option msg
withMin =
    WithMin


{-| Latest allowed time (`"HH:MM"`). -}
withMax : String -> Option msg
withMax =
    WithMax


{-| Step granularity in seconds. Use `60` for minute resolution (the browser
default) or `1` to expose seconds.
-}
withStep : Int -> Option msg
withStep =
    WithStep


{-| Mark the field as required. -}
withRequired : Bool -> Option msg
withRequired =
    WithRequired


{-| Disable the field. -}
withDisabled : Bool -> Option msg
withDisabled =
    WithDisabled


{-| Hint text for the form-field's `hint` slot. -}
withHint : Html msg -> Option msg
withHint =
    WithHint


{-| Error text for the form-field's `error` slot. -}
withError : Html msg -> Option msg
withError =
    WithError


{-| Handle the native `input` event. Receives the new time as `"HH:MM"`. -}
onChange : (String -> msg) -> Option msg
onChange =
    OnChange


-- VIEW ------------------------------------------------------------------------


{-| Render the time picker.

    M3e.TimePicker.view { label = "Meeting time" }
        [ M3e.TimePicker.withValue model.meetingTime
        , M3e.TimePicker.withMin "09:00"
        , M3e.TimePicker.withMax "17:00"
        , M3e.TimePicker.onChange MeetingTimeChanged
        ]

-}
view : { label : String } -> List (Option msg) -> Renderable { s | timePicker : Supported } msg
view req opts =
    let
        c =
            List.foldl apply defaultConfig opts

        id =
            Maybe.withDefault (slugify req.label) c.id
    in
    Internal.fromNode
        (Node.element "m3e-form-field"
            []
            (List.filterMap identity
                [ Just
                    (Node.element "label"
                        [ Node.attribute "for" id ]
                        [ Node.text req.label ]
                    )
                , Just
                    (Node.element "input"
                        (List.filterMap identity
                            [ Just (Node.attribute "id" id)
                            , Just (Node.attribute "type" "time")
                            , Maybe.map (\v -> Node.property "value" (Encode.string v)) c.value
                            , Maybe.map (Node.attribute "min") c.min
                            , Maybe.map (Node.attribute "max") c.max
                            , Maybe.map
                                (\n -> Node.attribute "step" (String.fromInt n))
                                c.step
                            , if c.required then
                                Just (Node.property "required" (Encode.bool True))

                              else
                                Nothing
                            , if c.disabled then
                                Just (Node.property "disabled" (Encode.bool True))

                              else
                                Nothing
                            , Maybe.map
                                (\f ->
                                    Node.on "input"
                                        (Decode.at [ "target", "value" ] Decode.string
                                            |> Decode.map f
                                        )
                                )
                                c.onChange
                            ]
                        )
                        []
                    )
                , Maybe.map
                    (\h -> Node.element "span" [ Node.attribute "slot" "hint" ] [ Node.raw h ])
                    c.hint
                , Maybe.map
                    (\h -> Node.element "span" [ Node.attribute "slot" "error" ] [ Node.raw h ])
                    c.error
                ]
            )
        )


-- INTERNAL --------------------------------------------------------------------


apply : Option msg -> Config msg -> Config msg
apply opt c =
    case opt of
        WithId s ->
            { c | id = Just s }

        WithValue s ->
            { c | value = Just s }

        WithMin s ->
            { c | min = Just s }

        WithMax s ->
            { c | max = Just s }

        WithStep n ->
            { c | step = Just n }

        WithRequired b ->
            { c | required = b }

        WithDisabled b ->
            { c | disabled = b }

        WithHint h ->
            { c | hint = Just h }

        WithError h ->
            { c | error = Just h }

        OnChange f ->
            { c | onChange = Just f }


{-| Derive a fallback id from the label text. -}
slugify : String -> String
slugify label =
    let
        slug =
            label
                |> String.toLower
                |> String.toList
                |> List.map
                    (\ch ->
                        if Char.isAlphaNum ch then
                            ch

                        else
                            '-'
                    )
                |> String.fromList
                |> String.split "-"
                |> List.filter (not << String.isEmpty)
                |> String.join "-"
    in
    "m3etp-" ++ slug
