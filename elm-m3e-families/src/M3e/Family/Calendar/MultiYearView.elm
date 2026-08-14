module M3e.Family.Calendar.MultiYearView exposing (el, Is, Attrs, ChildAdmittedBy, active, activeDate, date, maxDate, minDate, today, onChange, onActiveChange)

{-| `MultiYearView`, grouped under the **Calendar** family as `MultiYearView`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.MultiYearView`](M3e.Component.MultiYearView) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, ChildAdmittedBy, active, activeDate, date, maxDate, minDate, today, onChange, onActiveChange

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Kind exposing (Shared, Supported)
import M3e.Component.MultiYearView as Orig


{-| See [`M3e.Component.MultiYearView.el`](M3e.Component.MultiYearView#el).
-}
el :
    List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.MultiYearView.Is`](M3e.Component.MultiYearView#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.MultiYearView.Attrs`](M3e.Component.MultiYearView#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.MultiYearView.ChildAdmittedBy`](M3e.Component.MultiYearView#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm


{-| See [`M3e.Component.MultiYearView.active`](M3e.Component.MultiYearView#active).
-}
active : Bool -> Attr { c | active : Supported } msg
active =
    Orig.active


{-| See [`M3e.Component.MultiYearView.activeDate`](M3e.Component.MultiYearView#activeDate).
-}
activeDate : String -> Attr { c | activeDate : Supported } msg
activeDate =
    Orig.activeDate


{-| See [`M3e.Component.MultiYearView.date`](M3e.Component.MultiYearView#date).
-}
date : String -> Attr { c | date : Supported } msg
date =
    Orig.date


{-| See [`M3e.Component.MultiYearView.maxDate`](M3e.Component.MultiYearView#maxDate).
-}
maxDate : String -> Attr { c | maxDate : Supported } msg
maxDate =
    Orig.maxDate


{-| See [`M3e.Component.MultiYearView.minDate`](M3e.Component.MultiYearView#minDate).
-}
minDate : String -> Attr { c | minDate : Supported } msg
minDate =
    Orig.minDate


{-| See [`M3e.Component.MultiYearView.today`](M3e.Component.MultiYearView#today).
-}
today : String -> Attr { c | today : Supported } msg
today =
    Orig.today


{-| See [`M3e.Component.MultiYearView.onChange`](M3e.Component.MultiYearView#onChange).
-}
onChange : msg -> Attr { c | onChange : Supported } msg
onChange =
    Orig.onChange


{-| See [`M3e.Component.MultiYearView.onActiveChange`](M3e.Component.MultiYearView#onActiveChange).
-}
onActiveChange : msg -> Attr { c | onActiveChange : Supported } msg
onActiveChange =
    Orig.onActiveChange
