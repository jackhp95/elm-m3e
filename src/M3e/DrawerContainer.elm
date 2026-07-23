module M3e.DrawerContainer exposing
    ( view, build, toElement
    , Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , EndMode, endMode, StartMode, startMode
    , endDivider, startDivider, onChange
    , end, start
    , withChild, withClass, withEnd, withEndDivider, withEndMode, withEndSlot, withId, withOnChange, withSlot, withStart, withStartDivider, withStartMode, withStartSlot, withStyle
    )

{-| The `m3e-drawer-container` component — strict per-component surface.

A container for one or two sliding drawers.

@docs view, build, toElement
@docs Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs EndMode, endMode, StartMode, startMode
@docs endDivider, startDivider, onChange
@docs end, start
@docs withChild, withClass, withEnd, withEndDivider, withEndMode, withEndSlot, withId, withOnChange, withSlot, withStart, withStartDivider, withStartMode, withStartSlot, withStyle

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import HtmlIr.Value as Val exposing (Value)
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Events as Ev
import M3e.Html as H
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-drawer-container` produces (open — composes into any slot naming it).
-}
type alias Is s =
    { s | drawerContainer : Brand }


{-| The closed attribute-capability row.
-}
type alias Attrs =
    { class : Supported
    , end : Supported
    , endDivider : Supported
    , endMode : Supported
    , id : Supported
    , onChange : Supported
    , slot : Supported
    , start : Supported
    , startDivider : Supported
    , startMode : Supported
    , style : Supported
    }


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    { childAdm | drawerContainer : Ctx }


{-| The `endMode` values valid on this component (compile-tight narrowing).
-}
type alias EndMode =
    { auto : Supported
    , over : Supported
    , push : Supported
    , side : Supported
    }


{-| The `startMode` values valid on this component (compile-tight narrowing).
-}
type alias StartMode =
    { auto : Supported
    , over : Supported
    , push : Supported
    , side : Supported
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
    H.drawerContainer


{-| The behavior mode of the end drawer. (default: `"side"`)
-}
endMode : Value EndMode -> Attr { c | endMode : Supported } msg
endMode value_ =
    Ir.attribute "end-mode" (Val.toString value_)


{-| The behavior mode of the start drawer. (default: `"side"`)
-}
startMode : Value StartMode -> Attr { c | startMode : Supported } msg
startMode value_ =
    Ir.attribute "start-mode" (Val.toString value_)


{-| See `M3e.Attributes.endDivider`.
-}
endDivider : Bool -> Attr { c | endDivider : Supported } msg
endDivider =
    A.endDivider


{-| See `M3e.Attributes.startDivider`.
-}
startDivider : Bool -> Attr { c | startDivider : Supported } msg
startDivider =
    A.startDivider


{-| See `M3e.Events.onChange`.
-}
onChange : msg -> Attr { c | onChange : Supported } msg
onChange =
    Ev.onChange


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
    , end : Available
    , endDivider : Available
    , endMode : Available
    , id : Available
    , onChange : Available
    , slot : Available
    , start : Available
    , startDivider : Available
    , startMode : Available
    , style : Available
    }


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    { end : Available
    , start : Available
    }


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg
build =
    B.init "m3e-drawer-container" [] []


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


{-| Pipe form of `end` — consumes its capability (write-once).
-}
withEnd : Bool -> Builder { a | end : Available } slotCaps msg -> Builder { a | end : Used } slotCaps msg
withEnd value_ =
    B.withAttribute (A.end value_)


{-| Pipe form of `endDivider` — consumes its capability (write-once).
-}
withEndDivider : Bool -> Builder { a | endDivider : Available } slotCaps msg -> Builder { a | endDivider : Used } slotCaps msg
withEndDivider value_ =
    B.withAttribute (A.endDivider value_)


{-| Pipe form of `endMode` — consumes its capability (write-once).
-}
withEndMode : Value EndMode -> Builder { a | endMode : Available } slotCaps msg -> Builder { a | endMode : Used } slotCaps msg
withEndMode value_ =
    B.withAttribute (endMode value_)


{-| Pipe form of `start` — consumes its capability (write-once).
-}
withStart : Bool -> Builder { a | start : Available } slotCaps msg -> Builder { a | start : Used } slotCaps msg
withStart value_ =
    B.withAttribute (A.start value_)


{-| Pipe form of `startDivider` — consumes its capability (write-once).
-}
withStartDivider : Bool -> Builder { a | startDivider : Available } slotCaps msg -> Builder { a | startDivider : Used } slotCaps msg
withStartDivider value_ =
    B.withAttribute (A.startDivider value_)


{-| Pipe form of `startMode` — consumes its capability (write-once).
-}
withStartMode : Value StartMode -> Builder { a | startMode : Available } slotCaps msg -> Builder { a | startMode : Used } slotCaps msg
withStartMode value_ =
    B.withAttribute (startMode value_)


{-| Pipe form of `onChange` — consumes its capability (write-once).
-}
withOnChange : msg -> Builder { a | onChange : Available } slotCaps msg -> Builder { a | onChange : Used } slotCaps msg
withOnChange value_ =
    B.withAttribute (Ev.onChange value_)


{-| Pipe form of the `end` slot — consumes its capability (write-once).
-}
withEndSlot : Element childAccepts admittedBy msg -> Builder attrCaps { s | end : Available } msg -> Builder attrCaps { s | end : Used } msg
withEndSlot element =
    B.withChild (El.toNode (end element))


{-| Pipe form of the `start` slot — consumes its capability (write-once).
-}
withStartSlot : Element childAccepts admittedBy msg -> Builder attrCaps { s | start : Available } msg -> Builder attrCaps { s | start : Used } msg
withStartSlot element =
    B.withChild (El.toNode (start element))


{-| Pipe form of a default-slot child (repeatable).
-}
withChild : Element childAccepts (ChildAdmittedBy childAdm) msg -> Builder attrCaps slotCaps msg -> Builder attrCaps slotCaps msg
withChild element =
    B.withChild (El.toNode element)
