module M3e.ExpandableListItem exposing
    ( view, build, toElement
    , Is, Attrs, Content, LeadingSlot, OverlineSlot, SupportingTextSlot, ToggleIconSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , disabled, open, onOpening, onOpened, onClosing, onClosed
    , items, leading, overline, supportingText, toggleIcon, child
    , withChild, withClass, withDisabled, withId, withItems, withLeading, withOnClosed, withOnClosing, withOnOpened, withOnOpening, withOpen, withOverline, withSlot, withStyle, withSupportingText, withToggleIcon
    )

{-| The `m3e-expandable-list-item` component — strict per-component surface.

An item in a list that can be expanded to show more items.

@docs view, build, toElement
@docs Is, Attrs, Content, LeadingSlot, OverlineSlot, SupportingTextSlot, ToggleIconSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs disabled, open, onOpening, onOpened, onClosing, onClosed
@docs items, leading, overline, supportingText, toggleIcon, child
@docs withChild, withClass, withDisabled, withId, withItems, withLeading, withOnClosed, withOnClosing, withOnOpened, withOnOpening, withOpen, withOverline, withSlot, withStyle, withSupportingText, withToggleIcon

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Shared, Supported)
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Events as Ev
import M3e.Html as H
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-expandable-list-item` produces (open — composes into any slot naming it).
-}
type alias Is s =
    { s | expandableListItem : Brand }


{-| The closed attribute-capability row.
-}
type alias Attrs =
    { class : Supported
    , disabled : Supported
    , id : Supported
    , onClosed : Supported
    , onClosing : Supported
    , onOpened : Supported
    , onOpening : Supported
    , open : Supported
    , slot : Supported
    , style : Supported
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


{-| The kinds the `toggle-icon` slot admits.
-}
type alias ToggleIconSlot =
    { sharedIcon : Shared }


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    { childAdm | expandableListItem : Ctx }


{-| Standard constructor: `[attributes] [children]`.
-}
view :
    List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
view =
    H.expandableListItem


{-| See `M3e.Attributes.disabled`.
-}
disabled : Bool -> Attr { c | disabled : Supported } msg
disabled =
    A.disabled


{-| See `M3e.Attributes.open`.
-}
open : Bool -> Attr { c | open : Supported } msg
open =
    A.open


{-| See `M3e.Events.onOpening`.
-}
onOpening : msg -> Attr { c | onOpening : Supported } msg
onOpening =
    Ev.onOpening


{-| See `M3e.Events.onOpened`.
-}
onOpened : msg -> Attr { c | onOpened : Supported } msg
onOpened =
    Ev.onOpened


{-| See `M3e.Events.onClosing`.
-}
onClosing : msg -> Attr { c | onClosing : Supported } msg
onClosing =
    Ev.onClosing


{-| See `M3e.Events.onClosed`.
-}
onClosed : msg -> Attr { c | onClosed : Supported } msg
onClosed =
    Ev.onClosed


{-| Place an element into the named `items` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
items : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
items element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "items") (El.toNode element))


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


{-| Place an element into the named `toggle-icon` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
toggleIcon : Element ToggleIconSlot admittedBy msg -> Element free freeAdmittedBy msg
toggleIcon element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "toggle-icon") (El.toNode element))


{-| Place a pre-built element into the default (unnamed) slot (input
constrained to the slot's kinds; output row free so it composes into the
child list). The list-form sibling of the builder's `withChild`.
-}
child : Element Content admittedBy msg -> Element free freeAdmittedBy msg
child element =
    Ir.fromNode (El.toNode element)


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
    , disabled : Available
    , id : Available
    , onClosed : Available
    , onClosing : Available
    , onOpened : Available
    , onOpening : Available
    , open : Available
    , slot : Available
    , style : Available
    }


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    { items : Available
    , leading : Available
    , overline : Available
    , supportingText : Available
    , toggleIcon : Available
    }


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg
build =
    B.init "m3e-expandable-list-item" [] []


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


{-| Pipe form of `disabled` — consumes its capability (write-once).
-}
withDisabled : Bool -> Builder { a | disabled : Available } slotCaps msg -> Builder { a | disabled : Used } slotCaps msg
withDisabled value_ =
    B.withAttribute (A.disabled value_)


{-| Pipe form of `open` — consumes its capability (write-once).
-}
withOpen : Bool -> Builder { a | open : Available } slotCaps msg -> Builder { a | open : Used } slotCaps msg
withOpen value_ =
    B.withAttribute (A.open value_)


{-| Pipe form of `onOpening` — consumes its capability (write-once).
-}
withOnOpening : msg -> Builder { a | onOpening : Available } slotCaps msg -> Builder { a | onOpening : Used } slotCaps msg
withOnOpening value_ =
    B.withAttribute (Ev.onOpening value_)


{-| Pipe form of `onOpened` — consumes its capability (write-once).
-}
withOnOpened : msg -> Builder { a | onOpened : Available } slotCaps msg -> Builder { a | onOpened : Used } slotCaps msg
withOnOpened value_ =
    B.withAttribute (Ev.onOpened value_)


{-| Pipe form of `onClosing` — consumes its capability (write-once).
-}
withOnClosing : msg -> Builder { a | onClosing : Available } slotCaps msg -> Builder { a | onClosing : Used } slotCaps msg
withOnClosing value_ =
    B.withAttribute (Ev.onClosing value_)


{-| Pipe form of `onClosed` — consumes its capability (write-once).
-}
withOnClosed : msg -> Builder { a | onClosed : Available } slotCaps msg -> Builder { a | onClosed : Used } slotCaps msg
withOnClosed value_ =
    B.withAttribute (Ev.onClosed value_)


{-| Pipe form of the `items` slot — consumes its capability (write-once).
-}
withItems : Element childAccepts admittedBy msg -> Builder attrCaps { s | items : Available } msg -> Builder attrCaps { s | items : Used } msg
withItems element =
    B.withChild (El.toNode (items element))


{-| Pipe form of the `leading` slot — consumes its capability (write-once).
-}
withLeading : Element LeadingSlot admittedBy msg -> Builder attrCaps { s | leading : Available } msg -> Builder attrCaps { s | leading : Used } msg
withLeading element =
    B.withChild (El.toNode (leading element))


{-| Pipe form of the `overline` slot — consumes its capability (write-once).
-}
withOverline : Element OverlineSlot admittedBy msg -> Builder attrCaps { s | overline : Available } msg -> Builder attrCaps { s | overline : Used } msg
withOverline element =
    B.withChild (El.toNode (overline element))


{-| Pipe form of the `supporting-text` slot — consumes its capability (write-once).
-}
withSupportingText : Element SupportingTextSlot admittedBy msg -> Builder attrCaps { s | supportingText : Available } msg -> Builder attrCaps { s | supportingText : Used } msg
withSupportingText element =
    B.withChild (El.toNode (supportingText element))


{-| Pipe form of the `toggle-icon` slot — consumes its capability (write-once).
-}
withToggleIcon : Element ToggleIconSlot admittedBy msg -> Builder attrCaps { s | toggleIcon : Available } msg -> Builder attrCaps { s | toggleIcon : Used } msg
withToggleIcon element =
    B.withChild (El.toNode (toggleIcon element))


{-| Pipe form of a default-slot child (repeatable).
-}
withChild : Element Content (ChildAdmittedBy childAdm) msg -> Builder attrCaps slotCaps msg -> Builder attrCaps slotCaps msg
withChild element =
    B.withChild (El.toNode element)
