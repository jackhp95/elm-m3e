module M3e.Divider exposing
    ( view, build, toElement
    , Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , inset, insetEnd, insetStart, vertical
    , withClass, withId, withInset, withInsetEnd, withInsetStart, withSlot, withStyle, withVertical
    )

{-| The `m3e-divider` component — strict per-component surface.

A thin line that separates content in lists or other containers.

@docs view, build, toElement
@docs Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs inset, insetEnd, insetStart, vertical
@docs withClass, withId, withInset, withInsetEnd, withInsetStart, withSlot, withStyle, withVertical

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import HtmlIr.Node exposing (Node)
import M3e.Attributes
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-divider` produces (open — composes into any slot naming it).
-}
type alias Is s =
    { s | divider : Brand }


{-| The closed attribute-capability row.
-}
type alias Attrs =
    { class : Supported
    , id : Supported
    , inset : Supported
    , insetEnd : Supported
    , insetStart : Supported
    , slot : Supported
    , style : Supported
    , vertical : Supported
    }


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    { childAdm | divider : Ctx }


{-| Standard constructor: `[attributes] [children]`.
-}
view :
    List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
view attrs children =
    Ir.fromNode (Ir.node "m3e-divider" attrs (List.map HtmlIr.Element.toNode children))


{-| See `M3e.Attributes.inset`.
-}
inset : Bool -> Attr { c | inset : Supported } msg
inset =
    M3e.Attributes.inset


{-| See `M3e.Attributes.insetEnd`.
-}
insetEnd : Bool -> Attr { c | insetEnd : Supported } msg
insetEnd =
    M3e.Attributes.insetEnd


{-| See `M3e.Attributes.insetStart`.
-}
insetStart : Bool -> Attr { c | insetStart : Supported } msg
insetStart =
    M3e.Attributes.insetStart


{-| See `M3e.Attributes.vertical`.
-}
vertical : Bool -> Attr { c | vertical : Supported } msg
vertical =
    M3e.Attributes.vertical


{-| The pipe-builder: capabilities are consumed Available→Used, so writing
a singular attribute or slot twice is unwritable.
-}
type Builder attrCaps slotCaps msg
    = Builder { attrs : List (Attr Attrs msg), children : List (Node msg) }


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    { class : Available
    , id : Available
    , inset : Available
    , insetEnd : Available
    , insetStart : Available
    , slot : Available
    , style : Available
    , vertical : Available
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
    Ir.fromNode (Ir.node "m3e-divider" (List.reverse b.attrs) (List.reverse b.children))


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


{-| Pipe form of `inset` — consumes its capability (write-once).
-}
withInset : Bool -> Builder { a | inset : Available } slotCaps msg -> Builder { a | inset : Used } slotCaps msg
withInset value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.inset value_ :: b.attrs }


{-| Pipe form of `insetEnd` — consumes its capability (write-once).
-}
withInsetEnd : Bool -> Builder { a | insetEnd : Available } slotCaps msg -> Builder { a | insetEnd : Used } slotCaps msg
withInsetEnd value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.insetEnd value_ :: b.attrs }


{-| Pipe form of `insetStart` — consumes its capability (write-once).
-}
withInsetStart : Bool -> Builder { a | insetStart : Available } slotCaps msg -> Builder { a | insetStart : Used } slotCaps msg
withInsetStart value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.insetStart value_ :: b.attrs }


{-| Pipe form of `vertical` — consumes its capability (write-once).
-}
withVertical : Bool -> Builder { a | vertical : Available } slotCaps msg -> Builder { a | vertical : Used } slotCaps msg
withVertical value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.vertical value_ :: b.attrs }
