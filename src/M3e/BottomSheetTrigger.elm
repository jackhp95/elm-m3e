module M3e.BottomSheetTrigger exposing (view, detent, secondary, for)

{-| An element, nested within a clickable element, used to trigger a bottom sheet.

**Component Info:**

  - **Extends:** `ActionElementBase`

@docs view, detent, secondary, for

-}

import M3e.Element
import M3e.Element.Internal
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Html.BottomSheetTrigger
import M3e.Node
import M3e.Token


{-| Build the `<m3e-bottom-sheet-trigger>` element (lazy IR).
-}
view :
    List
        (M3e.Html.Attr.Attr
            { detent : M3e.Token.Supported
            , secondary : M3e.Token.Supported
            , for : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element { text : M3e.Token.Supported } msg)
    -> M3e.Element.Element { s | bottomSheetTrigger : M3e.Token.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Html.BottomSheetTrigger.bottomSheetTrigger
                    (List.map M3e.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map M3e.Html.Attr.Internal.forget attributes)
            (List.map M3e.Element.toNode children)
        )


{-| The zero‑based index of the detent the sheet should open to.
-}
detent : Float -> M3e.Html.Attr.Attr { c | detent : M3e.Token.Supported } msg
detent =
    M3e.Html.BottomSheetTrigger.detent


{-| Marks this trigger as a secondary trigger for accessibility. Secondary triggers do not receive ARIA ownership. (default: `false`)
-}
secondary : Bool -> M3e.Html.Attr.Attr { c | secondary : M3e.Token.Supported } msg
secondary =
    M3e.Html.BottomSheetTrigger.secondary


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for : String -> M3e.Html.Attr.Attr { c | for : M3e.Token.Supported } msg
for =
    M3e.Html.BottomSheetTrigger.for
