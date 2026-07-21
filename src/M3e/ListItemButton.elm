module M3e.ListItemButton exposing
    ( view, build, toElement
    , Is, Attrs, Content, LeadingSlot, OverlineSlot, SupportingTextSlot, TrailingSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , disabled, download, href, rel, target, onClick
    , leading, overline, supportingText, trailing
    , withAriaLabel, withChild, withClass, withDisabled, withDownload, withHref, withId, withLeading, withOnClick, withOverline, withRel, withSlot, withStyle, withSupportingText, withTarget, withTrailing
    )

{-| The `m3e-list-item-button` component — strict per-component surface.

@docs view, build, toElement
@docs Is, Attrs, Content, LeadingSlot, OverlineSlot, SupportingTextSlot, TrailingSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs disabled, download, href, rel, target, onClick
@docs leading, overline, supportingText, trailing
@docs withAriaLabel, withChild, withClass, withDisabled, withDownload, withHref, withId, withLeading, withOnClick, withOverline, withRel, withSlot, withStyle, withSupportingText, withTarget, withTrailing

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Node exposing (Node)
import M3e.Attributes
import M3e.Events
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-list-item-button` produces (open — composes into any slot naming it).
-}
type alias Is s =
    { s | listItemButton : Brand }


{-| The closed attribute-capability row.
-}
type alias Attrs =
    { ariaLabel : Supported
    , class : Supported
    , disabled : Supported
    , download : Supported
    , href : Supported
    , id : Supported
    , onClick : Supported
    , rel : Supported
    , slot : Supported
    , style : Supported
    , target : Supported
    }


{-| The kinds the default slot admits.
-}
type alias Content =
    { html : Brand
    , sharedText : Shared
    }


{-| The kinds the `leading` slot admits.
-}
type alias LeadingSlot =
    { avatar : Brand
    , html : Brand
    , sharedIcon : Shared
    , sharedText : Shared
    }


{-| The kinds the `overline` slot admits.
-}
type alias OverlineSlot =
    { html : Brand
    , sharedText : Shared
    }


{-| The kinds the `supporting-text` slot admits.
-}
type alias SupportingTextSlot =
    { html : Brand
    , sharedText : Shared
    }


{-| The kinds the `trailing` slot admits.
-}
type alias TrailingSlot =
    { avatar : Brand
    , checkbox : Brand
    , html : Brand
    , radio : Brand
    , sharedIcon : Shared
    , sharedText : Shared
    , switch : Brand
    }


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    { childAdm | listItemButton : Ctx }


{-| Standard constructor: `[attributes] [children]`.
-}
view :
    List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
view attrs children =
    Ir.fromNode (Ir.node "m3e-list-item-button" attrs (List.map HtmlIr.Element.toNode children))


{-| See `M3e.Attributes.disabled`.
-}
disabled : Bool -> Attr { c | disabled : Supported } msg
disabled =
    M3e.Attributes.disabled


{-| See `M3e.Attributes.download`.
-}
download : String -> Attr { c | download : Supported } msg
download =
    M3e.Attributes.download


{-| See `M3e.Attributes.href`.
-}
href : String -> Attr { c | href : Supported } msg
href =
    M3e.Attributes.href


{-| See `M3e.Attributes.rel`.
-}
rel : String -> Attr { c | rel : Supported } msg
rel =
    M3e.Attributes.rel


{-| See `M3e.Attributes.target`.
-}
target : String -> Attr { c | target : Supported } msg
target =
    M3e.Attributes.target


{-| See `M3e.Events.onClick`.
-}
onClick : msg -> Attr { c | onClick : Supported } msg
onClick =
    M3e.Events.onClick


{-| Place an element into the named `leading` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
leading : Element LeadingSlot admittedBy msg -> Element free freeAdmittedBy msg
leading element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "leading") (HtmlIr.Element.toNode element))


{-| Place an element into the named `overline` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
overline : Element OverlineSlot admittedBy msg -> Element free freeAdmittedBy msg
overline element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "overline") (HtmlIr.Element.toNode element))


{-| Place an element into the named `supporting-text` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
supportingText : Element SupportingTextSlot admittedBy msg -> Element free freeAdmittedBy msg
supportingText element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "supporting-text") (HtmlIr.Element.toNode element))


{-| Place an element into the named `trailing` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
trailing : Element TrailingSlot admittedBy msg -> Element free freeAdmittedBy msg
trailing element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "trailing") (HtmlIr.Element.toNode element))


{-| The pipe-builder: capabilities are consumed Available→Used, so writing
a singular attribute or slot twice is unwritable.
-}
type Builder attrCaps slotCaps msg
    = Builder { attrs : List (Attr Attrs msg), children : List (Node msg) }


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    { ariaLabel : Available
    , class : Available
    , disabled : Available
    , download : Available
    , href : Available
    , id : Available
    , onClick : Available
    , rel : Available
    , slot : Available
    , style : Available
    , target : Available
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
build : Builder AttrCaps SlotCaps msg
build =
    Builder { attrs = [], children = [] }


{-| Close the pipe-builder.
-}
toElement : Builder attrCaps slotCaps msg -> Element (Is s) admittedBy msg
toElement (Builder b) =
    Ir.fromNode (Ir.node "m3e-list-item-button" (List.reverse b.attrs) (List.reverse b.children))


{-| Pipe form of `ariaLabel` — consumes its capability (write-once).
-}
withAriaLabel : String -> Builder { a | ariaLabel : Available } slotCaps msg -> Builder { a | ariaLabel : Used } slotCaps msg
withAriaLabel value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.ariaLabel value_ :: b.attrs }


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


{-| Pipe form of `disabled` — consumes its capability (write-once).
-}
withDisabled : Bool -> Builder { a | disabled : Available } slotCaps msg -> Builder { a | disabled : Used } slotCaps msg
withDisabled value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.disabled value_ :: b.attrs }


{-| Pipe form of `download` — consumes its capability (write-once).
-}
withDownload : String -> Builder { a | download : Available } slotCaps msg -> Builder { a | download : Used } slotCaps msg
withDownload value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.download value_ :: b.attrs }


{-| Pipe form of `href` — consumes its capability (write-once).
-}
withHref : String -> Builder { a | href : Available } slotCaps msg -> Builder { a | href : Used } slotCaps msg
withHref value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.href value_ :: b.attrs }


{-| Pipe form of `rel` — consumes its capability (write-once).
-}
withRel : String -> Builder { a | rel : Available } slotCaps msg -> Builder { a | rel : Used } slotCaps msg
withRel value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.rel value_ :: b.attrs }


{-| Pipe form of `target` — consumes its capability (write-once).
-}
withTarget : String -> Builder { a | target : Available } slotCaps msg -> Builder { a | target : Used } slotCaps msg
withTarget value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.target value_ :: b.attrs }


{-| Pipe form of `onClick` — consumes its capability (write-once).
-}
withOnClick : msg -> Builder { a | onClick : Available } slotCaps msg -> Builder { a | onClick : Used } slotCaps msg
withOnClick value_ (Builder b) =
    Builder { b | attrs = M3e.Events.onClick value_ :: b.attrs }


{-| Pipe form of the `leading` slot — consumes its capability (write-once).
-}
withLeading : Element LeadingSlot admittedBy msg -> Builder attrCaps { s | leading : Available } msg -> Builder attrCaps { s | leading : Used } msg
withLeading element (Builder b) =
    Builder { b | children = HtmlIr.Element.toNode (leading element) :: b.children }


{-| Pipe form of the `overline` slot — consumes its capability (write-once).
-}
withOverline : Element OverlineSlot admittedBy msg -> Builder attrCaps { s | overline : Available } msg -> Builder attrCaps { s | overline : Used } msg
withOverline element (Builder b) =
    Builder { b | children = HtmlIr.Element.toNode (overline element) :: b.children }


{-| Pipe form of the `supporting-text` slot — consumes its capability (write-once).
-}
withSupportingText : Element SupportingTextSlot admittedBy msg -> Builder attrCaps { s | supportingText : Available } msg -> Builder attrCaps { s | supportingText : Used } msg
withSupportingText element (Builder b) =
    Builder { b | children = HtmlIr.Element.toNode (supportingText element) :: b.children }


{-| Pipe form of the `trailing` slot — consumes its capability (write-once).
-}
withTrailing : Element TrailingSlot admittedBy msg -> Builder attrCaps { s | trailing : Available } msg -> Builder attrCaps { s | trailing : Used } msg
withTrailing element (Builder b) =
    Builder { b | children = HtmlIr.Element.toNode (trailing element) :: b.children }


{-| Pipe form of a default-slot child (repeatable).
-}
withChild : Element Content (ChildAdmittedBy childAdm) msg -> Builder attrCaps slotCaps msg -> Builder attrCaps slotCaps msg
withChild element (Builder b) =
    Builder { b | children = HtmlIr.Element.toNode element :: b.children }
