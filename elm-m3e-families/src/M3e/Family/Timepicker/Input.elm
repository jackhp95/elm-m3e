module M3e.Family.Timepicker.Input exposing (el, Is, Attrs, ChildAdmittedBy, Format, format, Period, period, ViewAttr, viewAttr, for, hideLabels, hour, hourLabel, maxTime, minTime, minute, minuteLabel, orientation, periodToggleLabel, second, secondLabel, showSeconds, onViewChange, onChange)

{-| `TimepickerInput`, grouped under the **Timepicker** family as `Input`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.TimepickerInput`](M3e.Component.TimepickerInput) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, ChildAdmittedBy, Format, format, Period, period, ViewAttr, viewAttr, for, hideLabels, hour, hourLabel, maxTime, minTime, minute, minuteLabel, orientation, periodToggleLabel, second, secondLabel, showSeconds, onViewChange, onChange

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Value exposing (Value)
import M3e.Component.TimepickerInput as Orig


{-| See [`M3e.Component.TimepickerInput.el`](M3e.Component.TimepickerInput#el).
-}
el :
    List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.TimepickerInput.Is`](M3e.Component.TimepickerInput#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.TimepickerInput.Attrs`](M3e.Component.TimepickerInput#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.TimepickerInput.ChildAdmittedBy`](M3e.Component.TimepickerInput#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm


{-| See [`M3e.Component.TimepickerInput.Format`](M3e.Component.TimepickerInput#Format).
-}
type alias Format =
    Orig.Format


{-| See [`M3e.Component.TimepickerInput.format`](M3e.Component.TimepickerInput#format).
-}
format : Value Format -> Attr { c | format : Supported } msg
format =
    Orig.format


{-| See [`M3e.Component.TimepickerInput.Period`](M3e.Component.TimepickerInput#Period).
-}
type alias Period =
    Orig.Period


{-| See [`M3e.Component.TimepickerInput.period`](M3e.Component.TimepickerInput#period).
-}
period : Value Period -> Attr { c | period : Supported } msg
period =
    Orig.period


{-| See [`M3e.Component.TimepickerInput.ViewAttr`](M3e.Component.TimepickerInput#ViewAttr).
-}
type alias ViewAttr =
    Orig.ViewAttr


{-| See [`M3e.Component.TimepickerInput.viewAttr`](M3e.Component.TimepickerInput#viewAttr).
-}
viewAttr : Value ViewAttr -> Attr { c | viewAttr : Supported } msg
viewAttr =
    Orig.viewAttr


{-| See [`M3e.Component.TimepickerInput.for`](M3e.Component.TimepickerInput#for).
-}
for : String -> Attr { c | for : Supported } msg
for =
    Orig.for


{-| See [`M3e.Component.TimepickerInput.hideLabels`](M3e.Component.TimepickerInput#hideLabels).
-}
hideLabels : Bool -> Attr { c | hideLabels : Supported } msg
hideLabels =
    Orig.hideLabels


{-| See [`M3e.Component.TimepickerInput.hour`](M3e.Component.TimepickerInput#hour).
-}
hour : Float -> Attr { c | hour : Supported } msg
hour =
    Orig.hour


{-| See [`M3e.Component.TimepickerInput.hourLabel`](M3e.Component.TimepickerInput#hourLabel).
-}
hourLabel : String -> Attr { c | hourLabel : Supported } msg
hourLabel =
    Orig.hourLabel


{-| See [`M3e.Component.TimepickerInput.maxTime`](M3e.Component.TimepickerInput#maxTime).
-}
maxTime : String -> Attr { c | maxTime : Supported } msg
maxTime =
    Orig.maxTime


{-| See [`M3e.Component.TimepickerInput.minTime`](M3e.Component.TimepickerInput#minTime).
-}
minTime : String -> Attr { c | minTime : Supported } msg
minTime =
    Orig.minTime


{-| See [`M3e.Component.TimepickerInput.minute`](M3e.Component.TimepickerInput#minute).
-}
minute : Float -> Attr { c | minute : Supported } msg
minute =
    Orig.minute


{-| See [`M3e.Component.TimepickerInput.minuteLabel`](M3e.Component.TimepickerInput#minuteLabel).
-}
minuteLabel : String -> Attr { c | minuteLabel : Supported } msg
minuteLabel =
    Orig.minuteLabel


{-| See [`M3e.Component.TimepickerInput.orientation`](M3e.Component.TimepickerInput#orientation).
-}
orientation : String -> Attr { c | orientation : Supported } msg
orientation =
    Orig.orientation


{-| See [`M3e.Component.TimepickerInput.periodToggleLabel`](M3e.Component.TimepickerInput#periodToggleLabel).
-}
periodToggleLabel : String -> Attr { c | periodToggleLabel : Supported } msg
periodToggleLabel =
    Orig.periodToggleLabel


{-| See [`M3e.Component.TimepickerInput.second`](M3e.Component.TimepickerInput#second).
-}
second : Float -> Attr { c | second : Supported } msg
second =
    Orig.second


{-| See [`M3e.Component.TimepickerInput.secondLabel`](M3e.Component.TimepickerInput#secondLabel).
-}
secondLabel : String -> Attr { c | secondLabel : Supported } msg
secondLabel =
    Orig.secondLabel


{-| See [`M3e.Component.TimepickerInput.showSeconds`](M3e.Component.TimepickerInput#showSeconds).
-}
showSeconds : Bool -> Attr { c | showSeconds : Supported } msg
showSeconds =
    Orig.showSeconds


{-| See [`M3e.Component.TimepickerInput.onViewChange`](M3e.Component.TimepickerInput#onViewChange).
-}
onViewChange : msg -> Attr { c | onViewChange : Supported } msg
onViewChange =
    Orig.onViewChange


{-| See [`M3e.Component.TimepickerInput.onChange`](M3e.Component.TimepickerInput#onChange).
-}
onChange : msg -> Attr { c | onChange : Supported } msg
onChange =
    Orig.onChange
