module M3e.StepperNext exposing (view)

{-| `<m3e-stepper-next>` — a companion element, nested within a clickable
element, that advances a [`M3e.Stepper`](M3e.Stepper) to the next step.

The content you pass becomes the visible action label (e.g. `"Next"`).

Spec (per upstream JS registration — CEM has a tagging bug for this element):

  - Required: none
  - Options: none
  - Slots: default (the action label / content)
  - Tag: stepperNext

@docs view

-}

import M3e.Element exposing (Element, Supported)
import M3e.Internal as Internal
import M3e.Node as Node


{-| Render an `<m3e-stepper-next>`. Pass the visible action content as the
first argument, nested inside a button element.

    M3e.Button.view { label = "", variant = M3e.Button.Filled }
        [ M3e.Button.extraContent
            [ M3e.StepperNext.view [ M3e.Element.text "Next" ] ]
        ]

-}
view : List (Element any msg) -> Element { s | stepperNext : Supported } msg
view content =
    Internal.fromNode
        (Node.element "m3e-stepper-next"
            []
            (List.map Internal.toNode content)
        )
