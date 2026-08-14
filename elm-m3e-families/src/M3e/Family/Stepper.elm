module M3e.Family.Stepper exposing (el, Is, Attrs, PanelSlot, StepSlot, ChildAdmittedBy, HeaderPosition, headerPosition, LabelPosition, labelPosition, Orientation, orientation, linear, onChange, onBeforeinput, onInput, panel, step)

{-| The **Stepper** family root — re-export of `M3e.Component.Stepper`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.Stepper`](M3e.Component.Stepper) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, PanelSlot, StepSlot, ChildAdmittedBy, HeaderPosition, headerPosition, LabelPosition, labelPosition, Orientation, orientation, linear, onChange, onBeforeinput, onInput, panel, step

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Value exposing (Value)
import M3e.Component.Stepper as Orig


{-| See [`M3e.Component.Stepper.el`](M3e.Component.Stepper#el).
-}
el :
    List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.Stepper.Is`](M3e.Component.Stepper#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.Stepper.Attrs`](M3e.Component.Stepper#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.Stepper.PanelSlot`](M3e.Component.Stepper#PanelSlot).
-}
type alias PanelSlot =
    Orig.PanelSlot


{-| See [`M3e.Component.Stepper.StepSlot`](M3e.Component.Stepper#StepSlot).
-}
type alias StepSlot =
    Orig.StepSlot


{-| See [`M3e.Component.Stepper.ChildAdmittedBy`](M3e.Component.Stepper#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm


{-| See [`M3e.Component.Stepper.HeaderPosition`](M3e.Component.Stepper#HeaderPosition).
-}
type alias HeaderPosition =
    Orig.HeaderPosition


{-| See [`M3e.Component.Stepper.headerPosition`](M3e.Component.Stepper#headerPosition).
-}
headerPosition : Value HeaderPosition -> Attr { c | headerPosition : Supported } msg
headerPosition =
    Orig.headerPosition


{-| See [`M3e.Component.Stepper.LabelPosition`](M3e.Component.Stepper#LabelPosition).
-}
type alias LabelPosition =
    Orig.LabelPosition


{-| See [`M3e.Component.Stepper.labelPosition`](M3e.Component.Stepper#labelPosition).
-}
labelPosition : Value LabelPosition -> Attr { c | labelPosition : Supported } msg
labelPosition =
    Orig.labelPosition


{-| See [`M3e.Component.Stepper.Orientation`](M3e.Component.Stepper#Orientation).
-}
type alias Orientation =
    Orig.Orientation


{-| See [`M3e.Component.Stepper.orientation`](M3e.Component.Stepper#orientation).
-}
orientation : Value Orientation -> Attr { c | orientation : Supported } msg
orientation =
    Orig.orientation


{-| See [`M3e.Component.Stepper.linear`](M3e.Component.Stepper#linear).
-}
linear : Bool -> Attr { c | linear : Supported } msg
linear =
    Orig.linear


{-| See [`M3e.Component.Stepper.onChange`](M3e.Component.Stepper#onChange).
-}
onChange : msg -> Attr { c | onChange : Supported } msg
onChange =
    Orig.onChange


{-| See [`M3e.Component.Stepper.onBeforeinput`](M3e.Component.Stepper#onBeforeinput).
-}
onBeforeinput : msg -> Attr { c | onBeforeinput : Supported } msg
onBeforeinput =
    Orig.onBeforeinput


{-| See [`M3e.Component.Stepper.onInput`](M3e.Component.Stepper#onInput).
-}
onInput : msg -> Attr { c | onInput : Supported } msg
onInput =
    Orig.onInput


{-| See [`M3e.Component.Stepper.panel`](M3e.Component.Stepper#panel).
-}
panel : Element PanelSlot admittedBy msg -> Element free freeAdmittedBy msg
panel =
    Orig.panel


{-| See [`M3e.Component.Stepper.step`](M3e.Component.Stepper#step).
-}
step : Element StepSlot admittedBy msg -> Element free freeAdmittedBy msg
step =
    Orig.step
