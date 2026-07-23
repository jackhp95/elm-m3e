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
view =
    H.splitPane


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
    view attrs (Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "end") (El.toNode required_.end)) :: Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "start") (El.toNode required_.start)) :: children)


{-| The orientation of the split. (default: `"horizontal"`)
-}
orientation : Value Orientation -> Attr { c | orientation : Supported } msg
orientation value_ =
    Ir.attribute "orientation" (Val.toString value_)


{-| See `M3e.Attributes.detents`.
-}
detents : String -> Attr { c | detents : Supported } msg
detents =
    A.detents


{-| See `M3e.Attributes.disabled`.
-}
disabled : Bool -> Attr { c | disabled : Supported } msg
disabled =
    A.disabled


{-| See `M3e.Attributes.label`.
-}
label : String -> Attr { c | label : Supported } msg
label =
    A.label


{-| See `M3e.Attributes.max`.
-}
max : Float -> Attr { c | max : Supported } msg
max =
    A.max


{-| See `M3e.Attributes.min`.
-}
min : Float -> Attr { c | min : Supported } msg
min =
    A.min


{-| The name that identifies the element when submitting the associated form.
-}
name : String -> Attr { c | name : Supported } msg
name value_ =
    Ir.attribute "name" value_


{-| See `M3e.Attributes.overshootLimit`.
-}
overshootLimit : Float -> Attr { c | overshootLimit : Supported } msg
overshootLimit =
    A.overshootLimit


{-| See `M3e.Attributes.step`.
-}
step : Float -> Attr { c | step : Supported } msg
step =
    A.step


{-| A fractional value, between 0 and 100, indicating the size of the start pane. (default: `50`)
-}
value : Float -> Attr { c | value : Supported } msg
value value_ =
    Ir.property "value" (Json.Encode.float value_)


{-| See `M3e.Attributes.valueformatter`.
-}
valueformatter : String -> Attr { c | valueformatter : Supported } msg
valueformatter =
    A.valueformatter


{-| See `M3e.Attributes.wrapDetents`.
-}
wrapDetents : Bool -> Attr { c | wrapDetents : Supported } msg
wrapDetents =
    A.wrapDetents


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


{-| Place an element into the named `end` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
end : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
end element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "end") (El.toNode element))


{-| Place an element into the named `start` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
start : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
start element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "start") (El.toNode element))


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
    B.init "m3e-split-pane" [] [ El.toNode (end required_.end), El.toNode (start required_.start) ]


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


{-| Pipe form of `detents` — consumes its capability (write-once).
-}
withDetents : String -> Builder { a | detents : Available } slotCaps msg -> Builder { a | detents : Used } slotCaps msg
withDetents value_ =
    B.withAttribute (A.detents value_)


{-| Pipe form of `disabled` — consumes its capability (write-once).
-}
withDisabled : Bool -> Builder { a | disabled : Available } slotCaps msg -> Builder { a | disabled : Used } slotCaps msg
withDisabled value_ =
    B.withAttribute (A.disabled value_)


{-| Pipe form of `label` — consumes its capability (write-once).
-}
withLabel : String -> Builder { a | label : Available } slotCaps msg -> Builder { a | label : Used } slotCaps msg
withLabel value_ =
    B.withAttribute (A.label value_)


{-| Pipe form of `max` — consumes its capability (write-once).
-}
withMax : Float -> Builder { a | max : Available } slotCaps msg -> Builder { a | max : Used } slotCaps msg
withMax value_ =
    B.withAttribute (A.max value_)


{-| Pipe form of `min` — consumes its capability (write-once).
-}
withMin : Float -> Builder { a | min : Available } slotCaps msg -> Builder { a | min : Used } slotCaps msg
withMin value_ =
    B.withAttribute (A.min value_)


{-| Pipe form of `name` — consumes its capability (write-once).
-}
withName : String -> Builder { a | name : Available } slotCaps msg -> Builder { a | name : Used } slotCaps msg
withName value_ =
    B.withAttribute (Ir.attribute "name" value_)


{-| Pipe form of `orientation` — consumes its capability (write-once).
-}
withOrientation : Value Orientation -> Builder { a | orientation : Available } slotCaps msg -> Builder { a | orientation : Used } slotCaps msg
withOrientation value_ =
    B.withAttribute (orientation value_)


{-| Pipe form of `overshootLimit` — consumes its capability (write-once).
-}
withOvershootLimit : Float -> Builder { a | overshootLimit : Available } slotCaps msg -> Builder { a | overshootLimit : Used } slotCaps msg
withOvershootLimit value_ =
    B.withAttribute (A.overshootLimit value_)


{-| Pipe form of `step` — consumes its capability (write-once).
-}
withStep : Float -> Builder { a | step : Available } slotCaps msg -> Builder { a | step : Used } slotCaps msg
withStep value_ =
    B.withAttribute (A.step value_)


{-| Pipe form of `value` — consumes its capability (write-once).
-}
withValue : Float -> Builder { a | value : Available } slotCaps msg -> Builder { a | value : Used } slotCaps msg
withValue value_ =
    B.withAttribute (Ir.property "value" (Json.Encode.float value_))


{-| Pipe form of `valueformatter` — consumes its capability (write-once).
-}
withValueformatter : String -> Builder { a | valueformatter : Available } slotCaps msg -> Builder { a | valueformatter : Used } slotCaps msg
withValueformatter value_ =
    B.withAttribute (A.valueformatter value_)


{-| Pipe form of `wrapDetents` — consumes its capability (write-once).
-}
withWrapDetents : Bool -> Builder { a | wrapDetents : Available } slotCaps msg -> Builder { a | wrapDetents : Used } slotCaps msg
withWrapDetents value_ =
    B.withAttribute (A.wrapDetents value_)


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


{-| Pipe form of the `end` slot — consumes its capability (write-once).
-}
withEnd : Element childAccepts admittedBy msg -> Builder attrCaps { s | end : Available } msg -> Builder attrCaps { s | end : Used } msg
withEnd element =
    B.withChild (El.toNode (end element))


{-| Pipe form of the `start` slot — consumes its capability (write-once).
-}
withStart : Element childAccepts admittedBy msg -> Builder attrCaps { s | start : Available } msg -> Builder attrCaps { s | start : Used } msg
withStart element =
    B.withChild (El.toNode (start element))
