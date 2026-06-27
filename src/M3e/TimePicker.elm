module M3e.TimePicker exposing
    ( view
    , Option
    , id, value, min, max, step, required, disabled, hint, error, onChange
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

@docs view
@docs Option
@docs id, value, min, max, step, required, disabled, hint, error, onChange

-}

import Json.Decode as Decode
import Json.Encode as Encode
import M3e.Element as Element exposing (Element, Supported)
import M3e.Internal as Internal
import M3e.Node as Node



-- TYPES -----------------------------------------------------------------------


{-| An option configuring the time-picker form field.
-}
type alias Option msg =
    Internal.Option (Config msg) msg


type alias Config msg =
    { id : Maybe String
    , value : Maybe String
    , min : Maybe String
    , max : Maybe String
    , step : Maybe Int
    , required : Bool
    , disabled : Bool
    , hint : Maybe (Node.Node msg)
    , error : Maybe (Node.Node msg)
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
id : String -> Option msg
id s =
    Internal.option (\c -> { c | id = Just s })


{-| Drive the time value (sets the DOM `value` property). Expects `"HH:MM"` in
24-hour format.
-}
value : String -> Option msg
value s =
    Internal.option (\c -> { c | value = Just s })


{-| Earliest allowed time (`"HH:MM"`).
-}
min : String -> Option msg
min s =
    Internal.option (\c -> { c | min = Just s })


{-| Latest allowed time (`"HH:MM"`).
-}
max : String -> Option msg
max s =
    Internal.option (\c -> { c | max = Just s })


{-| Step granularity in seconds. Use `60` for minute resolution (the browser
default) or `1` to expose seconds.
-}
step : Int -> Option msg
step n =
    Internal.option (\c -> { c | step = Just n })


{-| Mark the field as required.
-}
required : Bool -> Option msg
required b =
    Internal.option (\c -> { c | required = b })


{-| Disable the field.
-}
disabled : Bool -> Option msg
disabled b =
    Internal.option (\c -> { c | disabled = b })


{-| Hint for the form-field's `hint` slot. A slottable element — use
`Element.text` for a plain string, or `Element.element` for richer content.
-}
hint : Element { element : Supported } msg -> Option msg
hint r =
    Internal.option (\c -> { c | hint = Just (Element.toNode r) })


{-| Error for the form-field's `error` slot. See [`hint`](#hint).
-}
error : Element { element : Supported } msg -> Option msg
error r =
    Internal.option (\c -> { c | error = Just (Element.toNode r) })


{-| Handle the native `input` event. Receives the new time as `"HH:MM"`.
-}
onChange : (String -> msg) -> Option msg
onChange f =
    Internal.option (\c -> { c | onChange = Just f })



-- VIEW ------------------------------------------------------------------------


{-| Render the time picker.

    M3e.TimePicker.view { label = "Meeting time" }
        [ M3e.TimePicker.value model.meetingTime
        , M3e.TimePicker.min "09:00"
        , M3e.TimePicker.max "17:00"
        , M3e.TimePicker.onChange MeetingTimeChanged
        ]

-}
view : { label : String } -> List (Option msg) -> Element { s | timePicker : Supported } msg
view req opts =
    let
        c : Config msg
        c =
            Internal.applyOptions opts defaultConfig

        fieldId : String
        fieldId =
            Maybe.withDefault (slugify req.label) c.id
    in
    Internal.fromNode
        (Node.element "m3e-form-field"
            []
            (List.filterMap identity
                [ Just
                    (Node.element "label"
                        [ Node.attribute "for" fieldId ]
                        [ Node.text req.label ]
                    )
                , Just
                    (Node.element "input"
                        (List.filterMap identity
                            [ Just (Node.attribute "id" fieldId)
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
                , Maybe.map (Node.withSlot "hint") c.hint
                , Maybe.map (Node.withSlot "error") c.error
                ]
            )
        )



-- INTERNAL --------------------------------------------------------------------


{-| Derive a fallback id from the label text (shared slug logic in M3e.Internal).
-}
slugify : String -> String
slugify =
    Internal.slugify "m3etp-"
