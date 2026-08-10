module M3e.AppBar exposing
    ( view, build, toElement
    , Is, Attrs, LeadingSlot, SubtitleSlot, TitleSlot, TrailingSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , Size, size
    , centered, for
    , leading, leadingIcon, subtitle, title, trailing, trailingIcon
    , withCentered, withClass, withFor, withId, withLeading, withLeadingIcon, withSize, withSlot, withStyle, withSubtitle, withTitle, withTrailing, withTrailingIcon
    )

{-| The `m3e-app-bar` component — strict per-component surface.

A bar, placed a the top of a screen, used to help users navigate through an application.

@docs view, build, toElement
@docs Is, Attrs, LeadingSlot, SubtitleSlot, TitleSlot, TrailingSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs Size, size
@docs centered, for
@docs leading, leadingIcon, subtitle, title, trailing, trailingIcon
@docs withCentered, withClass, withFor, withId, withLeading, withLeadingIcon, withSize, withSlot, withStyle, withSubtitle, withTitle, withTrailing, withTrailingIcon

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Value as Val exposing (Value)
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Html as H
import M3e.Internal.Types.AppBar
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-app-bar` produces (open — composes into any slot naming it).
-}
type alias Is s =
    M3e.Internal.Types.AppBar.Is s


{-| The closed attribute-capability row.
-}
type alias Attrs =
    M3e.Internal.Types.AppBar.Attrs


{-| The kinds the `leading` slot admits.
-}
type alias LeadingSlot =
    M3e.Internal.Types.AppBar.LeadingSlot


{-| The kinds the `subtitle` slot admits.
-}
type alias SubtitleSlot =
    M3e.Internal.Types.AppBar.SubtitleSlot


{-| The kinds the `title` slot admits.
-}
type alias TitleSlot =
    M3e.Internal.Types.AppBar.TitleSlot


{-| The kinds the `trailing` slot admits.
-}
type alias TrailingSlot =
    M3e.Internal.Types.AppBar.TrailingSlot


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    M3e.Internal.Types.AppBar.ChildAdmittedBy childAdm


{-| The `size` values valid on this component (compile-tight narrowing).
-}
type alias Size =
    M3e.Internal.Types.AppBar.Size


{-| Standard constructor: `[attributes] [children]`.
-}
view :
    List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
view =
    H.appBar


{-| The size of the bar. (default: `"small"`)
-}
size : Value Size -> Attr { c | size : Supported } msg
size value_ =
    Ir.attribute "size" (Val.toString value_)


{-| See `M3e.Attributes.centered`.
-}
centered : Bool -> Attr { c | centered : Supported } msg
centered =
    A.centered


{-| See `M3e.Attributes.for`.
-}
for : String -> Attr { c | for : Supported } msg
for =
    A.for


{-| Place an element into the named `leading` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
leading : Element LeadingSlot admittedBy msg -> Element free freeAdmittedBy msg
leading element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "leading") (El.toNode element))


{-| Place an element into the named `leading-icon` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
leadingIcon : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
leadingIcon element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "leading-icon") (El.toNode element))


{-| Place an element into the named `subtitle` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
subtitle : Element SubtitleSlot admittedBy msg -> Element free freeAdmittedBy msg
subtitle element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "subtitle") (El.toNode element))


{-| Place an element into the named `title` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
title : Element TitleSlot admittedBy msg -> Element free freeAdmittedBy msg
title element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "title") (El.toNode element))


{-| Place an element into the named `trailing` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
trailing : Element TrailingSlot admittedBy msg -> Element free freeAdmittedBy msg
trailing element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "trailing") (El.toNode element))


{-| Place an element into the named `trailing-icon` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
trailingIcon : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
trailingIcon element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "trailing-icon") (El.toNode element))


{-| The pipe-builder: capabilities are consumed Available→Used, so writing
a singular attribute or slot twice is unwritable. Aliases the shared builder in
`Build.Internal`, closed over this component's `Attrs` row and `Is s` kind.
-}
type alias Builder attrCaps slotCaps msg s =
    M3e.Internal.Types.AppBar.Builder attrCaps slotCaps msg s


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    M3e.Internal.Types.AppBar.AttrCaps


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    M3e.Internal.Types.AppBar.SlotCaps


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg kind
build =
    B.init "m3e-app-bar" [] []


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


{-| Pipe form of `centered` — consumes its capability (write-once).
-}
withCentered : Bool -> Builder { a | centered : Available } slotCaps msg kind -> Builder { a | centered : Used } slotCaps msg kind
withCentered value_ =
    B.withAttribute (A.centered value_)


{-| Pipe form of `for` — consumes its capability (write-once).
-}
withFor : String -> Builder { a | for : Available } slotCaps msg kind -> Builder { a | for : Used } slotCaps msg kind
withFor value_ =
    B.withAttribute (A.for value_)


{-| Pipe form of `size` — consumes its capability (write-once).
-}
withSize : Value Size -> Builder { a | size : Available } slotCaps msg kind -> Builder { a | size : Used } slotCaps msg kind
withSize value_ =
    B.withAttribute (size value_)


{-| Pipe form of the `leading-icon` slot — consumes its capability (write-once).
-}
withLeadingIcon : Element childAccepts admittedBy msg -> Builder attrCaps { s | leadingIcon : Available } msg kind -> Builder attrCaps { s | leadingIcon : Used } msg kind
withLeadingIcon element =
    B.withChild (El.toNode (leadingIcon element))


{-| Pipe form of the `subtitle` slot — consumes its capability (write-once).
-}
withSubtitle : Element SubtitleSlot admittedBy msg -> Builder attrCaps { s | subtitle : Available } msg kind -> Builder attrCaps { s | subtitle : Used } msg kind
withSubtitle element =
    B.withChild (El.toNode (subtitle element))


{-| Pipe form of the `title` slot — consumes its capability (write-once).
-}
withTitle : Element TitleSlot admittedBy msg -> Builder attrCaps { s | title : Available } msg kind -> Builder attrCaps { s | title : Used } msg kind
withTitle element =
    B.withChild (El.toNode (title element))


{-| Pipe form of the `trailing-icon` slot — consumes its capability (write-once).
-}
withTrailingIcon : Element childAccepts admittedBy msg -> Builder attrCaps { s | trailingIcon : Available } msg kind -> Builder attrCaps { s | trailingIcon : Used } msg kind
withTrailingIcon element =
    B.withChild (El.toNode (trailingIcon element))


{-| Pipe form of the `leading` slot — appends into the child list (repeatable, like `withChild`).
-}
withLeading : Element LeadingSlot admittedBy msg -> Builder attrCaps slotCaps msg kind -> Builder attrCaps slotCaps msg kind
withLeading element =
    B.withChild (El.toNode (leading element))


{-| Pipe form of the `trailing` slot — appends into the child list (repeatable, like `withChild`).
-}
withTrailing : Element TrailingSlot admittedBy msg -> Builder attrCaps slotCaps msg kind -> Builder attrCaps slotCaps msg kind
withTrailing element =
    B.withChild (El.toNode (trailing element))
