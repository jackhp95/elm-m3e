module M3e.Stepper exposing
    ( view, step, stepPanel
    , Option, StepOption, PanelOption, HeaderPosition(..)
    , stepId, stepFor, stepSelected, stepCompleted, stepOptional, stepDisabled, stepEditable, stepInvalid
    , panelId, panelActions
    , vertical, linear, stepperHeaderPosition
    )

{-| `<m3e-stepper>` + `<m3e-step>` + `<m3e-step-panel>` — a wizard-like
workflow dividing content into ordered, selectable steps (Material 3 Stepper).

Spec (per docs/CONVENTIONS.md):

  - Two sub-components:
    `step      : { label : String } → List StepOption → Element { step }`
    `stepPanel : { content }        → List PanelOption → Element { stepPanel }`
  - View:
    `view : { steps, panels } → List Option → Element { stepper }`
  - Steps → slot="step" (injected by view via Node.withSlot)
  - Panels → slot="panel" (injected by view via Node.withSlot)
  - Properties: selected, completed, optional, disabled, editable, invalid (step)
    linear (stepper)
  - Attrs: id, for (relational); orientation, header-position (strip rawAttr)
  - Events: (none at this layer; add onClick to step options if needed)
  - Tag: stepper

**Fix #13** — The `<m3e-step-panel>` actions slot is `slot="actions"`. The
generated `Cem.M3e.StepPanel.actionsSlot` binding emits `slot="actions-"` (a
stray trailing dash from the CEM codegen), which mis-slots the content. This
module emits `Node.attribute "slot" "actions"` directly and does NOT use
`Cem.M3e.StepPanel.actionsSlot`.

@docs view, step, stepPanel
@docs Option, StepOption, PanelOption, HeaderPosition
@docs stepId, stepFor, stepSelected, stepCompleted, stepOptional, stepDisabled, stepEditable, stepInvalid
@docs panelId, panelActions
@docs vertical, linear, stepperHeaderPosition

-}

import Cem.M3e.Stepper as CemStepper
import Json.Encode as Encode
import M3e.Element as Element exposing (Element, Supported)
import M3e.Internal as Internal
import M3e.Node as Node


{-| Where the step header sits relative to panel content (horizontal mode).
`Above` is the element default; `Below` places headers after panels.
-}
type HeaderPosition
    = Above
    | Below


{-| An option configuring an individual step.
-}
type alias StepOption msg =
    Internal.Option StepConfig msg


{-| An option configuring an individual step panel.
-}
type alias PanelOption msg =
    Internal.Option (PanelConfig msg) msg


{-| An option configuring the stepper strip.
-}
type alias Option msg =
    Internal.Option StripConfig msg


