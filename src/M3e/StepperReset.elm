module M3e.StepperReset exposing (view)

{-| `<m3e-stepper-reset>` — a companion element, nested within a clickable
element, that resets a [`M3e.Stepper`](M3e.Stepper) to its initial state.

The content you pass becomes the visible action label (e.g. `"Restart"`).

Spec (per upstream CEM):

  - Required: none
  - Options: none
  - Slots: default (the action label / content)
  - Tag: stepperReset

@docs view

-}

import M3e.Element exposing (Element, Supported)
import M3e.Internal as Internal
import M3e.Node as Node


{-| Render an `<m3e-stepper-reset>`. Pass the visible action content as the
first argument, nested inside a button element.

    M3e.Button.view { label = "", variant = M3e.Button.Outlined }
        [ M3e.Button.extraContent
            [ M3e.StepperReset.view [ M3e.Element.text "Restart" ] ]
        ]

-}
view : List (Element any msg) -> Element { s | stepperReset : Supported } msg
view content =
    Internal.fromNode
        (Node.element "m3e-stepper-reset"
            []
            (List.map Internal.toNode content)
        )
