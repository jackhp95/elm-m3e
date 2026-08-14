module M3e.Family.Datepicker.Toggle exposing (el, Is, Attrs, ChildAdmittedBy)

{-| `DatepickerToggle`, grouped under the **Datepicker** family as `Toggle`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.DatepickerToggle`](M3e.Component.DatepickerToggle) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, ChildAdmittedBy

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import M3e.Component.DatepickerToggle as Orig


{-| See [`M3e.Component.DatepickerToggle.el`](M3e.Component.DatepickerToggle#el).
-}
el :
    { for : String }
    -> List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.DatepickerToggle.Is`](M3e.Component.DatepickerToggle#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.DatepickerToggle.Attrs`](M3e.Component.DatepickerToggle#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.DatepickerToggle.ChildAdmittedBy`](M3e.Component.DatepickerToggle#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm
