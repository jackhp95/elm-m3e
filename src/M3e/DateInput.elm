module M3e.DateInput exposing
    ( view, build, toElement
    , Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , TimeFormat, timeFormat, Type, type_
    , dayLabel, disabled, hourLabel, maxDate, maxTime, minDate, minTime, minuteLabel, monthLabel, name, periodLabel, readonly, required, secondLabel, showSeconds, validationmessages, value, yearLabel, onChange, onBeforeinput, onInput, onInvalid
    , withClass, withDayLabel, withDisabled, withHourLabel, withId, withMaxDate, withMaxTime, withMinDate, withMinTime, withMinuteLabel, withMonthLabel, withName, withOnBeforeinput, withOnChange, withOnInput, withOnInvalid, withPeriodLabel, withReadonly, withRequired, withSecondLabel, withShowSeconds, withSlot, withStyle, withTimeFormat, withType, withValidationmessages, withValue, withYearLabel
    )

{-| The `m3e-date-input` component — strict per-component surface.

A segmented input for entering date and/or time values using a keyboard.

@docs view, build, toElement
@docs Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs TimeFormat, timeFormat, Type, type_
@docs dayLabel, disabled, hourLabel, maxDate, maxTime, minDate, minTime, minuteLabel, monthLabel, name, periodLabel, readonly, required, secondLabel, showSeconds, validationmessages, value, yearLabel, onChange, onBeforeinput, onInput, onInvalid
@docs withClass, withDayLabel, withDisabled, withHourLabel, withId, withMaxDate, withMaxTime, withMinDate, withMinTime, withMinuteLabel, withMonthLabel, withName, withOnBeforeinput, withOnChange, withOnInput, withOnInvalid, withPeriodLabel, withReadonly, withRequired, withSecondLabel, withShowSeconds, withSlot, withStyle, withTimeFormat, withType, withValidationmessages, withValue, withYearLabel

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
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-date-input` produces (open — composes into any slot naming it).
-}
type alias Is s =
    { s | dateInput : Brand }


{-| The closed attribute-capability row.
-}
type alias Attrs =
    { class : Supported
    , dayLabel : Supported
    , disabled : Supported
    , hourLabel : Supported
    , id : Supported
    , maxDate : Supported
    , maxTime : Supported
    , minDate : Supported
    , minTime : Supported
    , minuteLabel : Supported
    , monthLabel : Supported
    , name : Supported
    , onBeforeinput : Supported
    , onChange : Supported
    , onInput : Supported
    , onInvalid : Supported
    , periodLabel : Supported
    , readonly : Supported
    , required : Supported
    , secondLabel : Supported
    , showSeconds : Supported
    , slot : Supported
    , style : Supported
    , timeFormat : Supported
    , type_ : Supported
    , validationmessages : Supported
    , value : Supported
    , yearLabel : Supported
    }


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    { childAdm | dateInput : Ctx }


{-| The `timeFormat` values valid on this component (compile-tight narrowing).
-}
type alias TimeFormat =
    { value12 : Supported
    , value24 : Supported
    , auto : Supported
    }


{-| The `type_` values valid on this component (compile-tight narrowing).
-}
type alias Type =
    { date : Supported
    , datetime : Supported
    , time : Supported
    }


{-| Standard constructor: `[attributes] [children]`.
-}
view :
    List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
view =
    H.dateInput


{-| Format used when editing time values. (default: `"12"`)
-}
timeFormat : Value TimeFormat -> Attr { c | timeFormat : Supported } msg
timeFormat value_ =
    Ir.attribute "time-format" (Val.toString value_)


{-| The interaction mode for editing date and/or time values. (default: `"date"`)
-}
type_ : Value Type -> Attr { c | type_ : Supported } msg
type_ value_ =
    Ir.attribute "type" (Val.toString value_)


{-| See `M3e.Attributes.dayLabel`.
-}
dayLabel : String -> Attr { c | dayLabel : Supported } msg
dayLabel =
    A.dayLabel


{-| See `M3e.Attributes.disabled`.
-}
disabled : Bool -> Attr { c | disabled : Supported } msg
disabled =
    A.disabled


{-| See `M3e.Attributes.hourLabel`.
-}
hourLabel : String -> Attr { c | hourLabel : Supported } msg
hourLabel =
    A.hourLabel


{-| See `M3e.Attributes.maxDate`.
-}
maxDate : String -> Attr { c | maxDate : Supported } msg
maxDate =
    A.maxDate


{-| See `M3e.Attributes.maxTime`.
-}
maxTime : String -> Attr { c | maxTime : Supported } msg
maxTime =
    A.maxTime


{-| See `M3e.Attributes.minDate`.
-}
minDate : String -> Attr { c | minDate : Supported } msg
minDate =
    A.minDate


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


{-| See `M3e.Attributes.monthLabel`.
-}
monthLabel : String -> Attr { c | monthLabel : Supported } msg
monthLabel =
    A.monthLabel


{-| The name that identifies the element when submitting the associated form.
-}
name : String -> Attr { c | name : Supported } msg
name value_ =
    Ir.attribute "name" value_


{-| See `M3e.Attributes.periodLabel`.
-}
periodLabel : String -> Attr { c | periodLabel : Supported } msg
periodLabel =
    A.periodLabel


{-| See `M3e.Attributes.readonly`.
-}
readonly : Bool -> Attr { c | readonly : Supported } msg
readonly =
    A.readonly


{-| See `M3e.Attributes.required`.
-}
required : Bool -> Attr { c | required : Supported } msg
required =
    A.required


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


{-| See `M3e.Attributes.validationmessages`.
-}
validationmessages : String -> Attr { c | validationmessages : Supported } msg
validationmessages =
    A.validationmessages


{-| See `M3e.Attributes.value`.
-}
value : String -> Attr { c | value : Supported } msg
value =
    A.value


{-| See `M3e.Attributes.yearLabel`.
-}
yearLabel : String -> Attr { c | yearLabel : Supported } msg
yearLabel =
    A.yearLabel


{-| See `M3e.Events.onChange`.
-}
onChange : msg -> Attr { c | onChange : Supported } msg
onChange =
    Ev.onChange


{-| See `M3e.Events.onBeforeinput`.
-}
onBeforeinput : msg -> Attr { c | onBeforeinput : Supported } msg
onBeforeinput =
    Ev.onBeforeinput


{-| See `M3e.Events.onInput`.
-}
onInput : msg -> Attr { c | onInput : Supported } msg
onInput =
    Ev.onInput


{-| See `M3e.Events.onInvalid`.
-}
onInvalid : msg -> Attr { c | onInvalid : Supported } msg
onInvalid =
    Ev.onInvalid


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
    , dayLabel : Available
    , disabled : Available
    , hourLabel : Available
    , id : Available
    , maxDate : Available
    , maxTime : Available
    , minDate : Available
    , minTime : Available
    , minuteLabel : Available
    , monthLabel : Available
    , name : Available
    , onBeforeinput : Available
    , onChange : Available
    , onInput : Available
    , onInvalid : Available
    , periodLabel : Available
    , readonly : Available
    , required : Available
    , secondLabel : Available
    , showSeconds : Available
    , slot : Available
    , style : Available
    , timeFormat : Available
    , type_ : Available
    , validationmessages : Available
    , value : Available
    , yearLabel : Available
    }


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    {}


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg
build =
    B.init "m3e-date-input" [] []


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
withStyle : String -> String -> Builder { a | style : Available } slotCaps msg -> Builder { a | style : Used } slotCaps msg
withStyle property value_ =
    B.withAttribute (A.style property value_)


{-| Pipe form of `dayLabel` — consumes its capability (write-once).
-}
withDayLabel : String -> Builder { a | dayLabel : Available } slotCaps msg -> Builder { a | dayLabel : Used } slotCaps msg
withDayLabel value_ =
    B.withAttribute (A.dayLabel value_)


{-| Pipe form of `disabled` — consumes its capability (write-once).
-}
withDisabled : Bool -> Builder { a | disabled : Available } slotCaps msg -> Builder { a | disabled : Used } slotCaps msg
withDisabled value_ =
    B.withAttribute (A.disabled value_)


{-| Pipe form of `hourLabel` — consumes its capability (write-once).
-}
withHourLabel : String -> Builder { a | hourLabel : Available } slotCaps msg -> Builder { a | hourLabel : Used } slotCaps msg
withHourLabel value_ =
    B.withAttribute (A.hourLabel value_)


{-| Pipe form of `maxDate` — consumes its capability (write-once).
-}
withMaxDate : String -> Builder { a | maxDate : Available } slotCaps msg -> Builder { a | maxDate : Used } slotCaps msg
withMaxDate value_ =
    B.withAttribute (A.maxDate value_)


{-| Pipe form of `maxTime` — consumes its capability (write-once).
-}
withMaxTime : String -> Builder { a | maxTime : Available } slotCaps msg -> Builder { a | maxTime : Used } slotCaps msg
withMaxTime value_ =
    B.withAttribute (A.maxTime value_)


{-| Pipe form of `minDate` — consumes its capability (write-once).
-}
withMinDate : String -> Builder { a | minDate : Available } slotCaps msg -> Builder { a | minDate : Used } slotCaps msg
withMinDate value_ =
    B.withAttribute (A.minDate value_)


{-| Pipe form of `minTime` — consumes its capability (write-once).
-}
withMinTime : String -> Builder { a | minTime : Available } slotCaps msg -> Builder { a | minTime : Used } slotCaps msg
withMinTime value_ =
    B.withAttribute (A.minTime value_)


{-| Pipe form of `minuteLabel` — consumes its capability (write-once).
-}
withMinuteLabel : String -> Builder { a | minuteLabel : Available } slotCaps msg -> Builder { a | minuteLabel : Used } slotCaps msg
withMinuteLabel value_ =
    B.withAttribute (A.minuteLabel value_)


{-| Pipe form of `monthLabel` — consumes its capability (write-once).
-}
withMonthLabel : String -> Builder { a | monthLabel : Available } slotCaps msg -> Builder { a | monthLabel : Used } slotCaps msg
withMonthLabel value_ =
    B.withAttribute (A.monthLabel value_)


{-| Pipe form of `name` — consumes its capability (write-once).
-}
withName : String -> Builder { a | name : Available } slotCaps msg -> Builder { a | name : Used } slotCaps msg
withName value_ =
    B.withAttribute (Ir.attribute "name" value_)


{-| Pipe form of `periodLabel` — consumes its capability (write-once).
-}
withPeriodLabel : String -> Builder { a | periodLabel : Available } slotCaps msg -> Builder { a | periodLabel : Used } slotCaps msg
withPeriodLabel value_ =
    B.withAttribute (A.periodLabel value_)


{-| Pipe form of `readonly` — consumes its capability (write-once).
-}
withReadonly : Bool -> Builder { a | readonly : Available } slotCaps msg -> Builder { a | readonly : Used } slotCaps msg
withReadonly value_ =
    B.withAttribute (A.readonly value_)


{-| Pipe form of `required` — consumes its capability (write-once).
-}
withRequired : Bool -> Builder { a | required : Available } slotCaps msg -> Builder { a | required : Used } slotCaps msg
withRequired value_ =
    B.withAttribute (A.required value_)


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


{-| Pipe form of `timeFormat` — consumes its capability (write-once).
-}
withTimeFormat : Value TimeFormat -> Builder { a | timeFormat : Available } slotCaps msg -> Builder { a | timeFormat : Used } slotCaps msg
withTimeFormat value_ =
    B.withAttribute (timeFormat value_)


{-| Pipe form of `type_` — consumes its capability (write-once).
-}
withType : Value Type -> Builder { a | type_ : Available } slotCaps msg -> Builder { a | type_ : Used } slotCaps msg
withType value_ =
    B.withAttribute (type_ value_)


{-| Pipe form of `validationmessages` — consumes its capability (write-once).
-}
withValidationmessages : String -> Builder { a | validationmessages : Available } slotCaps msg -> Builder { a | validationmessages : Used } slotCaps msg
withValidationmessages value_ =
    B.withAttribute (A.validationmessages value_)


{-| Pipe form of `value` — consumes its capability (write-once).
-}
withValue : String -> Builder { a | value : Available } slotCaps msg -> Builder { a | value : Used } slotCaps msg
withValue value_ =
    B.withAttribute (A.value value_)


{-| Pipe form of `yearLabel` — consumes its capability (write-once).
-}
withYearLabel : String -> Builder { a | yearLabel : Available } slotCaps msg -> Builder { a | yearLabel : Used } slotCaps msg
withYearLabel value_ =
    B.withAttribute (A.yearLabel value_)


{-| Pipe form of `onChange` — consumes its capability (write-once).
-}
withOnChange : msg -> Builder { a | onChange : Available } slotCaps msg -> Builder { a | onChange : Used } slotCaps msg
withOnChange value_ =
    B.withAttribute (Ev.onChange value_)


{-| Pipe form of `onBeforeinput` — consumes its capability (write-once).
-}
withOnBeforeinput : msg -> Builder { a | onBeforeinput : Available } slotCaps msg -> Builder { a | onBeforeinput : Used } slotCaps msg
withOnBeforeinput value_ =
    B.withAttribute (Ev.onBeforeinput value_)


{-| Pipe form of `onInput` — consumes its capability (write-once).
-}
withOnInput : msg -> Builder { a | onInput : Available } slotCaps msg -> Builder { a | onInput : Used } slotCaps msg
withOnInput value_ =
    B.withAttribute (Ev.onInput value_)


{-| Pipe form of `onInvalid` — consumes its capability (write-once).
-}
withOnInvalid : msg -> Builder { a | onInvalid : Available } slotCaps msg -> Builder { a | onInvalid : Used } slotCaps msg
withOnInvalid value_ =
    B.withAttribute (Ev.onInvalid value_)
