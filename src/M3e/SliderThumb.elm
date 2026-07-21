module M3e.SliderThumb exposing
    ( view, build, toElement
    , Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , disabled, name, value, onValueChange, onBeforeinput, onInput, onChange, onClick
    , withClass, withDisabled, withId, withName, withOnBeforeinput, withOnChange, withOnClick, withOnInput, withOnValueChange, withSlot, withStyle, withValue
    )

{-| The `m3e-slider-thumb` component — strict per-component surface.

A thumb used to select a value in a slider.

@docs view, build, toElement
@docs Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs disabled, name, value, onValueChange, onBeforeinput, onInput, onChange, onClick
@docs withClass, withDisabled, withId, withName, withOnBeforeinput, withOnChange, withOnClick, withOnInput, withOnValueChange, withSlot, withStyle, withValue

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
import M3e.Values


{-| The kind row `m3e-slider-thumb` produces (open — composes into any slot naming it).
-}
type alias Is s =
    { s | sliderThumb : Brand }


{-| The closed attribute-capability row.
-}
type alias Attrs =
    { class : Supported
    , disabled : Supported
    , id : Supported
    , name : Supported
    , onBeforeinput : Supported
    , onChange : Supported
    , onClick : Supported
    , onInput : Supported
    , onValueChange : Supported
    , slot : Supported
    , style : Supported
    , value : Supported
    }


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    { childAdm | sliderThumb : Ctx }


{-| Standard constructor: `[attributes] [children]`.
-}
view :
    List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
view attrs children =
    Ir.fromNode (Ir.node "m3e-slider-thumb" attrs (List.map HtmlIr.Element.toNode children))


{-| See `M3e.Attributes.disabled`.
-}
disabled : Bool -> Attr { c | disabled : Supported } msg
disabled =
    M3e.Attributes.disabled


{-| See `M3e.Attributes.name`.
-}
name : Value M3e.Values.Name -> Attr { c | name : Supported } msg
name =
    M3e.Attributes.name


{-| The `value` attribute (this component's type differs from the shared canonical).
-}
value : Float -> Attr { c | value : Supported } msg
value value_ =
    Ir.property "value" (Json.Encode.float value_)


{-| See `M3e.Events.onValueChange`.
-}
onValueChange : msg -> Attr { c | onValueChange : Supported } msg
onValueChange =
    M3e.Events.onValueChange


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


{-| See `M3e.Events.onChange`.
-}
onChange : msg -> Attr { c | onChange : Supported } msg
onChange =
    M3e.Events.onChange


{-| See `M3e.Events.onClick`.
-}
onClick : msg -> Attr { c | onClick : Supported } msg
onClick =
    M3e.Events.onClick


{-| The pipe-builder: capabilities are consumed Available→Used, so writing
a singular attribute or slot twice is unwritable.
-}
type Builder attrCaps slotCaps msg
    = Builder { attrs : List (Attr Attrs msg), children : List (Node msg) }


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    { class : Available
    , disabled : Available
    , id : Available
    , name : Available
    , onBeforeinput : Available
    , onChange : Available
    , onClick : Available
    , onInput : Available
    , onValueChange : Available
    , slot : Available
    , style : Available
    , value : Available
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
    Ir.fromNode (Ir.node "m3e-slider-thumb" (List.reverse b.attrs) (List.reverse b.children))


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


{-| Pipe form of `disabled` — consumes its capability (write-once).
-}
withDisabled : Bool -> Builder { a | disabled : Available } slotCaps msg -> Builder { a | disabled : Used } slotCaps msg
withDisabled value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.disabled value_ :: b.attrs }


{-| Pipe form of `name` — consumes its capability (write-once).
-}
withName : Value M3e.Values.Name -> Builder { a | name : Available } slotCaps msg -> Builder { a | name : Used } slotCaps msg
withName value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.name value_ :: b.attrs }


{-| Pipe form of `value` — consumes its capability (write-once).
-}
withValue : Float -> Builder { a | value : Available } slotCaps msg -> Builder { a | value : Used } slotCaps msg
withValue value_ (Builder b) =
    Builder { b | attrs = Ir.property "value" (Json.Encode.float value_) :: b.attrs }


{-| Pipe form of `onValueChange` — consumes its capability (write-once).
-}
withOnValueChange : msg -> Builder { a | onValueChange : Available } slotCaps msg -> Builder { a | onValueChange : Used } slotCaps msg
withOnValueChange value_ (Builder b) =
    Builder { b | attrs = M3e.Events.onValueChange value_ :: b.attrs }


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


{-| Pipe form of `onChange` — consumes its capability (write-once).
-}
withOnChange : msg -> Builder { a | onChange : Available } slotCaps msg -> Builder { a | onChange : Used } slotCaps msg
withOnChange value_ (Builder b) =
    Builder { b | attrs = M3e.Events.onChange value_ :: b.attrs }


{-| Pipe form of `onClick` — consumes its capability (write-once).
-}
withOnClick : msg -> Builder { a | onClick : Available } slotCaps msg -> Builder { a | onClick : Used } slotCaps msg
withOnClick value_ (Builder b) =
    Builder { b | attrs = M3e.Events.onClick value_ :: b.attrs }
