module M3e.Stepper exposing
    ( view, headerPosition, labelPosition, linear, orientation, onChange
    , onBeforeinput, onInput, step, panel
    )

{-|
Provides a wizard-like workflow by dividing content into logical steps.

**Component Info:**
- **Extends:** `LitElement`

**Events:**
- `change`: Dispatched when the selected step changes.
- `beforeinput`: Dispatched before the selected state of a step changes.
- `input`: Dispatched when the selected state of a step changes.

**Slots:**
- `step`: Renders a step.
- `panel`: Renders a panel.

<!-- elm-cem:docmeta category=Navigation -->

## Examples

### Examples

<!-- elm-cem:example title="Horizontal stepper with completed and optional steps" -->
```elm
M3e.Stepper.view [ M3e.Stepper.orientation M3e.Value.horizontal, M3e.Stepper.headerPosition M3e.Value.above, M3e.Stepper.labelPosition M3e.Value.end ] [ M3e.Stepper.step (M3e.Step.view [ M3e.Step.for "acct", M3e.Step.completed True, M3e.Step.editable True ] [ M3e.Step.child (Kit.text "Account"), M3e.Step.icon (M3e.Icon.view [ M3e.Icon.name "person" ] []) ]), M3e.Stepper.step (M3e.Step.view [ M3e.Step.for "profile", M3e.Step.selected True ] [ M3e.Step.child (Kit.text "Profile"), M3e.Step.hint (Kit.text "Tell us about yourself") ]), M3e.Stepper.step (M3e.Step.view [ M3e.Step.for "review", M3e.Step.optional True ] [ M3e.Step.child (Kit.text "Review") ]), M3e.Stepper.panel (M3e.StepPanel.view [] [ M3e.StepPanel.child (Native.p [] [ Kit.text "Account details saved." ]) ]), M3e.Stepper.panel (M3e.StepPanel.view [] [ M3e.StepPanel.child (Native.p [] [ Kit.text "Enter your profile information." ]) ]), M3e.Stepper.panel (M3e.StepPanel.view [] [ M3e.StepPanel.child (Native.p [] [ Kit.text "Review and submit." ]) ]) ]
```

<!-- elm-cem:example title="Linear vertical stepper with navigation controls" -->
```elm
M3e.Stepper.view [ M3e.Stepper.orientation M3e.Value.vertical, M3e.Stepper.linear True ] [ M3e.Stepper.step (M3e.Step.view [ M3e.Step.for "s1", M3e.Step.selected True ] [ M3e.Step.child (Kit.text "Choose a plan") ]), M3e.Stepper.step (M3e.Step.view [ M3e.Step.for "s2" ] [ M3e.Step.child (Kit.text "Payment") ]), M3e.Stepper.panel (M3e.StepPanel.view [] [ M3e.StepPanel.child (Native.p [] [ Kit.text "Pick the plan that fits you." ]) ]), M3e.Stepper.panel (M3e.StepPanel.view [] (M3e.StepPanel.children [ Native.p [] [ Kit.text "Confirm and reset if needed." ], M3e.Record.Button.view { content = Kit.text "Back", action = M3e.Action.stepperPrevious } [] [], M3e.Record.Button.view { content = Kit.text "Start over", action = M3e.Action.stepperReset } [] [] ])) ]
```

@docs view, headerPosition, labelPosition, linear, orientation, onChange
@docs onBeforeinput, onInput, step, panel
-}


import M3e.Cem.Attr
import M3e.Cem.Stepper
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-stepper>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { headerPosition : M3e.Value.Supported
    , labelPosition : M3e.Value.Supported
    , linear : M3e.Value.Supported
    , orientation : M3e.Value.Supported
    , onChange : M3e.Value.Supported
    , onBeforeinput : M3e.Value.Supported
    , onInput : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { step : M3e.Value.Supported
    , panel : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | stepper : M3e.Value.Supported } msg
view attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.Stepper.stepper
                      (List.map M3e.Cem.Attr.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.forget attributes)
             (List.map M3e.Content.toNode content_)
        )


{-| The position of the step header, when oriented horizontally. (default: `"above"`) -}
headerPosition :
    M3e.Value.Value { above : M3e.Value.Supported, below : M3e.Value.Supported }
    -> M3e.Cem.Attr.Attr { c | headerPosition : M3e.Value.Supported } msg
headerPosition =
    M3e.Cem.Stepper.headerPosition


{-| The position of the step labels, when oriented horizontally. (default: `"end"`) -}
labelPosition :
    M3e.Value.Value { below : M3e.Value.Supported, end : M3e.Value.Supported }
    -> M3e.Cem.Attr.Attr { c | labelPosition : M3e.Value.Supported } msg
labelPosition =
    M3e.Cem.Stepper.labelPosition


{-| Whether the validity of previous steps should be checked or not. (default: `false`) -}
linear : Bool -> M3e.Cem.Attr.Attr { c | linear : M3e.Value.Supported } msg
linear =
    M3e.Cem.Stepper.linear


{-| The orientation of the stepper. (default: `"horizontal"`) -}
orientation :
    M3e.Value.Value { auto : M3e.Value.Supported
    , horizontal : M3e.Value.Supported
    , vertical : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | orientation : M3e.Value.Supported } msg
orientation =
    M3e.Cem.Stepper.orientation


{-| Listen for `change` events. -}
onChange : msg -> M3e.Cem.Attr.Attr { c | onChange : M3e.Value.Supported } msg
onChange =
    M3e.Cem.Stepper.onChange


{-| Listen for `beforeinput` events. -}
onBeforeinput :
    msg -> M3e.Cem.Attr.Attr { c | onBeforeinput : M3e.Value.Supported } msg
onBeforeinput =
    M3e.Cem.Stepper.onBeforeinput


{-| Listen for `input` events. -}
onInput : msg -> M3e.Cem.Attr.Attr { c | onInput : M3e.Value.Supported } msg
onInput =
    M3e.Cem.Stepper.onInput


{-| Place content in the `step` slot. -}
step :
    M3e.Element.Element { step : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | step : M3e.Value.Supported } msg
step el =
    M3e.Content.slot "step" el


{-| Place content in the `panel` slot. -}
panel :
    M3e.Element.Element { stepPanel : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | panel : M3e.Value.Supported } msg
panel el =
    M3e.Content.slot "panel" el