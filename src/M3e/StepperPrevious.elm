module M3e.StepperPrevious exposing (view)

{-| `<m3e-stepper-previous>` — a companion element, nested within a clickable
element, that moves a [`M3e.Stepper`](M3e.Stepper) back to the previous step.

The content you pass becomes the visible action label (e.g. `"Back"`).

Spec (per upstream CEM):

  - Required: none
  - Options: none
  - Slots: default (the action label / content)
  - Tag: stepperPrevious

@docs view

-}

import M3e.Element exposing (Element, Supported)
import M3e.Internal as Internal
import M3e.Node as Node


{-| Render an `<m3e-stepper-previous>`. Pass the visible action content as the
first argument, nested inside a button element.

    M3e.Button.view { label = "", variant = M3e.Button.Outlined }
        [ M3e.Button.extraContent
            [ M3e.StepperPrevious.view [ M3e.Element.text "Back" ] ]
        ]

-}
view : List (Element any msg) -> Element { s | stepperPrevious : Supported } msg
view content =
    Internal.fromNode
        (Node.element "m3e-stepper-previous"
            []
            (List.map Internal.toNode content)
        )
