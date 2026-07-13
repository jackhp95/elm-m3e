module M3e.StepPanel exposing (view, actions)

{-| A panel presented for a step in a wizard-like workflow.

**Component Info:**

  - **Extends:** `LitElement`

**Slots:**

  - `actions-`: Renders the actions bar of the panel.

@docs view, actions

-}

import M3e.Html.StepPanel
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Node


{-| Build the `<m3e-step-panel>` element (lazy IR).
-}
view :
    List (Markup.Html.Attr.Attr { slot : M3e.Token.Supported } msg)
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | stepPanel : M3e.Kind.Brand } msg
view attributes children =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.StepPanel.stepPanel
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.map Markup.Element.toNode children)
        )


{-| Place content in the `actions` slot.
-}
actions : Markup.Element.Element any msg -> Markup.Element.Element k msg
actions el =
    Markup.Element.Internal.placeSlot "actions" el
