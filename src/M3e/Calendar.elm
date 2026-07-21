module M3e.Calendar exposing
    ( view, build, toElement
    , Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , StartView, startView
    , date, maxDate, minDate, nextMonthLabel, nextMultiYearLabel, nextYearLabel, previousMonthLabel, previousMultiYearLabel, previousYearLabel, rangeEnd, rangeStart, startAt, onChange
    , header
    , withAriaLabel, withClass, withDate, withHeader, withId, withMaxDate, withMinDate, withNextMonthLabel, withNextMultiYearLabel, withNextYearLabel, withOnChange, withPreviousMonthLabel, withPreviousMultiYearLabel, withPreviousYearLabel, withRangeEnd, withRangeStart, withSlot, withStartAt, withStartView, withStyle
    )

{-| The `m3e-calendar` component — strict per-component surface.

A calendar used to select a date.

@docs view, build, toElement
@docs Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs StartView, startView
@docs date, maxDate, minDate, nextMonthLabel, nextMultiYearLabel, nextYearLabel, previousMonthLabel, previousMultiYearLabel, previousYearLabel, rangeEnd, rangeStart, startAt, onChange
@docs header
@docs withAriaLabel, withClass, withDate, withHeader, withId, withMaxDate, withMinDate, withNextMonthLabel, withNextMultiYearLabel, withNextYearLabel, withOnChange, withPreviousMonthLabel, withPreviousMultiYearLabel, withPreviousYearLabel, withRangeEnd, withRangeStart, withSlot, withStartAt, withStartView, withStyle

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import HtmlIr.Node exposing (Node)
import HtmlIr.Value exposing (Value)
import Json.Decode
import M3e.Attributes
import M3e.Events
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-calendar` produces (open — composes into any slot naming it).
-}
type alias Is s =
    { s | calendar : Brand }


{-| The closed attribute-capability row.
-}
type alias Attrs =
    { ariaLabel : Supported
    , class : Supported
    , date : Supported
    , id : Supported
    , maxDate : Supported
    , minDate : Supported
    , nextMonthLabel : Supported
    , nextMultiYearLabel : Supported
    , nextYearLabel : Supported
    , onChange : Supported
    , previousMonthLabel : Supported
    , previousMultiYearLabel : Supported
    , previousYearLabel : Supported
    , rangeEnd : Supported
    , rangeStart : Supported
    , slot : Supported
    , startAt : Supported
    , startView : Supported
    , style : Supported
    }


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    { childAdm | calendar : Ctx }


{-| The `startView` values valid on this component (compile-tight narrowing).
-}
type alias StartView =
    { month : Supported
    , multiYear : Supported
    , year : Supported
    }


{-| Standard constructor: `[attributes] [children]`.
-}
view :
    List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
view attrs children =
    Ir.fromNode (Ir.node "m3e-calendar" attrs (List.map HtmlIr.Element.toNode children))


{-| Narrowed value setter for `startView`. Tokens come from `M3e.Values`.
-}
startView : Value StartView -> Attr { c | startView : Supported } msg
startView value_ =
    Ir.attribute "start-view" (HtmlIr.Value.toString value_)


{-| See `M3e.Attributes.date`.
-}
date : String -> Attr { c | date : Supported } msg
date =
    M3e.Attributes.date


{-| See `M3e.Attributes.maxDate`.
-}
maxDate : String -> Attr { c | maxDate : Supported } msg
maxDate =
    M3e.Attributes.maxDate


{-| See `M3e.Attributes.minDate`.
-}
minDate : String -> Attr { c | minDate : Supported } msg
minDate =
    M3e.Attributes.minDate


{-| See `M3e.Attributes.nextMonthLabel`.
-}
nextMonthLabel : String -> Attr { c | nextMonthLabel : Supported } msg
nextMonthLabel =
    M3e.Attributes.nextMonthLabel


{-| See `M3e.Attributes.nextMultiYearLabel`.
-}
nextMultiYearLabel : String -> Attr { c | nextMultiYearLabel : Supported } msg
nextMultiYearLabel =
    M3e.Attributes.nextMultiYearLabel


{-| See `M3e.Attributes.nextYearLabel`.
-}
nextYearLabel : String -> Attr { c | nextYearLabel : Supported } msg
nextYearLabel =
    M3e.Attributes.nextYearLabel


{-| See `M3e.Attributes.previousMonthLabel`.
-}
previousMonthLabel : String -> Attr { c | previousMonthLabel : Supported } msg
previousMonthLabel =
    M3e.Attributes.previousMonthLabel


{-| See `M3e.Attributes.previousMultiYearLabel`.
-}
previousMultiYearLabel : String -> Attr { c | previousMultiYearLabel : Supported } msg
previousMultiYearLabel =
    M3e.Attributes.previousMultiYearLabel


{-| See `M3e.Attributes.previousYearLabel`.
-}
previousYearLabel : String -> Attr { c | previousYearLabel : Supported } msg
previousYearLabel =
    M3e.Attributes.previousYearLabel


{-| See `M3e.Attributes.rangeEnd`.
-}
rangeEnd : String -> Attr { c | rangeEnd : Supported } msg
rangeEnd =
    M3e.Attributes.rangeEnd


{-| See `M3e.Attributes.rangeStart`.
-}
rangeStart : String -> Attr { c | rangeStart : Supported } msg
rangeStart =
    M3e.Attributes.rangeStart


{-| See `M3e.Attributes.startAt`.
-}
startAt : String -> Attr { c | startAt : Supported } msg
startAt =
    M3e.Attributes.startAt


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
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "header") (HtmlIr.Element.toNode element))


{-| The pipe-builder: capabilities are consumed Available→Used, so writing
a singular attribute or slot twice is unwritable.
-}
type Builder attrCaps slotCaps msg
    = Builder { attrs : List (Attr Attrs msg), children : List (Node msg) }


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    { ariaLabel : Available
    , class : Available
    , date : Available
    , id : Available
    , maxDate : Available
    , minDate : Available
    , nextMonthLabel : Available
    , nextMultiYearLabel : Available
    , nextYearLabel : Available
    , onChange : Available
    , previousMonthLabel : Available
    , previousMultiYearLabel : Available
    , previousYearLabel : Available
    , rangeEnd : Available
    , rangeStart : Available
    , slot : Available
    , startAt : Available
    , startView : Available
    , style : Available
    }


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    { header : Available
    }


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg
build =
    Builder { attrs = [], children = [] }


{-| Close the pipe-builder.
-}
toElement : Builder attrCaps slotCaps msg -> Element (Is s) admittedBy msg
toElement (Builder b) =
    Ir.fromNode (Ir.node "m3e-calendar" (List.reverse b.attrs) (List.reverse b.children))


{-| Pipe form of `ariaLabel` — consumes its capability (write-once).
-}
withAriaLabel : String -> Builder { a | ariaLabel : Available } slotCaps msg -> Builder { a | ariaLabel : Used } slotCaps msg
withAriaLabel value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.ariaLabel value_ :: b.attrs }


{-| Pipe form of `class` — consumes its capability (write-once).
-}
withClass : String -> Builder { a | class : Available } slotCaps msg -> Builder { a | class : Used } slotCaps msg
withClass value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.class value_ :: b.attrs }


{-| Pipe form of `id` — consumes its capability (write-once).
-}
withId : String -> Builder { a | id : Available } slotCaps msg -> Builder { a | id : Used } slotCaps msg
withId value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.id value_ :: b.attrs }


{-| Pipe form of `slot` — consumes its capability (write-once).
-}
withSlot : String -> Builder { a | slot : Available } slotCaps msg -> Builder { a | slot : Used } slotCaps msg
withSlot value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.slot value_ :: b.attrs }


{-| Pipe form of `style` — consumes its capability (write-once).
-}
withStyle : String -> Builder { a | style : Available } slotCaps msg -> Builder { a | style : Used } slotCaps msg
withStyle value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.style value_ :: b.attrs }


{-| Pipe form of `date` — consumes its capability (write-once).
-}
withDate : String -> Builder { a | date : Available } slotCaps msg -> Builder { a | date : Used } slotCaps msg
withDate value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.date value_ :: b.attrs }


{-| Pipe form of `maxDate` — consumes its capability (write-once).
-}
withMaxDate : String -> Builder { a | maxDate : Available } slotCaps msg -> Builder { a | maxDate : Used } slotCaps msg
withMaxDate value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.maxDate value_ :: b.attrs }


{-| Pipe form of `minDate` — consumes its capability (write-once).
-}
withMinDate : String -> Builder { a | minDate : Available } slotCaps msg -> Builder { a | minDate : Used } slotCaps msg
withMinDate value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.minDate value_ :: b.attrs }


{-| Pipe form of `nextMonthLabel` — consumes its capability (write-once).
-}
withNextMonthLabel : String -> Builder { a | nextMonthLabel : Available } slotCaps msg -> Builder { a | nextMonthLabel : Used } slotCaps msg
withNextMonthLabel value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.nextMonthLabel value_ :: b.attrs }


{-| Pipe form of `nextMultiYearLabel` — consumes its capability (write-once).
-}
withNextMultiYearLabel : String -> Builder { a | nextMultiYearLabel : Available } slotCaps msg -> Builder { a | nextMultiYearLabel : Used } slotCaps msg
withNextMultiYearLabel value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.nextMultiYearLabel value_ :: b.attrs }


{-| Pipe form of `nextYearLabel` — consumes its capability (write-once).
-}
withNextYearLabel : String -> Builder { a | nextYearLabel : Available } slotCaps msg -> Builder { a | nextYearLabel : Used } slotCaps msg
withNextYearLabel value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.nextYearLabel value_ :: b.attrs }


{-| Pipe form of `previousMonthLabel` — consumes its capability (write-once).
-}
withPreviousMonthLabel : String -> Builder { a | previousMonthLabel : Available } slotCaps msg -> Builder { a | previousMonthLabel : Used } slotCaps msg
withPreviousMonthLabel value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.previousMonthLabel value_ :: b.attrs }


{-| Pipe form of `previousMultiYearLabel` — consumes its capability (write-once).
-}
withPreviousMultiYearLabel : String -> Builder { a | previousMultiYearLabel : Available } slotCaps msg -> Builder { a | previousMultiYearLabel : Used } slotCaps msg
withPreviousMultiYearLabel value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.previousMultiYearLabel value_ :: b.attrs }


{-| Pipe form of `previousYearLabel` — consumes its capability (write-once).
-}
withPreviousYearLabel : String -> Builder { a | previousYearLabel : Available } slotCaps msg -> Builder { a | previousYearLabel : Used } slotCaps msg
withPreviousYearLabel value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.previousYearLabel value_ :: b.attrs }


{-| Pipe form of `rangeEnd` — consumes its capability (write-once).
-}
withRangeEnd : String -> Builder { a | rangeEnd : Available } slotCaps msg -> Builder { a | rangeEnd : Used } slotCaps msg
withRangeEnd value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.rangeEnd value_ :: b.attrs }


{-| Pipe form of `rangeStart` — consumes its capability (write-once).
-}
withRangeStart : String -> Builder { a | rangeStart : Available } slotCaps msg -> Builder { a | rangeStart : Used } slotCaps msg
withRangeStart value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.rangeStart value_ :: b.attrs }


{-| Pipe form of `startAt` — consumes its capability (write-once).
-}
withStartAt : String -> Builder { a | startAt : Available } slotCaps msg -> Builder { a | startAt : Used } slotCaps msg
withStartAt value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.startAt value_ :: b.attrs }


{-| Pipe form of `startView` — consumes its capability (write-once).
-}
withStartView : Value StartView -> Builder { a | startView : Available } slotCaps msg -> Builder { a | startView : Used } slotCaps msg
withStartView value_ (Builder b) =
    Builder { b | attrs = startView value_ :: b.attrs }


{-| Pipe form of `onChange` — consumes its capability (write-once).
-}
withOnChange : (String -> msg) -> Builder { a | onChange : Available } slotCaps msg -> Builder { a | onChange : Used } slotCaps msg
withOnChange value_ (Builder b) =
    Builder { b | attrs = onChange value_ :: b.attrs }


{-| Pipe form of the `header` slot — consumes its capability (write-once).
-}
withHeader : Element childAccepts admittedBy msg -> Builder attrCaps { s | header : Available } msg -> Builder attrCaps { s | header : Used } msg
withHeader element (Builder b) =
    Builder { b | children = HtmlIr.Element.toNode (header element) :: b.children }
