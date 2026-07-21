module M3e.Breadcrumb exposing
    ( view, el, build, toElement
    , Is, Attrs, Content, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , wrap
    , separator
    , withChild, withClass, withId, withSeparator, withSlot, withStyle, withWrap
    )

{-| The `m3e-breadcrumb` component — strict per-component surface.

Displays a hierarchical navigation path and identifies the user's
current location within an application.

@docs view, el, build, toElement
@docs Is, Attrs, Content, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs wrap
@docs separator
@docs withChild, withClass, withId, withSeparator, withSlot, withStyle, withWrap

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import HtmlIr.Node exposing (Node)
import M3e.Attributes
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-breadcrumb` produces (open — composes into any slot naming it).
-}
type alias Is s =
    { s | breadcrumb : Brand }


{-| The closed attribute-capability row.
-}
type alias Attrs =
    { class : Supported
    , id : Supported
    , slot : Supported
    , style : Supported
    , wrap : Supported
    }


{-| The kinds the default slot admits.
-}
type alias Content =
    { breadcrumbItem : Brand }


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    { childAdm | breadcrumb : Ctx }


{-| Standard constructor: `[attributes] [children]`.
-}
view :
    List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
view attrs children =
    Ir.fromNode (Ir.node "m3e-breadcrumb" attrs (List.map HtmlIr.Element.toNode children))


{-| Required-content constructor — missing required content is unwritable.
-}
el :
    { content : Element Content (ChildAdmittedBy childAdm) msg }
    -> List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el required_ attrs children =
    view attrs (required_.content :: children)


{-| See `M3e.Attributes.wrap`.
-}
wrap : Bool -> Attr { c | wrap : Supported } msg
wrap =
    M3e.Attributes.wrap


{-| Place an element into the named `separator` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
separator : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
separator element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "separator") (HtmlIr.Element.toNode element))


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
    , slot : Available
    , style : Available
    , wrap : Available
    }


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    { separator : Available
    }


{-| Seed the pipe-builder.
-}
build :
    { content : Element Content (ChildAdmittedBy childAdm) msg }
    -> Builder AttrCaps SlotCaps msg
build required_ =
    Builder { attrs = [], children = [ HtmlIr.Element.toNode required_.content ] }


{-| Close the pipe-builder.
-}
toElement : Builder attrCaps slotCaps msg -> Element (Is s) admittedBy msg
toElement (Builder b) =
    Ir.fromNode (Ir.node "m3e-breadcrumb" (List.reverse b.attrs) (List.reverse b.children))


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


{-| Pipe form of `wrap` — consumes its capability (write-once).
-}
withWrap : Bool -> Builder { a | wrap : Available } slotCaps msg -> Builder { a | wrap : Used } slotCaps msg
withWrap value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.wrap value_ :: b.attrs }


{-| Pipe form of the `separator` slot — consumes its capability (write-once).
-}
withSeparator : Element childAccepts admittedBy msg -> Builder attrCaps { s | separator : Available } msg -> Builder attrCaps { s | separator : Used } msg
withSeparator element (Builder b) =
    Builder { b | children = HtmlIr.Element.toNode (separator element) :: b.children }


{-| Pipe form of a default-slot child (repeatable).
-}
withChild : Element Content (ChildAdmittedBy childAdm) msg -> Builder attrCaps slotCaps msg -> Builder attrCaps slotCaps msg
withChild element (Builder b) =
    Builder { b | children = HtmlIr.Element.toNode element :: b.children }
