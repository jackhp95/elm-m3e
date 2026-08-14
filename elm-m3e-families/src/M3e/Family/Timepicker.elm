module M3e.Family.Timepicker exposing (el, Is, Attrs, ChildAdmittedBy, Format, format, Mode, mode, Orientation, orientation, Variant, variant, confirmLabel, date, dialLabel, dismissLabel, for, hideModeToggle, hourLabel, inputLabel, maxTime, minTime, minuteLabel, modeToggleLabel, periodToggleLabel, secondLabel, showSeconds, onChange, onBeforetoggle, onToggle)

{-| The **Timepicker** family root — re-export of `M3e.Component.Timepicker`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.Timepicker`](M3e.Component.Timepicker) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, ChildAdmittedBy, Format, format, Mode, mode, Orientation, orientation, Variant, variant, confirmLabel, date, dialLabel, dismissLabel, for, hideModeToggle, hourLabel, inputLabel, maxTime, minTime, minuteLabel, modeToggleLabel, periodToggleLabel, secondLabel, showSeconds, onChange, onBeforetoggle, onToggle

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Value exposing (Value)
import M3e.Component.Timepicker as Orig


{-| See [`M3e.Component.Timepicker.el`](M3e.Component.Timepicker#el).
-}
el :
    List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.Timepicker.Is`](M3e.Component.Timepicker#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.Timepicker.Attrs`](M3e.Component.Timepicker#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.Timepicker.ChildAdmittedBy`](M3e.Component.Timepicker#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm


{-| See [`M3e.Component.Timepicker.Format`](M3e.Component.Timepicker#Format).
-}
type alias Format =
    Orig.Format


{-| See [`M3e.Component.Timepicker.format`](M3e.Component.Timepicker#format).
-}
format : Value Format -> Attr { c | format : Supported } msg
format =
    Orig.format


{-| See [`M3e.Component.Timepicker.Mode`](M3e.Component.Timepicker#Mode).
-}
type alias Mode =
    Orig.Mode


{-| See [`M3e.Component.Timepicker.mode`](M3e.Component.Timepicker#mode).
-}
mode : Value Mode -> Attr { c | mode : Supported } msg
mode =
    Orig.mode


{-| See [`M3e.Component.Timepicker.Orientation`](M3e.Component.Timepicker#Orientation).
-}
type alias Orientation =
    Orig.Orientation


{-| See [`M3e.Component.Timepicker.orientation`](M3e.Component.Timepicker#orientation).
-}
orientation : Value Orientation -> Attr { c | orientation : Supported } msg
orientation =
    Orig.orientation


{-| See [`M3e.Component.Timepicker.Variant`](M3e.Component.Timepicker#Variant).
-}
type alias Variant =
    Orig.Variant


{-| See [`M3e.Component.Timepicker.variant`](M3e.Component.Timepicker#variant).
-}
variant : Value Variant -> Attr { c | variant : Supported } msg
variant =
    Orig.variant


{-| See [`M3e.Component.Timepicker.confirmLabel`](M3e.Component.Timepicker#confirmLabel).
-}
confirmLabel : String -> Attr { c | confirmLabel : Supported } msg
confirmLabel =
    Orig.confirmLabel


{-| See [`M3e.Component.Timepicker.date`](M3e.Component.Timepicker#date).
-}
date : String -> Attr { c | date : Supported } msg
date =
    Orig.date


{-| See [`M3e.Component.Timepicker.dialLabel`](M3e.Component.Timepicker#dialLabel).
-}
dialLabel : String -> Attr { c | dialLabel : Supported } msg
dialLabel =
    Orig.dialLabel


{-| See [`M3e.Component.Timepicker.dismissLabel`](M3e.Component.Timepicker#dismissLabel).
-}
dismissLabel : String -> Attr { c | dismissLabel : Supported } msg
dismissLabel =
    Orig.dismissLabel


{-| See [`M3e.Component.Timepicker.for`](M3e.Component.Timepicker#for).
-}
for : String -> Attr { c | for : Supported } msg
for =
    Orig.for


{-| See [`M3e.Component.Timepicker.hideModeToggle`](M3e.Component.Timepicker#hideModeToggle).
-}
hideModeToggle : Bool -> Attr { c | hideModeToggle : Supported } msg
hideModeToggle =
    Orig.hideModeToggle


{-| See [`M3e.Component.Timepicker.hourLabel`](M3e.Component.Timepicker#hourLabel).
-}
hourLabel : String -> Attr { c | hourLabel : Supported } msg
hourLabel =
    Orig.hourLabel


{-| See [`M3e.Component.Timepicker.inputLabel`](M3e.Component.Timepicker#inputLabel).
-}
inputLabel : String -> Attr { c | inputLabel : Supported } msg
inputLabel =
    Orig.inputLabel


{-| See [`M3e.Component.Timepicker.maxTime`](M3e.Component.Timepicker#maxTime).
-}
maxTime : String -> Attr { c | maxTime : Supported } msg
maxTime =
    Orig.maxTime


{-| See [`M3e.Component.Timepicker.minTime`](M3e.Component.Timepicker#minTime).
-}
minTime : String -> Attr { c | minTime : Supported } msg
minTime =
    Orig.minTime


{-| See [`M3e.Component.Timepicker.minuteLabel`](M3e.Component.Timepicker#minuteLabel).
-}
minuteLabel : String -> Attr { c | minuteLabel : Supported } msg
minuteLabel =
    Orig.minuteLabel


{-| See [`M3e.Component.Timepicker.modeToggleLabel`](M3e.Component.Timepicker#modeToggleLabel).
-}
modeToggleLabel : String -> Attr { c | modeToggleLabel : Supported } msg
modeToggleLabel =
    Orig.modeToggleLabel


{-| See [`M3e.Component.Timepicker.periodToggleLabel`](M3e.Component.Timepicker#periodToggleLabel).
-}
periodToggleLabel : String -> Attr { c | periodToggleLabel : Supported } msg
periodToggleLabel =
    Orig.periodToggleLabel


{-| See [`M3e.Component.Timepicker.secondLabel`](M3e.Component.Timepicker#secondLabel).
-}
secondLabel : String -> Attr { c | secondLabel : Supported } msg
secondLabel =
    Orig.secondLabel


{-| See [`M3e.Component.Timepicker.showSeconds`](M3e.Component.Timepicker#showSeconds).
-}
showSeconds : Bool -> Attr { c | showSeconds : Supported } msg
showSeconds =
    Orig.showSeconds


{-| See [`M3e.Component.Timepicker.onChange`](M3e.Component.Timepicker#onChange).
-}
onChange : msg -> Attr { c | onChange : Supported } msg
onChange =
    Orig.onChange


{-| See [`M3e.Component.Timepicker.onBeforetoggle`](M3e.Component.Timepicker#onBeforetoggle).
-}
onBeforetoggle : msg -> Attr { c | onBeforetoggle : Supported } msg
onBeforetoggle =
    Orig.onBeforetoggle


{-| See [`M3e.Component.Timepicker.onToggle`](M3e.Component.Timepicker#onToggle).
-}
onToggle : msg -> Attr { c | onToggle : Supported } msg
onToggle =
    Orig.onToggle
