module M3e.Family.Stepper.Reset exposing (el, Is, Attrs, ChildAdmittedBy, child)

{-| `StepperReset`, grouped under the **Stepper** family as `Reset`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.StepperReset`](M3e.Component.StepperReset) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, ChildAdmittedBy, child

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import M3e.Component.StepperReset as Orig


{-| See [`M3e.Component.StepperReset.el`](M3e.Component.StepperReset#el).
-}
el :
    List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.StepperReset.Is`](M3e.Component.StepperReset#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.StepperReset.Attrs`](M3e.Component.StepperReset#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.StepperReset.ChildAdmittedBy`](M3e.Component.StepperReset#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm


{-| See [`M3e.Component.StepperReset.child`](M3e.Component.StepperReset#child).
-}
child : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
child =
    Orig.child
