module M3e.Family.BottomSheet.Trigger exposing (el, Is, Attrs, Content, ChildAdmittedBy, detent, secondary, child)

{-| `BottomSheetTrigger`, grouped under the **BottomSheet** family as `Trigger`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.BottomSheetTrigger`](M3e.Component.BottomSheetTrigger) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, Content, ChildAdmittedBy, detent, secondary, child

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Kind exposing (Shared, Supported)
import M3e.Component.BottomSheetTrigger as Orig


{-| See [`M3e.Component.BottomSheetTrigger.el`](M3e.Component.BottomSheetTrigger#el).
-}
el :
    { for : String }
    -> List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.BottomSheetTrigger.Is`](M3e.Component.BottomSheetTrigger#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.BottomSheetTrigger.Attrs`](M3e.Component.BottomSheetTrigger#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.BottomSheetTrigger.Content`](M3e.Component.BottomSheetTrigger#Content).
-}
type alias Content =
    Orig.Content


{-| See [`M3e.Component.BottomSheetTrigger.ChildAdmittedBy`](M3e.Component.BottomSheetTrigger#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm


{-| See [`M3e.Component.BottomSheetTrigger.detent`](M3e.Component.BottomSheetTrigger#detent).
-}
detent : Float -> Attr { c | detent : Supported } msg
detent =
    Orig.detent


{-| See [`M3e.Component.BottomSheetTrigger.secondary`](M3e.Component.BottomSheetTrigger#secondary).
-}
secondary : Bool -> Attr { c | secondary : Supported } msg
secondary =
    Orig.secondary


{-| See [`M3e.Component.BottomSheetTrigger.child`](M3e.Component.BottomSheetTrigger#child).
-}
child : Element Content admittedBy msg -> Element free freeAdmittedBy msg
child =
    Orig.child
