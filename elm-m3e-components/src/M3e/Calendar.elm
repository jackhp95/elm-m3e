module M3e.Calendar exposing
    ( view, build, toElement
    , Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , StartView, startView
    , date, maxDate, minDate, nextMonthLabel, nextMultiYearLabel, nextYearLabel, previousMonthLabel, previousMultiYearLabel, previousYearLabel, rangeEnd, rangeStart, startAt, onChange
    , header
    , withClass, withDate, withHeader, withId, withMaxDate, withMinDate, withNextMonthLabel, withNextMultiYearLabel, withNextYearLabel, withOnChange, withPreviousMonthLabel, withPreviousMultiYearLabel, withPreviousYearLabel, withRangeEnd, withRangeStart, withSlot, withStartAt, withStartView, withStyle
    )

{-| The `m3e-calendar` component — strict per-component surface.

A calendar used to select a date.

@docs view, build, toElement
@docs Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs StartView, startView
@docs date, maxDate, minDate, nextMonthLabel, nextMultiYearLabel, nextYearLabel, previousMonthLabel, previousMultiYearLabel, previousYearLabel, rangeEnd, rangeStart, startAt, onChange
@docs header
@docs withClass, withDate, withHeader, withId, withMaxDate, withMinDate, withNextMonthLabel, withNextMultiYearLabel, withNextYearLabel, withOnChange, withPreviousMonthLabel, withPreviousMultiYearLabel, withPreviousYearLabel, withRangeEnd, withRangeStart, withSlot, withStartAt, withStartView, withStyle

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import HtmlIr.Value as Val exposing (Value)
import Json.Decode
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Events as Ev
import M3e.Html as H
import M3e.Internal.Types.Calendar
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-calendar` produces (open — composes into any slot naming it).
-}
type alias Is s =
    M3e.Internal.Types.Calendar.Is s


{-| The closed attribute-capability row.
-}
type alias Attrs =
    M3e.Internal.Types.Calendar.Attrs


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    M3e.Internal.Types.Calendar.ChildAdmittedBy childAdm


{-| The `startView` values valid on this component (compile-tight narrowing).
-}
type alias StartView =
    M3e.Internal.Types.Calendar.StartView


{-| Standard constructor: `[attributes] [children]`.
-}
view :
    List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
view =
    H.calendar


{-| The initial view used to select a date. (default: `"month"`)
-}
startView : Value StartView -> Attr { c | startView : Supported } msg
startView value_ =
    Ir.attribute "start-view" (Val.toString value_)


{-| See `M3e.Attributes.date`.
-}
date : String -> Attr { c | date : Supported } msg
date =
    A.date


{-| See `M3e.Attributes.maxDate`.
-}
maxDate : String -> Attr { c | maxDate : Supported } msg
maxDate =
    A.maxDate


{-| See `M3e.Attributes.minDate`.
-}
minDate : String -> Attr { c | minDate : Supported } msg
minDate =
    A.minDate


{-| See `M3e.Attributes.nextMonthLabel`.
-}
nextMonthLabel : String -> Attr { c | nextMonthLabel : Supported } msg
nextMonthLabel =
    A.nextMonthLabel


{-| See `M3e.Attributes.nextMultiYearLabel`.
-}
nextMultiYearLabel : String -> Attr { c | nextMultiYearLabel : Supported } msg
nextMultiYearLabel =
    A.nextMultiYearLabel


{-| See `M3e.Attributes.nextYearLabel`.
-}
nextYearLabel : String -> Attr { c | nextYearLabel : Supported } msg
nextYearLabel =
    A.nextYearLabel


{-| See `M3e.Attributes.previousMonthLabel`.
-}
previousMonthLabel : String -> Attr { c | previousMonthLabel : Supported } msg
previousMonthLabel =
    A.previousMonthLabel


{-| See `M3e.Attributes.previousMultiYearLabel`.
-}
previousMultiYearLabel : String -> Attr { c | previousMultiYearLabel : Supported } msg
previousMultiYearLabel =
    A.previousMultiYearLabel


{-| See `M3e.Attributes.previousYearLabel`.
-}
previousYearLabel : String -> Attr { c | previousYearLabel : Supported } msg
previousYearLabel =
    A.previousYearLabel


{-| See `M3e.Attributes.rangeEnd`.
-}
rangeEnd : String -> Attr { c | rangeEnd : Supported } msg
rangeEnd =
    A.rangeEnd


{-| See `M3e.Attributes.rangeStart`.
-}
rangeStart : String -> Attr { c | rangeStart : Supported } msg
rangeStart =
    A.rangeStart


{-| See `M3e.Attributes.startAt`.
-}
startAt : String -> Attr { c | startAt : Supported } msg
startAt =
    A.startAt


{-| Typed `change` event: decodes `target.date` as String.
-}
onChange : (String -> msg) -> Attr { c | onChange : Supported } msg
onChange toMsg =
    Ir.on "change" (Json.Decode.map toMsg (Json.Decode.at [ "target", "date" ] Json.Decode.string))


{-| Place an element into the named `header` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
header : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
header element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "header") (El.toNode element))


{-| The pipe-builder: capabilities are consumed Available→Used, so writing
a singular attribute or slot twice is unwritable. Aliases the shared builder in
`Build.Internal`, closed over this component's `Attrs` row and `Is s` kind.
-}
type alias Builder attrCaps slotCaps msg s =
    M3e.Internal.Types.Calendar.Builder attrCaps slotCaps msg s


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    M3e.Internal.Types.Calendar.AttrCaps


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    M3e.Internal.Types.Calendar.SlotCaps


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg kind
build =
    B.init "m3e-calendar" [] []


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


{-| Pipe form of `date` — consumes its capability (write-once).
-}
withDate : String -> Builder { a | date : Available } slotCaps msg kind -> Builder { a | date : Used } slotCaps msg kind
withDate value_ =
    B.withAttribute (A.date value_)


{-| Pipe form of `maxDate` — consumes its capability (write-once).
-}
withMaxDate : String -> Builder { a | maxDate : Available } slotCaps msg kind -> Builder { a | maxDate : Used } slotCaps msg kind
withMaxDate value_ =
    B.withAttribute (A.maxDate value_)


{-| Pipe form of `minDate` — consumes its capability (write-once).
-}
withMinDate : String -> Builder { a | minDate : Available } slotCaps msg kind -> Builder { a | minDate : Used } slotCaps msg kind
withMinDate value_ =
    B.withAttribute (A.minDate value_)


{-| Pipe form of `nextMonthLabel` — consumes its capability (write-once).
-}
withNextMonthLabel : String -> Builder { a | nextMonthLabel : Available } slotCaps msg kind -> Builder { a | nextMonthLabel : Used } slotCaps msg kind
withNextMonthLabel value_ =
    B.withAttribute (A.nextMonthLabel value_)


{-| Pipe form of `nextMultiYearLabel` — consumes its capability (write-once).
-}
withNextMultiYearLabel : String -> Builder { a | nextMultiYearLabel : Available } slotCaps msg kind -> Builder { a | nextMultiYearLabel : Used } slotCaps msg kind
withNextMultiYearLabel value_ =
    B.withAttribute (A.nextMultiYearLabel value_)


{-| Pipe form of `nextYearLabel` — consumes its capability (write-once).
-}
withNextYearLabel : String -> Builder { a | nextYearLabel : Available } slotCaps msg kind -> Builder { a | nextYearLabel : Used } slotCaps msg kind
withNextYearLabel value_ =
    B.withAttribute (A.nextYearLabel value_)


{-| Pipe form of `previousMonthLabel` — consumes its capability (write-once).
-}
withPreviousMonthLabel : String -> Builder { a | previousMonthLabel : Available } slotCaps msg kind -> Builder { a | previousMonthLabel : Used } slotCaps msg kind
withPreviousMonthLabel value_ =
    B.withAttribute (A.previousMonthLabel value_)


{-| Pipe form of `previousMultiYearLabel` — consumes its capability (write-once).
-}
withPreviousMultiYearLabel : String -> Builder { a | previousMultiYearLabel : Available } slotCaps msg kind -> Builder { a | previousMultiYearLabel : Used } slotCaps msg kind
withPreviousMultiYearLabel value_ =
    B.withAttribute (A.previousMultiYearLabel value_)


{-| Pipe form of `previousYearLabel` — consumes its capability (write-once).
-}
withPreviousYearLabel : String -> Builder { a | previousYearLabel : Available } slotCaps msg kind -> Builder { a | previousYearLabel : Used } slotCaps msg kind
withPreviousYearLabel value_ =
    B.withAttribute (A.previousYearLabel value_)


{-| Pipe form of `rangeEnd` — consumes its capability (write-once).
-}
withRangeEnd : String -> Builder { a | rangeEnd : Available } slotCaps msg kind -> Builder { a | rangeEnd : Used } slotCaps msg kind
withRangeEnd value_ =
    B.withAttribute (A.rangeEnd value_)


{-| Pipe form of `rangeStart` — consumes its capability (write-once).
-}
withRangeStart : String -> Builder { a | rangeStart : Available } slotCaps msg kind -> Builder { a | rangeStart : Used } slotCaps msg kind
withRangeStart value_ =
    B.withAttribute (A.rangeStart value_)


{-| Pipe form of `startAt` — consumes its capability (write-once).
-}
withStartAt : String -> Builder { a | startAt : Available } slotCaps msg kind -> Builder { a | startAt : Used } slotCaps msg kind
withStartAt value_ =
    B.withAttribute (A.startAt value_)


{-| Pipe form of `startView` — consumes its capability (write-once).
-}
withStartView : Value StartView -> Builder { a | startView : Available } slotCaps msg kind -> Builder { a | startView : Used } slotCaps msg kind
withStartView value_ =
    B.withAttribute (startView value_)


{-| Pipe form of `onChange` — consumes its capability (write-once).
-}
withOnChange : (String -> msg) -> Builder { a | onChange : Available } slotCaps msg kind -> Builder { a | onChange : Used } slotCaps msg kind
withOnChange value_ =
    B.withAttribute (onChange value_)


{-| Pipe form of the `header` slot — consumes its capability (write-once).
-}
withHeader : Element childAccepts admittedBy msg -> Builder attrCaps { s | header : Available } msg kind -> Builder attrCaps { s | header : Used } msg kind
withHeader element =
    B.withChild (El.toNode (header element))
