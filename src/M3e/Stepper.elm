module M3e.Stepper exposing
    ( HeaderPosition(..)
    , StepOption, PanelOption, Option
    , step, stepPanel, view
    , stepId, stepFor, stepSelected, stepCompleted
    , stepOptional, stepDisabled, stepEditable, stepInvalid
    , panelId, panelActions
    , vertical, linear, stepperHeaderPosition
    )

{-| `<m3e-stepper>` + `<m3e-step>` + `<m3e-step-panel>` — a wizard-like
workflow dividing content into ordered, selectable steps (Material 3 Stepper).

Spec (per docs/CONVENTIONS.md):

  - Two sub-components:
      `step      : { label : String } → List StepOption → Renderable { step }`
      `stepPanel : { content }        → List PanelOption → Renderable { stepPanel }`
  - View:
      `view : { steps, panels } → List Option → Renderable { stepper }`
  - Steps  → slot="step"  (injected by view via Node.withSlot)
  - Panels → slot="panel" (injected by view via Node.withSlot)
  - Properties: selected, completed, optional, disabled, editable, invalid (step)
                linear (stepper)
  - Attrs:      id, for (relational); orientation, header-position (strip rawAttr)
  - Events:     (none at this layer; add onClick to step options if needed)
  - Tag:        stepper

**Fix #13** — The `<m3e-step-panel>` actions slot is `slot="actions"`. The
generated `Cem.M3e.StepPanel.actionsSlot` binding emits `slot="actions-"` (a
stray trailing dash from the CEM codegen), which mis-slots the content. This
module emits `Node.attribute "slot" "actions"` directly and does NOT use
`Cem.M3e.StepPanel.actionsSlot`.

-}

import Cem.M3e.Stepper as CemStepper
import Json.Decode as Decode
import Json.Encode as Encode
import M3e.Node as Node
import M3e.Renderable as Renderable exposing (Renderable, Supported)


{-| Where the step header sits relative to panel content (horizontal mode).
`Above` is the element default; `Below` places headers after panels.
-}
type HeaderPosition
    = Above
    | Below


type StepOption msg
    = StepId String
    | StepFor String
    | StepSelected Bool
    | StepCompleted Bool
    | StepOptional Bool
    | StepDisabled Bool
    | StepEditable Bool
    | StepInvalid Bool


type PanelOption msg
    = PanelId String
    | PanelActions (List (Renderable { button : Supported } msg))


type Option msg
    = Vertical Bool
    | Linear Bool
    | HeaderPositionOpt HeaderPosition


