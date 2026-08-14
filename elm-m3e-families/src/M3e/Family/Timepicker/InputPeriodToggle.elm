module M3e.Family.Timepicker.InputPeriodToggle exposing (el, Is, Attrs, ChildAdmittedBy, Period, period, orientation, onChange)

{-| `TimepickerInputPeriodToggle`, grouped under the **Timepicker** family as `InputPeriodToggle`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.TimepickerInputPeriodToggle`](M3e.Component.TimepickerInputPeriodToggle) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, ChildAdmittedBy, Period, period, orientation, onChange

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Value exposing (Value)
import M3e.Component.TimepickerInputPeriodToggle as Orig


{-| See [`M3e.Component.TimepickerInputPeriodToggle.el`](M3e.Component.TimepickerInputPeriodToggle#el).
-}
el :
    List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.TimepickerInputPeriodToggle.Is`](M3e.Component.TimepickerInputPeriodToggle#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.TimepickerInputPeriodToggle.Attrs`](M3e.Component.TimepickerInputPeriodToggle#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.TimepickerInputPeriodToggle.ChildAdmittedBy`](M3e.Component.TimepickerInputPeriodToggle#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm


{-| See [`M3e.Component.TimepickerInputPeriodToggle.Period`](M3e.Component.TimepickerInputPeriodToggle#Period).
-}
type alias Period =
    Orig.Period


{-| See [`M3e.Component.TimepickerInputPeriodToggle.period`](M3e.Component.TimepickerInputPeriodToggle#period).
-}
period : Value Period -> Attr { c | period : Supported } msg
period =
    Orig.period


{-| See [`M3e.Component.TimepickerInputPeriodToggle.orientation`](M3e.Component.TimepickerInputPeriodToggle#orientation).
-}
orientation : String -> Attr { c | orientation : Supported } msg
orientation =
    Orig.orientation


{-| See [`M3e.Component.TimepickerInputPeriodToggle.onChange`](M3e.Component.TimepickerInputPeriodToggle#onChange).
-}
onChange : msg -> Attr { c | onChange : Supported } msg
onChange =
    Orig.onChange
