module M3e.Family.Tabs exposing (el, Is, Attrs, Content, NextIconSlot, PanelSlot, PrevIconSlot, ChildAdmittedBy, DisablePagination, disablePagination, HeaderPosition, headerPosition, Variant, variant, nextPageLabel, previousPageLabel, stretch, onChange, onBeforeinput, onInput, nextIcon, panel, prevIcon, child)

{-| The **Tabs** family root — re-export of `M3e.Component.Tabs`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.Tabs`](M3e.Component.Tabs) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, Content, NextIconSlot, PanelSlot, PrevIconSlot, ChildAdmittedBy, DisablePagination, disablePagination, HeaderPosition, headerPosition, Variant, variant, nextPageLabel, previousPageLabel, stretch, onChange, onBeforeinput, onInput, nextIcon, panel, prevIcon, child

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Value exposing (Value)
import M3e.Component.Tabs as Orig


{-| See [`M3e.Component.Tabs.el`](M3e.Component.Tabs#el).
-}
el :
    List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.Tabs.Is`](M3e.Component.Tabs#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.Tabs.Attrs`](M3e.Component.Tabs#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.Tabs.Content`](M3e.Component.Tabs#Content).
-}
type alias Content =
    Orig.Content


{-| See [`M3e.Component.Tabs.NextIconSlot`](M3e.Component.Tabs#NextIconSlot).
-}
type alias NextIconSlot =
    Orig.NextIconSlot


{-| See [`M3e.Component.Tabs.PanelSlot`](M3e.Component.Tabs#PanelSlot).
-}
type alias PanelSlot =
    Orig.PanelSlot


{-| See [`M3e.Component.Tabs.PrevIconSlot`](M3e.Component.Tabs#PrevIconSlot).
-}
type alias PrevIconSlot =
    Orig.PrevIconSlot


{-| See [`M3e.Component.Tabs.ChildAdmittedBy`](M3e.Component.Tabs#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm


{-| See [`M3e.Component.Tabs.DisablePagination`](M3e.Component.Tabs#DisablePagination).
-}
type alias DisablePagination =
    Orig.DisablePagination


{-| See [`M3e.Component.Tabs.disablePagination`](M3e.Component.Tabs#disablePagination).
-}
disablePagination : Value DisablePagination -> Attr { c | disablePagination : Supported } msg
disablePagination =
    Orig.disablePagination


{-| See [`M3e.Component.Tabs.HeaderPosition`](M3e.Component.Tabs#HeaderPosition).
-}
type alias HeaderPosition =
    Orig.HeaderPosition


{-| See [`M3e.Component.Tabs.headerPosition`](M3e.Component.Tabs#headerPosition).
-}
headerPosition : Value HeaderPosition -> Attr { c | headerPosition : Supported } msg
headerPosition =
    Orig.headerPosition


{-| See [`M3e.Component.Tabs.Variant`](M3e.Component.Tabs#Variant).
-}
type alias Variant =
    Orig.Variant


{-| See [`M3e.Component.Tabs.variant`](M3e.Component.Tabs#variant).
-}
variant : Value Variant -> Attr { c | variant : Supported } msg
variant =
    Orig.variant


{-| See [`M3e.Component.Tabs.nextPageLabel`](M3e.Component.Tabs#nextPageLabel).
-}
nextPageLabel : String -> Attr { c | nextPageLabel : Supported } msg
nextPageLabel =
    Orig.nextPageLabel


{-| See [`M3e.Component.Tabs.previousPageLabel`](M3e.Component.Tabs#previousPageLabel).
-}
previousPageLabel : String -> Attr { c | previousPageLabel : Supported } msg
previousPageLabel =
    Orig.previousPageLabel


{-| See [`M3e.Component.Tabs.stretch`](M3e.Component.Tabs#stretch).
-}
stretch : Bool -> Attr { c | stretch : Supported } msg
stretch =
    Orig.stretch


{-| See [`M3e.Component.Tabs.onChange`](M3e.Component.Tabs#onChange).
-}
onChange : msg -> Attr { c | onChange : Supported } msg
onChange =
    Orig.onChange


{-| See [`M3e.Component.Tabs.onBeforeinput`](M3e.Component.Tabs#onBeforeinput).
-}
onBeforeinput : msg -> Attr { c | onBeforeinput : Supported } msg
onBeforeinput =
    Orig.onBeforeinput


{-| See [`M3e.Component.Tabs.onInput`](M3e.Component.Tabs#onInput).
-}
onInput : msg -> Attr { c | onInput : Supported } msg
onInput =
    Orig.onInput


{-| See [`M3e.Component.Tabs.nextIcon`](M3e.Component.Tabs#nextIcon).
-}
nextIcon : Element NextIconSlot admittedBy msg -> Element free freeAdmittedBy msg
nextIcon =
    Orig.nextIcon


{-| See [`M3e.Component.Tabs.panel`](M3e.Component.Tabs#panel).
-}
panel : Element PanelSlot admittedBy msg -> Element free freeAdmittedBy msg
panel =
    Orig.panel


{-| See [`M3e.Component.Tabs.prevIcon`](M3e.Component.Tabs#prevIcon).
-}
prevIcon : Element PrevIconSlot admittedBy msg -> Element free freeAdmittedBy msg
prevIcon =
    Orig.prevIcon


{-| See [`M3e.Component.Tabs.child`](M3e.Component.Tabs#child).
-}
child : Element Content admittedBy msg -> Element free freeAdmittedBy msg
child =
    Orig.child
