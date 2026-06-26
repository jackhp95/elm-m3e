module Ui.Checkbox exposing
    ( Checkbox, Boolean, Tristate
    , boolean, tristate
    , withAttributes
    , withId, withRequired, withDisabled
    , view
    )

{-| Typed builder for `<m3e-checkbox>` — a control for selecting one or
more items from a list, or toggling a single value on/off. Mirrors the
Material 3 [Checkbox][m3] surface 1:1.

[m3]: https://m3.material.io/components/checkbox/overview

For a single on/off toggle where the change should commit instantly,
prefer [`Ui.Switch`](Ui-Switch). For exclusive single-choice in a small
group, prefer [`Ui.RadioButton`](Ui-RadioButton).


# Two kinds, gated by the type system

A checkbox carries either a boolean state or a tristate (with an
indeterminate option). The kind is reflected in `Checkbox`'s phantom
type tag (`Boolean` / `Tristate`) so future kind-specific modifiers can
land without redesigning the type.

  - **Boolean** (`boolean`) — checked or unchecked.
  - **Tristate** (`tristate`) — checked, unchecked, or indeterminate
    (represented by `Maybe Bool`: `Just True` / `Just False` / `Nothing`).

Per Material guidance, the indeterminate state is set programmatically
(e.g. when a parent "select all" reflects a mixed child selection) — a
user click on an indeterminate checkbox flips it to _checked_ and the
caller decides how to evolve its `Maybe Bool` model from there.


# Required-by-design

Every constructor requires:

  - `label` — the visible adjacent text. Per Material spec the label
    is the primary affordance; clicking it must toggle the checkbox, so
    it's required for accessibility and is not optional.
  - the state value (`checked : Bool` or `state : Maybe Bool`).
  - `onChange` — handler receiving the _new_ boolean state from the
    user's interaction.


# Required marker

`withRequired` sets the underlying control's `required` property (used for
form submission and the field's required marker when composed with `Ui.Field`).


# Quick examples

A single boolean checkbox:

    Ui.Checkbox.boolean
        { label = "I agree to the terms"
        , checked = state.agreed
        , onChange = TermsAgreementChanged
        }
        |> Ui.Checkbox.withRequired True
        |> Ui.Checkbox.view

A tristate "select all" checkbox in a parent row:

    Ui.Checkbox.tristate
        { label = "Select all"
        , state = state.allSelectionState
        , onChange = AllToggled
        }
        |> Ui.Checkbox.view

A checkbox renders **bare** (just the box, with its `label` kept as an
`aria-label`). For a visible label and supporting/error text, compose it with
[`Ui.Field`](Ui-Field):

    Ui.Field.new "Subscribe to product updates"
        |> Ui.Field.withHint (text "We'll email you no more than once a week.")
        |> Ui.Field.view
            (Ui.Checkbox.boolean
                { label = "Subscribe to product updates"
                , checked = state.subscribed
                , onChange = SubscribeToggled
                }
                |> Ui.Checkbox.view
            )


# Type

@docs Checkbox, Boolean, Tristate


# Constructors

@docs boolean, tristate


# Host attributes

@docs withAttributes


# Modifiers

@docs withId, withRequired, withDisabled


# Render

@docs view

-}

import Html exposing (Attribute, Html)
import Html.Attributes as Attr
import Json.Decode as Decode
import M3e.Checkbox



-- TYPES ------------------------------------------------------------------


{-| A checkbox, parameterized by its kind tag (`Boolean` / `Tristate`)
and the message type. Built via `boolean` / `tristate` and configured
with `with*` modifiers.
-}
type Checkbox kind msg
    = Checkbox (Config msg)


{-| Phantom tag for boolean-state checkboxes. Has no values; appears
only in the `Checkbox` type parameter.
-}
type Boolean
    = BooleanPhantomTag Never


{-| Phantom tag for tristate (Maybe Bool) checkboxes. Has no values;
appears only in the `Checkbox` type parameter.
-}
type Tristate
    = TristatePhantomTag Never


type alias Config msg =
    { id : Maybe String
    , attributes : List (Attribute msg)
    , label : String
    , state : State
    , onChange : Bool -> msg
    , required : Bool
    , disabled : Bool
    }


type State
    = StateBool Bool
    | StateMaybe (Maybe Bool)



-- CONSTRUCTORS -----------------------------------------------------------


