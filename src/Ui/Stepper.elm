module Ui.Stepper exposing
    ( Stepper, new
    , withAttributes
    , withId
    , Step, step, withStep, withSteps, withCompleted, withOptional
    , withStepIcon, withStepHint, withStepError, withStepActions
    , withVertical, withLinear
    , withDefaultSelected, withExplicitSelectedState
    , view
    )

{-| Typed builder for M3 steppers — a wizard-like workflow that divides
content into discrete, ordered steps. Each `Step` carries its own label,
panel content, and completion state; the renderer threads parallel
`Step`/`StepPanel` elements with proper selection.

Reach for a stepper to walk an ordered, multi-step flow. To switch between
peer views use tabs; to page through data use a paginator; for directional
content paging use a slide group (`Ui.Slide`).


# State philosophy

Two ways to drive selection:

  - **Uncontrolled** (DOM owns ongoing state): `withDefaultSelected`
  - **Controlled** (caller owns state): `withExplicitSelectedState
    onSelect currentStepId`


# Construction

@docs Stepper, new


# Host attributes

@docs withAttributes


# Identity

@docs withId


# Steps

@docs Step, step, withStep, withSteps, withCompleted, withOptional


# Step decoration & actions

Each step can carry a custom marker icon plus hint/error text (slotted onto the
`<m3e-step>` indicator), and its panel can carry an actions bar (slotted into
the `<m3e-step-panel>` `actions` region — the home for prev/next/reset
navigation).

@docs withStepIcon, withStepHint, withStepError, withStepActions


# Layout

@docs withVertical, withLinear


# Selection (hybrid)

@docs withDefaultSelected, withExplicitSelectedState


# Render

@docs view

-}

import Html exposing (Attribute, Html)
import Html.Attributes as Attr
import Json.Decode as Decode
import M3e.Step
import M3e.StepPanel
import M3e.Stepper
import Ui.Icon


{-| The stepper opaque type. Build via `new`.
-}
type Stepper msg
    = Stepper (Config msg)


{-| A single step. Build via `step`.
-}
type Step msg
    = Step (StepConfig msg)


type SelectionState msg
    = NoSelection
    | DefaultSelection String
    | ExplicitSelection (String -> msg) String


type alias Config msg =
    { id : Maybe String
    , attributes : List (Attribute msg)
    , steps : List (Step msg)
    , vertical : Bool
    , linear : Bool
    , selection : SelectionState msg
    }


type alias StepConfig msg =
    { id : String
    , label : Html msg
    , content : List (Html msg)
    , completed : Bool
    , optional : Bool
    , icon : Maybe (Ui.Icon.Icon msg)
    , hint : Maybe (Html msg)
    , error : Maybe (Html msg)
    , actions : List (Html msg)
    }


{-| Construct a fresh stepper with no steps and no selection.
-}
new : Stepper msg
new =
    Stepper
        { id = Nothing
        , attributes = []
        , steps = []
        , vertical = False
        , linear = False
        , selection = NoSelection
        }


{-| Append attributes to the underlying `<m3e-stepper>` host element — the
escape hatch for styling the component itself. Structural attributes are emitted
after these, so callers can't clobber them.
-}
withAttributes : List (Attribute msg) -> Stepper msg -> Stepper msg
withAttributes attributes (Stepper cfg) =
    Stepper { cfg | attributes = cfg.attributes ++ attributes }


{-| Set the host `id`. Also seeds the generated per-step and per-panel DOM
ids (`<id>-step-<stepId>` / `<id>-panel-<stepId>`) that wire each
`<m3e-step>` to its `<m3e-step-panel>` via `for`. Defaults to `"stepper"`
when unset.
-}
withId : String -> Stepper msg -> Stepper msg
withId id (Stepper cfg) =
    Stepper { cfg | id = Just id }


{-| Construct a step from an id, label, and panel content. The label fills
the `<m3e-step>` default slot; the content becomes the body of the matching
`<m3e-step-panel>`.
-}
step : String -> Html msg -> List (Html msg) -> Step msg
step id label content =
    Step
        { id = id
        , label = label
        , content = content
        , completed = False
        , optional = False
        , icon = Nothing
        , hint = Nothing
        , error = Nothing
        , actions = []
        }


{-| Mark a step completed (`completed` on `<m3e-step>`, default false). A
completed step swaps its numbered indicator for the `done-icon`.
-}
withCompleted : Bool -> Step msg -> Step msg
withCompleted flag (Step cfg) =
    Step { cfg | completed = flag }


{-| Mark a step optional (`optional` on `<m3e-step>`, default false).
-}
withOptional : Bool -> Step msg -> Step msg
withOptional flag (Step cfg) =
    Step { cfg | optional = flag }


{-| Set a custom marker icon for the step, slotted into the `<m3e-step>` `icon`
slot (replacing the default numbered indicator).
-}
withStepIcon : Ui.Icon.Icon msg -> Step msg -> Step msg
withStepIcon icon (Step cfg) =
    Step { cfg | icon = Just icon }


{-| Attach hint text shown beneath the step label, slotted into the
`<m3e-step>` `hint` slot.
-}
withStepHint : Html msg -> Step msg -> Step msg
withStepHint hint (Step cfg) =
    Step { cfg | hint = Just hint }


{-| Attach an error message for an invalid step, slotted into the `<m3e-step>`
`error` slot. The element shows it in place of the hint when the step is
invalid.
-}
withStepError : Html msg -> Step msg -> Step msg
withStepError error (Step cfg) =
    Step { cfg | error = Just error }


