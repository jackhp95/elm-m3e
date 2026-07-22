module M3e.YearView exposing
    ( view, build, toElement
    , Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , active, activeDate, date, maxDate, minDate, today, onChange, onActiveChange
    , withActive, withActiveDate, withClass, withDate, withId, withMaxDate, withMinDate, withOnActiveChange, withOnChange, withSlot, withStyle, withToday
    )

{-| The `m3e-year-view` component — strict per-component surface.

An internal component used to display a single year in a calendar.

@docs view, build, toElement
@docs Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs active, activeDate, date, maxDate, minDate, today, onChange, onActiveChange
@docs withActive, withActiveDate, withClass, withDate, withId, withMaxDate, withMinDate, withOnActiveChange, withOnChange, withSlot, withStyle, withToday

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import HtmlIr.Node exposing (Node)
import M3e.Attributes
import M3e.Events
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-year-view` produces (open — composes into any slot naming it).
-}
type alias Is s =
    { s | yearView : Brand }


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
    , slot : Supported
    , style : Supported
    , today : Supported
    }


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    { childAdm | yearView : Ctx }


{-| Standard constructor: `[attributes] [children]`.
-}
view :
    List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
view attrs children =
    Ir.fromNode (Ir.node "m3e-year-view" attrs (List.map HtmlIr.Element.toNode children))


{-| See `M3e.Attributes.active`.
-}
active : Bool -> Attr { c | active : Supported } msg
active =
    M3e.Attributes.active


{-| See `M3e.Attributes.activeDate`.
-}
activeDate : String -> Attr { c | activeDate : Supported } msg
activeDate =
    M3e.Attributes.activeDate


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


{-| See `M3e.Attributes.today`.
-}
today : String -> Attr { c | today : Supported } msg
today =
    M3e.Attributes.today


{-| See `M3e.Events.onChange`.
-}
onChange : msg -> Attr { c | onChange : Supported } msg
onChange =
    M3e.Events.onChange


{-| See `M3e.Events.onActiveChange`.
-}
onActiveChange : msg -> Attr { c | onActiveChange : Supported } msg
onActiveChange =
    M3e.Events.onActiveChange


{-| The pipe-builder: capabilities are consumed Available→Used, so writing
a singular attribute or slot twice is unwritable.
-}
type Builder attrCaps slotCaps msg
    = Builder { attrs : List (Attr Attrs msg), children : List (Node msg) }


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
    Builder { attrs = [], children = [] }


{-| Close the pipe-builder.
-}
toElement : Builder attrCaps slotCaps msg -> Element (Is s) admittedBy msg
toElement (Builder b) =
    Ir.fromNode (Ir.node "m3e-year-view" (List.reverse b.attrs) (List.reverse b.children))


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


{-| Pipe form of `active` — consumes its capability (write-once).
-}
withActive : Bool -> Builder { a | active : Available } slotCaps msg -> Builder { a | active : Used } slotCaps msg
withActive value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.active value_ :: b.attrs }


{-| Pipe form of `activeDate` — consumes its capability (write-once).
-}
withActiveDate : String -> Builder { a | activeDate : Available } slotCaps msg -> Builder { a | activeDate : Used } slotCaps msg
withActiveDate value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.activeDate value_ :: b.attrs }


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


{-| Pipe form of `today` — consumes its capability (write-once).
-}
withToday : String -> Builder { a | today : Available } slotCaps msg -> Builder { a | today : Used } slotCaps msg
withToday value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.today value_ :: b.attrs }


{-| Pipe form of `onChange` — consumes its capability (write-once).
-}
withOnChange : msg -> Builder { a | onChange : Available } slotCaps msg -> Builder { a | onChange : Used } slotCaps msg
withOnChange value_ (Builder b) =
    Builder { b | attrs = M3e.Events.onChange value_ :: b.attrs }


{-| Pipe form of `onActiveChange` — consumes its capability (write-once).
-}
withOnActiveChange : msg -> Builder { a | onActiveChange : Available } slotCaps msg -> Builder { a | onActiveChange : Used } slotCaps msg
withOnActiveChange value_ (Builder b) =
    Builder { b | attrs = M3e.Events.onActiveChange value_ :: b.attrs }
