module M3e.Family.Datepicker exposing (el, Is, Attrs, ChildAdmittedBy, StartView, startView, Variant, variant, clearLabel, clearable, confirmLabel, date, dismissLabel, for, label, maxDate, minDate, nextMonthLabel, nextMultiYearLabel, nextYearLabel, previousMonthLabel, previousMultiYearLabel, previousYearLabel, range, rangeEnd, rangeStart, startAt, onChange, onBeforetoggle, onToggle)

{-| The **Datepicker** family root — re-export of `M3e.Component.Datepicker`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.Datepicker`](M3e.Component.Datepicker) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, ChildAdmittedBy, StartView, startView, Variant, variant, clearLabel, clearable, confirmLabel, date, dismissLabel, for, label, maxDate, minDate, nextMonthLabel, nextMultiYearLabel, nextYearLabel, previousMonthLabel, previousMultiYearLabel, previousYearLabel, range, rangeEnd, rangeStart, startAt, onChange, onBeforetoggle, onToggle

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Value exposing (Value)
import M3e.Component.Datepicker as Orig


{-| See [`M3e.Component.Datepicker.el`](M3e.Component.Datepicker#el).
-}
el :
    List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.Datepicker.Is`](M3e.Component.Datepicker#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.Datepicker.Attrs`](M3e.Component.Datepicker#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.Datepicker.ChildAdmittedBy`](M3e.Component.Datepicker#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm


{-| See [`M3e.Component.Datepicker.StartView`](M3e.Component.Datepicker#StartView).
-}
type alias StartView =
    Orig.StartView


{-| See [`M3e.Component.Datepicker.startView`](M3e.Component.Datepicker#startView).
-}
startView : Value StartView -> Attr { c | startView : Supported } msg
startView =
    Orig.startView


{-| See [`M3e.Component.Datepicker.Variant`](M3e.Component.Datepicker#Variant).
-}
type alias Variant =
    Orig.Variant


{-| See [`M3e.Component.Datepicker.variant`](M3e.Component.Datepicker#variant).
-}
variant : Value Variant -> Attr { c | variant : Supported } msg
variant =
    Orig.variant


{-| See [`M3e.Component.Datepicker.clearLabel`](M3e.Component.Datepicker#clearLabel).
-}
clearLabel : String -> Attr { c | clearLabel : Supported } msg
clearLabel =
    Orig.clearLabel


{-| See [`M3e.Component.Datepicker.clearable`](M3e.Component.Datepicker#clearable).
-}
clearable : Bool -> Attr { c | clearable : Supported } msg
clearable =
    Orig.clearable


{-| See [`M3e.Component.Datepicker.confirmLabel`](M3e.Component.Datepicker#confirmLabel).
-}
confirmLabel : String -> Attr { c | confirmLabel : Supported } msg
confirmLabel =
    Orig.confirmLabel


{-| See [`M3e.Component.Datepicker.date`](M3e.Component.Datepicker#date).
-}
date : String -> Attr { c | date : Supported } msg
date =
    Orig.date


{-| See [`M3e.Component.Datepicker.dismissLabel`](M3e.Component.Datepicker#dismissLabel).
-}
dismissLabel : String -> Attr { c | dismissLabel : Supported } msg
dismissLabel =
    Orig.dismissLabel


{-| See [`M3e.Component.Datepicker.for`](M3e.Component.Datepicker#for).
-}
for : String -> Attr { c | for : Supported } msg
for =
    Orig.for


{-| See [`M3e.Component.Datepicker.label`](M3e.Component.Datepicker#label).
-}
label : String -> Attr { c | label : Supported } msg
label =
    Orig.label


{-| See [`M3e.Component.Datepicker.maxDate`](M3e.Component.Datepicker#maxDate).
-}
maxDate : String -> Attr { c | maxDate : Supported } msg
maxDate =
    Orig.maxDate


{-| See [`M3e.Component.Datepicker.minDate`](M3e.Component.Datepicker#minDate).
-}
minDate : String -> Attr { c | minDate : Supported } msg
minDate =
    Orig.minDate


{-| See [`M3e.Component.Datepicker.nextMonthLabel`](M3e.Component.Datepicker#nextMonthLabel).
-}
nextMonthLabel : String -> Attr { c | nextMonthLabel : Supported } msg
nextMonthLabel =
    Orig.nextMonthLabel


{-| See [`M3e.Component.Datepicker.nextMultiYearLabel`](M3e.Component.Datepicker#nextMultiYearLabel).
-}
nextMultiYearLabel : String -> Attr { c | nextMultiYearLabel : Supported } msg
nextMultiYearLabel =
    Orig.nextMultiYearLabel


{-| See [`M3e.Component.Datepicker.nextYearLabel`](M3e.Component.Datepicker#nextYearLabel).
-}
nextYearLabel : String -> Attr { c | nextYearLabel : Supported } msg
nextYearLabel =
    Orig.nextYearLabel


{-| See [`M3e.Component.Datepicker.previousMonthLabel`](M3e.Component.Datepicker#previousMonthLabel).
-}
previousMonthLabel : String -> Attr { c | previousMonthLabel : Supported } msg
previousMonthLabel =
    Orig.previousMonthLabel


{-| See [`M3e.Component.Datepicker.previousMultiYearLabel`](M3e.Component.Datepicker#previousMultiYearLabel).
-}
previousMultiYearLabel : String -> Attr { c | previousMultiYearLabel : Supported } msg
previousMultiYearLabel =
    Orig.previousMultiYearLabel


{-| See [`M3e.Component.Datepicker.previousYearLabel`](M3e.Component.Datepicker#previousYearLabel).
-}
previousYearLabel : String -> Attr { c | previousYearLabel : Supported } msg
previousYearLabel =
    Orig.previousYearLabel


{-| See [`M3e.Component.Datepicker.range`](M3e.Component.Datepicker#range).
-}
range : Bool -> Attr { c | range : Supported } msg
range =
    Orig.range


{-| See [`M3e.Component.Datepicker.rangeEnd`](M3e.Component.Datepicker#rangeEnd).
-}
rangeEnd : String -> Attr { c | rangeEnd : Supported } msg
rangeEnd =
    Orig.rangeEnd


{-| See [`M3e.Component.Datepicker.rangeStart`](M3e.Component.Datepicker#rangeStart).
-}
rangeStart : String -> Attr { c | rangeStart : Supported } msg
rangeStart =
    Orig.rangeStart


{-| See [`M3e.Component.Datepicker.startAt`](M3e.Component.Datepicker#startAt).
-}
startAt : String -> Attr { c | startAt : Supported } msg
startAt =
    Orig.startAt


{-| See [`M3e.Component.Datepicker.onChange`](M3e.Component.Datepicker#onChange).
-}
onChange : (String -> msg) -> Attr { c | onChange : Supported } msg
onChange =
    Orig.onChange


{-| See [`M3e.Component.Datepicker.onBeforetoggle`](M3e.Component.Datepicker#onBeforetoggle).
-}
onBeforetoggle : msg -> Attr { c | onBeforetoggle : Supported } msg
onBeforetoggle =
    Orig.onBeforetoggle


{-| See [`M3e.Component.Datepicker.onToggle`](M3e.Component.Datepicker#onToggle).
-}
onToggle : msg -> Attr { c | onToggle : Supported } msg
onToggle =
    Orig.onToggle
