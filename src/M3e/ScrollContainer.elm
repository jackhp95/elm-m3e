module M3e.ScrollContainer exposing
    ( view, build, toElement
    , Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , Dividers, dividers
    , thin
    , withChild, withClass, withDividers, withId, withSlot, withStyle, withThin
    )

{-| The `m3e-scroll-container` component — strict per-component surface.

A vertically oriented content container which presents dividers above and below content when scrolled.

@docs view, build, toElement
@docs Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs Dividers, dividers
@docs thin
@docs withChild, withClass, withDividers, withId, withSlot, withStyle, withThin

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import HtmlIr.Node exposing (Node)
import HtmlIr.Value exposing (Value)
import M3e.Attributes
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-scroll-container` produces (open — composes into any slot naming it).
-}
type alias Is s =
    { s | scrollContainer : Brand }


{-| The closed attribute-capability row.
-}
type alias Attrs =
    { class : Supported
    , dividers : Supported
    , id : Supported
    , slot : Supported
    , style : Supported
    , thin : Supported
    }


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    { childAdm | scrollContainer : Ctx }


{-| The `dividers` values valid on this component (compile-tight narrowing).
-}
type alias Dividers =
    { above : Supported
    , aboveBelow : Supported
    , below : Supported
    , none : Supported
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
    Ir.fromNode (Ir.node "m3e-scroll-container" attrs (List.map HtmlIr.Element.toNode children))


{-| Narrowed value setter for `dividers`. Tokens come from `M3e.Values`.
-}
dividers : Value Dividers -> Attr { c | dividers : Supported } msg
dividers value_ =
    Ir.attribute "dividers" (HtmlIr.Value.toString value_)


{-| See `M3e.Attributes.thin`.
-}
thin : Bool -> Attr { c | thin : Supported } msg
thin =
    M3e.Attributes.thin


{-| The pipe-builder: capabilities are consumed Available→Used, so writing
a singular attribute or slot twice is unwritable.
-}
type Builder attrCaps slotCaps msg
    = Builder { attrs : List (Attr Attrs msg), children : List (Node msg) }


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    { class : Available
    , dividers : Available
    , id : Available
    , slot : Available
    , style : Available
    , thin : Available
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
    Ir.fromNode (Ir.node "m3e-scroll-container" (List.reverse b.attrs) (List.reverse b.children))


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


{-| Pipe form of `dividers` — consumes its capability (write-once).
-}
withDividers : Value Dividers -> Builder { a | dividers : Available } slotCaps msg -> Builder { a | dividers : Used } slotCaps msg
withDividers value_ (Builder b) =
    Builder { b | attrs = dividers value_ :: b.attrs }


{-| Pipe form of `thin` — consumes its capability (write-once).
-}
withThin : Bool -> Builder { a | thin : Available } slotCaps msg -> Builder { a | thin : Used } slotCaps msg
withThin value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.thin value_ :: b.attrs }


{-| Pipe form of a default-slot child (repeatable).
-}
withChild : Element childAccepts (ChildAdmittedBy childAdm) msg -> Builder attrCaps slotCaps msg -> Builder attrCaps slotCaps msg
withChild element (Builder b) =
    Builder { b | children = HtmlIr.Element.toNode element :: b.children }
