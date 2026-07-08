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

<!-- elm-cem:example title="Basic usage" -->
```elm
M3e.Stepper.view [] [ M3e.Stepper.step (M3e.Step.view [ M3e.Step.for "step1" ] [ Kit.text "Fill out your name" ]), M3e.Stepper.step (M3e.Step.view [ M3e.Step.for "step2" ] [ Kit.text "Fill out your address" ]), M3e.Stepper.step (M3e.Step.view [ M3e.Step.for "step3" ] [ Kit.text "Done" ]), M3e.Stepper.panel (M3e.StepPanel.view [] [ M3e.StepPanel.actions (Native.div [] [ M3e.Button.view [] [ M3e.StepperNext.view [] [ Kit.text "Next" ] ] ]), Native.node Html.form [] [ M3e.FormField.view [] [ M3e.FormField.label "name" (Native.node Html.label [] [ Kit.text "Name" ]), M3e.FormField.control "name" (Native.node Html.input [] []) ] ] ]), M3e.Stepper.panel (M3e.StepPanel.view [] [ M3e.StepPanel.actions (Native.div [] [ M3e.Button.view [] [ M3e.StepperPrevious.view [] [ Kit.text "Back" ] ], M3e.Button.view [] [ M3e.StepperNext.view [] [ Kit.text "Next" ] ] ]), Native.node Html.form [] [ M3e.FormField.view [] [ M3e.FormField.label "address" (Native.node Html.label [] [ Kit.text "Address" ]), M3e.FormField.control "address" (Native.node Html.input [] []) ] ] ]), M3e.Stepper.panel (M3e.StepPanel.view [] [ M3e.StepPanel.actions (Native.div [] [ M3e.Button.view [] [ M3e.StepperPrevious.view [] [ Kit.text "Back" ] ], M3e.Button.view [] [ M3e.StepperReset.view [] [ Kit.text "Reset" ] ] ]), Kit.text "Done" ]) ]
```

<!-- elm-cem:example title="Orientation" -->
```elm
M3e.Stepper.view [ M3e.Stepper.orientation M3e.Value.vertical ] [ M3e.Stepper.step (M3e.Step.view [ M3e.Step.for "step4" ] [ Kit.text "Fill out your name" ]), M3e.Stepper.step (M3e.Step.view [ M3e.Step.for "step5" ] [ Kit.text "Fill out your address" ]), M3e.Stepper.step (M3e.Step.view [ M3e.Step.for "step6" ] [ Kit.text "Done" ]), M3e.Stepper.panel (M3e.StepPanel.view [] [ M3e.StepPanel.actions (Native.div [] [ M3e.Button.view [] [ M3e.StepperNext.view [] [ Kit.text "Next" ] ] ]), Native.node Html.form [] [ M3e.FormField.view [] [ M3e.FormField.label "name2" (Native.node Html.label [] [ Kit.text "Name" ]), M3e.FormField.control "name2" (Native.node Html.input [] []) ] ] ]), M3e.Stepper.panel (M3e.StepPanel.view [] [ M3e.StepPanel.actions (Native.div [] [ M3e.Button.view [] [ M3e.StepperPrevious.view [] [ Kit.text "Back" ] ], M3e.Button.view [] [ M3e.StepperNext.view [] [ Kit.text "Next" ] ] ]), Native.node Html.form [] [ M3e.FormField.view [] [ M3e.FormField.label "address2" (Native.node Html.label [] [ Kit.text "Address" ]), M3e.FormField.control "address2" (Native.node Html.input [] []) ] ] ]), M3e.Stepper.panel (M3e.StepPanel.view [] [ M3e.StepPanel.actions (Native.div [] [ M3e.Button.view [] [ M3e.StepperPrevious.view [] [ Kit.text "Back" ] ], M3e.Button.view [] [ M3e.StepperReset.view [] [ Kit.text "Reset" ] ] ]), Kit.text "Done" ]) ]
```

<!-- elm-cem:example title="Header positions" -->
```elm
M3e.Stepper.view [ M3e.Stepper.headerPosition M3e.Value.below ] [ M3e.Stepper.step (M3e.Step.view [ M3e.Step.for "step7" ] [ Kit.text "Fill out your name" ]), M3e.Stepper.step (M3e.Step.view [ M3e.Step.for "step8" ] [ Kit.text "Fill out your address" ]), M3e.Stepper.step (M3e.Step.view [ M3e.Step.for "step9" ] [ Kit.text "Done" ]), M3e.Stepper.panel (M3e.StepPanel.view [] [ M3e.StepPanel.actions (Native.div [] [ M3e.Button.view [] [ M3e.StepperNext.view [] [ Kit.text "Next" ] ] ]), Native.node Html.form [] [ M3e.FormField.view [] [ M3e.FormField.label "name3" (Native.node Html.label [] [ Kit.text "Name" ]), M3e.FormField.control "name3" (Native.node Html.input [] []) ] ] ]), M3e.Stepper.panel (M3e.StepPanel.view [] [ M3e.StepPanel.actions (Native.div [] [ M3e.Button.view [] [ M3e.StepperPrevious.view [] [ Kit.text "Back" ] ], M3e.Button.view [] [ M3e.StepperNext.view [] [ Kit.text "Next" ] ] ]), Native.node Html.form [] [ M3e.FormField.view [] [ M3e.FormField.label "address3" (Native.node Html.label [] [ Kit.text "Address" ]), M3e.FormField.control "address3" (Native.node Html.input [] []) ] ] ]), M3e.Stepper.panel (M3e.StepPanel.view [] [ M3e.StepPanel.actions (Native.div [] [ M3e.Button.view [] [ M3e.StepperPrevious.view [] [ Kit.text "Back" ] ], M3e.Button.view [] [ M3e.StepperReset.view [] [ Kit.text "Reset" ] ] ]), Kit.text "Done" ]) ]
```

