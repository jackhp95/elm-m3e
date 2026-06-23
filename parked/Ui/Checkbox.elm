module Ui.Checkbox exposing
    ( Checkbox, Boolean, Tristate
    , boolean, tristate
    , withId, withHelp, withError, withRequired, withDisabled
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


# Form chrome modifiers

`withHelp`, `withError`, `withRequired` decorate the surrounding
`<m3e-form-field>`. Setting both `withHelp` and `withError` is allowed
— `withError` takes visual precedence at render time.


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

With help text and an error message:

    Ui.Checkbox.boolean
        { label = "Subscribe to product updates"
        , checked = state.subscribed
        , onChange = SubscribeToggled
        }
        |> Ui.Checkbox.withHelp (text "We'll email you no more than once a week.")
        |> Ui.Checkbox.withError (text "Subscription requires a verified email.")
        |> Ui.Checkbox.view


# Type

@docs Checkbox, Boolean, Tristate


# Constructors

@docs boolean, tristate


# Modifiers

@docs withId, withHelp, withError, withRequired, withDisabled


# Render

@docs view

-}

import Html exposing (Html)
import Html.Attributes as Attr
import Json.Decode as Decode
import M3e.Checkbox
import M3e.FormField



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
    , label : String
    , state : State
    , onChange : Bool -> msg
    , help : Maybe (Html msg)
    , error : Maybe (Html msg)
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
    , label = label
    , state = state
    , onChange = onChange
    , help = Nothing
    , error = Nothing
    , required = False
    , disabled = False
    }



-- MODIFIERS --------------------------------------------------------------


{-| Set the `id` attribute on the underlying `<m3e-checkbox>`. Useful for
analytics, scroll-to, and label-`for` association in custom layouts.
-}
withId : String -> Checkbox kind msg -> Checkbox kind msg
withId id (Checkbox cfg) =
    Checkbox { cfg | id = Just id }


{-| Set help text rendered beneath the field.

    |> Ui.Checkbox.withHelp (text "We'll email you no more than once a week.")

-}
withHelp : Html msg -> Checkbox kind msg -> Checkbox kind msg
withHelp help (Checkbox cfg) =
    Checkbox { cfg | help = Just help }


{-| Set an error message. When set, the field renders in its error
visual style and the error message replaces help text.

    |> Ui.Checkbox.withError (text "Subscription requires a verified email.")

-}
withError : Html msg -> Checkbox kind msg -> Checkbox kind msg
withError error (Checkbox cfg) =
    Checkbox { cfg | error = Just error }


{-| Mark the checkbox as required for form submission. Affects the
field's visual marker and the underlying control's `required` property.
-}
withRequired : Bool -> Checkbox kind msg -> Checkbox kind msg
withRequired required (Checkbox cfg) =
    Checkbox { cfg | required = required }


{-| Mark the checkbox as disabled — non-interactive.
-}
withDisabled : Bool -> Checkbox kind msg -> Checkbox kind msg
withDisabled disabled (Checkbox cfg) =
    Checkbox { cfg | disabled = disabled }



-- RENDER -----------------------------------------------------------------


{-| Render the checkbox (wrapped in its form-field chrome) to `Html`.
Use this as the final step of the builder pipeline.
-}
view : Checkbox kind msg -> Html msg
view (Checkbox cfg) =
    M3e.FormField.component
        []
        (List.concat
            [ [ checkboxElement cfg
              , labelElement cfg
              ]
            , subscriptElements cfg
            ]
        )


checkboxElement : Config msg -> Html msg
checkboxElement cfg =
    M3e.Checkbox.component
        (List.filterMap identity
            [ Maybe.map Attr.id cfg.id
            , Just (M3e.Checkbox.checked (isChecked cfg.state))
            , Just (M3e.Checkbox.indeterminate (isIndeterminate cfg.state))
            , Just (M3e.Checkbox.disabled cfg.disabled)
            , Just (M3e.Checkbox.required cfg.required)
            , Just (M3e.Checkbox.onChange (changeDecoder cfg.onChange))
            ]
        )
        []


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
    -- Error takes visual precedence over help when both are set.
    case ( cfg.error, cfg.help ) of
        ( Just err, _ ) ->
            [ Html.span [ M3e.FormField.errorSlot ] [ err ] ]

        ( Nothing, Just help ) ->
            [ Html.span [ M3e.FormField.hintSlot ] [ help ] ]

        ( Nothing, Nothing ) ->
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
