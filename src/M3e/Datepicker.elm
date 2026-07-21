module M3e.Datepicker exposing
    ( view, build, toElement
    , Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , StartView, startView, Variant, variant
    , clearLabel, clearable, confirmLabel, date, dismissLabel, label, maxDate, minDate, nextMonthLabel, nextMultiYearLabel, nextYearLabel, previousMonthLabel, previousMultiYearLabel, previousYearLabel, range, rangeEnd, rangeStart, startAt, onChange, onBeforetoggle, onToggle
    , withClass, withClearLabel, withClearable, withConfirmLabel, withDate, withDismissLabel, withId, withLabel, withMaxDate, withMinDate, withNextMonthLabel, withNextMultiYearLabel, withNextYearLabel, withOnBeforetoggle, withOnChange, withOnToggle, withPreviousMonthLabel, withPreviousMultiYearLabel, withPreviousYearLabel, withRange, withRangeEnd, withRangeStart, withSlot, withStartAt, withStartView, withStyle, withVariant
    )

{-| The `m3e-datepicker` component — strict per-component surface.

Presents a date picker on a temporary surface.

@docs view, build, toElement
@docs Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs StartView, startView, Variant, variant
@docs clearLabel, clearable, confirmLabel, date, dismissLabel, label, maxDate, minDate, nextMonthLabel, nextMultiYearLabel, nextYearLabel, previousMonthLabel, previousMultiYearLabel, previousYearLabel, range, rangeEnd, rangeStart, startAt, onChange, onBeforetoggle, onToggle
@docs withClass, withClearLabel, withClearable, withConfirmLabel, withDate, withDismissLabel, withId, withLabel, withMaxDate, withMinDate, withNextMonthLabel, withNextMultiYearLabel, withNextYearLabel, withOnBeforetoggle, withOnChange, withOnToggle, withPreviousMonthLabel, withPreviousMultiYearLabel, withPreviousYearLabel, withRange, withRangeEnd, withRangeStart, withSlot, withStartAt, withStartView, withStyle, withVariant

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import HtmlIr.Node exposing (Node)
import HtmlIr.Value exposing (Value)
import M3e.Attributes
import M3e.Events
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-datepicker` produces (open — composes into any slot naming it).
-}
type alias Is s =
    { s | datepicker : Brand }


{-| The closed attribute-capability row.
-}
type alias Attrs =
    { class : Supported
    , clearLabel : Supported
    , clearable : Supported
    , confirmLabel : Supported
    , date : Supported
    , dismissLabel : Supported
    , id : Supported
    , label : Supported
    , maxDate : Supported
    , minDate : Supported
    , nextMonthLabel : Supported
    , nextMultiYearLabel : Supported
    , nextYearLabel : Supported
    , onBeforetoggle : Supported
    , onChange : Supported
    , onToggle : Supported
    , previousMonthLabel : Supported
    , previousMultiYearLabel : Supported
    , previousYearLabel : Supported
    , range : Supported
    , rangeEnd : Supported
    , rangeStart : Supported
    , slot : Supported
    , startAt : Supported
    , startView : Supported
    , style : Supported
    , variant : Supported
    }


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    { childAdm | datepicker : Ctx }


{-| The `startView` values valid on this component (compile-tight narrowing).
-}
type alias StartView =
    { month : Supported
    , multiYear : Supported
    , year : Supported
    }


{-| The `variant` values valid on this component (compile-tight narrowing).
-}
type alias Variant =
    { auto : Supported
    , docked : Supported
    , modal : Supported
    }


{-| Standard constructor: `[attributes] [children]`.
-}
view :
    List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
view attrs children =
    Ir.fromNode (Ir.node "m3e-datepicker" attrs (List.map HtmlIr.Element.toNode children))


{-| Narrowed value setter for `startView`. Tokens come from `M3e.Values`.
-}
startView : Value StartView -> Attr { c | startView : Supported } msg
startView value_ =
    Ir.attribute "start-view" (HtmlIr.Value.toString value_)


{-| Narrowed value setter for `variant`. Tokens come from `M3e.Values`.
-}
variant : Value Variant -> Attr { c | variant : Supported } msg
variant value_ =
    Ir.attribute "variant" (HtmlIr.Value.toString value_)


{-| See `M3e.Attributes.clearLabel`.
-}
clearLabel : String -> Attr { c | clearLabel : Supported } msg
clearLabel =
    M3e.Attributes.clearLabel


{-| See `M3e.Attributes.clearable`.
-}
clearable : Bool -> Attr { c | clearable : Supported } msg
clearable =
    M3e.Attributes.clearable


{-| See `M3e.Attributes.confirmLabel`.
-}
confirmLabel : String -> Attr { c | confirmLabel : Supported } msg
confirmLabel =
    M3e.Attributes.confirmLabel


{-| See `M3e.Attributes.date`.
-}
date : String -> Attr { c | date : Supported } msg
date =
    M3e.Attributes.date


{-| See `M3e.Attributes.dismissLabel`.
-}
dismissLabel : String -> Attr { c | dismissLabel : Supported } msg
dismissLabel =
    M3e.Attributes.dismissLabel


{-| See `M3e.Attributes.label`.
-}
label : String -> Attr { c | label : Supported } msg
label =
    M3e.Attributes.label


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


{-| See `M3e.Attributes.range`.
-}
range : Bool -> Attr { c | range : Supported } msg
range =
    M3e.Attributes.range


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


{-| See `M3e.Events.onChange`.
-}
onChange : msg -> Attr { c | onChange : Supported } msg
onChange =
    M3e.Events.onChange


{-| See `M3e.Events.onBeforetoggle`.
-}
onBeforetoggle : msg -> Attr { c | onBeforetoggle : Supported } msg
onBeforetoggle =
    M3e.Events.onBeforetoggle


{-| See `M3e.Events.onToggle`.
-}
onToggle : msg -> Attr { c | onToggle : Supported } msg
onToggle =
    M3e.Events.onToggle


{-| The pipe-builder: capabilities are consumed Available→Used, so writing
a singular attribute or slot twice is unwritable.
-}
type Builder attrCaps slotCaps msg
    = Builder { attrs : List (Attr Attrs msg), children : List (Node msg) }


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    { class : Available
    , clearLabel : Available
    , clearable : Available
    , confirmLabel : Available
    , date : Available
    , dismissLabel : Available
    , id : Available
    , label : Available
    , maxDate : Available
    , minDate : Available
    , nextMonthLabel : Available
    , nextMultiYearLabel : Available
    , nextYearLabel : Available
    , onBeforetoggle : Available
    , onChange : Available
    , onToggle : Available
    , previousMonthLabel : Available
    , previousMultiYearLabel : Available
    , previousYearLabel : Available
    , range : Available
    , rangeEnd : Available
    , rangeStart : Available
    , slot : Available
    , startAt : Available
    , startView : Available
    , style : Available
    , variant : Available
    }


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    {}


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg
build =
    Builder { attrs = [], children = [] }


{-| Close the pipe-builder.
-}
toElement : Builder attrCaps slotCaps msg -> Element (Is s) admittedBy msg
toElement (Builder b) =
    Ir.fromNode (Ir.node "m3e-datepicker" (List.reverse b.attrs) (List.reverse b.children))


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


{-| Pipe form of `clearLabel` — consumes its capability (write-once).
-}
withClearLabel : String -> Builder { a | clearLabel : Available } slotCaps msg -> Builder { a | clearLabel : Used } slotCaps msg
withClearLabel value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.clearLabel value_ :: b.attrs }


{-| Pipe form of `clearable` — consumes its capability (write-once).
-}
withClearable : Bool -> Builder { a | clearable : Available } slotCaps msg -> Builder { a | clearable : Used } slotCaps msg
withClearable value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.clearable value_ :: b.attrs }


{-| Pipe form of `confirmLabel` — consumes its capability (write-once).
-}
withConfirmLabel : String -> Builder { a | confirmLabel : Available } slotCaps msg -> Builder { a | confirmLabel : Used } slotCaps msg
withConfirmLabel value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.confirmLabel value_ :: b.attrs }


{-| Pipe form of `date` — consumes its capability (write-once).
-}
withDate : String -> Builder { a | date : Available } slotCaps msg -> Builder { a | date : Used } slotCaps msg
withDate value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.date value_ :: b.attrs }


{-| Pipe form of `dismissLabel` — consumes its capability (write-once).
-}
withDismissLabel : String -> Builder { a | dismissLabel : Available } slotCaps msg -> Builder { a | dismissLabel : Used } slotCaps msg
withDismissLabel value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.dismissLabel value_ :: b.attrs }


{-| Pipe form of `label` — consumes its capability (write-once).
-}
withLabel : String -> Builder { a | label : Available } slotCaps msg -> Builder { a | label : Used } slotCaps msg
withLabel value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.label value_ :: b.attrs }


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


{-| Pipe form of `range` — consumes its capability (write-once).
-}
withRange : Bool -> Builder { a | range : Available } slotCaps msg -> Builder { a | range : Used } slotCaps msg
withRange value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.range value_ :: b.attrs }


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


{-| Pipe form of `variant` — consumes its capability (write-once).
-}
withVariant : Value Variant -> Builder { a | variant : Available } slotCaps msg -> Builder { a | variant : Used } slotCaps msg
withVariant value_ (Builder b) =
    Builder { b | attrs = variant value_ :: b.attrs }


{-| Pipe form of `onChange` — consumes its capability (write-once).
-}
withOnChange : msg -> Builder { a | onChange : Available } slotCaps msg -> Builder { a | onChange : Used } slotCaps msg
withOnChange value_ (Builder b) =
    Builder { b | attrs = M3e.Events.onChange value_ :: b.attrs }


{-| Pipe form of `onBeforetoggle` — consumes its capability (write-once).
-}
withOnBeforetoggle : msg -> Builder { a | onBeforetoggle : Available } slotCaps msg -> Builder { a | onBeforetoggle : Used } slotCaps msg
withOnBeforetoggle value_ (Builder b) =
    Builder { b | attrs = M3e.Events.onBeforetoggle value_ :: b.attrs }


{-| Pipe form of `onToggle` — consumes its capability (write-once).
-}
withOnToggle : msg -> Builder { a | onToggle : Available } slotCaps msg -> Builder { a | onToggle : Used } slotCaps msg
withOnToggle value_ (Builder b) =
    Builder { b | attrs = M3e.Events.onToggle value_ :: b.attrs }
