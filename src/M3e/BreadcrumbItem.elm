module M3e.BreadcrumbItem exposing
    ( view, build, toElement
    , Is, Attrs, Content, IconSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , Current, current
    , disabled, download, href, itemLabel, rel, target, onClick
    , icon
    , withChild, withClass, withCurrent, withDisabled, withDownload, withHref, withIcon, withId, withItemLabel, withOnClick, withRel, withSlot, withStyle, withTarget
    )

{-| The `m3e-breadcrumb-item` component — strict per-component surface.

An item in a breadcrumb.

@docs view, build, toElement
@docs Is, Attrs, Content, IconSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs Current, current
@docs disabled, download, href, itemLabel, rel, target, onClick
@docs icon
@docs withChild, withClass, withCurrent, withDisabled, withDownload, withHref, withIcon, withId, withItemLabel, withOnClick, withRel, withSlot, withStyle, withTarget

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Value as Val exposing (Value)
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Events as Ev
import M3e.Html as H
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-breadcrumb-item` produces (open — composes into any slot naming it).
-}
type alias Is s =
    { s | breadcrumbItem : Brand }


{-| The closed attribute-capability row.
-}
type alias Attrs =
    { class : Supported
    , current : Supported
    , disabled : Supported
    , download : Supported
    , href : Supported
    , id : Supported
    , itemLabel : Supported
    , onClick : Supported
    , rel : Supported
    , slot : Supported
    , style : Supported
    , target : Supported
    }


{-| The kinds the default slot admits.
-}
type alias Content =
    { sharedIcon : Shared
    , sharedText : Shared
    }


{-| The kinds the `icon` slot admits.
-}
type alias IconSlot =
    { sharedIcon : Shared }


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    { childAdm | breadcrumbItem : Ctx }


{-| The `current` values valid on this component (compile-tight narrowing).
-}
type alias Current =
    { date : Supported
    , location : Supported
    , page : Supported
    , step : Supported
    , time : Supported
    , true : Supported
    }


{-| Standard constructor: `[attributes] [children]`.
-}
view :
    List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
view =
    H.breadcrumbItem


{-| Indicates the current item in the breadcrumb path.
-}
current : Value Current -> Attr { c | current : Supported } msg
current value_ =
    Ir.attribute "current" (Val.toString value_)


{-| See `M3e.Attributes.disabled`.
-}
disabled : Bool -> Attr { c | disabled : Supported } msg
disabled =
    A.disabled


{-| See `M3e.Attributes.download`.
-}
download : String -> Attr { c | download : Supported } msg
download =
    A.download


{-| See `M3e.Attributes.href`.
-}
href : String -> Attr { c | href : Supported } msg
href =
    A.href


{-| See `M3e.Attributes.itemLabel`.
-}
itemLabel : String -> Attr { c | itemLabel : Supported } msg
itemLabel =
    A.itemLabel


{-| See `M3e.Attributes.rel`.
-}
rel : String -> Attr { c | rel : Supported } msg
rel =
    A.rel


{-| See `M3e.Attributes.target`.
-}
target : String -> Attr { c | target : Supported } msg
target =
    A.target


{-| See `M3e.Events.onClick`.
-}
onClick : msg -> Attr { c | onClick : Supported } msg
onClick =
    Ev.onClick


{-| Place an element into the named `icon` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
icon : Element IconSlot admittedBy msg -> Element free freeAdmittedBy msg
icon element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "icon") (El.toNode element))


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
    , current : Available
    , disabled : Available
    , download : Available
    , href : Available
    , id : Available
    , itemLabel : Available
    , onClick : Available
    , rel : Available
    , slot : Available
    , style : Available
    , target : Available
    }


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    { icon : Available
    }


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg
build =
    B.init "m3e-breadcrumb-item" [] []


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


{-| Pipe form of `current` — consumes its capability (write-once).
-}
withCurrent : Value Current -> Builder { a | current : Available } slotCaps msg -> Builder { a | current : Used } slotCaps msg
withCurrent value_ =
    B.withAttribute (current value_)


{-| Pipe form of `disabled` — consumes its capability (write-once).
-}
withDisabled : Bool -> Builder { a | disabled : Available } slotCaps msg -> Builder { a | disabled : Used } slotCaps msg
withDisabled value_ =
    B.withAttribute (A.disabled value_)


{-| Pipe form of `download` — consumes its capability (write-once).
-}
withDownload : String -> Builder { a | download : Available } slotCaps msg -> Builder { a | download : Used } slotCaps msg
withDownload value_ =
    B.withAttribute (A.download value_)


{-| Pipe form of `href` — consumes its capability (write-once).
-}
withHref : String -> Builder { a | href : Available } slotCaps msg -> Builder { a | href : Used } slotCaps msg
withHref value_ =
    B.withAttribute (A.href value_)


{-| Pipe form of `itemLabel` — consumes its capability (write-once).
-}
withItemLabel : String -> Builder { a | itemLabel : Available } slotCaps msg -> Builder { a | itemLabel : Used } slotCaps msg
withItemLabel value_ =
    B.withAttribute (A.itemLabel value_)


{-| Pipe form of `rel` — consumes its capability (write-once).
-}
withRel : String -> Builder { a | rel : Available } slotCaps msg -> Builder { a | rel : Used } slotCaps msg
withRel value_ =
    B.withAttribute (A.rel value_)


{-| Pipe form of `target` — consumes its capability (write-once).
-}
withTarget : String -> Builder { a | target : Available } slotCaps msg -> Builder { a | target : Used } slotCaps msg
withTarget value_ =
    B.withAttribute (A.target value_)


{-| Pipe form of `onClick` — consumes its capability (write-once).
-}
withOnClick : msg -> Builder { a | onClick : Available } slotCaps msg -> Builder { a | onClick : Used } slotCaps msg
withOnClick value_ =
    B.withAttribute (Ev.onClick value_)


{-| Pipe form of the `icon` slot — consumes its capability (write-once).
-}
withIcon : Element IconSlot admittedBy msg -> Builder attrCaps { s | icon : Available } msg -> Builder attrCaps { s | icon : Used } msg
withIcon element =
    B.withChild (El.toNode (icon element))


{-| Pipe form of a default-slot child (repeatable).
-}
withChild : Element Content (ChildAdmittedBy childAdm) msg -> Builder attrCaps slotCaps msg -> Builder attrCaps slotCaps msg
withChild element =
    B.withChild (El.toNode element)
