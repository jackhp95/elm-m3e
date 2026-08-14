module M3e.Family.Stepper.Previous exposing (el, Is, Attrs, ChildAdmittedBy, child)

{-| `StepperPrevious`, grouped under the **Stepper** family as `Previous`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.StepperPrevious`](M3e.Component.StepperPrevious) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, ChildAdmittedBy, child

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import M3e.Component.StepperPrevious as Orig


{-| See [`M3e.Component.StepperPrevious.el`](M3e.Component.StepperPrevious#el).
-}
el :
    List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.StepperPrevious.Is`](M3e.Component.StepperPrevious#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.StepperPrevious.Attrs`](M3e.Component.StepperPrevious#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.StepperPrevious.ChildAdmittedBy`](M3e.Component.StepperPrevious#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm


{-| See [`M3e.Component.StepperPrevious.child`](M3e.Component.StepperPrevious#child).
-}
child : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
child =
    Orig.child
