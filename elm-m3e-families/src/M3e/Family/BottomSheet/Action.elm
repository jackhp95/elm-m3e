module M3e.Family.BottomSheet.Action exposing (el, Is, Attrs, Content, ChildAdmittedBy, child)

{-| `BottomSheetAction`, grouped under the **BottomSheet** family as `Action`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.BottomSheetAction`](M3e.Component.BottomSheetAction) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, Content, ChildAdmittedBy, child

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import M3e.Component.BottomSheetAction as Orig


{-| See [`M3e.Component.BottomSheetAction.el`](M3e.Component.BottomSheetAction#el).
-}
el :
    List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.BottomSheetAction.Is`](M3e.Component.BottomSheetAction#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.BottomSheetAction.Attrs`](M3e.Component.BottomSheetAction#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.BottomSheetAction.Content`](M3e.Component.BottomSheetAction#Content).
-}
type alias Content =
    Orig.Content


{-| See [`M3e.Component.BottomSheetAction.ChildAdmittedBy`](M3e.Component.BottomSheetAction#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm


{-| See [`M3e.Component.BottomSheetAction.child`](M3e.Component.BottomSheetAction#child).
-}
child : Element Content admittedBy msg -> Element free freeAdmittedBy msg
child =
    Orig.child
