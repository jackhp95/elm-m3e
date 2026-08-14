module M3e.Family.Stepper.Panel exposing (el, Is, Attrs, ChildAdmittedBy, actions, child)

{-| `StepPanel`, grouped under the **Stepper** family as `Panel`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.StepPanel`](M3e.Component.StepPanel) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, ChildAdmittedBy, actions, child

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import M3e.Component.StepPanel as Orig


{-| See [`M3e.Component.StepPanel.el`](M3e.Component.StepPanel#el).
-}
el :
    List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.StepPanel.Is`](M3e.Component.StepPanel#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.StepPanel.Attrs`](M3e.Component.StepPanel#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.StepPanel.ChildAdmittedBy`](M3e.Component.StepPanel#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm


{-| See [`M3e.Component.StepPanel.actions`](M3e.Component.StepPanel#actions).
-}
actions : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
actions =
    Orig.actions


{-| See [`M3e.Component.StepPanel.child`](M3e.Component.StepPanel#child).
-}
child : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
child =
    Orig.child
