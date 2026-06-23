module Ui.RadioButton exposing
    ( RadioGroup, Option
    , group, option
    , withId, withHelp, withError, withRequired, withDisabled
    , view
    )

{-| Typed builder for `<m3e-radio-group>` containing `<m3e-radio>`
elements — a control for selecting exactly one option from a small set.
Mirrors the Material 3 [Radio button][m3] surface.

[m3]: https://m3.material.io/components/radio-button/overview

A lone radio button isn't a real interaction — radio buttons always
appear as a group. This module's API reflects that: callers always
build a `RadioGroup`, not a single button.

When to choose Radio vs siblings:

  - **`Ui.RadioButton`** — exclusive single-choice in a _small_ set
    (5–7 options is the Material sweet spot).
  - **`Ui.Checkbox`** (in a list) — when _multiple_ options can be
    selected, or when a single boolean toggles.
  - **`Ui.Select`** — single-choice from a _long_ list (10+ options).
  - **`Ui.SegmentedButton`** — single-choice with strong button-row
    visual treatment (2–5 options).


# Required-by-design

`group` requires:

  - `label` — the group's label (per Material, a radio group needs
    a label that names what's being chosen).
  - `options` — at least one `Option`.
  - `selected` — currently-selected `value` (`Nothing` for no
    initial selection).
  - `onChange` — handler receiving the newly-selected typed value.

Each `option` requires:

  - `value` — your typed model value (e.g. a custom union type).
  - `label` — the visible text adjacent to this option's button.


# Generic over `value`

The group is parameterized by a `value` type variable, so your
selection state stays typed end-to-end:

    type Pricing
        = Monthly
        | Yearly
        | Lifetime

    pricingGroup : Maybe Pricing -> Html Msg
    pricingGroup selected =
        Ui.RadioButton.group
            { label = "Billing cycle"
            , options =
                [ Ui.RadioButton.option { value = Monthly, label = "Monthly" }
                , Ui.RadioButton.option { value = Yearly, label = "Yearly" }
                , Ui.RadioButton.option { value = Lifetime, label = "Lifetime" }
                ]
            , selected = selected
            , onChange = PricingChanged
            }
            |> Ui.RadioButton.view

`value` must support equality (`==`) — the renderer compares each
option's value to `selected` to determine which radio renders checked.
Records and custom union types both work; functions do not.


# Type

@docs RadioGroup, Option


# Constructors

@docs group, option


# Modifiers

@docs withId, withHelp, withError, withRequired, withDisabled


# Render

@docs view

-}

import Html exposing (Html)
import Html.Attributes as Attr
import Html.Events as HtmlEvents
import M3e.FormField
import M3e.Radio
import M3e.RadioGroup



-- TYPES ------------------------------------------------------------------


{-| A group of radio buttons, parameterized by the selectable `value` type.
Built via `group` and configured with `with*` modifiers.
-}
type RadioGroup value msg
    = RadioGroup (Config value msg)


{-| One selectable option in a `RadioGroup`. Construct via `option`.
-}
type Option value
    = Option { value : value, label : String }


type alias Config value msg =
    { id : Maybe String
    , label : String
    , options : List (Option value)
    , selected : Maybe value
    , onChange : value -> msg
    , help : Maybe (Html msg)
    , error : Maybe (Html msg)
    , required : Bool
    , disabled : Bool
    }



-- CONSTRUCTORS -----------------------------------------------------------


{-| Construct a radio group.

    Ui.RadioButton.group
        { label = "Billing cycle"
        , options =
            [ Ui.RadioButton.option { value = Monthly, label = "Monthly" }
            , Ui.RadioButton.option { value = Yearly, label = "Yearly" }
            ]
        , selected = Just Monthly
        , onChange = BillingCycleChanged
        }
        |> Ui.RadioButton.view

-}
group :
    { label : String
    , options : List (Option value)
    , selected : Maybe value
    , onChange : value -> msg
    }
    -> RadioGroup value msg
group c =
    RadioGroup
        { id = Nothing
        , label = c.label
        , options = c.options
        , selected = c.selected
        , onChange = c.onChange
        , help = Nothing
        , error = Nothing
        , required = False
        , disabled = False
        }


{-| Construct one option in a radio group.

    Ui.RadioButton.option { value = Monthly, label = "Monthly" }

-}
option : { value : value, label : String } -> Option value
option =
    Option



-- MODIFIERS --------------------------------------------------------------


{-| Set the `id` attribute on the underlying `<m3e-radio-group>`.
-}
withId : String -> RadioGroup value msg -> RadioGroup value msg
withId id (RadioGroup cfg) =
    RadioGroup { cfg | id = Just id }


{-| Set help text rendered beneath the group.
-}
withHelp : Html msg -> RadioGroup value msg -> RadioGroup value msg
withHelp help (RadioGroup cfg) =
    RadioGroup { cfg | help = Just help }


{-| Set an error message. Replaces help text when both are present.
-}
withError : Html msg -> RadioGroup value msg -> RadioGroup value msg
withError error (RadioGroup cfg) =
    RadioGroup { cfg | error = Just error }


{-| Mark the group as required for form submission.
-}
withRequired : Bool -> RadioGroup value msg -> RadioGroup value msg
withRequired required (RadioGroup cfg) =
    RadioGroup { cfg | required = required }


{-| Disable every radio in the group.
-}
withDisabled : Bool -> RadioGroup value msg -> RadioGroup value msg
withDisabled disabled (RadioGroup cfg) =
    RadioGroup { cfg | disabled = disabled }



-- RENDER -----------------------------------------------------------------


{-| Render the radio group (wrapped in its form-field chrome) to `Html`.
-}
view : RadioGroup value msg -> Html msg
view (RadioGroup cfg) =
    M3e.FormField.component
        []
        (List.concat
            [ [ groupElement cfg
              , labelElement cfg
              ]
            , subscriptElements cfg
            ]
        )


groupElement : Config value msg -> Html msg
groupElement cfg =
    M3e.RadioGroup.component
        (List.filterMap identity
            [ Maybe.map Attr.id cfg.id
            , Just (M3e.RadioGroup.disabled cfg.disabled)
            , Just (M3e.RadioGroup.required cfg.required)
            ]
        )
        (List.map (renderOption cfg) cfg.options)


renderOption : Config value msg -> Option value -> Html msg
renderOption cfg (Option opt) =
    M3e.Radio.component
        [ M3e.Radio.checked (cfg.selected == Just opt.value)
        , M3e.Radio.disabled cfg.disabled
        , HtmlEvents.onClick (cfg.onChange opt.value)
        ]
        [ Html.text opt.label ]


labelElement : Config value msg -> Html msg
labelElement cfg =
    Html.label
        (List.filterMap identity
            -- FormField has no label slot; the label is a default-slot child.
            [ Maybe.map Attr.for cfg.id
            ]
        )
        [ Html.text cfg.label ]


subscriptElements : Config value msg -> List (Html msg)
subscriptElements cfg =
    case ( cfg.error, cfg.help ) of
        ( Just err, _ ) ->
            [ Html.span [ M3e.FormField.errorSlot ] [ err ] ]

        ( Nothing, Just help ) ->
            [ Html.span [ M3e.FormField.hintSlot ] [ help ] ]

        ( Nothing, Nothing ) ->
            []