<!-- elm-cem:example title="Label positions" -->
```elm
M3e.Stepper.view [ M3e.Stepper.labelPosition M3e.Value.below ] [ M3e.Stepper.step (M3e.Step.view [ M3e.Step.for "step10" ] [ Kit.text "Fill out your name" ]), M3e.Stepper.step (M3e.Step.view [ M3e.Step.for "step11" ] [ Kit.text "Fill out your address" ]), M3e.Stepper.step (M3e.Step.view [ M3e.Step.for "step12" ] [ Kit.text "Done" ]), M3e.Stepper.panel (M3e.StepPanel.view [] [ M3e.StepPanel.actions (Native.div [] [ M3e.Button.view [] [ M3e.StepperNext.view [] [ Kit.text "Next" ] ] ]), Native.node Html.form [] [ M3e.FormField.view [] [ M3e.FormField.label "name4" (Native.node Html.label [] [ Kit.text "Name" ]), M3e.FormField.control "name4" (Native.node Html.input [] []) ] ] ]), M3e.Stepper.panel (M3e.StepPanel.view [] [ M3e.StepPanel.actions (Native.div [] [ M3e.Button.view [] [ M3e.StepperPrevious.view [] [ Kit.text "Back" ] ], M3e.Button.view [] [ M3e.StepperNext.view [] [ Kit.text "Next" ] ] ]), Native.node Html.form [] [ M3e.FormField.view [] [ M3e.FormField.label "address4" (Native.node Html.label [] [ Kit.text "Address" ]), M3e.FormField.control "address4" (Native.node Html.input [] []) ] ] ]), M3e.Stepper.panel (M3e.StepPanel.view [] [ M3e.StepPanel.actions (Native.div [] [ M3e.Button.view [] [ M3e.StepperPrevious.view [] [ Kit.text "Back" ] ], M3e.Button.view [] [ M3e.StepperReset.view [] [ Kit.text "Reset" ] ] ]), Kit.text "Done" ]) ]
```

<!-- elm-cem:example title="Stepper buttons" -->
```elm
M3e.StepPanel.view [] [ M3e.StepPanel.actions (Native.div [] [ M3e.Button.view [] [ M3e.StepperPrevious.view [] [ Kit.text "Back" ] ], M3e.Button.view [] [ M3e.StepperNext.view [] [ Kit.text "Next" ] ] ]) ]
```

<!-- elm-cem:example title="Linear stepper" -->
```elm
M3e.Stepper.view [ M3e.Stepper.linear True ] [ M3e.Stepper.step (M3e.Step.view [ M3e.Step.for "step13", M3e.Step.editable True ] [ Kit.text "Fill out your name" ]), M3e.Stepper.step (M3e.Step.view [ M3e.Step.for "step14", M3e.Step.editable True ] [ Kit.text "Fill out your address" ]), M3e.Stepper.step (M3e.Step.view [ M3e.Step.for "step15" ] [ Kit.text "Done" ]), M3e.Stepper.panel (M3e.StepPanel.view [] [ M3e.StepPanel.actions (Native.div [] [ M3e.Button.view [] [ M3e.StepperNext.view [] [ Kit.text "Next" ] ] ]), Native.node Html.form [] [ M3e.FormField.view [] [ M3e.FormField.label "name5" (Native.node Html.label [] [ Kit.text "Name" ]), M3e.FormField.control "name5" (Native.node Html.input [] []) ] ] ]), M3e.Stepper.panel (M3e.StepPanel.view [] [ M3e.StepPanel.actions (Native.div [] [ M3e.Button.view [] [ M3e.StepperPrevious.view [] [ Kit.text "Back" ] ], M3e.Button.view [] [ M3e.StepperNext.view [] [ Kit.text "Next" ] ] ]), Native.node Html.form [] [ M3e.FormField.view [] [ M3e.FormField.label "address5" (Native.node Html.label [] [ Kit.text "Address" ]), M3e.FormField.control "address5" (Native.node Html.input [] []) ] ] ]), M3e.Stepper.panel (M3e.StepPanel.view [] [ M3e.StepPanel.actions (Native.div [] [ M3e.Button.view [] [ M3e.StepperPrevious.view [] [ Kit.text "Back" ] ], M3e.Button.view [] [ M3e.StepperReset.view [] [ Kit.text "Reset" ] ] ]), Kit.text "Done" ]) ]
```

@docs view, headerPosition, labelPosition, linear, orientation, onChange
@docs onBeforeinput, onInput, step, panel
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.Stepper
import M3e.Element
import M3e.Element.Internal
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
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | stepper : M3e.Value.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.Stepper.stepper
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Element.toNode children)
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
    -> M3e.Element.Element k msg
step el =
    M3e.Element.Internal.placeSlot "step" el


{-| Place content in the `panel` slot. -}
panel :
    M3e.Element.Element { stepPanel : M3e.Value.Supported } msg
    -> M3e.Element.Element k msg
panel el =
    M3e.Element.Internal.placeSlot "panel" el