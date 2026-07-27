module M3e.AppBar exposing
    ( view, build, toElement
    , Is, Attrs, LeadingSlot, SubtitleSlot, TitleSlot, TrailingSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , Size, size
    , centered, for
    , leading, leadingIcon, subtitle, title, trailing, trailingIcon
    , withCentered, withClass, withFor, withId, withLeading, withLeadingIcon, withSize, withSlot, withStyle, withSubtitle, withTitle, withTrailingIcon
    )

{-| The `m3e-app-bar` component — strict per-component surface.

A bar, placed a the top of a screen, used to help users navigate through an application.

@docs view, build, toElement
@docs Is, Attrs, LeadingSlot, SubtitleSlot, TitleSlot, TrailingSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs Size, size
@docs centered, for
@docs leading, leadingIcon, subtitle, title, trailing, trailingIcon
@docs withCentered, withClass, withFor, withId, withLeading, withLeadingIcon, withSize, withSlot, withStyle, withSubtitle, withTitle, withTrailingIcon

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Value as Val exposing (Value)
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Html as H
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-app-bar` produces (open — composes into any slot naming it).
-}
type alias Is s =
    { s | appBar : Brand }


{-| The closed attribute-capability row.
-}
type alias Attrs =
    { centered : Supported
    , class : Supported
    , for : Supported
    , id : Supported
    , size : Supported
    , slot : Supported
    , style : Supported
    }


{-| The kinds the `leading` slot admits.
-}
type alias LeadingSlot =
    { button : Brand
    , iconButton : Brand
    , sharedIcon : Shared
    }


{-| The kinds the `subtitle` slot admits.
-}
type alias SubtitleSlot =
    { html : Brand
    , sharedText : Shared
    }


{-| The kinds the `title` slot admits.
-}
type alias TitleSlot =
    { html : Brand
    , sharedText : Shared
    }


{-| The kinds the `trailing` slot admits.
-}
type alias TrailingSlot =
    { button : Brand
    , html : Brand
    , iconButton : Brand
    , searchBar : Brand
    }


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    { childAdm | appBar : Ctx }


{-| The `size` values valid on this component (compile-tight narrowing).
-}
type alias Size =
    { large : Supported
    , medium : Supported
    , small : Supported
    }


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
`Build.Internal`, closed over this component's `Attrs` row.
-}
type alias Builder attrCaps slotCaps msg =
    B.Builder Attrs attrCaps slotCaps msg


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    { centered : Available
    , class : Available
    , for : Available
    , id : Available
    , size : Available
    , slot : Available
    , style : Available
    }


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    { leading : Available
    , leadingIcon : Available
    , subtitle : Available
    , title : Available
    , trailingIcon : Available
    }


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg
build =
    B.init "m3e-app-bar" [] []


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


{-| Pipe form of `centered` — consumes its capability (write-once).
-}
withCentered : Bool -> Builder { a | centered : Available } slotCaps msg -> Builder { a | centered : Used } slotCaps msg
withCentered value_ =
    B.withAttribute (A.centered value_)


{-| Pipe form of `for` — consumes its capability (write-once).
-}
withFor : String -> Builder { a | for : Available } slotCaps msg -> Builder { a | for : Used } slotCaps msg
withFor value_ =
    B.withAttribute (A.for value_)


{-| Pipe form of `size` — consumes its capability (write-once).
-}
withSize : Value Size -> Builder { a | size : Available } slotCaps msg -> Builder { a | size : Used } slotCaps msg
withSize value_ =
    B.withAttribute (size value_)


{-| Pipe form of the `leading` slot — consumes its capability (write-once).
-}
withLeading : Element LeadingSlot admittedBy msg -> Builder attrCaps { s | leading : Available } msg -> Builder attrCaps { s | leading : Used } msg
withLeading element =
    B.withChild (El.toNode (leading element))


{-| Pipe form of the `leading-icon` slot — consumes its capability (write-once).
-}
withLeadingIcon : Element childAccepts admittedBy msg -> Builder attrCaps { s | leadingIcon : Available } msg -> Builder attrCaps { s | leadingIcon : Used } msg
withLeadingIcon element =
    B.withChild (El.toNode (leadingIcon element))


{-| Pipe form of the `subtitle` slot — consumes its capability (write-once).
-}
withSubtitle : Element SubtitleSlot admittedBy msg -> Builder attrCaps { s | subtitle : Available } msg -> Builder attrCaps { s | subtitle : Used } msg
withSubtitle element =
    B.withChild (El.toNode (subtitle element))


{-| Pipe form of the `title` slot — consumes its capability (write-once).
-}
withTitle : Element TitleSlot admittedBy msg -> Builder attrCaps { s | title : Available } msg -> Builder attrCaps { s | title : Used } msg
withTitle element =
    B.withChild (El.toNode (title element))


{-| Pipe form of the `trailing-icon` slot — consumes its capability (write-once).
-}
withTrailingIcon : Element childAccepts admittedBy msg -> Builder attrCaps { s | trailingIcon : Available } msg -> Builder attrCaps { s | trailingIcon : Used } msg
withTrailingIcon element =
    B.withChild (El.toNode (trailingIcon element))
