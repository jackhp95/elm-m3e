module M3e.Skeleton exposing
    ( view, build, toElement
    , Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , Animation, animation, Shape, shape
    , loaded
    , child
    , withAnimation, withChild, withClass, withId, withLoaded, withShape, withSlot, withStyle
    )

{-| The `m3e-skeleton` component — strict per-component surface.

A visual placeholder that mimics the layout of content while it's still loading.

@docs view, build, toElement
@docs Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs Animation, animation, Shape, shape
@docs loaded
@docs child
@docs withAnimation, withChild, withClass, withId, withLoaded, withShape, withSlot, withStyle

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


{-| The kind row `m3e-skeleton` produces (open — composes into any slot naming it).
-}
type alias Is s =
    { s | skeleton : Brand }


{-| The closed attribute-capability row.
-}
type alias Attrs =
    { animation : Supported
    , class : Supported
    , id : Supported
    , loaded : Supported
    , shape : Supported
    , slot : Supported
    , style : Supported
    }


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    { childAdm | skeleton : Ctx }


{-| The `animation` values valid on this component (compile-tight narrowing).
-}
type alias Animation =
    { none : Supported
    , pulse : Supported
    , wave : Supported
    }


{-| The `shape` values valid on this component (compile-tight narrowing).
-}
type alias Shape =
    { auto : Supported
    , circular : Supported
    , rounded : Supported
    , square : Supported
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
    H.skeleton


{-| The animation effect of the skeleton. (default: `"wave"`)
-}
animation : Value Animation -> Attr { c | animation : Supported } msg
animation value_ =
    Ir.attribute "animation" (Val.toString value_)


{-| The shape of the skeleton. (default: `"auto"`)
-}
shape : Value Shape -> Attr { c | shape : Supported } msg
shape value_ =
    Ir.attribute "shape" (Val.toString value_)


{-| See `M3e.Attributes.loaded`.
-}
loaded : Bool -> Attr { c | loaded : Supported } msg
loaded =
    A.loaded


{-| Place a pre-built element into the default (unnamed) slot (input
constrained to the slot's kinds; output row free so it composes into the
child list). The list-form sibling of the builder's `withChild`.
-}
child : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
child element =
    Ir.fromNode (El.toNode element)


{-| The pipe-builder: capabilities are consumed Available→Used, so writing
a singular attribute or slot twice is unwritable. Aliases the shared builder in
`Build.Internal`, closed over this component's `Attrs` row and `Is s` kind.
-}
type alias Builder attrCaps slotCaps msg s =
    B.Builder Attrs attrCaps slotCaps (Is s) msg


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    { animation : Available
    , class : Available
    , id : Available
    , loaded : Available
    , shape : Available
    , slot : Available
    , style : Available
    }


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    {}


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg kind
build =
    B.init "m3e-skeleton" [] []


{-| Close the pipe-builder (`toElement` is defined once in `Build.Internal`).
-}
toElement : Builder attrCaps slotCaps msg kind -> Element (Is kind) admittedBy msg
toElement =
    B.toElement


{-| Pipe form of `class` — consumes its capability (write-once).
-}
withClass : String -> Builder { a | class : Available } slotCaps msg kind -> Builder { a | class : Used } slotCaps msg kind
withClass value_ =
    B.withAttribute (A.class value_)


{-| Pipe form of `id` — consumes its capability (write-once).
-}
withId : String -> Builder { a | id : Available } slotCaps msg kind -> Builder { a | id : Used } slotCaps msg kind
withId value_ =
    B.withAttribute (A.id value_)


{-| Pipe form of `slot` — consumes its capability (write-once).
-}
withSlot : String -> Builder { a | slot : Available } slotCaps msg kind -> Builder { a | slot : Used } slotCaps msg kind
withSlot value_ =
    B.withAttribute (A.slot value_)


{-| Pipe form of `style` — consumes its capability (write-once).
-}
withStyle : String -> String -> Builder { a | style : Available } slotCaps msg kind -> Builder { a | style : Used } slotCaps msg kind
withStyle property value_ =
    B.withAttribute (A.style property value_)


{-| Pipe form of `animation` — consumes its capability (write-once).
-}
withAnimation : Value Animation -> Builder { a | animation : Available } slotCaps msg kind -> Builder { a | animation : Used } slotCaps msg kind
withAnimation value_ =
    B.withAttribute (animation value_)


{-| Pipe form of `loaded` — consumes its capability (write-once).
-}
withLoaded : Bool -> Builder { a | loaded : Available } slotCaps msg kind -> Builder { a | loaded : Used } slotCaps msg kind
withLoaded value_ =
    B.withAttribute (A.loaded value_)


{-| Pipe form of `shape` — consumes its capability (write-once).
-}
withShape : Value Shape -> Builder { a | shape : Available } slotCaps msg kind -> Builder { a | shape : Used } slotCaps msg kind
withShape value_ =
    B.withAttribute (shape value_)


{-| Pipe form of a default-slot child (repeatable).
-}
withChild : Element childAccepts (ChildAdmittedBy childAdm) msg -> Builder attrCaps slotCaps msg kind -> Builder attrCaps slotCaps msg kind
withChild element =
    B.withChild (El.toNode element)
