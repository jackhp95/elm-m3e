module M3e.Family.List.Action exposing (el, Is, Attrs, Content, LeadingSlot, OverlineSlot, SupportingTextSlot, TrailingSlot, ChildAdmittedBy, disabled, download, href, rel, target, onClick, leading, overline, supportingText, trailing, child)

{-| `ListAction`, grouped under the **List** family as `Action`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.ListAction`](M3e.Component.ListAction) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, Content, LeadingSlot, OverlineSlot, SupportingTextSlot, TrailingSlot, ChildAdmittedBy, disabled, download, href, rel, target, onClick, leading, overline, supportingText, trailing, child

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Kind exposing (Shared, Supported)
import M3e.Component.ListAction as Orig


{-| See [`M3e.Component.ListAction.el`](M3e.Component.ListAction#el).
-}
el :
    List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.ListAction.Is`](M3e.Component.ListAction#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.ListAction.Attrs`](M3e.Component.ListAction#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.ListAction.Content`](M3e.Component.ListAction#Content).
-}
type alias Content =
    Orig.Content


{-| See [`M3e.Component.ListAction.LeadingSlot`](M3e.Component.ListAction#LeadingSlot).
-}
type alias LeadingSlot =
    Orig.LeadingSlot


{-| See [`M3e.Component.ListAction.OverlineSlot`](M3e.Component.ListAction#OverlineSlot).
-}
type alias OverlineSlot =
    Orig.OverlineSlot


{-| See [`M3e.Component.ListAction.SupportingTextSlot`](M3e.Component.ListAction#SupportingTextSlot).
-}
type alias SupportingTextSlot =
    Orig.SupportingTextSlot


{-| See [`M3e.Component.ListAction.TrailingSlot`](M3e.Component.ListAction#TrailingSlot).
-}
type alias TrailingSlot =
    Orig.TrailingSlot


{-| See [`M3e.Component.ListAction.ChildAdmittedBy`](M3e.Component.ListAction#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm


{-| See [`M3e.Component.ListAction.disabled`](M3e.Component.ListAction#disabled).
-}
disabled : Bool -> Attr { c | disabled : Supported } msg
disabled =
    Orig.disabled


{-| See [`M3e.Component.ListAction.download`](M3e.Component.ListAction#download).
-}
download : String -> Attr { c | download : Supported } msg
download =
    Orig.download


{-| See [`M3e.Component.ListAction.href`](M3e.Component.ListAction#href).
-}
href : String -> Attr { c | href : Supported } msg
href =
    Orig.href


{-| See [`M3e.Component.ListAction.rel`](M3e.Component.ListAction#rel).
-}
rel : String -> Attr { c | rel : Supported } msg
rel =
    Orig.rel


{-| See [`M3e.Component.ListAction.target`](M3e.Component.ListAction#target).
-}
target : String -> Attr { c | target : Supported } msg
target =
    Orig.target


{-| See [`M3e.Component.ListAction.onClick`](M3e.Component.ListAction#onClick).
-}
onClick : msg -> Attr { c | onClick : Supported } msg
onClick =
    Orig.onClick


{-| See [`M3e.Component.ListAction.leading`](M3e.Component.ListAction#leading).
-}
leading : Element LeadingSlot admittedBy msg -> Element free freeAdmittedBy msg
leading =
    Orig.leading


{-| See [`M3e.Component.ListAction.overline`](M3e.Component.ListAction#overline).
-}
overline : Element OverlineSlot admittedBy msg -> Element free freeAdmittedBy msg
overline =
    Orig.overline


{-| See [`M3e.Component.ListAction.supportingText`](M3e.Component.ListAction#supportingText).
-}
supportingText : Element SupportingTextSlot admittedBy msg -> Element free freeAdmittedBy msg
supportingText =
    Orig.supportingText


{-| See [`M3e.Component.ListAction.trailing`](M3e.Component.ListAction#trailing).
-}
trailing : Element TrailingSlot admittedBy msg -> Element free freeAdmittedBy msg
trailing =
    Orig.trailing


{-| See [`M3e.Component.ListAction.child`](M3e.Component.ListAction#child).
-}
child : Element Content admittedBy msg -> Element free freeAdmittedBy msg
child =
    Orig.child
