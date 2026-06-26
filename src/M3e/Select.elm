module M3e.Select exposing
    ( OptionOption, Option
    , option, optionSelected, optionDisabled
    , view
    , withId, withMulti, withRequired, withDisabled, withOptions, onChange
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
import M3e.Node as Node exposing (Node)
import M3e.Renderable as Renderable exposing (Renderable, Supported)


-- TYPES -----------------------------------------------------------------------


{-| Options on an individual `<m3e-option>`. -}
type OptionOption msg
    = OptionSelected Bool
    | OptionDisabled Bool


{-| Options on the `<m3e-select>` container. -}
type Option msg
    = WithId String
    | WithMulti Bool
    | WithRequired Bool
    | WithDisabled Bool
    | OnChange (String -> msg)
    | WithOptions (List (Renderable { selectOption : Supported } msg))
    | WithHint (Html msg)
    | WithError (Html msg)


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
optionSelected =
    OptionSelected


{-| Disable this option. -}
optionDisabled : Bool -> OptionOption msg
optionDisabled =
    OptionDisabled


-- OPTION CONSTRUCTORS (CONTAINER) ---------------------------------------------


{-| Set the `id` attribute on the `<m3e-select>`. -}
withId : String -> Option msg
withId =
    WithId


{-| Enable multi-select (sets the `multi` DOM property on `<m3e-select>`).
Default `False`.
-}
withMulti : Bool -> Option msg
withMulti =
    WithMulti


{-| Mark the select as required. -}
withRequired : Bool -> Option msg
withRequired =
    WithRequired


{-| Disable the select. -}
withDisabled : Bool -> Option msg
withDisabled =
    WithDisabled


{-| Handle selection changes. The handler receives the value string of the
newly selected option (from `event.target.value` on the `change` event).
-}
onChange : (String -> msg) -> Option msg
onChange =
    OnChange


{-| Supply the list of options to render inside `<m3e-select>`. -}
withOptions : List (Renderable { selectOption : Supported } msg) -> Option msg
withOptions =
    WithOptions


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
        selected =
            List.foldl
                (\o acc ->
                    case o of
                        OptionSelected b ->
                            b

                        _ ->
                            acc
                )
                False
                opts

        disabled =
            List.foldl
                (\o acc ->
                    case o of
                        OptionDisabled b ->
                            b

                        _ ->
                            acc
                )
                False
                opts
    in
    Renderable.fromNode
        (Node.element "m3e-option"
            (List.filterMap identity
                [ Just (Node.attribute "value" req.value)
                , Just (Node.property "selected" (Encode.bool selected))
                , if disabled then
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
        [ M3e.Select.withOptions
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
            List.foldl apply defaultConfig opts

        id =
            Maybe.withDefault (slugify req.label) c.id
    in
    Renderable.fromNode
        (Node.element "m3e-form-field"
            []
            (List.filterMap identity
                [ Just
                    (Node.element "label"
                        [ Node.attribute "for" id ]
                        [ Node.text req.label ]
                    )
                , Just
                    (Node.element "m3e-select"
                        (List.filterMap identity
                            [ Just (Node.attribute "id" id)
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


apply : Option msg -> Config msg -> Config msg
apply opt c =
    case opt of
        WithId s ->
            { c | id = Just s }

        WithMulti b ->
            { c | multi = b }

        WithRequired b ->
            { c | required = b }

        WithDisabled b ->
            { c | disabled = b }

        OnChange f ->
            { c | onChange = Just f }

        WithOptions os ->
            { c | options = os }

        WithHint h ->
            { c | hint = Just h }

        WithError h ->
            { c | error = Just h }


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
    "m3esel-" ++ slug
