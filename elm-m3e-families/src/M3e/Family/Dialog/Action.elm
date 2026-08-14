module M3e.Family.Dialog.Action exposing (el, Is, Attrs, ChildAdmittedBy, returnValue, child)

{-| `DialogAction`, grouped under the **Dialog** family as `Action`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.DialogAction`](M3e.Component.DialogAction) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, ChildAdmittedBy, returnValue, child

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Kind exposing (Shared, Supported)
import M3e.Component.DialogAction as Orig


{-| See [`M3e.Component.DialogAction.el`](M3e.Component.DialogAction#el).
-}
el :
    List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.DialogAction.Is`](M3e.Component.DialogAction#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.DialogAction.Attrs`](M3e.Component.DialogAction#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.DialogAction.ChildAdmittedBy`](M3e.Component.DialogAction#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm


{-| See [`M3e.Component.DialogAction.returnValue`](M3e.Component.DialogAction#returnValue).
-}
returnValue : String -> Attr { c | returnValue : Supported } msg
returnValue =
    Orig.returnValue


{-| See [`M3e.Component.DialogAction.child`](M3e.Component.DialogAction#child).
-}
child : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
child =
    Orig.child
