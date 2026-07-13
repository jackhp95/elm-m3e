module M3e.StepperPrevious exposing (view)

{-| An element, nested within a clickable element, used to move a stepper to the previous step.

**Component Info:**

  - **Extends:** `StepperButtonElementBase` from `/src/stepper/StepperButtonElementBase`

@docs view

-}

import M3e.Html.StepperPrevious
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Node


{-| Build the `<m3e-stepper-previous>` element (lazy IR).
-}
view :
    List (Markup.Html.Attr.Attr { slot : M3e.Token.Supported } msg)
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | stepperPrevious : M3e.Kind.Brand } msg
view attributes children =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.StepperPrevious.stepperPrevious
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.map Markup.Element.toNode children)
        )
