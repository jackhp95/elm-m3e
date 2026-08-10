module M3e.Timepicker exposing
    ( view, build, toElement
    , Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , Format, format, Mode, mode, Orientation, orientation, Variant, variant
    , confirmLabel, date, dialLabel, dismissLabel, for, hideModeToggle, hourLabel, inputLabel, maxTime, minTime, minuteLabel, modeToggleLabel, periodToggleLabel, secondLabel, showSeconds, onChange, onBeforetoggle, onToggle
    , withClass, withConfirmLabel, withDate, withDialLabel, withDismissLabel, withFor, withFormat, withHideModeToggle, withHourLabel, withId, withInputLabel, withMaxTime, withMinTime, withMinuteLabel, withMode, withModeToggleLabel, withOnBeforetoggle, withOnChange, withOnToggle, withOrientation, withPeriodToggleLabel, withSecondLabel, withShowSeconds, withSlot, withStyle, withVariant
    )

{-| The `m3e-timepicker` component — strict per-component surface.

Presents a time picker on a temporary surface.

@docs view, build, toElement
@docs Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs Format, format, Mode, mode, Orientation, orientation, Variant, variant
@docs confirmLabel, date, dialLabel, dismissLabel, for, hideModeToggle, hourLabel, inputLabel, maxTime, minTime, minuteLabel, modeToggleLabel, periodToggleLabel, secondLabel, showSeconds, onChange, onBeforetoggle, onToggle
@docs withClass, withConfirmLabel, withDate, withDialLabel, withDismissLabel, withFor, withFormat, withHideModeToggle, withHourLabel, withId, withInputLabel, withMaxTime, withMinTime, withMinuteLabel, withMode, withModeToggleLabel, withOnBeforetoggle, withOnChange, withOnToggle, withOrientation, withPeriodToggleLabel, withSecondLabel, withShowSeconds, withSlot, withStyle, withVariant

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
import M3e.Internal.Types.Timepicker
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-timepicker` produces (open — composes into any slot naming it).
-}
type alias Is s =
    M3e.Internal.Types.Timepicker.Is s


{-| The closed attribute-capability row.
-}
type alias Attrs =
    M3e.Internal.Types.Timepicker.Attrs


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    M3e.Internal.Types.Timepicker.ChildAdmittedBy childAdm


{-| The `format` values valid on this component (compile-tight narrowing).
-}
type alias Format =
    M3e.Internal.Types.Timepicker.Format


{-| The `mode` values valid on this component (compile-tight narrowing).
-}
type alias Mode =
    M3e.Internal.Types.Timepicker.Mode


{-| The `orientation` values valid on this component (compile-tight narrowing).
-}
type alias Orientation =
    M3e.Internal.Types.Timepicker.Orientation


{-| The `variant` values valid on this component (compile-tight narrowing).
-}
type alias Variant =
    M3e.Internal.Types.Timepicker.Variant


{-| Standard constructor: `[attributes] [children]`.
-}
view :
    List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
view =
    H.timepicker


{-| Whether to use a 12‑hour or 24‑hour clock. (default: `"12"`)
-}
format : Value Format -> Attr { c | format : Supported } msg
format value_ =
    Ir.attribute "format" (Val.toString value_)


{-| The mode in which to select time. (default: `"dial"`)
-}
mode : Value Mode -> Attr { c | mode : Supported } msg
mode value_ =
    Ir.attribute "mode" (Val.toString value_)


{-| The orientation of the picker. (default: `"vertical"`)
-}
orientation : Value Orientation -> Attr { c | orientation : Supported } msg
orientation value_ =
    Ir.attribute "orientation" (Val.toString value_)


{-| The appearance variant of the picker. (default: `"docked"`)
-}
variant : Value Variant -> Attr { c | variant : Supported } msg
variant value_ =
    Ir.attribute "variant" (Val.toString value_)


{-| See `M3e.Attributes.confirmLabel`.
-}
confirmLabel : String -> Attr { c | confirmLabel : Supported } msg
confirmLabel =
    A.confirmLabel


{-| See `M3e.Attributes.date`.
-}
date : String -> Attr { c | date : Supported } msg
date =
    A.date


{-| See `M3e.Attributes.dialLabel`.
-}
dialLabel : String -> Attr { c | dialLabel : Supported } msg
dialLabel =
    A.dialLabel


{-| See `M3e.Attributes.dismissLabel`.
-}
dismissLabel : String -> Attr { c | dismissLabel : Supported } msg
dismissLabel =
    A.dismissLabel


{-| See `M3e.Attributes.for`.
-}
for : String -> Attr { c | for : Supported } msg
for =
    A.for


{-| See `M3e.Attributes.hideModeToggle`.
-}
hideModeToggle : Bool -> Attr { c | hideModeToggle : Supported } msg
hideModeToggle =
    A.hideModeToggle


{-| See `M3e.Attributes.hourLabel`.
-}
hourLabel : String -> Attr { c | hourLabel : Supported } msg
hourLabel =
    A.hourLabel


{-| See `M3e.Attributes.inputLabel`.
-}
inputLabel : String -> Attr { c | inputLabel : Supported } msg
inputLabel =
    A.inputLabel


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


{-| See `M3e.Attributes.minuteLabel`.
-}
minuteLabel : String -> Attr { c | minuteLabel : Supported } msg
minuteLabel =
    A.minuteLabel


{-| See `M3e.Attributes.modeToggleLabel`.
-}
modeToggleLabel : String -> Attr { c | modeToggleLabel : Supported } msg
modeToggleLabel =
    A.modeToggleLabel


{-| See `M3e.Attributes.periodToggleLabel`.
-}
periodToggleLabel : String -> Attr { c | periodToggleLabel : Supported } msg
periodToggleLabel =
    A.periodToggleLabel


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


{-| See `M3e.Events.onChange`.
-}
onChange : msg -> Attr { c | onChange : Supported } msg
onChange =
    Ev.onChange


{-| See `M3e.Events.onBeforetoggle`.
-}
onBeforetoggle : msg -> Attr { c | onBeforetoggle : Supported } msg
onBeforetoggle =
    Ev.onBeforetoggle


{-| See `M3e.Events.onToggle`.
-}
onToggle : msg -> Attr { c | onToggle : Supported } msg
onToggle =
    Ev.onToggle


{-| The pipe-builder: capabilities are consumed Available→Used, so writing
a singular attribute or slot twice is unwritable. Aliases the shared builder in
`Build.Internal`, closed over this component's `Attrs` row and `Is s` kind.
-}
type alias Builder attrCaps slotCaps msg s =
    M3e.Internal.Types.Timepicker.Builder attrCaps slotCaps msg s


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    M3e.Internal.Types.Timepicker.AttrCaps


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    {}


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg kind
build =
    B.init "m3e-timepicker" [] []


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


{-| Pipe form of `confirmLabel` — consumes its capability (write-once).
-}
withConfirmLabel : String -> Builder { a | confirmLabel : Available } slotCaps msg kind -> Builder { a | confirmLabel : Used } slotCaps msg kind
withConfirmLabel value_ =
    B.withAttribute (A.confirmLabel value_)


{-| Pipe form of `date` — consumes its capability (write-once).
-}
withDate : String -> Builder { a | date : Available } slotCaps msg kind -> Builder { a | date : Used } slotCaps msg kind
withDate value_ =
    B.withAttribute (A.date value_)


{-| Pipe form of `dialLabel` — consumes its capability (write-once).
-}
withDialLabel : String -> Builder { a | dialLabel : Available } slotCaps msg kind -> Builder { a | dialLabel : Used } slotCaps msg kind
withDialLabel value_ =
    B.withAttribute (A.dialLabel value_)


{-| Pipe form of `dismissLabel` — consumes its capability (write-once).
-}
withDismissLabel : String -> Builder { a | dismissLabel : Available } slotCaps msg kind -> Builder { a | dismissLabel : Used } slotCaps msg kind
withDismissLabel value_ =
    B.withAttribute (A.dismissLabel value_)


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


{-| Pipe form of `hideModeToggle` — consumes its capability (write-once).
-}
withHideModeToggle : Bool -> Builder { a | hideModeToggle : Available } slotCaps msg kind -> Builder { a | hideModeToggle : Used } slotCaps msg kind
withHideModeToggle value_ =
    B.withAttribute (A.hideModeToggle value_)


{-| Pipe form of `hourLabel` — consumes its capability (write-once).
-}
withHourLabel : String -> Builder { a | hourLabel : Available } slotCaps msg kind -> Builder { a | hourLabel : Used } slotCaps msg kind
withHourLabel value_ =
    B.withAttribute (A.hourLabel value_)


{-| Pipe form of `inputLabel` — consumes its capability (write-once).
-}
withInputLabel : String -> Builder { a | inputLabel : Available } slotCaps msg kind -> Builder { a | inputLabel : Used } slotCaps msg kind
withInputLabel value_ =
    B.withAttribute (A.inputLabel value_)


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


{-| Pipe form of `minuteLabel` — consumes its capability (write-once).
-}
withMinuteLabel : String -> Builder { a | minuteLabel : Available } slotCaps msg kind -> Builder { a | minuteLabel : Used } slotCaps msg kind
withMinuteLabel value_ =
    B.withAttribute (A.minuteLabel value_)


{-| Pipe form of `mode` — consumes its capability (write-once).
-}
withMode : Value Mode -> Builder { a | mode : Available } slotCaps msg kind -> Builder { a | mode : Used } slotCaps msg kind
withMode value_ =
    B.withAttribute (mode value_)


{-| Pipe form of `modeToggleLabel` — consumes its capability (write-once).
-}
withModeToggleLabel : String -> Builder { a | modeToggleLabel : Available } slotCaps msg kind -> Builder { a | modeToggleLabel : Used } slotCaps msg kind
withModeToggleLabel value_ =
    B.withAttribute (A.modeToggleLabel value_)


{-| Pipe form of `orientation` — consumes its capability (write-once).
-}
withOrientation : Value Orientation -> Builder { a | orientation : Available } slotCaps msg kind -> Builder { a | orientation : Used } slotCaps msg kind
withOrientation value_ =
    B.withAttribute (orientation value_)


{-| Pipe form of `periodToggleLabel` — consumes its capability (write-once).
-}
withPeriodToggleLabel : String -> Builder { a | periodToggleLabel : Available } slotCaps msg kind -> Builder { a | periodToggleLabel : Used } slotCaps msg kind
withPeriodToggleLabel value_ =
    B.withAttribute (A.periodToggleLabel value_)


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


{-| Pipe form of `variant` — consumes its capability (write-once).
-}
withVariant : Value Variant -> Builder { a | variant : Available } slotCaps msg kind -> Builder { a | variant : Used } slotCaps msg kind
withVariant value_ =
    B.withAttribute (variant value_)


{-| Pipe form of `onChange` — consumes its capability (write-once).
-}
withOnChange : msg -> Builder { a | onChange : Available } slotCaps msg kind -> Builder { a | onChange : Used } slotCaps msg kind
withOnChange value_ =
    B.withAttribute (Ev.onChange value_)


{-| Pipe form of `onBeforetoggle` — consumes its capability (write-once).
-}
withOnBeforetoggle : msg -> Builder { a | onBeforetoggle : Available } slotCaps msg kind -> Builder { a | onBeforetoggle : Used } slotCaps msg kind
withOnBeforetoggle value_ =
    B.withAttribute (Ev.onBeforetoggle value_)


{-| Pipe form of `onToggle` — consumes its capability (write-once).
-}
withOnToggle : msg -> Builder { a | onToggle : Available } slotCaps msg kind -> Builder { a | onToggle : Used } slotCaps msg kind
withOnToggle value_ =
    B.withAttribute (Ev.onToggle value_)
