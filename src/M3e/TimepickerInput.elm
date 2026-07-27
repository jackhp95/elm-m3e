module M3e.TimepickerInput exposing
    ( view, build, toElement
    , Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , Format, format, Period, period, ViewAttr, viewAttr
    , blackouttimes, for, hideLabels, hour, hourLabel, maxTime, minTime, minute, minuteLabel, orientation, periodToggleLabel, second, secondLabel, showSeconds, onViewChange, onChange
    , withBlackouttimes, withClass, withFor, withFormat, withHideLabels, withHour, withHourLabel, withId, withMaxTime, withMinTime, withMinute, withMinuteLabel, withOnChange, withOnViewChange, withOrientation, withPeriod, withPeriodToggleLabel, withSecond, withSecondLabel, withShowSeconds, withSlot, withStyle, withViewAttr
    )

{-| The `m3e-timepicker-input` component — strict per-component surface.

A keyboard‑based time surface for choosing hours and minutes.

@docs view, build, toElement
@docs Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs Format, format, Period, period, ViewAttr, viewAttr
@docs blackouttimes, for, hideLabels, hour, hourLabel, maxTime, minTime, minute, minuteLabel, orientation, periodToggleLabel, second, secondLabel, showSeconds, onViewChange, onChange
@docs withBlackouttimes, withClass, withFor, withFormat, withHideLabels, withHour, withHourLabel, withId, withMaxTime, withMinTime, withMinute, withMinuteLabel, withOnChange, withOnViewChange, withOrientation, withPeriod, withPeriodToggleLabel, withSecond, withSecondLabel, withShowSeconds, withSlot, withStyle, withViewAttr

-}

