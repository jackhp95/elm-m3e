module M3e.MonthView exposing
    ( view, build, toElement
    , Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , active, activeDate, date, maxDate, minDate, rangeEnd, rangeStart, today, onChange, onActiveChange
    , withActive, withActiveDate, withClass, withDate, withId, withMaxDate, withMinDate, withOnActiveChange, withOnChange, withRangeEnd, withRangeStart, withSlot, withStyle, withToday
    )

{-| The `m3e-month-view` component — strict per-component surface.

An internal component used to display a single month in a calendar.

@docs view, build, toElement
@docs Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs active, activeDate, date, maxDate, minDate, rangeEnd, rangeStart, today, onChange, onActiveChange
@docs withActive, withActiveDate, withClass, withDate, withId, withMaxDate, withMinDate, withOnActiveChange, withOnChange, withRangeEnd, withRangeStart, withSlot, withStyle, withToday

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Events as Ev
import M3e.Html as H
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-month-view` produces (open — composes into any slot naming it).
-}
type alias Is s =
    { s | monthView : Brand }


{-| The closed attribute-capability row.
-}
type alias Attrs =
    { active : Supported
    , activeDate : Supported
    , class : Supported
    , date : Supported
    , id : Supported
    , maxDate : Supported
    , minDate : Supported
    , onActiveChange : Supported
    , onChange : Supported
    , rangeEnd : Supported
    , rangeStart : Supported
    , slot : Supported
    , style : Supported
    , today : Supported
    }


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    { childAdm | monthView : Ctx }


{-| Standard constructor: `[attributes] [children]`.
-}
view :
    List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
view =
    H.monthView


{-| See `M3e.Attributes.active`.
-}
active : Bool -> Attr { c | active : Supported } msg
active =
    A.active


{-| See `M3e.Attributes.activeDate`.
-}
activeDate : String -> Attr { c | activeDate : Supported } msg
activeDate =
    A.activeDate


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


{-| See `M3e.Attributes.today`.
-}
today : String -> Attr { c | today : Supported } msg
today =
    A.today


{-| See `M3e.Events.onChange`.
-}
onChange : msg -> Attr { c | onChange : Supported } msg
onChange =
    Ev.onChange


{-| See `M3e.Events.onActiveChange`.
-}
onActiveChange : msg -> Attr { c | onActiveChange : Supported } msg
onActiveChange =
    Ev.onActiveChange


{-| The pipe-builder: capabilities are consumed Available→Used, so writing
a singular attribute or slot twice is unwritable. Aliases the shared builder in
`Build.Internal`, closed over this component's `Attrs` row.
-}
type alias Builder attrCaps slotCaps msg =
    B.Builder Attrs attrCaps slotCaps msg


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    { active : Available
    , activeDate : Available
    , class : Available
    , date : Available
    , id : Available
    , maxDate : Available
    , minDate : Available
    , onActiveChange : Available
    , onChange : Available
    , rangeEnd : Available
    , rangeStart : Available
    , slot : Available
    , style : Available
    , today : Available
    }


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    {}


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg
build =
    B.init "m3e-month-view" [] []


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


{-| Pipe form of `active` — consumes its capability (write-once).
-}
withActive : Bool -> Builder { a | active : Available } slotCaps msg -> Builder { a | active : Used } slotCaps msg
withActive value_ =
    B.withAttribute (A.active value_)


{-| Pipe form of `activeDate` — consumes its capability (write-once).
-}
withActiveDate : String -> Builder { a | activeDate : Available } slotCaps msg -> Builder { a | activeDate : Used } slotCaps msg
withActiveDate value_ =
    B.withAttribute (A.activeDate value_)


{-| Pipe form of `date` — consumes its capability (write-once).
-}
withDate : String -> Builder { a | date : Available } slotCaps msg -> Builder { a | date : Used } slotCaps msg
withDate value_ =
    B.withAttribute (A.date value_)


{-| Pipe form of `maxDate` — consumes its capability (write-once).
-}
withMaxDate : String -> Builder { a | maxDate : Available } slotCaps msg -> Builder { a | maxDate : Used } slotCaps msg
withMaxDate value_ =
    B.withAttribute (A.maxDate value_)


{-| Pipe form of `minDate` — consumes its capability (write-once).
-}
withMinDate : String -> Builder { a | minDate : Available } slotCaps msg -> Builder { a | minDate : Used } slotCaps msg
withMinDate value_ =
    B.withAttribute (A.minDate value_)


{-| Pipe form of `rangeEnd` — consumes its capability (write-once).
-}
withRangeEnd : String -> Builder { a | rangeEnd : Available } slotCaps msg -> Builder { a | rangeEnd : Used } slotCaps msg
withRangeEnd value_ =
    B.withAttribute (A.rangeEnd value_)


{-| Pipe form of `rangeStart` — consumes its capability (write-once).
-}
withRangeStart : String -> Builder { a | rangeStart : Available } slotCaps msg -> Builder { a | rangeStart : Used } slotCaps msg
withRangeStart value_ =
    B.withAttribute (A.rangeStart value_)


{-| Pipe form of `today` — consumes its capability (write-once).
-}
withToday : String -> Builder { a | today : Available } slotCaps msg -> Builder { a | today : Used } slotCaps msg
withToday value_ =
    B.withAttribute (A.today value_)


{-| Pipe form of `onChange` — consumes its capability (write-once).
-}
withOnChange : msg -> Builder { a | onChange : Available } slotCaps msg -> Builder { a | onChange : Used } slotCaps msg
withOnChange value_ =
    B.withAttribute (Ev.onChange value_)


{-| Pipe form of `onActiveChange` — consumes its capability (write-once).
-}
withOnActiveChange : msg -> Builder { a | onActiveChange : Available } slotCaps msg -> Builder { a | onActiveChange : Used } slotCaps msg
withOnActiveChange value_ =
    B.withAttribute (Ev.onActiveChange value_)
