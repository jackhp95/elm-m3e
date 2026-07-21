module M3e.LinearProgressIndicator exposing
    ( view, build, toElement
    , Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , Mode, mode, Variant, variant
    , bufferValue, max, value
    , withAriaLabel, withBufferValue, withClass, withId, withMax, withMode, withSlot, withStyle, withValue, withVariant
    )

{-| The `m3e-linear-progress-indicator` component — strict per-component surface.

A horizontal bar for indicating progress and activity.

@docs view, build, toElement
@docs Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs Mode, mode, Variant, variant
@docs bufferValue, max, value
@docs withAriaLabel, withBufferValue, withClass, withId, withMax, withMode, withSlot, withStyle, withValue, withVariant

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
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-linear-progress-indicator` produces (open — composes into any slot naming it).
-}
type alias Is s =
    { s | linearProgressIndicator : Brand }


{-| The closed attribute-capability row.
-}
type alias Attrs =
    { ariaLabel : Supported
    , bufferValue : Supported
    , class : Supported
    , id : Supported
    , max : Supported
    , mode : Supported
    , slot : Supported
    , style : Supported
    , value : Supported
    , variant : Supported
    }


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    { childAdm | linearProgressIndicator : Ctx }


{-| The `mode` values valid on this component (compile-tight narrowing).
-}
type alias Mode =
    { buffer : Supported
    , determinate : Supported
    , indeterminate : Supported
    , query : Supported
    }


{-| The `variant` values valid on this component (compile-tight narrowing).
-}
type alias Variant =
    { flat : Supported
    , wavy : Supported
    }


{-| Standard constructor: `[attributes] [children]`.
-}
view :
    List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
view attrs children =
    Ir.fromNode (Ir.node "m3e-linear-progress-indicator" attrs (List.map HtmlIr.Element.toNode children))


{-| Narrowed value setter for `mode`. Tokens come from `M3e.Values`.
-}
mode : Value Mode -> Attr { c | mode : Supported } msg
mode value_ =
    Ir.attribute "mode" (HtmlIr.Value.toString value_)


{-| Narrowed value setter for `variant`. Tokens come from `M3e.Values`.
-}
variant : Value Variant -> Attr { c | variant : Supported } msg
variant value_ =
    Ir.attribute "variant" (HtmlIr.Value.toString value_)


{-| See `M3e.Attributes.bufferValue`.
-}
bufferValue : Float -> Attr { c | bufferValue : Supported } msg
bufferValue =
    M3e.Attributes.bufferValue


{-| See `M3e.Attributes.max`.
-}
max : Float -> Attr { c | max : Supported } msg
max =
    M3e.Attributes.max


{-| The `value` attribute (this component's type differs from the shared canonical).
-}
value : Float -> Attr { c | value : Supported } msg
value value_ =
    Ir.property "value" (Json.Encode.float value_)


{-| The pipe-builder: capabilities are consumed Available→Used, so writing
a singular attribute or slot twice is unwritable.
-}
type Builder attrCaps slotCaps msg
    = Builder { attrs : List (Attr Attrs msg), children : List (Node msg) }


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    { ariaLabel : Available
    , bufferValue : Available
    , class : Available
    , id : Available
    , max : Available
    , mode : Available
    , slot : Available
    , style : Available
    , value : Available
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
    Ir.fromNode (Ir.node "m3e-linear-progress-indicator" (List.reverse b.attrs) (List.reverse b.children))


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


{-| Pipe form of `bufferValue` — consumes its capability (write-once).
-}
withBufferValue : Float -> Builder { a | bufferValue : Available } slotCaps msg -> Builder { a | bufferValue : Used } slotCaps msg
withBufferValue value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.bufferValue value_ :: b.attrs }


{-| Pipe form of `max` — consumes its capability (write-once).
-}
withMax : Float -> Builder { a | max : Available } slotCaps msg -> Builder { a | max : Used } slotCaps msg
withMax value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.max value_ :: b.attrs }


{-| Pipe form of `mode` — consumes its capability (write-once).
-}
withMode : Value Mode -> Builder { a | mode : Available } slotCaps msg -> Builder { a | mode : Used } slotCaps msg
withMode value_ (Builder b) =
    Builder { b | attrs = mode value_ :: b.attrs }


{-| Pipe form of `value` — consumes its capability (write-once).
-}
withValue : Float -> Builder { a | value : Available } slotCaps msg -> Builder { a | value : Used } slotCaps msg
withValue value_ (Builder b) =
    Builder { b | attrs = Ir.property "value" (Json.Encode.float value_) :: b.attrs }


{-| Pipe form of `variant` — consumes its capability (write-once).
-}
withVariant : Value Variant -> Builder { a | variant : Available } slotCaps msg -> Builder { a | variant : Used } slotCaps msg
withVariant value_ (Builder b) =
    Builder { b | attrs = variant value_ :: b.attrs }
