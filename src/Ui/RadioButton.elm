module Ui.RadioButton exposing
    ( RadioGroup, Option
    , group, option
    , withAttributes
    , withId, withRequired, withDisabled
    , view
    )

{-| Typed builder for `<m3e-radio-group>` containing `<m3e-radio>`
elements — a control for selecting exactly one option from a small set.
Mirrors the Material 3 [Radio button][m3] surface.

[m3]: https://m3.material.io/components/radio-button/overview

A lone radio button isn't a real interaction — radio buttons always
appear as a group. This module's API reflects that: callers always
build a `RadioGroup`, not a single button.

When to choose Radio vs siblings (the one-of-many fork):

  - **`Ui.RadioButton`** — exclusive single-choice when every option
    should stay _visible_ at once and there are only a few (2–5).
  - **`Ui.Select`** — single-choice when the list is _long_ or should
    stay _collapsed_ until opened (a closed dropdown menu).
  - **`Ui.SegmentedButton`** — an inline, horizontal one-of-many that
    reads as a control (2–5 options).
  - **`Ui.Checkbox`** (in a list) — when _multiple_ options can be
    selected, or when a single boolean toggles.


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

A radio group renders **bare** (just the `<m3e-radio-group>` and its radios,
with the group `label` kept as an `aria-label` on the group). For a visible
group label and supporting/error text, compose it with [`Ui.Field`](Ui-Field):

    Ui.Field.new "Billing cycle"
        |> Ui.Field.withHint (text "You can change this anytime.")
        |> Ui.Field.view
            (Ui.RadioButton.group
                { label = "Billing cycle"
                , options =
                    [ Ui.RadioButton.option { value = Monthly, label = "Monthly" }
                    , Ui.RadioButton.option { value = Yearly, label = "Yearly" }
                    ]
                , selected = selected
                , onChange = PricingChanged
                }
                |> Ui.RadioButton.view
            )


# Type

@docs RadioGroup, Option


# Constructors

@docs group, option


# Host attributes

@docs withAttributes


# Modifiers

@docs withId, withRequired, withDisabled


# Render

@docs view

-}

import Html exposing (Attribute, Html)
import Html.Attributes as Attr
import Html.Events as HtmlEvents
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
    , attributes : List (Attribute msg)
    , label : String
    , options : List (Option value)
    , selected : Maybe value
    , onChange : value -> msg
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
        , attributes = []
        , label = c.label
        , options = c.options
        , selected = c.selected
        , onChange = c.onChange
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


{-| Append attributes to the rendered `<m3e-radio-group>`. The builder's
structural attributes are emitted after these, so callers can't clobber them.
-}
withAttributes : List (Attribute msg) -> RadioGroup value msg -> RadioGroup value msg
withAttributes attributes (RadioGroup cfg) =
    RadioGroup { cfg | attributes = cfg.attributes ++ attributes }


{-| Set the `id` attribute on the underlying `<m3e-radio-group>`. Also
seeds the shared `name` threaded onto every child radio; without it both
are derived as a stable slug of the group `label`.
-}
withId : String -> RadioGroup value msg -> RadioGroup value msg
withId id (RadioGroup cfg) =
    RadioGroup { cfg | id = Just id }


{-| Set the `required` attribute on the `<m3e-radio-group>` (default
`False`) — the group must have a selection for form submission.
-}
withRequired : Bool -> RadioGroup value msg -> RadioGroup value msg
withRequired required (RadioGroup cfg) =
    RadioGroup { cfg | required = required }


{-| Set the `disabled` attribute on the group and every child radio
(default `False`) — non-interactive.
-}
withDisabled : Bool -> RadioGroup value msg -> RadioGroup value msg
withDisabled disabled (RadioGroup cfg) =
    RadioGroup { cfg | disabled = disabled }



-- RENDER -----------------------------------------------------------------


{-| Render the radio group to `Html` — a bare `<m3e-radio-group>` with its group
`label` as an `aria-label`. Wrap it in [`Ui.Field`](Ui-Field) for a visible
group label / subscript.
-}
view : RadioGroup value msg -> Html msg
view (RadioGroup cfg) =
    groupElement cfg.attributes cfg


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


groupElement : List (Attribute msg) -> Config value msg -> Html msg
groupElement extraAttrs cfg =
    M3e.RadioGroup.component
        (extraAttrs
            ++ [ Attr.id (controlId cfg)
               , M3e.RadioGroup.name (groupName cfg)
               , M3e.RadioGroup.disabled cfg.disabled
               , M3e.RadioGroup.required cfg.required
               , Attr.attribute "aria-label" cfg.label
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