{-| Construct a boolean-state checkbox.

    Ui.Checkbox.boolean
        { label = "I agree to the terms"
        , checked = state.agreed
        , onChange = TermsAgreementChanged
        }
        |> Ui.Checkbox.view

The `onChange` handler receives the _new_ boolean state.

-}
boolean :
    { label : String, checked : Bool, onChange : Bool -> msg }
    -> Checkbox Boolean msg
boolean c =
    Checkbox (baseConfig c.label (StateBool c.checked) c.onChange)


{-| Construct a tristate checkbox.

    Ui.Checkbox.tristate
        { label = "Select all"
        , state = state.allSelectionState -- : Maybe Bool
        , onChange = AllToggled
        }
        |> Ui.Checkbox.view

`state` is `Maybe Bool`:

  - `Just True` — checked
  - `Just False` — unchecked
  - `Nothing` — indeterminate

The `onChange` handler receives the _new_ boolean state from the user
click. A click on an indeterminate checkbox produces `True`; the caller
decides how their `Maybe Bool` model evolves.

-}
tristate :
    { label : String, state : Maybe Bool, onChange : Bool -> msg }
    -> Checkbox Tristate msg
tristate c =
    Checkbox (baseConfig c.label (StateMaybe c.state) c.onChange)


baseConfig : String -> State -> (Bool -> msg) -> Config msg
baseConfig label state onChange =
    { id = Nothing
    , attributes = []
    , label = label
    , state = state
    , onChange = onChange
    , required = False
    , disabled = False
    }



-- MODIFIERS --------------------------------------------------------------


{-| Append attributes to the rendered `<m3e-checkbox>`. The builder's structural
attributes are emitted after these, so callers can't clobber them.
-}
withAttributes : List (Attribute msg) -> Checkbox kind msg -> Checkbox kind msg
withAttributes attributes (Checkbox cfg) =
    Checkbox { cfg | attributes = cfg.attributes ++ attributes }


{-| Set the `id` attribute on the underlying `<m3e-checkbox>`. Useful for
analytics, scroll-to, and label-`for` association in custom layouts.
-}
withId : String -> Checkbox kind msg -> Checkbox kind msg
withId id (Checkbox cfg) =
    Checkbox { cfg | id = Just id }


{-| Mark the checkbox as required for form submission. Maps to the
`required` attribute (default `false`); drives form-submission validation
and the required marker when composed with `Ui.Field`.
-}
withRequired : Bool -> Checkbox kind msg -> Checkbox kind msg
withRequired required (Checkbox cfg) =
    Checkbox { cfg | required = required }


{-| Mark the checkbox as disabled — non-interactive. Maps to the
`disabled` attribute (default `false`).
-}
withDisabled : Bool -> Checkbox kind msg -> Checkbox kind msg
withDisabled disabled (Checkbox cfg) =
    Checkbox { cfg | disabled = disabled }



-- RENDER -----------------------------------------------------------------


{-| Render the checkbox to `Html` — a bare `<m3e-checkbox>` with its `label` as
an `aria-label`. Wrap it in [`Ui.Field`](Ui-Field) for a visible label /
subscript.
-}
view : Checkbox kind msg -> Html msg
view (Checkbox cfg) =
    checkboxElement cfg.attributes cfg


controlId : Config msg -> String
controlId cfg =
    case cfg.id of
        Just id ->
            id

        Nothing ->
            slugify cfg.label


checkboxElement : List (Attribute msg) -> Config msg -> Html msg
checkboxElement extraAttrs cfg =
    M3e.Checkbox.component
        (extraAttrs
            ++ List.filterMap identity
                [ Just (Attr.id (controlId cfg))
                , Just (M3e.Checkbox.checked (isChecked cfg.state))
                , Just (M3e.Checkbox.indeterminate (isIndeterminate cfg.state))
                , Just (M3e.Checkbox.disabled cfg.disabled)
                , Just (M3e.Checkbox.required cfg.required)
                , Just (Attr.attribute "aria-label" cfg.label)
                , Just (M3e.Checkbox.onChange (changeDecoder cfg.onChange))
                ]
        )
        []


isChecked : State -> Bool
isChecked state =
    case state of
        StateBool b ->
            b

        StateMaybe maybe ->
            maybe == Just True


isIndeterminate : State -> Bool
isIndeterminate state =
    case state of
        StateBool _ ->
            False

        StateMaybe maybe ->
            maybe == Nothing


changeDecoder : (Bool -> msg) -> Decode.Decoder msg
changeDecoder toMsg =
    Decode.at [ "target", "checked" ] Decode.bool
        |> Decode.map toMsg


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