{-| Set the DOM `id` on the step element (used by the panel's paired `for`).
-}
stepId : String -> StepOption msg
stepId s =
    Internal.option (\c -> { c | id = Just s })


{-| Link this step to its panel via the panel's `id` (the `for` attribute).
-}
stepFor : String -> StepOption msg
stepFor s =
    Internal.option (\c -> { c | for = Just s })


{-| Mark the step as currently selected.
-}
stepSelected : Bool -> StepOption msg
stepSelected b =
    Internal.option (\c -> { c | selected = b })


{-| Mark the step as completed.
-}
stepCompleted : Bool -> StepOption msg
stepCompleted b =
    Internal.option (\c -> { c | completed = b })


{-| Mark the step as optional.
-}
stepOptional : Bool -> StepOption msg
stepOptional b =
    Internal.option (\c -> { c | optional = b })


{-| Disable the step (shown but cannot be selected).
-}
stepDisabled : Bool -> StepOption msg
stepDisabled b =
    Internal.option (\c -> { c | disabled = b })


{-| Mark the step as editable (returns to it after completion).
-}
stepEditable : Bool -> StepOption msg
stepEditable b =
    Internal.option (\c -> { c | editable = b })


{-| Mark the step as invalid.
-}
stepInvalid : Bool -> StepOption msg
stepInvalid b =
    Internal.option (\c -> { c | invalid = b })


{-| Set the DOM `id` on the panel (paired with the step's `stepFor`).
-}
panelId : String -> PanelOption msg
panelId s =
    Internal.option (\c -> { c | id = Just s })


{-| Action buttons for the panel's actions region.

**Fix #13:** Emits `slot="actions"` directly — NOT via
`Cem.M3e.StepPanel.actionsSlot` which emits the buggy `slot="actions-"`.

-}
panelActions : List (Element { button : Supported } msg) -> PanelOption msg
panelActions xs =
    Internal.option (\c -> { c | actions = xs })


{-| Orient the stepper vertically (`orientation="vertical"`). Default false
(horizontal).
-}
vertical : Bool -> Option msg
vertical b =
    Internal.option (\c -> { c | vertical = b })


{-| Require linear progression — validity of previous steps is checked before
the user can advance. Default false.
-}
linear : Bool -> Option msg
linear b =
    Internal.option (\c -> { c | linear = b })


{-| Set where the step header sits relative to panel content (horizontal mode).
-}
stepperHeaderPosition : HeaderPosition -> Option msg
stepperHeaderPosition hp =
    Internal.option (\c -> { c | headerPosition = Just hp })



-- Step sub-component


type alias StepConfig =
    { id : Maybe String
    , for : Maybe String
    , selected : Bool
    , completed : Bool
    , optional : Bool
    , disabled : Bool
    , editable : Bool
    , invalid : Bool
    }


defaultStepConfig : StepConfig
defaultStepConfig =
    { id = Nothing
    , for = Nothing
    , selected = False
    , completed = False
    , optional = False
    , disabled = False
    , editable = False
    , invalid = False
    }


{-| Construct a step indicator.

    M3e.Stepper.step { label = "Shipping" }
        [ M3e.Stepper.stepId "step-shipping"
        , M3e.Stepper.stepFor "panel-shipping"
        , M3e.Stepper.stepSelected True
        ]

-}
step : { label : String } -> List (StepOption msg) -> Element { s | step : Supported } msg
step req opts =
    let
        c : StepConfig
        c =
            Internal.applyOptions opts defaultStepConfig
    in
    Internal.fromNode
        (Node.element "m3e-step"
            (List.filterMap identity
                [ Maybe.map (Node.attribute "id") c.id
                , Maybe.map (Node.attribute "for") c.for
                , Just (Node.property "selected" (Encode.bool c.selected))
                , if c.completed then
                    Just (Node.property "completed" (Encode.bool True))

                  else
                    Nothing
                , if c.optional then
                    Just (Node.property "optional" (Encode.bool True))

                  else
                    Nothing
                , if c.disabled then
                    Just (Node.property "disabled" (Encode.bool True))

                  else
                    Nothing
                , if c.editable then
                    Just (Node.property "editable" (Encode.bool True))

                  else
                    Nothing
                , if c.invalid then
                    Just (Node.property "invalid" (Encode.bool True))

                  else
                    Nothing
                ]
            )
            [ Node.text req.label ]
        )



-- Panel sub-component


type alias PanelConfig msg =
    { id : Maybe String
    , actions : List (Element { button : Supported } msg)
    }


defaultPanelConfig : PanelConfig msg
defaultPanelConfig =
    { id = Nothing
    , actions = []
    }


{-| Construct a step panel.

    M3e.Stepper.stepPanel
        { content = [ shippingForm ] }
        [ M3e.Stepper.panelId "panel-shipping"
        , M3e.Stepper.panelActions
            [ M3e.Button.view { label = "Back", variant = M3e.Button.Text } []
            , M3e.Button.view { label = "Continue", variant = M3e.Button.Filled } []
            ]
        ]

-}
stepPanel : { content : List (Element any msg) } -> List (PanelOption msg) -> Element { s | stepPanel : Supported } msg
stepPanel req opts =
    let
        c : PanelConfig msg
        c =
            Internal.applyOptions opts defaultPanelConfig
    in
    Internal.fromNode
        (Node.element "m3e-step-panel"
            (List.filterMap identity
                [ Maybe.map (Node.attribute "id") c.id
                ]
            )
            (List.map Element.toNode req.content
                ++ actionsNodes c.actions
            )
        )


{-| Fix #13: Emit the actions wrapper with `slot="actions"` directly.
The generated `Cem.M3e.StepPanel.actionsSlot` binding emits `slot="actions-"`
(a stray trailing dash), which would mis-slot the content. We write the
correct value here.
-}
actionsNodes : List (Element { button : Supported } msg) -> List (Node.Node msg)
actionsNodes xs =
    case xs of
        [] ->
            []

        _ ->
            [ Node.element "div"
                [ Node.attribute "slot" "actions" ]
                (List.map Element.toNode xs)
            ]



-- Strip


type alias StripConfig =
    { vertical : Bool
    , linear : Bool
    , headerPosition : Maybe HeaderPosition
    }


defaultStripConfig : StripConfig
defaultStripConfig =
    { vertical = False
    , linear = False
    , headerPosition = Nothing
    }


{-| Render the stepper.

    M3e.Stepper.view
        { steps =
            [ M3e.Stepper.step { label = "Shipping" }
                [ M3e.Stepper.stepId "s1", M3e.Stepper.stepFor "p1", M3e.Stepper.stepSelected True ]
            , M3e.Stepper.step { label = "Payment" }
                [ M3e.Stepper.stepId "s2", M3e.Stepper.stepFor "p2" ]
            ]
        , panels =
            [ M3e.Stepper.stepPanel { content = [ shippingForm ] }
                [ M3e.Stepper.panelId "p1"
                , M3e.Stepper.panelActions [ backBtn, nextBtn ]
                ]
            , M3e.Stepper.stepPanel { content = [ paymentForm ] }
                [ M3e.Stepper.panelId "p2" ]
            ]
        }
        []

Steps receive `slot="step"` and panels receive `slot="panel"` automatically.

-}
view :
    { steps : List (Element { step : Supported } msg)
    , panels : List (Element { stepPanel : Supported } msg)
    }
    -> List (Option msg)
    -> Element { s | stepper : Supported } msg
view req opts =
    let
        c : StripConfig
        c =
            Internal.applyOptions opts defaultStripConfig
    in
    Internal.fromNode
        (Node.element "m3e-stepper"
            (List.filterMap identity
                [ if c.vertical then
                    Just (Node.rawAttr (CemStepper.orientation CemStepper.Vertical))

                  else
                    Nothing
                , if c.linear then
                    Just (Node.property "linear" (Encode.bool True))

                  else
                    Nothing
                , Maybe.map
                    (\hp ->
                        Node.rawAttr
                            (CemStepper.headerPosition (toCemHeaderPosition hp))
                    )
                    c.headerPosition
                ]
            )
            (List.map (Node.withSlot "step" << Element.toNode) req.steps
                ++ List.map (Node.withSlot "panel" << Element.toNode) req.panels
            )
        )


toCemHeaderPosition : HeaderPosition -> CemStepper.HeaderPosition
toCemHeaderPosition hp =
    case hp of
        Above ->
            CemStepper.Above

        Below ->
            CemStepper.HeaderPositionBelow
