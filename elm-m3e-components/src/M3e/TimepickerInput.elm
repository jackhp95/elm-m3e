module M3e.TimepickerInput exposing
    ( view, build, toElement
    , Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , Format, format, Period, period, ViewAttr, viewAttr
    , for, hideLabels, hour, hourLabel, maxTime, minTime, minute, minuteLabel, orientation, periodToggleLabel, second, secondLabel, showSeconds, onViewChange, onChange
    , withClass, withFor, withFormat, withHideLabels, withHour, withHourLabel, withId, withMaxTime, withMinTime, withMinute, withMinuteLabel, withOnChange, withOnViewChange, withOrientation, withPeriod, withPeriodToggleLabel, withSecond, withSecondLabel, withShowSeconds, withSlot, withStyle, withViewAttr
    )

{-| The `m3e-timepicker-input` component — strict per-component surface.

A keyboard‑based time surface for choosing hours and minutes.

@docs view, build, toElement
@docs Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs Format, format, Period, period, ViewAttr, viewAttr
@docs for, hideLabels, hour, hourLabel, maxTime, minTime, minute, minuteLabel, orientation, periodToggleLabel, second, secondLabel, showSeconds, onViewChange, onChange
@docs withClass, withFor, withFormat, withHideLabels, withHour, withHourLabel, withId, withMaxTime, withMinTime, withMinute, withMinuteLabel, withOnChange, withOnViewChange, withOrientation, withPeriod, withPeriodToggleLabel, withSecond, withSecondLabel, withShowSeconds, withSlot, withStyle, withViewAttr

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import HtmlIr.Value as Val exposing (Value)
import Json.Encode
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Events as Ev
import M3e.Html as H
import M3e.Internal.Types.TimepickerInput
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-timepicker-input` produces (open — composes into any slot naming it).
-}
type alias Is s =
    M3e.Internal.Types.TimepickerInput.Is s


{-| The closed attribute-capability row.
-}
type alias Attrs =
    M3e.Internal.Types.TimepickerInput.Attrs


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    M3e.Internal.Types.TimepickerInput.ChildAdmittedBy childAdm


{-| The `format` values valid on this component (compile-tight narrowing).
-}
type alias Format =
    M3e.Internal.Types.TimepickerInput.Format


{-| The `period` values valid on this component (compile-tight narrowing).
-}
type alias Period =
    M3e.Internal.Types.TimepickerInput.Period


{-| The `viewAttr` values valid on this component (compile-tight narrowing).
-}
type alias ViewAttr =
    M3e.Internal.Types.TimepickerInput.ViewAttr


{-| Standard constructor: `[attributes] [children]`.
-}
view :
    List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
view =
    H.timepickerInput


{-| Whether to use a 12‑hour or 24‑hour clock. (default: `"12"`)
-}
format : Value Format -> Attr { c | format : Supported } msg
format value_ =
    Ir.attribute "format" (Val.toString value_)


{-| The 12-hour time period. (default: `"am"`)
-}
period : Value Period -> Attr { c | period : Supported } msg
period value_ =
    Ir.attribute "period" (Val.toString value_)


{-| The view used to input time. (default: `"hour"`)
-}
viewAttr : Value ViewAttr -> Attr { c | viewAttr : Supported } msg
viewAttr value_ =
    Ir.attribute "view" (Val.toString value_)


{-| See `M3e.Attributes.for`.
-}
for : String -> Attr { c | for : Supported } msg
for =
    A.for


{-| See `M3e.Attributes.hideLabels`.
-}
hideLabels : Bool -> Attr { c | hideLabels : Supported } msg
hideLabels =
    A.hideLabels


{-| See `M3e.Attributes.hour`.
-}
hour : Float -> Attr { c | hour : Supported } msg
hour =
    A.hour


{-| See `M3e.Attributes.hourLabel`.
-}
hourLabel : String -> Attr { c | hourLabel : Supported } msg
hourLabel =
    A.hourLabel


{-| See `M3e.Attributes.maxTime`.
-}
maxTime : String -> Attr { c | maxTime : Supported } msg
maxTime =
    A.maxTime


{-| See `M3e.Attributes.minTime`.
-}
minTime : String -> Attr { c | minTime : Supported } msg
minTime =
    A.minTime


{-| See `M3e.Attributes.minute`.
-}
minute : Float -> Attr { c | minute : Supported } msg
minute =
    A.minute


{-| See `M3e.Attributes.minuteLabel`.
-}
minuteLabel : String -> Attr { c | minuteLabel : Supported } msg
minuteLabel =
    A.minuteLabel


{-| The orientation of the input. (default: `"horizontal"`)
-}
orientation : String -> Attr { c | orientation : Supported } msg
orientation value_ =
    Ir.attribute "orientation" value_


{-| See `M3e.Attributes.periodToggleLabel`.
-}
periodToggleLabel : String -> Attr { c | periodToggleLabel : Supported } msg
periodToggleLabel =
    A.periodToggleLabel


{-| See `M3e.Attributes.second`.
-}
second : Float -> Attr { c | second : Supported } msg
second =
    A.second


{-| See `M3e.Attributes.secondLabel`.
-}
secondLabel : String -> Attr { c | secondLabel : Supported } msg
secondLabel =
    A.secondLabel


{-| See `M3e.Attributes.showSeconds`.
-}
showSeconds : Bool -> Attr { c | showSeconds : Supported } msg
showSeconds =
    A.showSeconds


{-| See `M3e.Events.onViewChange`.
-}
onViewChange : msg -> Attr { c | onViewChange : Supported } msg
onViewChange =
    Ev.onViewChange


{-| See `M3e.Events.onChange`.
-}
onChange : msg -> Attr { c | onChange : Supported } msg
onChange =
    Ev.onChange


{-| The pipe-builder: capabilities are consumed Available→Used, so writing
a singular attribute or slot twice is unwritable. Aliases the shared builder in
`Build.Internal`, closed over this component's `Attrs` row and `Is s` kind.
-}
type alias Builder attrCaps slotCaps msg s =
    M3e.Internal.Types.TimepickerInput.Builder attrCaps slotCaps msg s


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    M3e.Internal.Types.TimepickerInput.AttrCaps


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    {}


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg kind
build =
    B.init "m3e-timepicker-input" [] []


{-| Close the pipe-builder (`toElement` is defined once in `Build.Internal`).
-}
toElement : Builder attrCaps slotCaps msg kind -> Element (Is kind) admittedBy msg
toElement =
    B.toElement


{-| Pipe form of `class` — consumes its capability (write-once).
-}
withClass : String -> Builder { a | class : Available } slotCaps msg kind -> Builder { a | class : Used } slotCaps msg kind
withClass value_ =
    B.withAttribute (A.class value_)


{-| Pipe form of `id` — consumes its capability (write-once).
-}
withId : String -> Builder { a | id : Available } slotCaps msg kind -> Builder { a | id : Used } slotCaps msg kind
withId value_ =
    B.withAttribute (A.id value_)


{-| Pipe form of `slot` — consumes its capability (write-once).
-}
withSlot : String -> Builder { a | slot : Available } slotCaps msg kind -> Builder { a | slot : Used } slotCaps msg kind
withSlot value_ =
    B.withAttribute (A.slot value_)


{-| Pipe form of `style` — consumes its capability (write-once).
-}
withStyle : String -> String -> Builder { a | style : Available } slotCaps msg kind -> Builder { a | style : Used } slotCaps msg kind
withStyle property value_ =
    B.withAttribute (A.style property value_)


{-| Pipe form of `for` — consumes its capability (write-once).
-}
withFor : String -> Builder { a | for : Available } slotCaps msg kind -> Builder { a | for : Used } slotCaps msg kind
withFor value_ =
    B.withAttribute (A.for value_)


{-| Pipe form of `format` — consumes its capability (write-once).
-}
withFormat : Value Format -> Builder { a | format : Available } slotCaps msg kind -> Builder { a | format : Used } slotCaps msg kind
withFormat value_ =
    B.withAttribute (format value_)


{-| Pipe form of `hideLabels` — consumes its capability (write-once).
-}
withHideLabels : Bool -> Builder { a | hideLabels : Available } slotCaps msg kind -> Builder { a | hideLabels : Used } slotCaps msg kind
withHideLabels value_ =
    B.withAttribute (A.hideLabels value_)


{-| Pipe form of `hour` — consumes its capability (write-once).
-}
withHour : Float -> Builder { a | hour : Available } slotCaps msg kind -> Builder { a | hour : Used } slotCaps msg kind
withHour value_ =
    B.withAttribute (A.hour value_)


{-| Pipe form of `hourLabel` — consumes its capability (write-once).
-}
withHourLabel : String -> Builder { a | hourLabel : Available } slotCaps msg kind -> Builder { a | hourLabel : Used } slotCaps msg kind
withHourLabel value_ =
    B.withAttribute (A.hourLabel value_)


{-| Pipe form of `maxTime` — consumes its capability (write-once).
-}
withMaxTime : String -> Builder { a | maxTime : Available } slotCaps msg kind -> Builder { a | maxTime : Used } slotCaps msg kind
withMaxTime value_ =
    B.withAttribute (A.maxTime value_)


{-| Pipe form of `minTime` — consumes its capability (write-once).
-}
withMinTime : String -> Builder { a | minTime : Available } slotCaps msg kind -> Builder { a | minTime : Used } slotCaps msg kind
withMinTime value_ =
    B.withAttribute (A.minTime value_)


{-| Pipe form of `minute` — consumes its capability (write-once).
-}
withMinute : Float -> Builder { a | minute : Available } slotCaps msg kind -> Builder { a | minute : Used } slotCaps msg kind
withMinute value_ =
    B.withAttribute (A.minute value_)


{-| Pipe form of `minuteLabel` — consumes its capability (write-once).
-}
withMinuteLabel : String -> Builder { a | minuteLabel : Available } slotCaps msg kind -> Builder { a | minuteLabel : Used } slotCaps msg kind
withMinuteLabel value_ =
    B.withAttribute (A.minuteLabel value_)


{-| Pipe form of `orientation` — consumes its capability (write-once).
-}
withOrientation : String -> Builder { a | orientation : Available } slotCaps msg kind -> Builder { a | orientation : Used } slotCaps msg kind
withOrientation value_ =
    B.withAttribute (Ir.attribute "orientation" value_)


{-| Pipe form of `period` — consumes its capability (write-once).
-}
withPeriod : Value Period -> Builder { a | period : Available } slotCaps msg kind -> Builder { a | period : Used } slotCaps msg kind
withPeriod value_ =
    B.withAttribute (period value_)


{-| Pipe form of `periodToggleLabel` — consumes its capability (write-once).
-}
withPeriodToggleLabel : String -> Builder { a | periodToggleLabel : Available } slotCaps msg kind -> Builder { a | periodToggleLabel : Used } slotCaps msg kind
withPeriodToggleLabel value_ =
    B.withAttribute (A.periodToggleLabel value_)


{-| Pipe form of `second` — consumes its capability (write-once).
-}
withSecond : Float -> Builder { a | second : Available } slotCaps msg kind -> Builder { a | second : Used } slotCaps msg kind
withSecond value_ =
    B.withAttribute (A.second value_)


{-| Pipe form of `secondLabel` — consumes its capability (write-once).
-}
withSecondLabel : String -> Builder { a | secondLabel : Available } slotCaps msg kind -> Builder { a | secondLabel : Used } slotCaps msg kind
withSecondLabel value_ =
    B.withAttribute (A.secondLabel value_)


{-| Pipe form of `showSeconds` — consumes its capability (write-once).
-}
withShowSeconds : Bool -> Builder { a | showSeconds : Available } slotCaps msg kind -> Builder { a | showSeconds : Used } slotCaps msg kind
withShowSeconds value_ =
    B.withAttribute (A.showSeconds value_)


{-| Pipe form of `viewAttr` — consumes its capability (write-once).
-}
withViewAttr : Value ViewAttr -> Builder { a | viewAttr : Available } slotCaps msg kind -> Builder { a | viewAttr : Used } slotCaps msg kind
withViewAttr value_ =
    B.withAttribute (viewAttr value_)


{-| Pipe form of `onViewChange` — consumes its capability (write-once).
-}
withOnViewChange : msg -> Builder { a | onViewChange : Available } slotCaps msg kind -> Builder { a | onViewChange : Used } slotCaps msg kind
withOnViewChange value_ =
    B.withAttribute (Ev.onViewChange value_)


{-| Pipe form of `onChange` — consumes its capability (write-once).
-}
withOnChange : msg -> Builder { a | onChange : Available } slotCaps msg kind -> Builder { a | onChange : Used } slotCaps msg kind
withOnChange value_ =
    B.withAttribute (Ev.onChange value_)
