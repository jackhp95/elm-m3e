module M3e.Icon exposing
    ( view, build, toElement
    , Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , Grade, grade, Variant, variant
    , filled, name, opticalSize, weight
    , withClass, withFilled, withGrade, withId, withName, withOpticalSize, withSlot, withStyle, withVariant, withWeight
    )

{-| The `m3e-icon` component — strict per-component surface.

A small symbol used to easily identify an action or category.

@docs view, build, toElement
@docs Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs Grade, grade, Variant, variant
@docs filled, name, opticalSize, weight
@docs withClass, withFilled, withGrade, withId, withName, withOpticalSize, withSlot, withStyle, withVariant, withWeight

-}

import Html.Attributes
import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Node exposing (Node)
import HtmlIr.Value exposing (Value)
import Json.Encode
import M3e.Attributes
import M3e.Kind exposing (Available, Ctx, Used)


{-| The kind row `m3e-icon` produces — the SHARED icon atom kind, admissible
into any library's opted-in slot.
-}
type alias Is s =
    { s | sharedIcon : Shared }


{-| The closed attribute-capability row.
-}
type alias Attrs =
    { class : Supported
    , filled : Supported
    , grade : Supported
    , id : Supported
    , name : Supported
    , opticalSize : Supported
    , slot : Supported
    , style : Supported
    , variant : Supported
    , weight : Supported
    }


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    { childAdm | icon : Ctx }


{-| The `grade` values valid on this component (compile-tight narrowing).
-}
type alias Grade =
    { high : Supported
    , low : Supported
    , medium : Supported
    }


{-| The `variant` values valid on this component (compile-tight narrowing).
-}
type alias Variant =
    { outlined : Supported
    , rounded : Supported
    , sharp : Supported
    }


{-| Standard constructor: `[attributes] [children]`.
-}
view :
    List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
view attrs children =
    Ir.fromNode (Ir.node "m3e-icon" attrs (List.map HtmlIr.Element.toNode children))


{-| Narrowed value setter for `grade`. Tokens come from `M3e.Values`.
-}
grade : Value Grade -> Attr { c | grade : Supported } msg
grade value_ =
    Ir.attribute "grade" (HtmlIr.Value.toString value_)


{-| Narrowed value setter for `variant`. Tokens come from `M3e.Values`.
-}
variant : Value Variant -> Attr { c | variant : Supported } msg
variant value_ =
    Ir.attribute "variant" (HtmlIr.Value.toString value_)


{-| See `M3e.Attributes.filled`.
-}
filled : Bool -> Attr { c | filled : Supported } msg
filled =
    M3e.Attributes.filled


{-| The `name` attribute (this component's type differs from the shared canonical).
-}
name : String -> Attr { c | name : Supported } msg
name value_ =
    Ir.attribute "name" value_


{-| See `M3e.Attributes.opticalSize`.
-}
opticalSize : Float -> Attr { c | opticalSize : Supported } msg
opticalSize =
    M3e.Attributes.opticalSize


{-| See `M3e.Attributes.weight`.
-}
weight : Int -> Attr { c | weight : Supported } msg
weight =
    M3e.Attributes.weight


{-| The pipe-builder: capabilities are consumed Available→Used, so writing
a singular attribute or slot twice is unwritable.
-}
type Builder attrCaps slotCaps msg
    = Builder { attrs : List (Attr Attrs msg), children : List (Node msg) }


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    { class : Available
    , filled : Available
    , grade : Available
    , id : Available
    , name : Available
    , opticalSize : Available
    , slot : Available
    , style : Available
    , variant : Available
    , weight : Available
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
    Ir.fromNode (Ir.node "m3e-icon" (List.reverse b.attrs) (List.reverse b.children))


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


{-| Pipe form of `filled` — consumes its capability (write-once).
-}
withFilled : Bool -> Builder { a | filled : Available } slotCaps msg -> Builder { a | filled : Used } slotCaps msg
withFilled value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.filled value_ :: b.attrs }


{-| Pipe form of `grade` — consumes its capability (write-once).
-}
withGrade : Value Grade -> Builder { a | grade : Available } slotCaps msg -> Builder { a | grade : Used } slotCaps msg
withGrade value_ (Builder b) =
    Builder { b | attrs = grade value_ :: b.attrs }


{-| Pipe form of `name` — consumes its capability (write-once).
-}
withName : String -> Builder { a | name : Available } slotCaps msg -> Builder { a | name : Used } slotCaps msg
withName value_ (Builder b) =
    Builder { b | attrs = Ir.attribute "name" value_ :: b.attrs }


{-| Pipe form of `opticalSize` — consumes its capability (write-once).
-}
withOpticalSize : Float -> Builder { a | opticalSize : Available } slotCaps msg -> Builder { a | opticalSize : Used } slotCaps msg
withOpticalSize value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.opticalSize value_ :: b.attrs }


{-| Pipe form of `variant` — consumes its capability (write-once).
-}
withVariant : Value Variant -> Builder { a | variant : Available } slotCaps msg -> Builder { a | variant : Used } slotCaps msg
withVariant value_ (Builder b) =
    Builder { b | attrs = variant value_ :: b.attrs }


{-| Pipe form of `weight` — consumes its capability (write-once).
-}
withWeight : Int -> Builder { a | weight : Available } slotCaps msg -> Builder { a | weight : Used } slotCaps msg
withWeight value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.weight value_ :: b.attrs }
