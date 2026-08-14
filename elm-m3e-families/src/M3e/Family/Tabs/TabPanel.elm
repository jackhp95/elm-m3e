module M3e.Family.Tabs.TabPanel exposing (el, Is, Attrs, ChildAdmittedBy, child)

{-| `TabPanel`, grouped under the **Tabs** family as `TabPanel`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.TabPanel`](M3e.Component.TabPanel) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, ChildAdmittedBy, child

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import M3e.Component.TabPanel as Orig


{-| See [`M3e.Component.TabPanel.el`](M3e.Component.TabPanel#el).
-}
el :
    List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.TabPanel.Is`](M3e.Component.TabPanel#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.TabPanel.Attrs`](M3e.Component.TabPanel#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.TabPanel.ChildAdmittedBy`](M3e.Component.TabPanel#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm


{-| See [`M3e.Component.TabPanel.child`](M3e.Component.TabPanel#child).
-}
child : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
child =
    Orig.child
