module M3e.Family.Chip.FilterSet exposing (el, Is, Attrs, Content, ChildAdmittedBy, disabled, hideSelectionIndicator, multi, name, vertical, onChange, onBeforeinput, onInput, child)

{-| `FilterChipSet`, grouped under the **Chip** family as `FilterSet`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.FilterChipSet`](M3e.Component.FilterChipSet) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, Content, ChildAdmittedBy, disabled, hideSelectionIndicator, multi, name, vertical, onChange, onBeforeinput, onInput, child

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Kind exposing (Shared, Supported)
import M3e.Component.FilterChipSet as Orig


{-| See [`M3e.Component.FilterChipSet.el`](M3e.Component.FilterChipSet#el).
-}
el :
    List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.FilterChipSet.Is`](M3e.Component.FilterChipSet#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.FilterChipSet.Attrs`](M3e.Component.FilterChipSet#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.FilterChipSet.Content`](M3e.Component.FilterChipSet#Content).
-}
type alias Content =
    Orig.Content


{-| See [`M3e.Component.FilterChipSet.ChildAdmittedBy`](M3e.Component.FilterChipSet#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm


{-| See [`M3e.Component.FilterChipSet.disabled`](M3e.Component.FilterChipSet#disabled).
-}
disabled : Bool -> Attr { c | disabled : Supported } msg
disabled =
    Orig.disabled


{-| See [`M3e.Component.FilterChipSet.hideSelectionIndicator`](M3e.Component.FilterChipSet#hideSelectionIndicator).
-}
hideSelectionIndicator : Bool -> Attr { c | hideSelectionIndicator : Supported } msg
hideSelectionIndicator =
    Orig.hideSelectionIndicator


{-| See [`M3e.Component.FilterChipSet.multi`](M3e.Component.FilterChipSet#multi).
-}
multi : Bool -> Attr { c | multi : Supported } msg
multi =
    Orig.multi


{-| See [`M3e.Component.FilterChipSet.name`](M3e.Component.FilterChipSet#name).
-}
name : String -> Attr { c | name : Supported } msg
name =
    Orig.name


{-| See [`M3e.Component.FilterChipSet.vertical`](M3e.Component.FilterChipSet#vertical).
-}
vertical : Bool -> Attr { c | vertical : Supported } msg
vertical =
    Orig.vertical


{-| See [`M3e.Component.FilterChipSet.onChange`](M3e.Component.FilterChipSet#onChange).
-}
onChange : msg -> Attr { c | onChange : Supported } msg
onChange =
    Orig.onChange


{-| See [`M3e.Component.FilterChipSet.onBeforeinput`](M3e.Component.FilterChipSet#onBeforeinput).
-}
onBeforeinput : msg -> Attr { c | onBeforeinput : Supported } msg
onBeforeinput =
    Orig.onBeforeinput


{-| See [`M3e.Component.FilterChipSet.onInput`](M3e.Component.FilterChipSet#onInput).
-}
onInput : msg -> Attr { c | onInput : Supported } msg
onInput =
    Orig.onInput


{-| See [`M3e.Component.FilterChipSet.child`](M3e.Component.FilterChipSet#child).
-}
child : Element Content admittedBy msg -> Element free freeAdmittedBy msg
child =
    Orig.child
