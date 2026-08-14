module M3e.Family.List.Item exposing (el, Is, Attrs, Content, LeadingSlot, OverlineSlot, SupportingTextSlot, TrailingSlot, ChildAdmittedBy, leading, overline, supportingText, trailing, child)

{-| `ListItem`, grouped under the **List** family as `Item`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.ListItem`](M3e.Component.ListItem) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, Content, LeadingSlot, OverlineSlot, SupportingTextSlot, TrailingSlot, ChildAdmittedBy, leading, overline, supportingText, trailing, child

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import M3e.Component.ListItem as Orig


{-| See [`M3e.Component.ListItem.el`](M3e.Component.ListItem#el).
-}
el :
    List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.ListItem.Is`](M3e.Component.ListItem#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.ListItem.Attrs`](M3e.Component.ListItem#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.ListItem.Content`](M3e.Component.ListItem#Content).
-}
type alias Content =
    Orig.Content


{-| See [`M3e.Component.ListItem.LeadingSlot`](M3e.Component.ListItem#LeadingSlot).
-}
type alias LeadingSlot =
    Orig.LeadingSlot


{-| See [`M3e.Component.ListItem.OverlineSlot`](M3e.Component.ListItem#OverlineSlot).
-}
type alias OverlineSlot =
    Orig.OverlineSlot


{-| See [`M3e.Component.ListItem.SupportingTextSlot`](M3e.Component.ListItem#SupportingTextSlot).
-}
type alias SupportingTextSlot =
    Orig.SupportingTextSlot


{-| See [`M3e.Component.ListItem.TrailingSlot`](M3e.Component.ListItem#TrailingSlot).
-}
type alias TrailingSlot =
    Orig.TrailingSlot


{-| See [`M3e.Component.ListItem.ChildAdmittedBy`](M3e.Component.ListItem#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm


{-| See [`M3e.Component.ListItem.leading`](M3e.Component.ListItem#leading).
-}
leading : Element LeadingSlot admittedBy msg -> Element free freeAdmittedBy msg
leading =
    Orig.leading


{-| See [`M3e.Component.ListItem.overline`](M3e.Component.ListItem#overline).
-}
overline : Element OverlineSlot admittedBy msg -> Element free freeAdmittedBy msg
overline =
    Orig.overline


{-| See [`M3e.Component.ListItem.supportingText`](M3e.Component.ListItem#supportingText).
-}
supportingText : Element SupportingTextSlot admittedBy msg -> Element free freeAdmittedBy msg
supportingText =
    Orig.supportingText


{-| See [`M3e.Component.ListItem.trailing`](M3e.Component.ListItem#trailing).
-}
trailing : Element TrailingSlot admittedBy msg -> Element free freeAdmittedBy msg
trailing =
    Orig.trailing


{-| See [`M3e.Component.ListItem.child`](M3e.Component.ListItem#child).
-}
child : Element Content admittedBy msg -> Element free freeAdmittedBy msg
child =
    Orig.child
