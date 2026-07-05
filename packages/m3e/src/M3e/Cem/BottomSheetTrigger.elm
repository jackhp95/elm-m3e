module M3e.Cem.BottomSheetTrigger exposing ( bottomSheetTrigger, detent, secondary, for )

{-|
Middle layer for `<m3e-bottom-sheet-trigger>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.BottomSheetTrigger` module for everyday use.

@docs bottomSheetTrigger, detent, secondary, for
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.Html.BottomSheetTrigger
import M3e.Value


{-| An element, nested within a clickable element, used to trigger a bottom sheet.

**Component Info:**
- **Extends:** `ActionElementBase`
-}
bottomSheetTrigger :
    List (M3e.Cem.Attr.Attr { detent : M3e.Value.Supported
    , secondary : M3e.Value.Supported
    , for : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
bottomSheetTrigger attributes children =
    M3e.Cem.Html.BottomSheetTrigger.bottomSheetTrigger
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| The zero‑based index of the detent the sheet should open to. -}
detent : Float -> M3e.Cem.Attr.Attr { c | detent : M3e.Value.Supported } msg
detent =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.BottomSheetTrigger.detent


{-| Marks this trigger as a secondary trigger for accessibility. Secondary triggers do not receive ARIA ownership. (default: `false`) -}
secondary :
    Bool -> M3e.Cem.Attr.Attr { c | secondary : M3e.Value.Supported } msg
secondary =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.BottomSheetTrigger.secondary


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for : String -> M3e.Cem.Attr.Attr { c | for : M3e.Value.Supported } msg
for =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.BottomSheetTrigger.for