module M3e.Family.Calendar.MonthView exposing (el, Is, Attrs, ChildAdmittedBy, active, activeDate, date, maxDate, minDate, rangeEnd, rangeStart, today, onChange, onActiveChange)

{-| `MonthView`, grouped under the **Calendar** family as `MonthView`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.MonthView`](M3e.Component.MonthView) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, ChildAdmittedBy, active, activeDate, date, maxDate, minDate, rangeEnd, rangeStart, today, onChange, onActiveChange

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Kind exposing (Shared, Supported)
import M3e.Component.MonthView as Orig


{-| See [`M3e.Component.MonthView.el`](M3e.Component.MonthView#el).
-}
el :
    List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.MonthView.Is`](M3e.Component.MonthView#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.MonthView.Attrs`](M3e.Component.MonthView#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.MonthView.ChildAdmittedBy`](M3e.Component.MonthView#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm


{-| See [`M3e.Component.MonthView.active`](M3e.Component.MonthView#active).
-}
active : Bool -> Attr { c | active : Supported } msg
active =
    Orig.active


{-| See [`M3e.Component.MonthView.activeDate`](M3e.Component.MonthView#activeDate).
-}
activeDate : String -> Attr { c | activeDate : Supported } msg
activeDate =
    Orig.activeDate


{-| See [`M3e.Component.MonthView.date`](M3e.Component.MonthView#date).
-}
date : String -> Attr { c | date : Supported } msg
date =
    Orig.date


{-| See [`M3e.Component.MonthView.maxDate`](M3e.Component.MonthView#maxDate).
-}
maxDate : String -> Attr { c | maxDate : Supported } msg
maxDate =
    Orig.maxDate


{-| See [`M3e.Component.MonthView.minDate`](M3e.Component.MonthView#minDate).
-}
minDate : String -> Attr { c | minDate : Supported } msg
minDate =
    Orig.minDate


{-| See [`M3e.Component.MonthView.rangeEnd`](M3e.Component.MonthView#rangeEnd).
-}
rangeEnd : String -> Attr { c | rangeEnd : Supported } msg
rangeEnd =
    Orig.rangeEnd


{-| See [`M3e.Component.MonthView.rangeStart`](M3e.Component.MonthView#rangeStart).
-}
rangeStart : String -> Attr { c | rangeStart : Supported } msg
rangeStart =
    Orig.rangeStart


{-| See [`M3e.Component.MonthView.today`](M3e.Component.MonthView#today).
-}
today : String -> Attr { c | today : Supported } msg
today =
    Orig.today


{-| See [`M3e.Component.MonthView.onChange`](M3e.Component.MonthView#onChange).
-}
onChange : msg -> Attr { c | onChange : Supported } msg
onChange =
    Orig.onChange


{-| See [`M3e.Component.MonthView.onActiveChange`](M3e.Component.MonthView#onActiveChange).
-}
onActiveChange : msg -> Attr { c | onActiveChange : Supported } msg
onActiveChange =
    Orig.onActiveChange
