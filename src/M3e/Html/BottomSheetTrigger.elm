module M3e.Html.BottomSheetTrigger exposing (bottomSheetTrigger, detent, secondary, for)

{-| Middle layer for `<m3e-bottom-sheet-trigger>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.BottomSheetTrigger` module for everyday use.

@docs bottomSheetTrigger, detent, secondary, for

-}

import Html
import M3e.Raw.BottomSheetTrigger
import M3e.Token
import Markup.Html.Attr
import Markup.Html.Attr.Internal


{-| An element, nested within a clickable element, used to trigger a bottom sheet.

**Component Info:**

  - **Extends:** `ActionElementBase`

-}
bottomSheetTrigger :
    List
        (Markup.Html.Attr.Attr
            { detent : M3e.Token.Supported
            , secondary : M3e.Token.Supported
            , for : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
bottomSheetTrigger attributes children =
    M3e.Raw.BottomSheetTrigger.bottomSheetTrigger
        (List.map Markup.Html.Attr.toAttribute attributes)
        children


{-| The zero‑based index of the detent the sheet should open to.
-}
detent : Float -> Markup.Html.Attr.Attr { c | detent : M3e.Token.Supported } msg
detent =
    Markup.Html.Attr.Internal.attribute M3e.Raw.BottomSheetTrigger.detent


{-| Marks this trigger as a secondary trigger for accessibility. Secondary triggers do not receive ARIA ownership. (default: `false`)
-}
secondary : Bool -> Markup.Html.Attr.Attr { c | secondary : M3e.Token.Supported } msg
secondary =
    Markup.Html.Attr.Internal.attribute M3e.Raw.BottomSheetTrigger.secondary


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for : String -> Markup.Html.Attr.Attr { c | for : M3e.Token.Supported } msg
for =
    Markup.Html.Attr.Internal.attribute M3e.Raw.BottomSheetTrigger.for
