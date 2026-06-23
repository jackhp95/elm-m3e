module Ui.SegmentedButton exposing
    ( SegmentedButton, Segment, Single, Multi
    , single, multi, segment
    , withId, withHelp, withError, withDisabled
    , view
    )

{-| Typed builder for `<m3e-segmented-button>` — a small row of
buttons for choosing one (or several) options. Mirrors the Material 3
[Segmented buttons][m3] surface.

[m3]: https://m3.material.io/components/segmented-buttons/overview

**Deprecation note (Material 3 Expressive):** Material is migrating
segmented buttons into the [connected button group][bg]. Prefer
`Ui.ButtonGroup` for new code when it lands; this module continues to
exist for callers that need the existing element.

[bg]: https://m3.material.io/components/button-groups


# Two kinds, gated by the type system

  - **Single** (`single`) — exclusive choice; selection is
    `Maybe value`.
  - **Multi** (`multi`) — independent toggles; selection is a
    `List value`.

Use for _small_ sets (2–5 segments). For longer lists, prefer
`Ui.Select`; for richer selection patterns, prefer `Ui.RadioButton`
or chips.


# Required-by-design

`single` and `multi` both require:

  - `label` — visible field label.
  - `segments` — the option list (at least 2 in practice; 1 is
    degenerate-but-valid).
  - `selected` — `Maybe value` for `single`; `List value` for `multi`.
  - `onChange` — handler receiving the new selection.

Each `segment` requires:

  - `value` — your typed model value.
  - `label` — visible segment text.


# Quick examples

Single-select:

    Ui.SegmentedButton.single
        { label = "View"
        , segments =
            [ Ui.SegmentedButton.segment { value = Day, label = "Day" }
            , Ui.SegmentedButton.segment { value = Week, label = "Week" }
            , Ui.SegmentedButton.segment { value = Month, label = "Month" }
            ]
        , selected = Just Week
        , onChange = ViewChanged
        }
        |> Ui.SegmentedButton.view

Multi-select:

    Ui.SegmentedButton.multi
        { label = "Day filters"
        , segments =
            [ Ui.SegmentedButton.segment { value = Weekdays, label = "Wk" }
            , Ui.SegmentedButton.segment { value = Weekends, label = "We" }
            ]
        , selected = state.dayFilters
        , onChange = DayFiltersChanged
        }
        |> Ui.SegmentedButton.view


# Type

@docs SegmentedButton, Segment, Single, Multi


# Constructors

@docs single, multi, segment


# Modifiers

@docs withId, withHelp, withError, withDisabled


# Render

@docs view

-}

import Html exposing (Html)
import Html.Attributes as Attr
import Html.Events as HtmlEvents
import M3e.ButtonSegment
import M3e.FormField
import M3e.SegmentedButton



-- TYPES ------------------------------------------------------------------


{-| A segmented-button group, parameterized by selection kind tag and
the message type.
-}
type SegmentedButton kind value msg
    = SegmentedButton (Config value msg)


{-| Phantom tag for single-select segmented buttons. Has no values.
-}
type Single
    = SinglePhantomTag Never


{-| Phantom tag for multi-select segmented buttons. Has no values.
-}
type Multi
    = MultiPhantomTag Never


{-| One option within a segmented-button group.
-}
type Segment value
    = Segment { value : value, label : String }


type alias Config value msg =
    { id : Maybe String
    , label : String
    , segments : List (Segment value)
    , isSelected : value -> Bool
    , onSegmentClick : value -> msg
    , multiAttr : Bool
    , help : Maybe (Html msg)
    , error : Maybe (Html msg)
    , disabled : Bool
    }



-- CONSTRUCTORS -----------------------------------------------------------


{-| Construct a single-select segmented button.
-}
single :
    { label : String
    , segments : List (Segment value)
    , selected : Maybe value
    , onChange : value -> msg
    }
    -> SegmentedButton Single value msg
single c =
    SegmentedButton
        { id = Nothing
        , label = c.label
        , segments = c.segments
        , isSelected = \v -> c.selected == Just v
        , onSegmentClick = c.onChange
        , multiAttr = False
        , help = Nothing
        , error = Nothing
        , disabled = False
        }


{-| Construct a multi-select segmented button.
-}
multi :
    { label : String
    , segments : List (Segment value)
    , selected : List value
    , onChange : List value -> msg
    }
    -> SegmentedButton Multi value msg
multi c =
    SegmentedButton
        { id = Nothing
        , label = c.label
        , segments = c.segments
        , isSelected = \v -> List.member v c.selected
        , onSegmentClick = \v -> c.onChange (toggleInList v c.selected)
        , multiAttr = True
        , help = Nothing
        , error = Nothing
        , disabled = False
        }


{-| Construct a segment.
-}
segment : { value : value, label : String } -> Segment value
segment =
    Segment



-- MODIFIERS --------------------------------------------------------------


{-| Set the `id` attribute on the underlying `<m3e-segmented-button>`.
-}
withId : String -> SegmentedButton kind value msg -> SegmentedButton kind value msg
withId id (SegmentedButton cfg) =
    SegmentedButton { cfg | id = Just id }


{-| Set help text rendered beneath the field.
-}
withHelp : Html msg -> SegmentedButton kind value msg -> SegmentedButton kind value msg
withHelp help (SegmentedButton cfg) =
    SegmentedButton { cfg | help = Just help }


{-| Set an error message. Replaces help text when both are present.
-}
withError : Html msg -> SegmentedButton kind value msg -> SegmentedButton kind value msg
withError error (SegmentedButton cfg) =
    SegmentedButton { cfg | error = Just error }


{-| Disable every segment in the group.
-}
withDisabled : Bool -> SegmentedButton kind value msg -> SegmentedButton kind value msg
withDisabled disabled (SegmentedButton cfg) =
    SegmentedButton { cfg | disabled = disabled }



-- RENDER -----------------------------------------------------------------


{-| Render the segmented button group to `Html`.
-}
view : SegmentedButton kind value msg -> Html msg
view (SegmentedButton cfg) =
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
    M3e.SegmentedButton.component
        (List.filterMap identity
            [ Maybe.map Attr.id cfg.id
            , Just (M3e.SegmentedButton.disabled cfg.disabled)
            , Just (M3e.SegmentedButton.multi cfg.multiAttr)
            ]
        )
        (List.map (segmentView cfg) cfg.segments)


segmentView : Config value msg -> Segment value -> Html msg
segmentView cfg (Segment seg) =
    M3e.ButtonSegment.component
        [ M3e.ButtonSegment.checked (cfg.isSelected seg.value)
        , M3e.ButtonSegment.disabled cfg.disabled
        , HtmlEvents.onClick (cfg.onSegmentClick seg.value)
        ]
        [ Html.text seg.label ]


toggleInList : value -> List value -> List value
toggleInList value list =
    if List.member value list then
        List.filter ((/=) value) list

    else
        value :: list


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
