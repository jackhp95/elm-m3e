module M3e.Shape exposing
    ( view, build, toElement
    , Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , Name, name
    , withChild, withClass, withId, withName, withSlot, withStyle
    )

{-| The `m3e-shape` component — strict per-component surface.

A shape used to add emphasis and decorative flair.

@docs view, build, toElement
@docs Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs Name, name
@docs withChild, withClass, withId, withName, withSlot, withStyle

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import HtmlIr.Value as Val exposing (Value)
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Html as H
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-shape` produces (open — composes into any slot naming it).
-}
type alias Is s =
    { s | shape : Brand }


{-| The closed attribute-capability row.
-}
type alias Attrs =
    { class : Supported
    , id : Supported
    , name : Supported
    , slot : Supported
    , style : Supported
    }


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    { childAdm | shape : Ctx }


{-| The `name` values valid on this component (compile-tight narrowing).
-}
type alias Name =
    { value12SidedCookie : Supported
    , value4LeafClover : Supported
    , value4SidedCookie : Supported
    , value6SidedCookie : Supported
    , value7SidedCookie : Supported
    , value8LeafClover : Supported
    , value9SidedCookie : Supported
    , arch : Supported
    , arrow : Supported
    , boom : Supported
    , bun : Supported
    , burst : Supported
    , circle : Supported
    , diamond : Supported
    , fan : Supported
    , flower : Supported
    , gem : Supported
    , ghostIsh : Supported
    , heart : Supported
    , hexagon : Supported
    , oval : Supported
    , pentagon : Supported
    , pill : Supported
    , pixelCircle : Supported
    , pixelTriangle : Supported
    , puffy : Supported
    , puffyDiamond : Supported
    , semicircle : Supported
    , slanted : Supported
    , softBoom : Supported
    , softBurst : Supported
    , square : Supported
    , sunny : Supported
    , triangle : Supported
    , verySunny : Supported
    }


{-| Standard constructor: `[attributes] [children]`. The default slot is
kind-permissive (`any`): children of any kind compose, but each child's OWN
admittedBy must still admit this context — a restricted-parent element is
rejected here at compile time.
-}
view :
    List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
view =
    H.shape


{-| The name of the shape. (default: `null`)
-}
name : Value Name -> Attr { c | name : Supported } msg
name value_ =
    Ir.attribute "name" (Val.toString value_)


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
    , id : Available
    , name : Available
    , slot : Available
    , style : Available
    }


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    {}


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg
build =
    B.init "m3e-shape" [] []


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


{-| Pipe form of `name` — consumes its capability (write-once).
-}
withName : Value Name -> Builder { a | name : Available } slotCaps msg -> Builder { a | name : Used } slotCaps msg
withName value_ =
    B.withAttribute (name value_)


{-| Pipe form of a default-slot child (repeatable).
-}
withChild : Element childAccepts (ChildAdmittedBy childAdm) msg -> Builder attrCaps slotCaps msg -> Builder attrCaps slotCaps msg
withChild element =
    B.withChild (El.toNode element)
