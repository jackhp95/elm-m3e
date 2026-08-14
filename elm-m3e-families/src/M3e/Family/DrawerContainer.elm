module M3e.Family.DrawerContainer exposing (el, Is, Attrs, ChildAdmittedBy, EndMode, endMode, StartMode, startMode, endDivider, startDivider, onChange, end, start, child)

{-| The **DrawerContainer** family root — re-export of `M3e.Component.DrawerContainer`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.DrawerContainer`](M3e.Component.DrawerContainer) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, ChildAdmittedBy, EndMode, endMode, StartMode, startMode, endDivider, startDivider, onChange, end, start, child

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Value exposing (Value)
import M3e.Component.DrawerContainer as Orig


{-| See [`M3e.Component.DrawerContainer.el`](M3e.Component.DrawerContainer#el).
-}
el :
    List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.DrawerContainer.Is`](M3e.Component.DrawerContainer#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.DrawerContainer.Attrs`](M3e.Component.DrawerContainer#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.DrawerContainer.ChildAdmittedBy`](M3e.Component.DrawerContainer#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm


{-| See [`M3e.Component.DrawerContainer.EndMode`](M3e.Component.DrawerContainer#EndMode).
-}
type alias EndMode =
    Orig.EndMode


{-| See [`M3e.Component.DrawerContainer.endMode`](M3e.Component.DrawerContainer#endMode).
-}
endMode : Value EndMode -> Attr { c | endMode : Supported } msg
endMode =
    Orig.endMode


{-| See [`M3e.Component.DrawerContainer.StartMode`](M3e.Component.DrawerContainer#StartMode).
-}
type alias StartMode =
    Orig.StartMode


{-| See [`M3e.Component.DrawerContainer.startMode`](M3e.Component.DrawerContainer#startMode).
-}
startMode : Value StartMode -> Attr { c | startMode : Supported } msg
startMode =
    Orig.startMode


{-| See [`M3e.Component.DrawerContainer.endDivider`](M3e.Component.DrawerContainer#endDivider).
-}
endDivider : Bool -> Attr { c | endDivider : Supported } msg
endDivider =
    Orig.endDivider


{-| See [`M3e.Component.DrawerContainer.startDivider`](M3e.Component.DrawerContainer#startDivider).
-}
startDivider : Bool -> Attr { c | startDivider : Supported } msg
startDivider =
    Orig.startDivider


{-| See [`M3e.Component.DrawerContainer.onChange`](M3e.Component.DrawerContainer#onChange).
-}
onChange : msg -> Attr { c | onChange : Supported } msg
onChange =
    Orig.onChange


{-| See [`M3e.Component.DrawerContainer.end`](M3e.Component.DrawerContainer#end).
-}
end : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
end =
    Orig.end


{-| See [`M3e.Component.DrawerContainer.start`](M3e.Component.DrawerContainer#start).
-}
start : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
start =
    Orig.start


{-| See [`M3e.Component.DrawerContainer.child`](M3e.Component.DrawerContainer#child).
-}
child : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
child =
    Orig.child
