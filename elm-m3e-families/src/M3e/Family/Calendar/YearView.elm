module M3e.Family.Calendar.YearView exposing (el, Is, Attrs, ChildAdmittedBy, active, activeDate, date, maxDate, minDate, today, onChange, onActiveChange)

{-| `YearView`, grouped under the **Calendar** family as `YearView`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.YearView`](M3e.Component.YearView) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, ChildAdmittedBy, active, activeDate, date, maxDate, minDate, today, onChange, onActiveChange

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Kind exposing (Shared, Supported)
import M3e.Component.YearView as Orig


{-| See [`M3e.Component.YearView.el`](M3e.Component.YearView#el).
-}
el :
    List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.YearView.Is`](M3e.Component.YearView#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.YearView.Attrs`](M3e.Component.YearView#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.YearView.ChildAdmittedBy`](M3e.Component.YearView#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm


{-| See [`M3e.Component.YearView.active`](M3e.Component.YearView#active).
-}
active : Bool -> Attr { c | active : Supported } msg
active =
    Orig.active


{-| See [`M3e.Component.YearView.activeDate`](M3e.Component.YearView#activeDate).
-}
activeDate : String -> Attr { c | activeDate : Supported } msg
activeDate =
    Orig.activeDate


{-| See [`M3e.Component.YearView.date`](M3e.Component.YearView#date).
-}
date : String -> Attr { c | date : Supported } msg
date =
    Orig.date


{-| See [`M3e.Component.YearView.maxDate`](M3e.Component.YearView#maxDate).
-}
maxDate : String -> Attr { c | maxDate : Supported } msg
maxDate =
    Orig.maxDate


{-| See [`M3e.Component.YearView.minDate`](M3e.Component.YearView#minDate).
-}
minDate : String -> Attr { c | minDate : Supported } msg
minDate =
    Orig.minDate


{-| See [`M3e.Component.YearView.today`](M3e.Component.YearView#today).
-}
today : String -> Attr { c | today : Supported } msg
today =
    Orig.today


{-| See [`M3e.Component.YearView.onChange`](M3e.Component.YearView#onChange).
-}
onChange : msg -> Attr { c | onChange : Supported } msg
onChange =
    Orig.onChange


{-| See [`M3e.Component.YearView.onActiveChange`](M3e.Component.YearView#onActiveChange).
-}
onActiveChange : msg -> Attr { c | onActiveChange : Supported } msg
onActiveChange =
    Orig.onActiveChange
