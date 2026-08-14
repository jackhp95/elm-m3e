module M3e.Family.Calendar exposing (el, Is, Attrs, ChildAdmittedBy, StartView, startView, date, maxDate, minDate, nextMonthLabel, nextMultiYearLabel, nextYearLabel, previousMonthLabel, previousMultiYearLabel, previousYearLabel, rangeEnd, rangeStart, startAt, onChange, header)

{-| The **Calendar** family root — re-export of `M3e.Component.Calendar`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.Calendar`](M3e.Component.Calendar) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, ChildAdmittedBy, StartView, startView, date, maxDate, minDate, nextMonthLabel, nextMultiYearLabel, nextYearLabel, previousMonthLabel, previousMultiYearLabel, previousYearLabel, rangeEnd, rangeStart, startAt, onChange, header

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Value exposing (Value)
import M3e.Component.Calendar as Orig


{-| See [`M3e.Component.Calendar.el`](M3e.Component.Calendar#el).
-}
el :
    List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.Calendar.Is`](M3e.Component.Calendar#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.Calendar.Attrs`](M3e.Component.Calendar#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.Calendar.ChildAdmittedBy`](M3e.Component.Calendar#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm


{-| See [`M3e.Component.Calendar.StartView`](M3e.Component.Calendar#StartView).
-}
type alias StartView =
    Orig.StartView


{-| See [`M3e.Component.Calendar.startView`](M3e.Component.Calendar#startView).
-}
startView : Value StartView -> Attr { c | startView : Supported } msg
startView =
    Orig.startView


{-| See [`M3e.Component.Calendar.date`](M3e.Component.Calendar#date).
-}
date : String -> Attr { c | date : Supported } msg
date =
    Orig.date


{-| See [`M3e.Component.Calendar.maxDate`](M3e.Component.Calendar#maxDate).
-}
maxDate : String -> Attr { c | maxDate : Supported } msg
maxDate =
    Orig.maxDate


{-| See [`M3e.Component.Calendar.minDate`](M3e.Component.Calendar#minDate).
-}
minDate : String -> Attr { c | minDate : Supported } msg
minDate =
    Orig.minDate


{-| See [`M3e.Component.Calendar.nextMonthLabel`](M3e.Component.Calendar#nextMonthLabel).
-}
nextMonthLabel : String -> Attr { c | nextMonthLabel : Supported } msg
nextMonthLabel =
    Orig.nextMonthLabel


{-| See [`M3e.Component.Calendar.nextMultiYearLabel`](M3e.Component.Calendar#nextMultiYearLabel).
-}
nextMultiYearLabel : String -> Attr { c | nextMultiYearLabel : Supported } msg
nextMultiYearLabel =
    Orig.nextMultiYearLabel


{-| See [`M3e.Component.Calendar.nextYearLabel`](M3e.Component.Calendar#nextYearLabel).
-}
nextYearLabel : String -> Attr { c | nextYearLabel : Supported } msg
nextYearLabel =
    Orig.nextYearLabel


{-| See [`M3e.Component.Calendar.previousMonthLabel`](M3e.Component.Calendar#previousMonthLabel).
-}
previousMonthLabel : String -> Attr { c | previousMonthLabel : Supported } msg
previousMonthLabel =
    Orig.previousMonthLabel


{-| See [`M3e.Component.Calendar.previousMultiYearLabel`](M3e.Component.Calendar#previousMultiYearLabel).
-}
previousMultiYearLabel : String -> Attr { c | previousMultiYearLabel : Supported } msg
previousMultiYearLabel =
    Orig.previousMultiYearLabel


{-| See [`M3e.Component.Calendar.previousYearLabel`](M3e.Component.Calendar#previousYearLabel).
-}
previousYearLabel : String -> Attr { c | previousYearLabel : Supported } msg
previousYearLabel =
    Orig.previousYearLabel


{-| See [`M3e.Component.Calendar.rangeEnd`](M3e.Component.Calendar#rangeEnd).
-}
rangeEnd : String -> Attr { c | rangeEnd : Supported } msg
rangeEnd =
    Orig.rangeEnd


{-| See [`M3e.Component.Calendar.rangeStart`](M3e.Component.Calendar#rangeStart).
-}
rangeStart : String -> Attr { c | rangeStart : Supported } msg
rangeStart =
    Orig.rangeStart


{-| See [`M3e.Component.Calendar.startAt`](M3e.Component.Calendar#startAt).
-}
startAt : String -> Attr { c | startAt : Supported } msg
startAt =
    Orig.startAt


{-| See [`M3e.Component.Calendar.onChange`](M3e.Component.Calendar#onChange).
-}
onChange : (String -> msg) -> Attr { c | onChange : Supported } msg
onChange =
    Orig.onChange


{-| See [`M3e.Component.Calendar.header`](M3e.Component.Calendar#header).
-}
header : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
header =
    Orig.header
