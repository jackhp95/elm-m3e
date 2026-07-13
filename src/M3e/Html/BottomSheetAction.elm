module M3e.Html.BottomSheetAction exposing (bottomSheetAction)

{-| Middle layer for `<m3e-bottom-sheet-action>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.BottomSheetAction` module for everyday use.

@docs bottomSheetAction

-}

import Html
import M3e.Raw.BottomSheetAction
import M3e.Token
import Markup.Html.Attr


{-| An element, nested within a clickable element, used to close a parenting bottom sheet.

**Component Info:**

  - **Extends:** `ActionElementBase`

-}
bottomSheetAction :
    List (Markup.Html.Attr.Attr { slot : M3e.Token.Supported } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
bottomSheetAction attributes children =
    M3e.Raw.BottomSheetAction.bottomSheetAction
        (List.map Markup.Html.Attr.toAttribute attributes)
        children