{-| Set the DOM `id` on the step element (used by the panel's paired `for`). -}
stepId : String -> StepOption msg
stepId =
    StepId


{-| Link this step to its panel via the panel's `id` (the `for` attribute). -}
stepFor : String -> StepOption msg
stepFor =
    StepFor


{-| Mark the step as currently selected. -}
stepSelected : Bool -> StepOption msg
stepSelected =
    StepSelected


{-| Mark the step as completed. -}
stepCompleted : Bool -> StepOption msg
stepCompleted =
    StepCompleted


{-| Mark the step as optional. -}
stepOptional : Bool -> StepOption msg
stepOptional =
    StepOptional


{-| Disable the step (shown but cannot be selected). -}
stepDisabled : Bool -> StepOption msg
stepDisabled =
    StepDisabled


{-| Mark the step as editable (returns to it after completion). -}
stepEditable : Bool -> StepOption msg
stepEditable =
    StepEditable


{-| Mark the step as invalid. -}
stepInvalid : Bool -> StepOption msg
stepInvalid =
    StepInvalid


{-| Set the DOM `id` on the panel (paired with the step's `stepFor`). -}
panelId : String -> PanelOption msg
panelId =
    PanelId


{-| Action buttons for the panel's actions region.

**Fix #13:** Emits `slot="actions"` directly — NOT via
`Cem.M3e.StepPanel.actionsSlot` which emits the buggy `slot="actions-"`.
-}
panelActions : List (Renderable { button : Supported } msg) -> PanelOption msg
panelActions =
    PanelActions


{-| Orient the stepper vertically (`orientation="vertical"`). Default false
(horizontal).
-}
vertical : Bool -> Option msg
vertical =
    Vertical


{-| Require linear progression — validity of previous steps is checked before
the user can advance. Default false.
-}
linear : Bool -> Option msg
linear =
    Linear


{-| Set where the step header sits relative to panel content (horizontal mode).
-}
stepperHeaderPosition : HeaderPosition -> Option msg
stepperHeaderPosition =
    HeaderPositionOpt



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


applyStep : StepOption msg -> StepConfig -> StepConfig
applyStep opt c =
    case opt of
        StepId s ->
            { c | id = Just s }

        StepFor s ->
            { c | for = Just s }

        StepSelected b ->
            { c | selected = b }

        StepCompleted b ->
            { c | completed = b }

        StepOptional b ->
            { c | optional = b }

        StepDisabled b ->
            { c | disabled = b }

        StepEditable b ->
            { c | editable = b }

        StepInvalid b ->
            { c | invalid = b }


{-| Construct a step indicator.

    M3e.Stepper.step { label = "Shipping" }
        [ M3e.Stepper.stepId "step-shipping"
        , M3e.Stepper.stepFor "panel-shipping"
        , M3e.Stepper.stepSelected True
        ]

-}
step : { label : String } -> List (StepOption msg) -> Renderable { s | step : Supported } msg
step req opts =
    let
        c =
            List.foldl applyStep defaultStepConfig opts
    in
    Renderable.fromNode
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
    , actions : List (Renderable { button : Supported } msg)
    }


defaultPanelConfig : PanelConfig msg
defaultPanelConfig =
    { id = Nothing
    , actions = []
    }


applyPanel : PanelOption msg -> PanelConfig msg -> PanelConfig msg
applyPanel opt c =
    case opt of
        PanelId s ->
            { c | id = Just s }

        PanelActions xs ->
            { c | actions = xs }


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
stepPanel : { content : List (Renderable any msg) } -> List (PanelOption msg) -> Renderable { s | stepPanel : Supported } msg
stepPanel req opts =
    let
        c =
            List.foldl applyPanel defaultPanelConfig opts
    in
    Renderable.fromNode
        (Node.element "m3e-step-panel"
            (List.filterMap identity
                [ Maybe.map (Node.attribute "id") c.id
                ]
            )
            (List.map Renderable.toNode req.content
                ++ actionsNodes c.actions
            )
        )


{-| Fix #13: Emit the actions wrapper with `slot="actions"` directly.
The generated `Cem.M3e.StepPanel.actionsSlot` binding emits `slot="actions-"`
(a stray trailing dash), which would mis-slot the content. We write the
correct value here.
-}
actionsNodes : List (Renderable { button : Supported } msg) -> List (Node.Node msg)
actionsNodes xs =
    case xs of
        [] ->
            []

        _ ->
            [ Node.element "div"
                [ Node.attribute "slot" "actions" ]
                (List.map Renderable.toNode xs)
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


applyStrip : Option msg -> StripConfig -> StripConfig
applyStrip opt c =
    case opt of
        Vertical b ->
            { c | vertical = b }

        Linear b ->
            { c | linear = b }

        HeaderPositionOpt hp ->
            { c | headerPosition = Just hp }


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
    { steps : List (Renderable { step : Supported } msg)
    , panels : List (Renderable { stepPanel : Supported } msg)
    }
    -> List (Option msg)
    -> Renderable { s | stepper : Supported } msg
view req opts =
    let
        c =
            List.foldl applyStrip defaultStripConfig opts
    in
    Renderable.fromNode
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
            (List.map (Node.withSlot "step" << Renderable.toNode) req.steps
                ++ List.map (Node.withSlot "panel" << Renderable.toNode) req.panels
            )
        )


toCemHeaderPosition : HeaderPosition -> CemStepper.HeaderPosition
toCemHeaderPosition hp =
    case hp of
        Above ->
            CemStepper.Above

        Below ->
            CemStepper.HeaderPositionBelow
