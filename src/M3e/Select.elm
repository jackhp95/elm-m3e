module M3e.Select exposing
    ( Option, OptionOption
    , view, option, options
    , id, multi, required, disabled, onChange, onInput, onToggle, onMultiChange
    , name
    , optionSelected, optionDisabled
    )

{-| `<m3e-select>` inside `<m3e-form-field>` with a proper `<label for=id>`
— Material 3 select / dropdown.

Spec (per docs/CONVENTIONS.md):

  - Required: `{ label : Label msg }` — visible accessible label
  - Options (container): id, multi, required, disabled, onChange, onInput,
    onToggle, onMultiChange, options, name
  - Options (option): selected, disabled
  - Slots: `selectOption` — the `<m3e-option>` children
  - Properties: multi, required, disabled (web-component properties on m3e-select)
  - Events (upstream `M3eSelectElement`):
    `change` → `onChange` (single-select) / `onMultiChange` (multi).
    `event.target.value` is `string | null` (single) or
    `readonly string[] | null` (multi).
    `input` → `onInput` (single-select live); same signal as `change`
    but fires synchronously. Decoded as String.
    `toggle` → `onToggle`: `ToggleEvent`, decoded from
    `event.newState == "open"` as Bool (`True` = panel opened).
    (`beforeinput` is also emitted upstream but is not exposed — it arrives
    before state changes and cannot be cancelled from Elm.)
  - Tag: `select`

**Fix #13 — relational label:** the label is rendered as `<label for=selectId>`
inside `<m3e-form-field>`, with the `<m3e-select>` carrying `id=selectId`. This
is what `M3e.Field` implements, applied inline. The old `Ui.Select` set `label=`
as an inert attribute on `<m3e-select>` — that never wired the accessible label.

**onChange:** wires the `change` event on `<m3e-select>` and decodes
`event.target.value` as a string. This requires each `<m3e-option>` to carry a
`value` attribute — `M3e.Select.option` sets this automatically from the
`value` field.

@docs Option, OptionOption
@docs view, option, options
@docs id, multi, required, disabled, onChange, onInput, onToggle, onMultiChange
@docs name
@docs optionSelected, optionDisabled

-}

import Json.Decode as Decode
import Json.Encode as Encode
import M3e.Element as Element exposing (Element, Supported)
import M3e.Internal as Internal
import M3e.Node as Node



-- TYPES -----------------------------------------------------------------------


type alias OptionConfig =
    { selected : Bool, disabled : Bool }


{-| Options on an individual `<m3e-option>`.
-}
type alias OptionOption msg =
    Internal.Option OptionConfig msg


{-| Options on the `<m3e-select>` container.
-}
type alias Option msg =
    Internal.Option (Config msg) msg


type alias Config msg =
    { id : Maybe String
    , multi : Bool
    , required : Bool
    , disabled : Bool
    , onChange : Maybe (String -> msg)
    , onInput : Maybe (String -> msg)
    , onToggle : Maybe (Bool -> msg)
    , onMultiChange : Maybe (List String -> msg)
    , options : List (Element { selectOption : Supported } msg)
    , name : Maybe String
    }


defaultConfig : Config msg
defaultConfig =
    { id = Nothing
    , multi = False
    , required = False
    , disabled = False
    , onChange = Nothing
    , onInput = Nothing
    , onToggle = Nothing
    , onMultiChange = Nothing
    , options = []
    , name = Nothing
    }



-- OPTION CONSTRUCTORS (ITEM) --------------------------------------------------


{-| Mark this option as currently selected. Sets the `selected` DOM property on
`<m3e-option>`.
-}
optionSelected : Bool -> OptionOption msg
optionSelected b =
    Internal.option (\c -> { c | selected = b })


{-| Disable this option.
-}
optionDisabled : Bool -> OptionOption msg
optionDisabled b =
    Internal.option (\c -> { c | disabled = b })



-- OPTION CONSTRUCTORS (CONTAINER) ---------------------------------------------


{-| Set the `id` attribute on the `<m3e-select>`.
-}
id : String -> Option msg
id s =
    Internal.option (\c -> { c | id = Just s })


{-| Enable multi-select (sets the `multi` DOM property on `<m3e-select>`).
Default `False`.
-}
multi : Bool -> Option msg
multi b =
    Internal.option (\c -> { c | multi = b })


{-| Mark the select as required.
-}
required : Bool -> Option msg
required b =
    Internal.option (\c -> { c | required = b })


{-| Disable the select.
-}
disabled : Bool -> Option msg
disabled b =
    Internal.option (\c -> { c | disabled = b })


{-| Handle selection changes (single-select). The handler receives the
value string of the newly selected option decoded from `event.target.value`
on the `change` event. Use `onMultiChange` instead when `multi = True`.
-}
onChange : (String -> msg) -> Option msg
onChange f =
    Internal.option (\c -> { c | onChange = Just f })


