module M3e.Cem.BottomSheetAction exposing ( bottomSheetAction )

{-|
Middle layer for `<m3e-bottom-sheet-action>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.BottomSheetAction` module for everyday use.

@docs bottomSheetAction
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Html.BottomSheetAction
import M3e.Value


{-| An element, nested within a clickable element, used to close a parenting bottom sheet.

**Component Info:**
- **Extends:** `ActionElementBase`
-}
bottomSheetAction :
    List (M3e.Cem.Attr.Attr { slot : M3e.Value.Supported } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
bottomSheetAction attributes children =
    M3e.Cem.Html.BottomSheetAction.bottomSheetAction
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children