import Html.Attributes
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
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-timepicker-input` produces (open — composes into any slot naming it).
-}
type alias Is s =
    { s | timepickerInput : Brand }


{-| The closed attribute-capability row.
-}
type alias Attrs =
    { blackouttimes : Supported
    , class : Supported
    , for : Supported
    , format : Supported
    , hideLabels : Supported
    , hour : Supported
    , hourLabel : Supported
    , id : Supported
    , maxTime : Supported
    , minTime : Supported
    , minute : Supported
    , minuteLabel : Supported
    , onChange : Supported
    , onViewChange : Supported
    , orientation : Supported
    , period : Supported
    , periodToggleLabel : Supported
    , second : Supported
    , secondLabel : Supported
    , showSeconds : Supported
    , slot : Supported
    , style : Supported
    , viewAttr : Supported
    }


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    { childAdm | timepickerInput : Ctx }


{-| The `format` values valid on this component (compile-tight narrowing).
-}
type alias Format =
    { value12 : Supported
    , value24 : Supported
    , auto : Supported
    }


{-| The `period` values valid on this component (compile-tight narrowing).
-}
type alias Period =
    { am : Supported
    , pm : Supported
    }


{-| The `viewAttr` values valid on this component (compile-tight narrowing).
-}
type alias ViewAttr =
    { hour : Supported
    , minute : Supported
    , second : Supported
    }


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


{-| See `M3e.Attributes.blackouttimes`.
-}
blackouttimes : String -> Attr { c | blackouttimes : Supported } msg
blackouttimes =
    A.blackouttimes


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
`Build.Internal`, closed over this component's `Attrs` row.
-}
type alias Builder attrCaps slotCaps msg =
    B.Builder Attrs attrCaps slotCaps msg


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    { blackouttimes : Available
    , class : Available
    , for : Available
    , format : Available
    , hideLabels : Available
    , hour : Available
    , hourLabel : Available
    , id : Available
    , maxTime : Available
    , minTime : Available
    , minute : Available
    , minuteLabel : Available
    , onChange : Available
    , onViewChange : Available
    , orientation : Available
    , period : Available
    , periodToggleLabel : Available
    , second : Available
    , secondLabel : Available
    , showSeconds : Available
    , slot : Available
    , style : Available
    , viewAttr : Available
    }


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    {}


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg
build =
    B.init "m3e-timepicker-input" [] []


{-| Close the pipe-builder (`toElement` is defined once in `Build.Internal`).
-}
toElement : Builder attrCaps slotCaps msg -> Element (Is s) admittedBy msg
toElement =
    B.toElement


{-| Pipe form of `class` — consumes its capability (write-once).
-}
withClass : String -> Builder { a | class : Available } slotCaps msg -> Builder { a | class : Used } slotCaps msg
withClass value_ =
    B.withAttribute (A.class value_)


{-| Pipe form of `id` — consumes its capability (write-once).
-}
withId : String -> Builder { a | id : Available } slotCaps msg -> Builder { a | id : Used } slotCaps msg
withId value_ =
    B.withAttribute (A.id value_)


{-| Pipe form of `slot` — consumes its capability (write-once).
-}
withSlot : String -> Builder { a | slot : Available } slotCaps msg -> Builder { a | slot : Used } slotCaps msg
withSlot value_ =
    B.withAttribute (A.slot value_)


{-| Pipe form of `style` — consumes its capability (write-once).
-}
withStyle : String -> Builder { a | style : Available } slotCaps msg -> Builder { a | style : Used } slotCaps msg
withStyle value_ =
    B.withAttribute (A.style value_)


{-| Pipe form of `blackouttimes` — consumes its capability (write-once).
-}
withBlackouttimes : String -> Builder { a | blackouttimes : Available } slotCaps msg -> Builder { a | blackouttimes : Used } slotCaps msg
withBlackouttimes value_ =
    B.withAttribute (A.blackouttimes value_)


{-| Pipe form of `for` — consumes its capability (write-once).
-}
withFor : String -> Builder { a | for : Available } slotCaps msg -> Builder { a | for : Used } slotCaps msg
withFor value_ =
    B.withAttribute (A.for value_)


{-| Pipe form of `format` — consumes its capability (write-once).
-}
withFormat : Value Format -> Builder { a | format : Available } slotCaps msg -> Builder { a | format : Used } slotCaps msg
withFormat value_ =
    B.withAttribute (format value_)


{-| Pipe form of `hideLabels` — consumes its capability (write-once).
-}
withHideLabels : Bool -> Builder { a | hideLabels : Available } slotCaps msg -> Builder { a | hideLabels : Used } slotCaps msg
withHideLabels value_ =
    B.withAttribute (A.hideLabels value_)


{-| Pipe form of `hour` — consumes its capability (write-once).
-}
withHour : Float -> Builder { a | hour : Available } slotCaps msg -> Builder { a | hour : Used } slotCaps msg
withHour value_ =
    B.withAttribute (A.hour value_)


{-| Pipe form of `hourLabel` — consumes its capability (write-once).
-}
withHourLabel : String -> Builder { a | hourLabel : Available } slotCaps msg -> Builder { a | hourLabel : Used } slotCaps msg
withHourLabel value_ =
    B.withAttribute (A.hourLabel value_)


{-| Pipe form of `maxTime` — consumes its capability (write-once).
-}
withMaxTime : String -> Builder { a | maxTime : Available } slotCaps msg -> Builder { a | maxTime : Used } slotCaps msg
withMaxTime value_ =
    B.withAttribute (A.maxTime value_)


{-| Pipe form of `minTime` — consumes its capability (write-once).
-}
withMinTime : String -> Builder { a | minTime : Available } slotCaps msg -> Builder { a | minTime : Used } slotCaps msg
withMinTime value_ =
    B.withAttribute (A.minTime value_)


{-| Pipe form of `minute` — consumes its capability (write-once).
-}
withMinute : Float -> Builder { a | minute : Available } slotCaps msg -> Builder { a | minute : Used } slotCaps msg
withMinute value_ =
    B.withAttribute (A.minute value_)


{-| Pipe form of `minuteLabel` — consumes its capability (write-once).
-}
withMinuteLabel : String -> Builder { a | minuteLabel : Available } slotCaps msg -> Builder { a | minuteLabel : Used } slotCaps msg
withMinuteLabel value_ =
    B.withAttribute (A.minuteLabel value_)


{-| Pipe form of `orientation` — consumes its capability (write-once).
-}
withOrientation : String -> Builder { a | orientation : Available } slotCaps msg -> Builder { a | orientation : Used } slotCaps msg
withOrientation value_ =
    B.withAttribute (Ir.attribute "orientation" value_)


{-| Pipe form of `period` — consumes its capability (write-once).
-}
withPeriod : Value Period -> Builder { a | period : Available } slotCaps msg -> Builder { a | period : Used } slotCaps msg
withPeriod value_ =
    B.withAttribute (period value_)


{-| Pipe form of `periodToggleLabel` — consumes its capability (write-once).
-}
withPeriodToggleLabel : String -> Builder { a | periodToggleLabel : Available } slotCaps msg -> Builder { a | periodToggleLabel : Used } slotCaps msg
withPeriodToggleLabel value_ =
    B.withAttribute (A.periodToggleLabel value_)


{-| Pipe form of `second` — consumes its capability (write-once).
-}
withSecond : Float -> Builder { a | second : Available } slotCaps msg -> Builder { a | second : Used } slotCaps msg
withSecond value_ =
    B.withAttribute (A.second value_)


{-| Pipe form of `secondLabel` — consumes its capability (write-once).
-}
withSecondLabel : String -> Builder { a | secondLabel : Available } slotCaps msg -> Builder { a | secondLabel : Used } slotCaps msg
withSecondLabel value_ =
    B.withAttribute (A.secondLabel value_)


{-| Pipe form of `showSeconds` — consumes its capability (write-once).
-}
withShowSeconds : Bool -> Builder { a | showSeconds : Available } slotCaps msg -> Builder { a | showSeconds : Used } slotCaps msg
withShowSeconds value_ =
    B.withAttribute (A.showSeconds value_)


{-| Pipe form of `viewAttr` — consumes its capability (write-once).
-}
withViewAttr : Value ViewAttr -> Builder { a | viewAttr : Available } slotCaps msg -> Builder { a | viewAttr : Used } slotCaps msg
withViewAttr value_ =
    B.withAttribute (viewAttr value_)


{-| Pipe form of `onViewChange` — consumes its capability (write-once).
-}
withOnViewChange : msg -> Builder { a | onViewChange : Available } slotCaps msg -> Builder { a | onViewChange : Used } slotCaps msg
withOnViewChange value_ =
    B.withAttribute (Ev.onViewChange value_)


{-| Pipe form of `onChange` — consumes its capability (write-once).
-}
withOnChange : msg -> Builder { a | onChange : Available } slotCaps msg -> Builder { a | onChange : Used } slotCaps msg
withOnChange value_ =
    B.withAttribute (Ev.onChange value_)
