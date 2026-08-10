module M3e.ListItem exposing
    ( view, build, toElement
    , Is, Attrs, Content, LeadingSlot, OverlineSlot, SupportingTextSlot, TrailingSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , leading, overline, supportingText, trailing, child
    , withChild, withClass, withId, withLeading, withOverline, withSlot, withStyle, withSupportingText, withTrailing
    )

{-| The `m3e-list-item` component — strict per-component surface.

An item in a list.

@docs view, build, toElement
@docs Is, Attrs, Content, LeadingSlot, OverlineSlot, SupportingTextSlot, TrailingSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs leading, overline, supportingText, trailing, child
@docs withChild, withClass, withId, withLeading, withOverline, withSlot, withStyle, withSupportingText, withTrailing

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Shared, Supported)
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Html as H
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-list-item` produces (open — composes into any slot naming it).
-}
type alias Is s =
    { s | listItem : Brand }


{-| The closed attribute-capability row.
-}
type alias Attrs =
    { class : Supported
    , id : Supported
    , slot : Supported
    , style : Supported
    }


{-| The kinds the default slot admits.
-}
type alias Content =
    { heading : Brand
    , sharedFlow : Shared
    , sharedPhrasing : Shared
    , sharedText : Shared
    }


{-| The kinds the `leading` slot admits.
-}
type alias LeadingSlot =
    { avatar : Brand
    , heading : Brand
    , sharedFlow : Shared
    , sharedIcon : Shared
    , sharedPhrasing : Shared
    , sharedText : Shared
    }


{-| The kinds the `overline` slot admits.
-}
type alias OverlineSlot =
    { heading : Brand
    , sharedFlow : Shared
    , sharedPhrasing : Shared
    , sharedText : Shared
    }


{-| The kinds the `supporting-text` slot admits.
-}
type alias SupportingTextSlot =
    { heading : Brand
    , sharedFlow : Shared
    , sharedPhrasing : Shared
    , sharedText : Shared
    }


{-| The kinds the `trailing` slot admits.
-}
type alias TrailingSlot =
    { avatar : Brand
    , checkbox : Brand
    , heading : Brand
    , radio : Brand
    , sharedFlow : Shared
    , sharedIcon : Shared
    , sharedPhrasing : Shared
    , sharedText : Shared
    , switch : Brand
    }


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    { childAdm | listItem : Ctx }


{-| Standard constructor: `[attributes] [children]`.
-}
view :
    List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
view =
    H.listItem


{-| Place an element into the named `leading` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
leading : Element LeadingSlot admittedBy msg -> Element free freeAdmittedBy msg
leading element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "leading") (El.toNode element))


{-| Place an element into the named `overline` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
overline : Element OverlineSlot admittedBy msg -> Element free freeAdmittedBy msg
overline element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "overline") (El.toNode element))


{-| Place an element into the named `supporting-text` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
supportingText : Element SupportingTextSlot admittedBy msg -> Element free freeAdmittedBy msg
supportingText element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "supporting-text") (El.toNode element))


{-| Place an element into the named `trailing` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
trailing : Element TrailingSlot admittedBy msg -> Element free freeAdmittedBy msg
trailing element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "trailing") (El.toNode element))


{-| Place a pre-built element into the default (unnamed) slot (input
constrained to the slot's kinds; output row free so it composes into the
child list). The list-form sibling of the builder's `withChild`.
-}
child : Element Content admittedBy msg -> Element free freeAdmittedBy msg
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
    { class : Available
    , id : Available
    , slot : Available
    , style : Available
    }


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    { leading : Available
    , overline : Available
    , supportingText : Available
    , trailing : Available
    }


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg kind
build =
    B.init "m3e-list-item" [] []


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


{-| Pipe form of the `leading` slot — consumes its capability (write-once).
-}
withLeading : Element LeadingSlot admittedBy msg -> Builder attrCaps { s | leading : Available } msg kind -> Builder attrCaps { s | leading : Used } msg kind
withLeading element =
    B.withChild (El.toNode (leading element))


{-| Pipe form of the `overline` slot — consumes its capability (write-once).
-}
withOverline : Element OverlineSlot admittedBy msg -> Builder attrCaps { s | overline : Available } msg kind -> Builder attrCaps { s | overline : Used } msg kind
withOverline element =
    B.withChild (El.toNode (overline element))


{-| Pipe form of the `supporting-text` slot — consumes its capability (write-once).
-}
withSupportingText : Element SupportingTextSlot admittedBy msg -> Builder attrCaps { s | supportingText : Available } msg kind -> Builder attrCaps { s | supportingText : Used } msg kind
withSupportingText element =
    B.withChild (El.toNode (supportingText element))


{-| Pipe form of the `trailing` slot — consumes its capability (write-once).
-}
withTrailing : Element TrailingSlot admittedBy msg -> Builder attrCaps { s | trailing : Available } msg kind -> Builder attrCaps { s | trailing : Used } msg kind
withTrailing element =
    B.withChild (El.toNode (trailing element))


{-| Pipe form of a default-slot child (repeatable).
-}
withChild : Element Content (ChildAdmittedBy childAdm) msg -> Builder attrCaps slotCaps msg kind -> Builder attrCaps slotCaps msg kind
withChild element =
    B.withChild (El.toNode element)
