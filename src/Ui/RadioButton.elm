module Ui.RadioButton exposing
    ( RadioGroup, Option
    , group, option
    , withId, withHelp, withError, withRequired, withDisabled, withVisibleLabel
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

@docs withId, withHelp, withError, withRequired, withDisabled, withVisibleLabel


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
    , visibleLabel : Bool
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
        , visibleLabel = True
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


{-| Whether to render the visible group label and the surrounding
`m3e-form-field` chrome (default `True`).

Set `False` for a **bare** group — just the radios, with the group label kept
as an `aria-label` on `m3e-radio-group`. Use this when the group sits in a row
that already provides its own visible label, so the label isn't shown twice
and the radios aren't boxed in a text-field outline.

-}
withVisibleLabel : Bool -> RadioGroup value msg -> RadioGroup value msg
withVisibleLabel visible (RadioGroup cfg) =
    RadioGroup { cfg | visibleLabel = visible }



-- RENDER -----------------------------------------------------------------


{-| Render the radio group (wrapped in its form-field chrome) to `Html`.
-}
view : RadioGroup value msg -> Html msg
view (RadioGroup cfg) =
    if cfg.visibleLabel then
        M3e.FormField.component
            []
            (List.concat
                [ [ groupElement cfg
                  , labelElement cfg
                  ]
                , subscriptElements cfg
                ]
            )

    else
        groupElement cfg


{-| The group's `id`: the caller's `withId` if present, else a stable
slug derived from the label.
-}
controlId : Config value msg -> String
controlId cfg =
    case cfg.id of
        Just id ->
            id

        Nothing ->
            slugify cfg.label


{-| The shared `name` threaded onto the group and every child radio.
Native grouping, keyboard arrow-navigation, and form submission all
depend on every radio sharing a single `name`. Derived from the same
stable id so it's deterministic and override-friendly.
-}
groupName : Config value msg -> String
groupName cfg =
    controlId cfg


groupElement : Config value msg -> Html msg
groupElement cfg =
    M3e.RadioGroup.component
        (List.filterMap identity
            [ Just (Attr.id (controlId cfg))
            , Just (M3e.RadioGroup.name (groupName cfg))
            , Just (M3e.RadioGroup.disabled cfg.disabled)
            , Just (M3e.RadioGroup.required cfg.required)
            , if cfg.visibleLabel then
                Nothing

              else
                Just (Attr.attribute "aria-label" cfg.label)
            ]
        )
        (List.map (renderOption cfg) cfg.options)


renderOption : Config value msg -> Option value -> Html msg
renderOption cfg (Option opt) =
    M3e.Radio.component
        [ M3e.Radio.name (groupName cfg)
        , M3e.Radio.checked (cfg.selected == Just opt.value)
        , M3e.Radio.disabled cfg.disabled
        , HtmlEvents.onClick (cfg.onChange opt.value)
        ]
        [ Html.text opt.label ]


labelElement : Config value msg -> Html msg
labelElement cfg =
    Html.label
        [ Attr.attribute "slot" "label"
        , Attr.for (controlId cfg)
        ]
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


{-| Derive a stable, deterministic id/name from the label text so the
`<label slot="label" for="...">` can anchor the group and so the group
and its radios share a `name` even without an explicit `withId`.
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
