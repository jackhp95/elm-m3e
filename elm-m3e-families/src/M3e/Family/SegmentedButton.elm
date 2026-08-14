module M3e.Family.SegmentedButton exposing (el, Is, Attrs, Content, ChildAdmittedBy, disabled, hideSelectionIndicator, multi, name, onChange, onBeforeinput, onInput, child)

{-| The **SegmentedButton** family root — re-export of `M3e.Component.SegmentedButton`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.SegmentedButton`](M3e.Component.SegmentedButton) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, Content, ChildAdmittedBy, disabled, hideSelectionIndicator, multi, name, onChange, onBeforeinput, onInput, child

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Kind exposing (Shared, Supported)
import M3e.Component.SegmentedButton as Orig


{-| See [`M3e.Component.SegmentedButton.el`](M3e.Component.SegmentedButton#el).
-}
el :
    { content : Element Content (ChildAdmittedBy childAdm) msg }
    -> List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.SegmentedButton.Is`](M3e.Component.SegmentedButton#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.SegmentedButton.Attrs`](M3e.Component.SegmentedButton#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.SegmentedButton.Content`](M3e.Component.SegmentedButton#Content).
-}
type alias Content =
    Orig.Content


{-| See [`M3e.Component.SegmentedButton.ChildAdmittedBy`](M3e.Component.SegmentedButton#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm


{-| See [`M3e.Component.SegmentedButton.disabled`](M3e.Component.SegmentedButton#disabled).
-}
disabled : Bool -> Attr { c | disabled : Supported } msg
disabled =
    Orig.disabled


{-| See [`M3e.Component.SegmentedButton.hideSelectionIndicator`](M3e.Component.SegmentedButton#hideSelectionIndicator).
-}
hideSelectionIndicator : Bool -> Attr { c | hideSelectionIndicator : Supported } msg
hideSelectionIndicator =
    Orig.hideSelectionIndicator


{-| See [`M3e.Component.SegmentedButton.multi`](M3e.Component.SegmentedButton#multi).
-}
multi : Bool -> Attr { c | multi : Supported } msg
multi =
    Orig.multi


{-| See [`M3e.Component.SegmentedButton.name`](M3e.Component.SegmentedButton#name).
-}
name : String -> Attr { c | name : Supported } msg
name =
    Orig.name


{-| See [`M3e.Component.SegmentedButton.onChange`](M3e.Component.SegmentedButton#onChange).
-}
onChange : msg -> Attr { c | onChange : Supported } msg
onChange =
    Orig.onChange


{-| See [`M3e.Component.SegmentedButton.onBeforeinput`](M3e.Component.SegmentedButton#onBeforeinput).
-}
onBeforeinput : msg -> Attr { c | onBeforeinput : Supported } msg
onBeforeinput =
    Orig.onBeforeinput


{-| See [`M3e.Component.SegmentedButton.onInput`](M3e.Component.SegmentedButton#onInput).
-}
onInput : msg -> Attr { c | onInput : Supported } msg
onInput =
    Orig.onInput


{-| See [`M3e.Component.SegmentedButton.child`](M3e.Component.SegmentedButton#child).
-}
child : Element Content admittedBy msg -> Element free freeAdmittedBy msg
child =
    Orig.child