{-| Set the step panel's actions bar — the prev/next/reset navigation region,
slotted into the `<m3e-step-panel>` `actions` slot. Compose `Ui.Button`s
wrapping `<m3e-stepper-previous>` / `<m3e-stepper-next>` / `<m3e-stepper-reset>`
(see `M3e.StepperPrevious` / `M3e.StepperReset`) for stepper-driven navigation.
-}
withStepActions : List (Html msg) -> Step msg -> Step msg
withStepActions actions (Step cfg) =
    Step { cfg | actions = actions }


{-| Append a single step.
-}
withStep : Step msg -> Stepper msg -> Stepper msg
withStep s (Stepper cfg) =
    Stepper { cfg | steps = cfg.steps ++ [ s ] }


{-| Append a list of steps.
-}
withSteps : List (Step msg) -> Stepper msg -> Stepper msg
withSteps ss (Stepper cfg) =
    Stepper { cfg | steps = cfg.steps ++ ss }


{-| Set vertical orientation (emits `orientation="vertical"` on
`<m3e-stepper>`; the element default is horizontal).
-}
withVertical : Bool -> Stepper msg -> Stepper msg
withVertical flag (Stepper cfg) =
    Stepper { cfg | vertical = flag }


{-| Require linear progression (`linear` on `<m3e-stepper>`, default false):
the validity of previous steps is checked before the user can advance.
-}
withLinear : Bool -> Stepper msg -> Stepper msg
withLinear flag (Stepper cfg) =
    Stepper { cfg | linear = flag }


{-| Uncontrolled: set the initially selected step id; the DOM owns state
thereafter.
-}
withDefaultSelected : String -> Stepper msg -> Stepper msg
withDefaultSelected stepId (Stepper cfg) =
    Stepper { cfg | selection = DefaultSelection stepId }


{-| Controlled: the caller owns the selected step id and handles selection
changes.
-}
withExplicitSelectedState : (String -> msg) -> String -> Stepper msg -> Stepper msg
withExplicitSelectedState onSelect stepId (Stepper cfg) =
    Stepper { cfg | selection = ExplicitSelection onSelect stepId }


{-| Render the stepper.
-}
view : Stepper msg -> Html msg
view (Stepper cfg) =
    M3e.Stepper.component
        (cfg.attributes
            ++ List.filterMap identity
                [ Maybe.map Attr.id cfg.id
                , if cfg.vertical then
                    Just (M3e.Stepper.orientation M3e.Stepper.Vertical)

                  else
                    Nothing
                , if cfg.linear then
                    Just (M3e.Stepper.linear True)

                  else
                    Nothing
                ]
        )
        (List.map (viewStepHeader cfg) cfg.steps
            ++ List.map (viewStepPanel cfg) cfg.steps
        )


stepDomId : Config msg -> Step msg -> String
stepDomId cfg (Step s) =
    Maybe.withDefault "stepper" cfg.id ++ "-step-" ++ s.id


panelDomId : Config msg -> Step msg -> String
panelDomId cfg (Step s) =
    Maybe.withDefault "stepper" cfg.id ++ "-panel-" ++ s.id


viewStepHeader : Config msg -> Step msg -> Html msg
viewStepHeader cfg ((Step s) as fullStep) =
    M3e.Step.component
        (List.filterMap identity
            ([ Just M3e.Stepper.stepSlot
             , Just (Attr.id (stepDomId cfg fullStep))
             , Just (M3e.Step.for (panelDomId cfg fullStep))
             , Just (M3e.Step.completed s.completed)
             , Just (M3e.Step.optional s.optional)
             , if s.error == Nothing then
                Nothing

               else
                Just (M3e.Step.invalid True)
             ]
                ++ selectionAttrs cfg.selection s.id
            )
        )
        (List.concat
            [ stepIconPart s.icon
            , [ s.label ]
            , slotPart M3e.Step.hintSlot s.hint
            , slotPart M3e.Step.errorSlot s.error
            ]
        )


stepIconPart : Maybe (Ui.Icon.Icon msg) -> List (Html msg)
stepIconPart icon =
    case icon of
        Nothing ->
            []

        Just i ->
            [ Html.span [ M3e.Step.iconSlot ] [ Ui.Icon.view i ] ]


slotPart : Html.Attribute msg -> Maybe (Html msg) -> List (Html msg)
slotPart slot content =
    case content of
        Nothing ->
            []

        Just c ->
            [ Html.span [ slot ] [ c ] ]


selectionAttrs : SelectionState msg -> String -> List (Maybe (Html.Attribute msg))
selectionAttrs state stepId =
    case state of
        NoSelection ->
            []

        DefaultSelection selectedId ->
            if selectedId == stepId then
                [ Just (M3e.Step.selected True) ]

            else
                []

        ExplicitSelection onSelect selectedId ->
            [ Just (M3e.Step.selected (selectedId == stepId))
            , Just (M3e.Step.onClick (Decode.succeed (onSelect stepId)))
            ]


viewStepPanel : Config msg -> Step msg -> Html msg
viewStepPanel cfg ((Step s) as fullStep) =
    M3e.StepPanel.component
        [ M3e.Stepper.panelSlot
        , Attr.id (panelDomId cfg fullStep)
        ]
        (s.content ++ panelActionsPart s.actions)


{-| The `<m3e-step-panel>` actions slot is `slot="actions"`. The generated
`M3e.StepPanel.actionsSlot` binding emits `slot="actions-"` (a stray trailing
dash from the CEM), which would mis-slot, so the correct value is written
directly here.
-}
panelActionsPart : List (Html msg) -> List (Html msg)
panelActionsPart actions =
    case actions of
        [] ->
            []

        _ ->
            [ Html.div [ Attr.attribute "slot" "actions" ] actions ]
