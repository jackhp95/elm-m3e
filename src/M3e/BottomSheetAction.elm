module M3e.BottomSheetAction exposing (view)

{-| An element, nested within a clickable element, used to close a parenting bottom sheet.

**Component Info:**

  - **Extends:** `ActionElementBase`

@docs view

-}

import M3e.Html.BottomSheetAction
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Kind
import Markup.Node


{-| Build the `<m3e-bottom-sheet-action>` element (lazy IR).
-}
view :
    List (Markup.Html.Attr.Attr { slot : M3e.Token.Supported } msg)
    -> List (Markup.Element.Element { sharedText : Markup.Kind.Shared } msg)
    -> Markup.Element.Element { s | bottomSheetAction : M3e.Kind.Brand } msg
view attributes children =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.BottomSheetAction.bottomSheetAction
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.map Markup.Element.toNode children)
        )
