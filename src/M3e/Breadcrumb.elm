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
import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Html as H
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
view =
    H.breadcrumb


{-| Required-content (and action) constructor — omissions are unwritable.
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
    A.wrap


{-| Place an element into the named `separator` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
separator : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
separator element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "separator") (El.toNode element))


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
    B.init "m3e-breadcrumb" [] [ El.toNode required_.content ]


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


{-| Pipe form of `wrap` — consumes its capability (write-once).
-}
withWrap : Bool -> Builder { a | wrap : Available } slotCaps msg -> Builder { a | wrap : Used } slotCaps msg
withWrap value_ =
    B.withAttribute (A.wrap value_)


{-| Pipe form of the `separator` slot — consumes its capability (write-once).
-}
withSeparator : Element childAccepts admittedBy msg -> Builder attrCaps { s | separator : Available } msg -> Builder attrCaps { s | separator : Used } msg
withSeparator element =
    B.withChild (El.toNode (separator element))


{-| Pipe form of a default-slot child (repeatable).
-}
withChild : Element Content (ChildAdmittedBy childAdm) msg -> Builder attrCaps slotCaps msg -> Builder attrCaps slotCaps msg
withChild element =
    B.withChild (El.toNode element)
