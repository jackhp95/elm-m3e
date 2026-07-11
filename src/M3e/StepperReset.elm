module M3e.StepperReset exposing (view)

{-| An element, nested within a clickable element, used to reset a stepper to its initial state.

**Component Info:**

  - **Extends:** `StepperButtonElementBase` from `/src/stepper/StepperButtonElementBase`

@docs view

-}

import M3e.Element
import M3e.Element.Internal
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Html.StepperReset
import M3e.Node
import M3e.Token


{-| Build the `<m3e-stepper-reset>` element (lazy IR).
-}
view :
    List (M3e.Html.Attr.Attr { slot : M3e.Token.Supported } msg)
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | stepperReset : M3e.Token.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Html.StepperReset.stepperReset
                    (List.map M3e.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map M3e.Html.Attr.Internal.forget attributes)
            (List.map M3e.Element.toNode children)
        )
