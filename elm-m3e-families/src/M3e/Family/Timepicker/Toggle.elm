module M3e.Family.Timepicker.Toggle exposing (el, Is, Attrs, ChildAdmittedBy)

{-| `TimepickerToggle`, grouped under the **Timepicker** family as `Toggle`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.TimepickerToggle`](M3e.Component.TimepickerToggle) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, ChildAdmittedBy

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import M3e.Component.TimepickerToggle as Orig


{-| See [`M3e.Component.TimepickerToggle.el`](M3e.Component.TimepickerToggle#el).
-}
el :
    { for : String }
    -> List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.TimepickerToggle.Is`](M3e.Component.TimepickerToggle#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.TimepickerToggle.Attrs`](M3e.Component.TimepickerToggle#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.TimepickerToggle.ChildAdmittedBy`](M3e.Component.TimepickerToggle#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm
