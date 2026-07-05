module M3e.Build.Stepper.Slots exposing ( stepStep, panelStepPanel )

{-|
Slot setters for `M3e.Build.Stepper`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs stepStep, panelStepPanel
-}


import M3e.Build.Internal
import M3e.Build.Step
import M3e.Build.StepPanel
import M3e.Build.Stepper
import M3e.Node


step_core :
    M3e.Build.Internal.Builder anyK anyA anyS msg
    -> M3e.Build.Stepper.Builder pa ps msg pk
    -> M3e.Build.Stepper.Builder pa ps msg pk
step_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


panel_core :
    M3e.Build.Internal.Builder anyK anyA anyS msg
    -> M3e.Build.Stepper.Builder pa ps msg pk
    -> M3e.Build.Stepper.Builder pa ps msg pk
panel_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `Step` in the `step` slot of `Stepper`. -}
stepStep :
    M3e.Build.Step.Builder ca cs msg ck
    -> M3e.Build.Stepper.Builder pa ps msg pk
    -> M3e.Build.Stepper.Builder pa ps msg pk
stepStep =
    step_core


{-| Place a `StepPanel` in the `panel` slot of `Stepper`. -}
panelStepPanel :
    M3e.Build.StepPanel.Builder ca cs msg ck
    -> M3e.Build.Stepper.Builder pa ps msg pk
    -> M3e.Build.Stepper.Builder pa ps msg pk
panelStepPanel =
    panel_core