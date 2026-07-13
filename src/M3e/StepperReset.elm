module M3e.StepperReset exposing (view)

{-| An element, nested within a clickable element, used to reset a stepper to its initial state.

**Component Info:**

  - **Extends:** `StepperButtonElementBase` from `/src/stepper/StepperButtonElementBase`

@docs view

-}

import M3e.Html.StepperReset
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Node


{-| Build the `<m3e-stepper-reset>` element (lazy IR).
-}
view :
    List (Markup.Html.Attr.Attr { slot : M3e.Token.Supported } msg)
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | stepperReset : M3e.Kind.Brand } msg
view attributes children =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.StepperReset.stepperReset
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.map Markup.Element.toNode children)
        )
