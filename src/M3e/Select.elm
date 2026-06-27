module M3e.Select exposing
    ( Option
    , OptionOption
    , disabled
    , id
    , multi
    , onChange
    , option
    , optionDisabled
    , optionSelected
    , options
    , required
    , view
    )

{-| `<m3e-select>` inside `<m3e-form-field>` with a proper `<label for=id>`
— Material 3 select / dropdown.

Spec (per docs/CONVENTIONS.md):

  - Required: `{ label : Label msg }` — visible accessible label
  - Options (container): id, multi, required, disabled, onChange, options
  - Options (option): selected, disabled
  - Slots: `selectOption` — the `<m3e-option>` children
  - Properties: multi, required, disabled (web-component properties on m3e-select)
  - Events: `onChange` — fires on the `change` event, decodes
    `event.target.value` as the selected option's value string
  - Tag: `select`

**Fix #13 — relational label:** the label is rendered as `<label for=selectId>`
inside `<m3e-form-field>`, with the `<m3e-select>` carrying `id=selectId`. This
is what `M3e.Field` implements; here it is applied inline so we can also add
hint/error children to the form-field. The old `Ui.Select` set `label=` as an
inert attribute on `<m3e-select>` — that never wired the accessible label.

**onChange:** wires the `change` event on `<m3e-select>` and decodes
`event.target.value` as a string. This requires each `<m3e-option>` to carry a
`value` attribute — `M3e.Select.option` sets this automatically from the
`value` field.

-}

import Html exposing (Html)
import Json.Decode as Decode
import Json.Encode as Encode
import M3e.Internal as Internal
import M3e.Node as Node exposing (Node)
import M3e.Renderable as Renderable exposing (Renderable, Supported)



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
    , options : List (Renderable { selectOption : Supported } msg)
    , hint : Maybe (Html msg)
    , error : Maybe (Html msg)
    }


defaultConfig : Config msg
defaultConfig =
    { id = Nothing
    , multi = False
    , required = False
    , disabled = False
    , onChange = Nothing
    , options = []
    , hint = Nothing
    , error = Nothing
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


{-| Handle selection changes. The handler receives the value string of the
newly selected option (from `event.target.value` on the `change` event).
-}
onChange : (String -> msg) -> Option msg
onChange f =
    Internal.option (\c -> { c | onChange = Just f })


{-| Supply the list of options to render inside `<m3e-select>`.
-}
options : List (Renderable { selectOption : Supported } msg) -> Option msg
options os =
    Internal.option (\c -> { c | options = os })



-- ITEM CONSTRUCTOR ------------------------------------------------------------


{-| Construct an `<m3e-option>`. The `value` field is emitted as the `value`
attribute so `event.target.value` on the select's `change` event returns it.

    M3e.Select.option { value = "pro", label = "Pro" }
        [ M3e.Select.optionSelected (model.plan == "pro") ]

-}
option :
    { value : String, label : String }
    -> List (OptionOption msg)
    -> Renderable { selectOption : Supported } msg
option req opts =
    let
        oc =
            Internal.applyOptions opts { selected = False, disabled = False }
    in
    Internal.fromNode
        (Node.element "m3e-option"
            (List.filterMap identity
                [ Just (Node.attribute "value" req.value)
                , Just (Node.property "selected" (Encode.bool oc.selected))
                , if oc.disabled then
                    Just (Node.property "disabled" (Encode.bool True))

                  else
                    Nothing
                ]
            )
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
    -> Renderable { s | select : Supported } msg
view req opts =
    let
        c =
            Internal.applyOptions opts defaultConfig

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
                    (Node.element "m3e-select"
                        (List.filterMap identity
                            [ Just (Node.attribute "id" fieldId)
                            , if c.multi then
                                Just (Node.property "multi" (Encode.bool True))

                              else
                                Nothing
                            , if c.required then
                                Just (Node.property "required" (Encode.bool True))

                              else
                                Nothing
                            , if c.disabled then
                                Just (Node.property "disabled" (Encode.bool True))

                              else
                                Nothing
                            , Maybe.map
                                (\handler ->
                                    Node.on "change"
                                        (Decode.at [ "target", "value" ] Decode.string
                                            |> Decode.map handler
                                        )
                                )
                                c.onChange
                            ]
                        )
                        (List.map Renderable.toNode c.options)
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


{-| Derive a fallback id from the label text.
-}
slugify : String -> String
slugify =
    Internal.slugify "m3esel-"
