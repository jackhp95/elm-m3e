module M3e.Optgroup exposing (view, label)

{-| Groups options under a subheading.

**Component Info:**

  - **Extends:** `LitElement`

**Slots:**

  - `label`: Renders the label of the group.

@docs view, label

-}

import M3e.Html.Optgroup
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Kind
import Markup.Node


{-| Build the `<m3e-optgroup>` element (lazy IR).
-}
view :
    List (Markup.Html.Attr.Attr { slot : M3e.Token.Supported } msg)
    -> List (Markup.Element.Element { option : M3e.Kind.Brand } msg)
    -> Markup.Element.Element { s | optgroup : M3e.Kind.Brand } msg
view attributes children =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.Optgroup.optgroup
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.map Markup.Element.toNode children)
        )


{-| Place content in the `label` slot.
-}
label :
    Markup.Element.Element { text : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
label el =
    Markup.Element.Internal.placeSlot "label" el
