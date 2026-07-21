module M3e.SplitPane exposing
    ( view, el, build, toElement
    , Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , Orientation, orientation
    , detents, disabled, label, max, min, name, overshootLimit, step, value, valueformatter, wrapDetents, onChange, onBeforeinput, onInput
    , end, start
    , withClass, withDetents, withDisabled, withEnd, withId, withLabel, withMax, withMin, withName, withOnBeforeinput, withOnChange, withOnInput, withOrientation, withOvershootLimit, withSlot, withStart, withStep, withStyle, withValue, withValueformatter, withWrapDetents
    )

{-| The `m3e-split-pane` component — strict per-component surface.

A dual-view layout that separates content with a movable drag handle.

@docs view, el, build, toElement
@docs Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs Orientation, orientation
@docs detents, disabled, label, max, min, name, overshootLimit, step, value, valueformatter, wrapDetents, onChange, onBeforeinput, onInput
@docs end, start
@docs withClass, withDetents, withDisabled, withEnd, withId, withLabel, withMax, withMin, withName, withOnBeforeinput, withOnChange, withOnInput, withOrientation, withOvershootLimit, withSlot, withStart, withStep, withStyle, withValue, withValueformatter, withWrapDetents

-}

import Html.Attributes
import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import HtmlIr.Node exposing (Node)
import HtmlIr.Value exposing (Value)
import Json.Encode
import M3e.Attributes
import M3e.Events
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-split-pane` produces (open — composes into any slot naming it).
-}
type alias Is s =
    { s | splitPane : Brand }


{-| The closed attribute-capability row.
-}
type alias Attrs =
    { class : Supported
    , detents : Supported
    , disabled : Supported
    , id : Supported
    , label : Supported
    , max : Supported
    , min : Supported
    , name : Supported
    , onBeforeinput : Supported
    , onChange : Supported
    , onInput : Supported
    , orientation : Supported
    , overshootLimit : Supported
    , slot : Supported
    , step : Supported
    , style : Supported
    , value : Supported
    , valueformatter : Supported
    , wrapDetents : Supported
    }


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    { childAdm | splitPane : Ctx }


{-| The `orientation` values valid on this component (compile-tight narrowing).
-}
type alias Orientation =
    { auto : Supported
    , horizontal : Supported
    , vertical : Supported
    }


{-| Standard constructor: `[attributes] [children]`.
-}
view :
    List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
view attrs children =
    Ir.fromNode (Ir.node "m3e-split-pane" attrs (List.map HtmlIr.Element.toNode children))


{-| Required-content (and action) constructor — omissions are unwritable.
-}
el :
    { end : Element childAccepts (ChildAdmittedBy childAdm) msg
    , start : Element childAccepts (ChildAdmittedBy childAdm) msg
    }
    -> List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el required_ attrs children =
    view attrs (Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "end") (HtmlIr.Element.toNode required_.end)) :: Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "start") (HtmlIr.Element.toNode required_.start)) :: children)


{-| Narrowed value setter for `orientation`. Tokens come from `M3e.Values`.
-}
orientation : Value Orientation -> Attr { c | orientation : Supported } msg
orientation value_ =
    Ir.attribute "orientation" (HtmlIr.Value.toString value_)


{-| See `M3e.Attributes.detents`.
-}
detents : String -> Attr { c | detents : Supported } msg
detents =
    M3e.Attributes.detents


{-| See `M3e.Attributes.disabled`.
-}
disabled : Bool -> Attr { c | disabled : Supported } msg
disabled =
    M3e.Attributes.disabled


{-| See `M3e.Attributes.label`.
-}
label : String -> Attr { c | label : Supported } msg
label =
    M3e.Attributes.label


{-| See `M3e.Attributes.max`.
-}
max : Float -> Attr { c | max : Supported } msg
max =
    M3e.Attributes.max


{-| See `M3e.Attributes.min`.
-}
min : Float -> Attr { c | min : Supported } msg
min =
    M3e.Attributes.min


{-| The `name` attribute (this component's type differs from the shared canonical).
-}
name : String -> Attr { c | name : Supported } msg
name value_ =
    Ir.attribute "name" value_


{-| See `M3e.Attributes.overshootLimit`.
-}
overshootLimit : Float -> Attr { c | overshootLimit : Supported } msg
overshootLimit =
    M3e.Attributes.overshootLimit


{-| See `M3e.Attributes.step`.
-}
step : Float -> Attr { c | step : Supported } msg
step =
    M3e.Attributes.step


{-| The `value` attribute (this component's type differs from the shared canonical).
-}
value : Float -> Attr { c | value : Supported } msg
value value_ =
    Ir.property "value" (Json.Encode.float value_)


{-| See `M3e.Attributes.valueformatter`.
-}
valueformatter : String -> Attr { c | valueformatter : Supported } msg
valueformatter =
    M3e.Attributes.valueformatter


{-| See `M3e.Attributes.wrapDetents`.
-}
wrapDetents : Bool -> Attr { c | wrapDetents : Supported } msg
wrapDetents =
    M3e.Attributes.wrapDetents


{-| See `M3e.Events.onChange`.
-}
onChange : msg -> Attr { c | onChange : Supported } msg
onChange =
    M3e.Events.onChange


{-| See `M3e.Events.onBeforeinput`.
-}
onBeforeinput : msg -> Attr { c | onBeforeinput : Supported } msg
onBeforeinput =
    M3e.Events.onBeforeinput


{-| See `M3e.Events.onInput`.
-}
onInput : msg -> Attr { c | onInput : Supported } msg
onInput =
    M3e.Events.onInput


{-| Place an element into the named `end` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
end : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
end element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "end") (HtmlIr.Element.toNode element))


{-| Place an element into the named `start` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
start : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
start element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "start") (HtmlIr.Element.toNode element))


{-| The pipe-builder: capabilities are consumed Available→Used, so writing
a singular attribute or slot twice is unwritable.
-}
type Builder attrCaps slotCaps msg
    = Builder { attrs : List (Attr Attrs msg), children : List (Node msg) }


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    { class : Available
    , detents : Available
    , disabled : Available
    , id : Available
    , label : Available
    , max : Available
    , min : Available
    , name : Available
    , onBeforeinput : Available
    , onChange : Available
    , onInput : Available
    , orientation : Available
    , overshootLimit : Available
    , slot : Available
    , step : Available
    , style : Available
    , value : Available
    , valueformatter : Available
    , wrapDetents : Available
    }


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    { end : Available
    , start : Available
    }


{-| Seed the pipe-builder.
-}
build :
    { end : Element childAccepts (ChildAdmittedBy childAdm) msg
    , start : Element childAccepts (ChildAdmittedBy childAdm) msg
    }
    -> Builder AttrCaps SlotCaps msg
build required_ =
    Builder { attrs = [], children = [ HtmlIr.Element.toNode (end required_.end), HtmlIr.Element.toNode (start required_.start) ] }


{-| Close the pipe-builder.
-}
toElement : Builder attrCaps slotCaps msg -> Element (Is s) admittedBy msg
toElement (Builder b) =
    Ir.fromNode (Ir.node "m3e-split-pane" (List.reverse b.attrs) (List.reverse b.children))


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


{-| Pipe form of `detents` — consumes its capability (write-once).
-}
withDetents : String -> Builder { a | detents : Available } slotCaps msg -> Builder { a | detents : Used } slotCaps msg
withDetents value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.detents value_ :: b.attrs }


{-| Pipe form of `disabled` — consumes its capability (write-once).
-}
withDisabled : Bool -> Builder { a | disabled : Available } slotCaps msg -> Builder { a | disabled : Used } slotCaps msg
withDisabled value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.disabled value_ :: b.attrs }


{-| Pipe form of `label` — consumes its capability (write-once).
-}
withLabel : String -> Builder { a | label : Available } slotCaps msg -> Builder { a | label : Used } slotCaps msg
withLabel value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.label value_ :: b.attrs }


{-| Pipe form of `max` — consumes its capability (write-once).
-}
withMax : Float -> Builder { a | max : Available } slotCaps msg -> Builder { a | max : Used } slotCaps msg
withMax value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.max value_ :: b.attrs }


{-| Pipe form of `min` — consumes its capability (write-once).
-}
withMin : Float -> Builder { a | min : Available } slotCaps msg -> Builder { a | min : Used } slotCaps msg
withMin value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.min value_ :: b.attrs }


{-| Pipe form of `name` — consumes its capability (write-once).
-}
withName : String -> Builder { a | name : Available } slotCaps msg -> Builder { a | name : Used } slotCaps msg
withName value_ (Builder b) =
    Builder { b | attrs = Ir.attribute "name" value_ :: b.attrs }


{-| Pipe form of `orientation` — consumes its capability (write-once).
-}
withOrientation : Value Orientation -> Builder { a | orientation : Available } slotCaps msg -> Builder { a | orientation : Used } slotCaps msg
withOrientation value_ (Builder b) =
    Builder { b | attrs = orientation value_ :: b.attrs }


{-| Pipe form of `overshootLimit` — consumes its capability (write-once).
-}
withOvershootLimit : Float -> Builder { a | overshootLimit : Available } slotCaps msg -> Builder { a | overshootLimit : Used } slotCaps msg
withOvershootLimit value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.overshootLimit value_ :: b.attrs }


{-| Pipe form of `step` — consumes its capability (write-once).
-}
withStep : Float -> Builder { a | step : Available } slotCaps msg -> Builder { a | step : Used } slotCaps msg
withStep value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.step value_ :: b.attrs }


{-| Pipe form of `value` — consumes its capability (write-once).
-}
withValue : Float -> Builder { a | value : Available } slotCaps msg -> Builder { a | value : Used } slotCaps msg
withValue value_ (Builder b) =
    Builder { b | attrs = Ir.property "value" (Json.Encode.float value_) :: b.attrs }


{-| Pipe form of `valueformatter` — consumes its capability (write-once).
-}
withValueformatter : String -> Builder { a | valueformatter : Available } slotCaps msg -> Builder { a | valueformatter : Used } slotCaps msg
withValueformatter value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.valueformatter value_ :: b.attrs }


{-| Pipe form of `wrapDetents` — consumes its capability (write-once).
-}
withWrapDetents : Bool -> Builder { a | wrapDetents : Available } slotCaps msg -> Builder { a | wrapDetents : Used } slotCaps msg
withWrapDetents value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.wrapDetents value_ :: b.attrs }


{-| Pipe form of `onChange` — consumes its capability (write-once).
-}
withOnChange : msg -> Builder { a | onChange : Available } slotCaps msg -> Builder { a | onChange : Used } slotCaps msg
withOnChange value_ (Builder b) =
    Builder { b | attrs = M3e.Events.onChange value_ :: b.attrs }


{-| Pipe form of `onBeforeinput` — consumes its capability (write-once).
-}
withOnBeforeinput : msg -> Builder { a | onBeforeinput : Available } slotCaps msg -> Builder { a | onBeforeinput : Used } slotCaps msg
withOnBeforeinput value_ (Builder b) =
    Builder { b | attrs = M3e.Events.onBeforeinput value_ :: b.attrs }


{-| Pipe form of `onInput` — consumes its capability (write-once).
-}
withOnInput : msg -> Builder { a | onInput : Available } slotCaps msg -> Builder { a | onInput : Used } slotCaps msg
withOnInput value_ (Builder b) =
    Builder { b | attrs = M3e.Events.onInput value_ :: b.attrs }


{-| Pipe form of the `end` slot — consumes its capability (write-once).
-}
withEnd : Element childAccepts admittedBy msg -> Builder attrCaps { s | end : Available } msg -> Builder attrCaps { s | end : Used } msg
withEnd element (Builder b) =
    Builder { b | children = HtmlIr.Element.toNode (end element) :: b.children }


{-| Pipe form of the `start` slot — consumes its capability (write-once).
-}
withStart : Element childAccepts admittedBy msg -> Builder attrCaps { s | start : Available } msg -> Builder attrCaps { s | start : Used } msg
withStart element (Builder b) =
    Builder { b | children = HtmlIr.Element.toNode (start element) :: b.children }
