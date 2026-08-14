module M3e.Family.Dialog.Trigger exposing (el, Is, Attrs, ChildAdmittedBy)

{-| `DialogTrigger`, grouped under the **Dialog** family as `Trigger`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.DialogTrigger`](M3e.Component.DialogTrigger) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, ChildAdmittedBy

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import M3e.Component.DialogTrigger as Orig


{-| See [`M3e.Component.DialogTrigger.el`](M3e.Component.DialogTrigger#el).
-}
el :
    { for : String }
    -> List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.DialogTrigger.Is`](M3e.Component.DialogTrigger#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.DialogTrigger.Attrs`](M3e.Component.DialogTrigger#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.DialogTrigger.ChildAdmittedBy`](M3e.Component.DialogTrigger#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm
