module M3e.Family.RichTooltip.Action exposing (el, Is, Attrs, Content, ChildAdmittedBy, disableRestoreFocus, child)

{-| `RichTooltipAction`, grouped under the **RichTooltip** family as `Action`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.RichTooltipAction`](M3e.Component.RichTooltipAction) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, Content, ChildAdmittedBy, disableRestoreFocus, child

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Kind exposing (Shared, Supported)
import M3e.Component.RichTooltipAction as Orig


{-| See [`M3e.Component.RichTooltipAction.el`](M3e.Component.RichTooltipAction#el).
-}
el :
    { content : Element Content (ChildAdmittedBy childAdm) msg }
    -> List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.RichTooltipAction.Is`](M3e.Component.RichTooltipAction#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.RichTooltipAction.Attrs`](M3e.Component.RichTooltipAction#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.RichTooltipAction.Content`](M3e.Component.RichTooltipAction#Content).
-}
type alias Content =
    Orig.Content


{-| See [`M3e.Component.RichTooltipAction.ChildAdmittedBy`](M3e.Component.RichTooltipAction#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm


{-| See [`M3e.Component.RichTooltipAction.disableRestoreFocus`](M3e.Component.RichTooltipAction#disableRestoreFocus).
-}
disableRestoreFocus : Bool -> Attr { c | disableRestoreFocus : Supported } msg
disableRestoreFocus =
    Orig.disableRestoreFocus


{-| See [`M3e.Component.RichTooltipAction.child`](M3e.Component.RichTooltipAction#child).
-}
child : Element Content admittedBy msg -> Element free freeAdmittedBy msg
child =
    Orig.child