{-| Handle live selection changes (single-select). Fires on the `input`
event — synchronously as the selected state changes, before the `change`
event. Decodes `event.target.value` as a String. Useful for real-time
validation or previews.
-}
onInput : (String -> msg) -> Option msg
onInput f =
    Internal.option (\c -> { c | onInput = Just f })


{-| Handle the dropdown panel opening and closing. The handler receives
`True` when the panel opens and `False` when it closes, decoded from
`event.newState` on the `toggle` event (`ToggleEvent`).
-}
onToggle : (Bool -> msg) -> Option msg
onToggle f =
    Internal.option (\c -> { c | onToggle = Just f })


{-| Handle selection changes in multi-select mode (`multi = True`). The
handler receives the full list of selected values decoded from
`event.target.value` on the `change` event — the element's value is
`readonly string[] | null` in multi mode.
-}
onMultiChange : (List String -> msg) -> Option msg
onMultiChange f =
    Internal.option (\c -> { c | onMultiChange = Just f })


{-| Supply the list of options to render inside `<m3e-select>`.
-}
options : List (Element { selectOption : Supported } msg) -> Option msg
options os =
    Internal.option (\c -> { c | options = os })


{-| Set the form field name (the `name` attribute on `<m3e-select>`).
This identifies the select when its containing form is submitted.
Upstream: `FormAssociated` mixin → `name` attribute.
-}
name : String -> Option msg
name v =
    Internal.option (\c -> { c | name = Just v })



-- ITEM CONSTRUCTOR ------------------------------------------------------------


{-| Construct an `<m3e-option>`. The `value` field is emitted as the `value`
attribute so `event.target.value` on the select's `change` event returns it.

    M3e.Select.option { value = "pro", label = "Pro" }
        [ M3e.Select.optionSelected (model.plan == "pro") ]

-}
option :
    { value : String, label : String }
    -> List (OptionOption msg)
    -> Element { selectOption : Supported } msg
option req opts =
    let
        oc : OptionConfig
        oc =
            Internal.applyOptions opts { selected = False, disabled = False }
    in
    Internal.fromNode
        (Node.element "m3e-option"
            [ Node.attribute "value" req.value
            , Node.property "selected" (Encode.bool oc.selected)
            , Node.property "disabled" (Encode.bool oc.disabled)
            ]
            [ Node.text req.label ]
        )



-- VIEW ------------------------------------------------------------------------


{-| Render the select.

The label is wired as `<label for=id>` inside `<m3e-form-field>`, fixing the
accessible-label association (#13).

    M3e.Select.view
        { label = "Plan" }
        [ M3e.Select.options
            [ M3e.Select.option { value = "free", label = "Free" } []
            , M3e.Select.option { value = "pro", label = "Pro" }
                [ M3e.Select.optionSelected True ]
            ]
        , M3e.Select.onChange PlanSelected
        ]

-}
view :
    { label : String }
    -> List (Option msg)
    -> Element { s | select : Supported } msg
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
            [ Node.element "label"
                [ Node.attribute "for" fieldId ]
                [ Node.text req.label ]
            , Node.element "m3e-select"
                (List.filterMap identity
                    [ Just (Node.attribute "id" fieldId)
                    , Just (Node.property "multi" (Encode.bool c.multi))
                    , Just (Node.property "required" (Encode.bool c.required))
                    , Just (Node.property "disabled" (Encode.bool c.disabled))
                    , Maybe.map (\v -> Node.attribute "name" v) c.name
                    , Maybe.map
                        (\handler ->
                            Node.on "change"
                                (Decode.at [ "target", "value" ] Decode.string
                                    |> Decode.map handler
                                )
                        )
                        c.onChange
                    , Maybe.map
                        (\handler ->
                            Node.on "input"
                                (Decode.at [ "target", "value" ] Decode.string
                                    |> Decode.map handler
                                )
                        )
                        c.onInput
                    , Maybe.map
                        (\handler ->
                            Node.on "toggle"
                                (Decode.at [ "newState" ] Decode.string
                                    |> Decode.map (\s -> handler (s == "open"))
                                )
                        )
                        c.onToggle
                    , Maybe.map
                        (\handler ->
                            Node.on "change"
                                (Decode.at [ "target", "value" ] (Decode.list Decode.string)
                                    |> Decode.map handler
                                )
                        )
                        c.onMultiChange
                    ]
                )
                (List.map Element.toNode c.options)
            ]
        )



-- INTERNAL --------------------------------------------------------------------


{-| Derive a fallback id from the label text.
-}
slugify : String -> String
slugify =
    Internal.slugify "m3esel-"
