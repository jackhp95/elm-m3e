module Ui.Select exposing
    ( Select, Option, Single, Multi
    , single, multi, option
    , withId, withRequired, withDisabled, withHelp, withError
    , view
    )

{-| Typed builder for `<m3e-select>` — a dropdown for choosing one (or
several) values from a list. m3 doesn't ship a standalone "select" doc
page; this module covers the _form-control select_ shape that m3e
exposes as `<m3e-select>` + `<m3e-option>`. For action menus (open from
a button trigger), use `Ui.Menu` (Phase 3).


# Two kinds, gated by the type system

  - **Single** (`single`) — exclusive choice; `Maybe value` selection.
  - **Multi** (`multi`) — multi-select; `List value` selection.

When to choose Select over siblings (Material guidance):

  - **`Ui.Select`** — single- or multi-choice from a _long_ list
    (≈ 10+ options) where a dropdown is more space-efficient.
  - **`Ui.RadioButton`** — exclusive choice from a small set (≤ 7).
  - **`Ui.SegmentedButton`** — button-row style, small set (2–5).
  - **`Ui.Checkbox`** (in a list) — multi-select from a small set.


# Required-by-design

  - `label` — visible field label.
  - `options` — at least one `Option`.
  - `selected` — `Maybe value` / `List value` matching the kind.
  - `onChange` — handler receiving the new selection.

Each `option` requires:

  - `value` — your typed model value.
  - `label` — visible option text.


# Generic over `value`

Same pattern as `Ui.RadioButton`: selection state stays typed end-to-end.
`value` must support equality.


# Quick example

    type Plan = Free | Pro | Enterprise

    Ui.Select.single
        { label = "Plan"
        , options =
            [ Ui.Select.option { value = Free,       label = "Free" }
            , Ui.Select.option { value = Pro,        label = "Pro" }
            , Ui.Select.option { value = Enterprise, label = "Enterprise" }
            ]
        , selected = Just Pro
        , onChange = PlanChanged
        }
        |> Ui.Select.view


# Type

@docs Select, Option, Single, Multi


# Constructors

@docs single, multi, option


# Modifiers

@docs withId, withRequired, withDisabled, withHelp, withError


# Render

@docs view

-}

import Html exposing (Html)
import Html.Attributes as Attr
import Html.Events as HtmlEvents
import M3e.FormField
import M3e.Option
import M3e.Select



-- TYPES ------------------------------------------------------------------


{-| A select, parameterized by selection kind + the value type +
the message type.
-}
type Select kind value msg
    = Select (Config value msg)


{-| Phantom tag for single-select.
-}
type Single
    = SinglePhantomTag Never


{-| Phantom tag for multi-select.
-}
type Multi
    = MultiPhantomTag Never


{-| One option within a `Select`.
-}
type Option value
    = Option { value : value, label : String }


type alias Config value msg =
    { id : Maybe String
    , label : String
    , options : List (Option value)
    , isSelected : value -> Bool
    , onOptionClick : value -> msg
    , multiAttr : Bool
    , required : Bool
    , disabled : Bool
    , help : Maybe (Html msg)
    , error : Maybe (Html msg)
    }



-- CONSTRUCTORS -----------------------------------------------------------


{-| Construct a single-select.
-}
single :
    { label : String
    , options : List (Option value)
    , selected : Maybe value
    , onChange : value -> msg
    }
    -> Select Single value msg
single c =
    Select
        { id = Nothing
        , label = c.label
        , options = c.options
        , isSelected = \v -> c.selected == Just v
        , onOptionClick = c.onChange
        , multiAttr = False
        , required = False
        , disabled = False
        , help = Nothing
        , error = Nothing
        }


{-| Construct a multi-select.
-}
multi :
    { label : String
    , options : List (Option value)
    , selected : List value
    , onChange : List value -> msg
    }
    -> Select Multi value msg
multi c =
    Select
        { id = Nothing
        , label = c.label
        , options = c.options
        , isSelected = \v -> List.member v c.selected
        , onOptionClick = \v -> c.onChange (toggleInList v c.selected)
        , multiAttr = True
        , required = False
        , disabled = False
        , help = Nothing
        , error = Nothing
        }


{-| Construct an option.
-}
option : { value : value, label : String } -> Option value
option =
    Option



-- MODIFIERS --------------------------------------------------------------


{-| Set the `id` attribute.
-}
withId : String -> Select kind value msg -> Select kind value msg
withId id (Select cfg) =
    Select { cfg | id = Just id }


{-| Mark the field as required.
-}
withRequired : Bool -> Select kind value msg -> Select kind value msg
withRequired b (Select cfg) =
    Select { cfg | required = b }


{-| Disable the select.
-}
withDisabled : Bool -> Select kind value msg -> Select kind value msg
withDisabled b (Select cfg) =
    Select { cfg | disabled = b }


{-| Set help text.
-}
withHelp : Html msg -> Select kind value msg -> Select kind value msg
withHelp h (Select cfg) =
    Select { cfg | help = Just h }


{-| Set an error message (replaces help text).
-}
withError : Html msg -> Select kind value msg -> Select kind value msg
withError e (Select cfg) =
    Select { cfg | error = Just e }



-- RENDER -----------------------------------------------------------------


{-| Render the select to `Html`.
-}
view : Select kind value msg -> Html msg
view (Select cfg) =
    M3e.FormField.component
        []
        (List.concat
            [ [ selectElement cfg
              , labelElement cfg
              ]
            , subscriptElements cfg
            ]
        )


selectElement : Config value msg -> Html msg
selectElement cfg =
    M3e.Select.component
        (List.filterMap identity
            [ Maybe.map Attr.id cfg.id
            , Just (M3e.Select.multi cfg.multiAttr)
            , Just (M3e.Select.required cfg.required)
            , Just (M3e.Select.disabled cfg.disabled)
            ]
        )
        (List.indexedMap (optionView cfg) cfg.options)


optionView : Config value msg -> Int -> Option value -> Html msg
optionView cfg index (Option opt) =
    M3e.Option.component
        [ M3e.Option.value (String.fromInt index)
        , M3e.Option.selected (cfg.isSelected opt.value)
        , M3e.Option.disabled cfg.disabled
        , HtmlEvents.onClick (cfg.onOptionClick opt.value)
        ]
        [ Html.text opt.label ]


toggleInList : value -> List value -> List value
toggleInList v list =
    if List.member v list then
        List.filter ((/=) v) list

    else
        v :: list


labelElement : Config value msg -> Html msg
labelElement cfg =
    Html.label
        (List.filterMap identity
            [ Just M3e.FormField.labelSlot
            , Maybe.map Attr.for cfg.id
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
