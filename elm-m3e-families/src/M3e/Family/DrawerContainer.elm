module M3e.Family.DrawerContainer exposing (DrawerContainerIs, DrawerContainerAttrs, DrawerContainerChildAdmittedBy, DrawerContainerEndMode, DrawerContainerStartMode, ToggleIs, ToggleAttrs, ToggleChildAdmittedBy, drawerContainer, drawerContainerEndMode, drawerContainerStartMode, drawerContainerEndDivider, drawerContainerStartDivider, drawerContainerOnChange, drawerContainerEnd, drawerContainerStart, drawerContainerChild, toggle)

{-| The **DrawerContainer** family — flat module re-exporting its member elements.

This is the **flat family module** for this family: one module carrying every
member element as an element-named constructor (delegating to that component's
`component` ctor), with element-prefixed type aliases and element-prefixed
typed helpers so members never collide. It re-exports:

[`M3e.Component.DrawerContainer`](M3e.Component.DrawerContainer) as `drawerContainer`, [`M3e.Component.DrawerToggle`](M3e.Component.DrawerToggle) as `toggle`.

Prefer whichever import reads best — the flat `M3e.Component.*` modules and
this family module are the same elements, same types.

@docs DrawerContainerIs, DrawerContainerAttrs, DrawerContainerChildAdmittedBy, DrawerContainerEndMode, DrawerContainerStartMode, ToggleIs, ToggleAttrs, ToggleChildAdmittedBy, drawerContainer, drawerContainerEndMode, drawerContainerStartMode, drawerContainerEndDivider, drawerContainerStartDivider, drawerContainerOnChange, drawerContainerEnd, drawerContainerStart, drawerContainerChild, toggle

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Value exposing (Value)
import M3e.Component.DrawerContainer as DrawerContainer_
import M3e.Component.DrawerToggle as Toggle_


{-| The `drawerContainer` element of this family — delegates to [`M3e.Component.DrawerContainer.component`](M3e.Component.DrawerContainer#component).
-}
drawerContainer :
    List (Attr DrawerContainerAttrs msg)
    -> List (Element childAccepts (DrawerContainerChildAdmittedBy childAdm) msg)
    -> Element (DrawerContainerIs s) admittedBy msg
drawerContainer =
    DrawerContainer_.component


{-| See [`M3e.Component.DrawerContainer.Is`](M3e.Component.DrawerContainer#Is).
-}
type alias DrawerContainerIs s =
    DrawerContainer_.Is s


{-| See [`M3e.Component.DrawerContainer.Attrs`](M3e.Component.DrawerContainer#Attrs).
-}
type alias DrawerContainerAttrs =
    DrawerContainer_.Attrs


{-| See [`M3e.Component.DrawerContainer.ChildAdmittedBy`](M3e.Component.DrawerContainer#ChildAdmittedBy).
-}
type alias DrawerContainerChildAdmittedBy childAdm =
    DrawerContainer_.ChildAdmittedBy childAdm


{-| See [`M3e.Component.DrawerContainer.EndMode`](M3e.Component.DrawerContainer#EndMode).
-}
type alias DrawerContainerEndMode =
    DrawerContainer_.EndMode


{-| See [`M3e.Component.DrawerContainer.endMode`](M3e.Component.DrawerContainer#endMode).
-}
drawerContainerEndMode : Value DrawerContainerEndMode -> Attr { c | endMode : Supported } msg
drawerContainerEndMode =
    DrawerContainer_.endMode


{-| See [`M3e.Component.DrawerContainer.StartMode`](M3e.Component.DrawerContainer#StartMode).
-}
type alias DrawerContainerStartMode =
    DrawerContainer_.StartMode


{-| See [`M3e.Component.DrawerContainer.startMode`](M3e.Component.DrawerContainer#startMode).
-}
drawerContainerStartMode : Value DrawerContainerStartMode -> Attr { c | startMode : Supported } msg
drawerContainerStartMode =
    DrawerContainer_.startMode


{-| See [`M3e.Component.DrawerContainer.endDivider`](M3e.Component.DrawerContainer#endDivider).
-}
drawerContainerEndDivider : Bool -> Attr { c | endDivider : Supported } msg
drawerContainerEndDivider =
    DrawerContainer_.endDivider


{-| See [`M3e.Component.DrawerContainer.startDivider`](M3e.Component.DrawerContainer#startDivider).
-}
drawerContainerStartDivider : Bool -> Attr { c | startDivider : Supported } msg
drawerContainerStartDivider =
    DrawerContainer_.startDivider


{-| See [`M3e.Component.DrawerContainer.onChange`](M3e.Component.DrawerContainer#onChange).
-}
drawerContainerOnChange : msg -> Attr { c | onChange : Supported } msg
drawerContainerOnChange =
    DrawerContainer_.onChange


{-| See [`M3e.Component.DrawerContainer.end`](M3e.Component.DrawerContainer#end).
-}
drawerContainerEnd : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
drawerContainerEnd =
    DrawerContainer_.end


{-| See [`M3e.Component.DrawerContainer.start`](M3e.Component.DrawerContainer#start).
-}
drawerContainerStart : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
drawerContainerStart =
    DrawerContainer_.start


{-| See [`M3e.Component.DrawerContainer.child`](M3e.Component.DrawerContainer#child).
-}
drawerContainerChild : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
drawerContainerChild =
    DrawerContainer_.child


{-| The `toggle` element of this family — delegates to [`M3e.Component.DrawerToggle.component`](M3e.Component.DrawerToggle#component).
-}
toggle :
    { for : String }
    -> List (Attr ToggleAttrs msg)
    -> List (Element childAccepts (ToggleChildAdmittedBy childAdm) msg)
    -> Element (ToggleIs s) admittedBy msg
toggle =
    Toggle_.component


{-| See [`M3e.Component.DrawerToggle.Is`](M3e.Component.DrawerToggle#Is).
-}
type alias ToggleIs s =
    Toggle_.Is s


{-| See [`M3e.Component.DrawerToggle.Attrs`](M3e.Component.DrawerToggle#Attrs).
-}
type alias ToggleAttrs =
    Toggle_.Attrs


{-| See [`M3e.Component.DrawerToggle.ChildAdmittedBy`](M3e.Component.DrawerToggle#ChildAdmittedBy).
-}
type alias ToggleChildAdmittedBy childAdm =
    Toggle_.ChildAdmittedBy childAdm
