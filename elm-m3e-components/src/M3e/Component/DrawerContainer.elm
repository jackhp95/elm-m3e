module M3e.Component.DrawerContainer exposing
    ( view, build, toElement
    , Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , EndMode, endMode, StartMode, startMode
    , endDivider, startDivider, onChange
    , end, start, child
    , withChild, withClass, withEnd, withEndDivider, withEndMode, withEndSlot, withId, withOnChange, withSlot, withStart, withStartDivider, withStartMode, withStartSlot, withStyle
    )

{-| The `m3e-drawer-container` component — strict per-component surface.

A container for one or two sliding drawers.

@docs view, build, toElement
@docs Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs EndMode, endMode, StartMode, startMode
@docs endDivider, startDivider, onChange
@docs end, start, child
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
import M3e.Internal.Types.DrawerContainer
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-drawer-container` produces (open — composes into any slot naming it).
-}
type alias Is s =
    M3e.Internal.Types.DrawerContainer.Is s


{-| The closed attribute-capability row.
-}
type alias Attrs =
    M3e.Internal.Types.DrawerContainer.Attrs


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    M3e.Internal.Types.DrawerContainer.ChildAdmittedBy childAdm


{-| The `endMode` values valid on this component (compile-tight narrowing).
-}
type alias EndMode =
    M3e.Internal.Types.DrawerContainer.EndMode


{-| The `startMode` values valid on this component (compile-tight narrowing).
-}
type alias StartMode =
    M3e.Internal.Types.DrawerContainer.StartMode


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
    M3e.Internal.Types.DrawerContainer.Builder attrCaps slotCaps msg s


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    M3e.Internal.Types.DrawerContainer.AttrCaps


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    M3e.Internal.Types.DrawerContainer.SlotCaps


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg kind
build =
    B.init "m3e-drawer-container" [] []


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


{-| Pipe form of `end` — consumes its capability (write-once).
-}
withEnd : Bool -> Builder { a | end : Available } slotCaps msg kind -> Builder { a | end : Used } slotCaps msg kind
withEnd value_ =
    B.withAttribute (A.end value_)


{-| Pipe form of `endDivider` — consumes its capability (write-once).
-}
withEndDivider : Bool -> Builder { a | endDivider : Available } slotCaps msg kind -> Builder { a | endDivider : Used } slotCaps msg kind
withEndDivider value_ =
    B.withAttribute (A.endDivider value_)


{-| Pipe form of `endMode` — consumes its capability (write-once).
-}
withEndMode : Value EndMode -> Builder { a | endMode : Available } slotCaps msg kind -> Builder { a | endMode : Used } slotCaps msg kind
withEndMode value_ =
    B.withAttribute (endMode value_)


{-| Pipe form of `start` — consumes its capability (write-once).
-}
withStart : Bool -> Builder { a | start : Available } slotCaps msg kind -> Builder { a | start : Used } slotCaps msg kind
withStart value_ =
    B.withAttribute (A.start value_)


{-| Pipe form of `startDivider` — consumes its capability (write-once).
-}
withStartDivider : Bool -> Builder { a | startDivider : Available } slotCaps msg kind -> Builder { a | startDivider : Used } slotCaps msg kind
withStartDivider value_ =
    B.withAttribute (A.startDivider value_)


{-| Pipe form of `startMode` — consumes its capability (write-once).
-}
withStartMode : Value StartMode -> Builder { a | startMode : Available } slotCaps msg kind -> Builder { a | startMode : Used } slotCaps msg kind
withStartMode value_ =
    B.withAttribute (startMode value_)


{-| Pipe form of `onChange` — consumes its capability (write-once).
-}
withOnChange : msg -> Builder { a | onChange : Available } slotCaps msg kind -> Builder { a | onChange : Used } slotCaps msg kind
withOnChange value_ =
    B.withAttribute (Ev.onChange value_)


{-| Pipe form of the `end` slot — consumes its capability (write-once).
-}
withEndSlot : Element childAccepts admittedBy msg -> Builder attrCaps { s | end : Available } msg kind -> Builder attrCaps { s | end : Used } msg kind
withEndSlot element =
    B.withChild (El.toNode (end element))


{-| Pipe form of the `start` slot — consumes its capability (write-once).
-}
withStartSlot : Element childAccepts admittedBy msg -> Builder attrCaps { s | start : Available } msg kind -> Builder attrCaps { s | start : Used } msg kind
withStartSlot element =
    B.withChild (El.toNode (start element))


{-| Pipe form of a default-slot child (repeatable).
-}
withChild : Element childAccepts (ChildAdmittedBy childAdm) msg -> Builder attrCaps slotCaps msg kind -> Builder attrCaps slotCaps msg kind
withChild element =
    B.withChild (El.toNode element)
