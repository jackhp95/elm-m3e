module Ui.Stepper exposing
    ( Stepper, new
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

import Html exposing (Html)
import Html.Attributes as Attr
import Json.Decode as Decode
import M3e.Step
import M3e.StepPanel
import M3e.Stepper


type Stepper msg
    = Stepper (Config msg)


type Step msg
    = Step (StepConfig msg)


type SelectionState msg
    = NoSelection
    | DefaultSelection String
    | ExplicitSelection (String -> msg) String


type alias Config msg =
    { id : Maybe String
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


new : Stepper msg
new =
    Stepper
        { id = Nothing
        , steps = []
        , vertical = False
        , linear = False
        , selection = NoSelection
        }


withId : String -> Stepper msg -> Stepper msg
withId id (Stepper cfg) =
    Stepper { cfg | id = Just id }


step : String -> Html msg -> List (Html msg) -> Step msg
step id label content =
    Step
        { id = id
        , label = label
        , content = content
        , completed = False
        , optional = False
        }


withCompleted : Bool -> Step msg -> Step msg
withCompleted flag (Step cfg) =
    Step { cfg | completed = flag }


withOptional : Bool -> Step msg -> Step msg
withOptional flag (Step cfg) =
    Step { cfg | optional = flag }


withStep : Step msg -> Stepper msg -> Stepper msg
withStep s (Stepper cfg) =
    Stepper { cfg | steps = cfg.steps ++ [ s ] }


withSteps : List (Step msg) -> Stepper msg -> Stepper msg
withSteps ss (Stepper cfg) =
    Stepper { cfg | steps = cfg.steps ++ ss }


withVertical : Bool -> Stepper msg -> Stepper msg
withVertical flag (Stepper cfg) =
    Stepper { cfg | vertical = flag }


withLinear : Bool -> Stepper msg -> Stepper msg
withLinear flag (Stepper cfg) =
    Stepper { cfg | linear = flag }


withDefaultSelected : String -> Stepper msg -> Stepper msg
withDefaultSelected stepId (Stepper cfg) =
    Stepper { cfg | selection = DefaultSelection stepId }


withExplicitSelectedState : (String -> msg) -> String -> Stepper msg -> Stepper msg
withExplicitSelectedState onSelect stepId (Stepper cfg) =
    Stepper { cfg | selection = ExplicitSelection onSelect stepId }


view : Stepper msg -> Html msg
view (Stepper cfg) =
    M3e.Stepper.component
        (List.filterMap identity
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
        prefix =
            Maybe.withDefault "stepper" cfg.id

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
                [ Just (Attr.attribute "selected" "true") ]

            else
                []

        ExplicitSelection onSelect selectedId ->
            [ Just (M3e.Step.selected (selectedId == stepId))
            , Just (M3e.Step.onClick (Decode.succeed (onSelect stepId)))
            ]


viewStepPanel : Step msg -> Html msg
viewStepPanel (Step s) =
    M3e.StepPanel.component [ M3e.Stepper.panelSlot ] s.content
