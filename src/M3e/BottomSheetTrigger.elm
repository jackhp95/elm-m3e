module M3e.BottomSheetTrigger exposing (view, detent, secondary, for)

{-| An element, nested within a clickable element, used to trigger a bottom sheet.

**Component Info:**

  - **Extends:** `ActionElementBase`

@docs view, detent, secondary, for

-}

import M3e.Html.BottomSheetTrigger
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Kind
import Markup.Node


{-| Build the `<m3e-bottom-sheet-trigger>` element (lazy IR).
-}
view :
    List
        (Markup.Html.Attr.Attr
            { detent : M3e.Token.Supported
            , secondary : M3e.Token.Supported
            , for : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element { text : Markup.Kind.Shared } msg)
    -> Markup.Element.Element { s | bottomSheetTrigger : M3e.Kind.Brand } msg
view attributes children =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.BottomSheetTrigger.bottomSheetTrigger
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.map Markup.Element.toNode children)
        )


{-| The zero‑based index of the detent the sheet should open to.
-}
detent : Float -> Markup.Html.Attr.Attr { c | detent : M3e.Token.Supported } msg
detent =
    M3e.Html.BottomSheetTrigger.detent


{-| Marks this trigger as a secondary trigger for accessibility. Secondary triggers do not receive ARIA ownership. (default: `false`)
-}
secondary : Bool -> Markup.Html.Attr.Attr { c | secondary : M3e.Token.Supported } msg
secondary =
    M3e.Html.BottomSheetTrigger.secondary


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for : String -> Markup.Html.Attr.Attr { c | for : M3e.Token.Supported } msg
for =
    M3e.Html.BottomSheetTrigger.for
