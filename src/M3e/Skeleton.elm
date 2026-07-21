module M3e.Skeleton exposing
    ( view, build, toElement
    , Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , Animation, animation, Shape, shape
    , loaded
    , withAnimation, withChild, withClass, withId, withLoaded, withShape, withSlot, withStyle
    )

{-| The `m3e-skeleton` component — strict per-component surface.

A visual placeholder that mimics the layout of content while it's still loading.

@docs view, build, toElement
@docs Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs Animation, animation, Shape, shape
@docs loaded
@docs withAnimation, withChild, withClass, withId, withLoaded, withShape, withSlot, withStyle

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import HtmlIr.Node exposing (Node)
import HtmlIr.Value exposing (Value)
import M3e.Attributes
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
view attrs children =
    Ir.fromNode (Ir.node "m3e-skeleton" attrs (List.map HtmlIr.Element.toNode children))


{-| Narrowed value setter for `animation`. Tokens come from `M3e.Values`.
-}
animation : Value Animation -> Attr { c | animation : Supported } msg
animation value_ =
    Ir.attribute "animation" (HtmlIr.Value.toString value_)


{-| Narrowed value setter for `shape`. Tokens come from `M3e.Values`.
-}
shape : Value Shape -> Attr { c | shape : Supported } msg
shape value_ =
    Ir.attribute "shape" (HtmlIr.Value.toString value_)


{-| See `M3e.Attributes.loaded`.
-}
loaded : Bool -> Attr { c | loaded : Supported } msg
loaded =
    M3e.Attributes.loaded


{-| The pipe-builder: capabilities are consumed Available→Used, so writing
a singular attribute or slot twice is unwritable.
-}
type Builder attrCaps slotCaps msg
    = Builder { attrs : List (Attr Attrs msg), children : List (Node msg) }


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
build : Builder AttrCaps SlotCaps msg
build =
    Builder { attrs = [], children = [] }


{-| Close the pipe-builder.
-}
toElement : Builder attrCaps slotCaps msg -> Element (Is s) admittedBy msg
toElement (Builder b) =
    Ir.fromNode (Ir.node "m3e-skeleton" (List.reverse b.attrs) (List.reverse b.children))


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


{-| Pipe form of `animation` — consumes its capability (write-once).
-}
withAnimation : Value Animation -> Builder { a | animation : Available } slotCaps msg -> Builder { a | animation : Used } slotCaps msg
withAnimation value_ (Builder b) =
    Builder { b | attrs = animation value_ :: b.attrs }


{-| Pipe form of `loaded` — consumes its capability (write-once).
-}
withLoaded : Bool -> Builder { a | loaded : Available } slotCaps msg -> Builder { a | loaded : Used } slotCaps msg
withLoaded value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.loaded value_ :: b.attrs }


{-| Pipe form of `shape` — consumes its capability (write-once).
-}
withShape : Value Shape -> Builder { a | shape : Available } slotCaps msg -> Builder { a | shape : Used } slotCaps msg
withShape value_ (Builder b) =
    Builder { b | attrs = shape value_ :: b.attrs }


{-| Pipe form of a default-slot child (repeatable).
-}
withChild : Element childAccepts (ChildAdmittedBy childAdm) msg -> Builder attrCaps slotCaps msg -> Builder attrCaps slotCaps msg
withChild element (Builder b) =
    Builder { b | children = HtmlIr.Element.toNode element :: b.children }
