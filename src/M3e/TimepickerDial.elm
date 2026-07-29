module M3e.TimepickerDial exposing
    ( view, build, toElement
    , Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , Format, format, Period, period, ViewAttr, viewAttr
    , hour, maxTime, minTime, minute, second, showSeconds, onInput, onChange, onViewChange
    , withClass, withFormat, withHour, withId, withMaxTime, withMinTime, withMinute, withOnChange, withOnInput, withOnViewChange, withPeriod, withSecond, withShowSeconds, withSlot, withStyle, withViewAttr
    )

{-| The `m3e-timepicker-dial` component — strict per-component surface.

A clock‑face surface for selecting hours and minutes using a movable hand.

@docs view, build, toElement
@docs Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs Format, format, Period, period, ViewAttr, viewAttr
@docs hour, maxTime, minTime, minute, second, showSeconds, onInput, onChange, onViewChange
@docs withClass, withFormat, withHour, withId, withMaxTime, withMinTime, withMinute, withOnChange, withOnInput, withOnViewChange, withPeriod, withSecond, withShowSeconds, withSlot, withStyle, withViewAttr

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import HtmlIr.Value as Val exposing (Value)
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Events as Ev
import M3e.Html as H
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-timepicker-dial` produces (open — composes into any slot naming it).
-}
type alias Is s =
    { s | timepickerDial : Brand }


{-| The closed attribute-capability row.
-}
type alias Attrs =
    { class : Supported
    , format : Supported
    , hour : Supported
    , id : Supported
    , maxTime : Supported
    , minTime : Supported
    , minute : Supported
    , onChange : Supported
    , onInput : Supported
    , onViewChange : Supported
    , period : Supported
    , second : Supported
    , showSeconds : Supported
    , slot : Supported
    , style : Supported
    , viewAttr : Supported
    }


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    { childAdm | timepickerDial : Ctx }


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
    H.timepickerDial


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


{-| See `M3e.Attributes.hour`.
-}
hour : Float -> Attr { c | hour : Supported } msg
hour =
    A.hour


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


{-| See `M3e.Attributes.second`.
-}
second : Float -> Attr { c | second : Supported } msg
second =
    A.second


{-| See `M3e.Attributes.showSeconds`.
-}
showSeconds : Bool -> Attr { c | showSeconds : Supported } msg
showSeconds =
    A.showSeconds


{-| See `M3e.Events.onInput`.
-}
onInput : msg -> Attr { c | onInput : Supported } msg
onInput =
    Ev.onInput


{-| See `M3e.Events.onChange`.
-}
onChange : msg -> Attr { c | onChange : Supported } msg
onChange =
    Ev.onChange


{-| See `M3e.Events.onViewChange`.
-}
onViewChange : msg -> Attr { c | onViewChange : Supported } msg
onViewChange =
    Ev.onViewChange


{-| The pipe-builder: capabilities are consumed Available→Used, so writing
a singular attribute or slot twice is unwritable. Aliases the shared builder in
`Build.Internal`, closed over this component's `Attrs` row.
-}
type alias Builder attrCaps slotCaps msg =
    B.Builder Attrs attrCaps slotCaps msg


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    { class : Available
    , format : Available
    , hour : Available
    , id : Available
    , maxTime : Available
    , minTime : Available
    , minute : Available
    , onChange : Available
    , onInput : Available
    , onViewChange : Available
    , period : Available
    , second : Available
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
    B.init "m3e-timepicker-dial" [] []


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


{-| Pipe form of `format` — consumes its capability (write-once).
-}
withFormat : Value Format -> Builder { a | format : Available } slotCaps msg -> Builder { a | format : Used } slotCaps msg
withFormat value_ =
    B.withAttribute (format value_)


{-| Pipe form of `hour` — consumes its capability (write-once).
-}
withHour : Float -> Builder { a | hour : Available } slotCaps msg -> Builder { a | hour : Used } slotCaps msg
withHour value_ =
    B.withAttribute (A.hour value_)


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


{-| Pipe form of `period` — consumes its capability (write-once).
-}
withPeriod : Value Period -> Builder { a | period : Available } slotCaps msg -> Builder { a | period : Used } slotCaps msg
withPeriod value_ =
    B.withAttribute (period value_)


{-| Pipe form of `second` — consumes its capability (write-once).
-}
withSecond : Float -> Builder { a | second : Available } slotCaps msg -> Builder { a | second : Used } slotCaps msg
withSecond value_ =
    B.withAttribute (A.second value_)


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


{-| Pipe form of `onInput` — consumes its capability (write-once).
-}
withOnInput : msg -> Builder { a | onInput : Available } slotCaps msg -> Builder { a | onInput : Used } slotCaps msg
withOnInput value_ =
    B.withAttribute (Ev.onInput value_)


{-| Pipe form of `onChange` — consumes its capability (write-once).
-}
withOnChange : msg -> Builder { a | onChange : Available } slotCaps msg -> Builder { a | onChange : Used } slotCaps msg
withOnChange value_ =
    B.withAttribute (Ev.onChange value_)


{-| Pipe form of `onViewChange` — consumes its capability (write-once).
-}
withOnViewChange : msg -> Builder { a | onViewChange : Available } slotCaps msg -> Builder { a | onViewChange : Used } slotCaps msg
withOnViewChange value_ =
    B.withAttribute (Ev.onViewChange value_)
