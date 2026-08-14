module M3e.Family.Timepicker.Dial exposing (el, Is, Attrs, ChildAdmittedBy, Format, format, Period, period, ViewAttr, viewAttr, hour, maxTime, minTime, minute, second, showSeconds, onInput, onChange, onViewChange)

{-| `TimepickerDial`, grouped under the **Timepicker** family as `Dial`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.TimepickerDial`](M3e.Component.TimepickerDial) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, ChildAdmittedBy, Format, format, Period, period, ViewAttr, viewAttr, hour, maxTime, minTime, minute, second, showSeconds, onInput, onChange, onViewChange

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Value exposing (Value)
import M3e.Component.TimepickerDial as Orig


{-| See [`M3e.Component.TimepickerDial.el`](M3e.Component.TimepickerDial#el).
-}
el :
    List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.TimepickerDial.Is`](M3e.Component.TimepickerDial#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.TimepickerDial.Attrs`](M3e.Component.TimepickerDial#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.TimepickerDial.ChildAdmittedBy`](M3e.Component.TimepickerDial#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm


{-| See [`M3e.Component.TimepickerDial.Format`](M3e.Component.TimepickerDial#Format).
-}
type alias Format =
    Orig.Format


{-| See [`M3e.Component.TimepickerDial.format`](M3e.Component.TimepickerDial#format).
-}
format : Value Format -> Attr { c | format : Supported } msg
format =
    Orig.format


{-| See [`M3e.Component.TimepickerDial.Period`](M3e.Component.TimepickerDial#Period).
-}
type alias Period =
    Orig.Period


{-| See [`M3e.Component.TimepickerDial.period`](M3e.Component.TimepickerDial#period).
-}
period : Value Period -> Attr { c | period : Supported } msg
period =
    Orig.period


{-| See [`M3e.Component.TimepickerDial.ViewAttr`](M3e.Component.TimepickerDial#ViewAttr).
-}
type alias ViewAttr =
    Orig.ViewAttr


{-| See [`M3e.Component.TimepickerDial.viewAttr`](M3e.Component.TimepickerDial#viewAttr).
-}
viewAttr : Value ViewAttr -> Attr { c | viewAttr : Supported } msg
viewAttr =
    Orig.viewAttr


{-| See [`M3e.Component.TimepickerDial.hour`](M3e.Component.TimepickerDial#hour).
-}
hour : Float -> Attr { c | hour : Supported } msg
hour =
    Orig.hour


{-| See [`M3e.Component.TimepickerDial.maxTime`](M3e.Component.TimepickerDial#maxTime).
-}
maxTime : String -> Attr { c | maxTime : Supported } msg
maxTime =
    Orig.maxTime


{-| See [`M3e.Component.TimepickerDial.minTime`](M3e.Component.TimepickerDial#minTime).
-}
minTime : String -> Attr { c | minTime : Supported } msg
minTime =
    Orig.minTime


{-| See [`M3e.Component.TimepickerDial.minute`](M3e.Component.TimepickerDial#minute).
-}
minute : Float -> Attr { c | minute : Supported } msg
minute =
    Orig.minute


{-| See [`M3e.Component.TimepickerDial.second`](M3e.Component.TimepickerDial#second).
-}
second : Float -> Attr { c | second : Supported } msg
second =
    Orig.second


{-| See [`M3e.Component.TimepickerDial.showSeconds`](M3e.Component.TimepickerDial#showSeconds).
-}
showSeconds : Bool -> Attr { c | showSeconds : Supported } msg
showSeconds =
    Orig.showSeconds


{-| See [`M3e.Component.TimepickerDial.onInput`](M3e.Component.TimepickerDial#onInput).
-}
onInput : msg -> Attr { c | onInput : Supported } msg
onInput =
    Orig.onInput


{-| See [`M3e.Component.TimepickerDial.onChange`](M3e.Component.TimepickerDial#onChange).
-}
onChange : msg -> Attr { c | onChange : Supported } msg
onChange =
    Orig.onChange


{-| See [`M3e.Component.TimepickerDial.onViewChange`](M3e.Component.TimepickerDial#onViewChange).
-}
onViewChange : msg -> Attr { c | onViewChange : Supported } msg
onViewChange =
    Orig.onViewChange
