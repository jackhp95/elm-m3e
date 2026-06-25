module Ui.Stepper exposing
    ( Stepper, new
    , withAttributes
    , withId
    , Step, step, withStep, withSteps, withCompleted, withOptional
    , withVertical, withLinear
    , withDefaultSelected, withExplicitSelectedState
    , view
    )

{-| Typed builder for M3 steppers. Each `Step` carries its own label,
panel content, and completion state; the renderer threads parallel
`Step`/`StepPanel` elements with proper selection.


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


{-| Set the `id` attribute.
-}
withId : String -> Stepper msg -> Stepper msg
withId id (Stepper cfg) =
    Stepper { cfg | id = Just id }


{-| Construct a step from an id, label, and panel content.
-}
step : String -> Html msg -> List (Html msg) -> Step msg
step id label content =
    Step
        { id = id
        , label = label
        , content = content
        , completed = False
        , optional = False
        }


{-| Mark a step as completed.
-}
withCompleted : Bool -> Step msg -> Step msg
withCompleted flag (Step cfg) =
    Step { cfg | completed = flag }


{-| Mark a step as optional.
-}
withOptional : Bool -> Step msg -> Step msg
withOptional flag (Step cfg) =
    Step { cfg | optional = flag }


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


{-| Set the vertical orientation.
-}
withVertical : Bool -> Stepper msg -> Stepper msg
withVertical flag (Stepper cfg) =
    Stepper { cfg | vertical = flag }


{-| Require steps to be completed in order.
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
            ++ List.map viewStepPanel cfg.steps
        )


viewStepHeader : Config msg -> Step msg -> Html msg
viewStepHeader cfg (Step s) =
    let
        prefix : String
        prefix =
            Maybe.withDefault "stepper" cfg.id

        stepId : String
        stepId =
            prefix ++ "-step-" ++ s.id
    in
    M3e.Step.component
        (List.filterMap identity
            ([ Just M3e.Stepper.stepSlot
             , Just (Attr.id stepId)
             , Just (M3e.Step.completed s.completed)
             , Just (M3e.Step.optional s.optional)
             ]
                ++ selectionAttrs cfg.selection s.id
            )
        )
        [ s.label ]


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


viewStepPanel : Step msg -> Html msg
viewStepPanel (Step s) =
    M3e.StepPanel.component [ M3e.Stepper.panelSlot ] s.content
