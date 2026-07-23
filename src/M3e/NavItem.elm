module M3e.NavItem exposing
    ( view, build, toElement
    , Is, Attrs, Content, IconSlot, SelectedIconSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , Orientation, orientation
    , disabled, disabledInteractive, download, href, rel, selected, target, onBeforeinput, onInput, onChange, onClick
    , icon, selectedIcon
    , withChild, withClass, withDisabled, withDisabledInteractive, withDownload, withHref, withIcon, withId, withOnBeforeinput, withOnChange, withOnClick, withOnInput, withOrientation, withRel, withSelected, withSelectedIcon, withSlot, withStyle, withTarget
    )

{-| The `m3e-nav-item` component — strict per-component surface.

An item, placed in a navigation bar or rail, used to navigate to destinations in an application.

@docs view, build, toElement
@docs Is, Attrs, Content, IconSlot, SelectedIconSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs Orientation, orientation
@docs disabled, disabledInteractive, download, href, rel, selected, target, onBeforeinput, onInput, onChange, onClick
@docs icon, selectedIcon
@docs withChild, withClass, withDisabled, withDisabledInteractive, withDownload, withHref, withIcon, withId, withOnBeforeinput, withOnChange, withOnClick, withOnInput, withOrientation, withRel, withSelected, withSelectedIcon, withSlot, withStyle, withTarget

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


{-| The kind row `m3e-nav-item` produces (open — composes into any slot naming it).
-}
type alias Is s =
    { s | navItem : Brand }


{-| The closed attribute-capability row.
-}
type alias Attrs =
    { class : Supported
    , disabled : Supported
    , disabledInteractive : Supported
    , download : Supported
    , href : Supported
    , id : Supported
    , onBeforeinput : Supported
    , onChange : Supported
    , onClick : Supported
    , onInput : Supported
    , orientation : Supported
    , rel : Supported
    , selected : Supported
    , slot : Supported
    , style : Supported
    , target : Supported
    }


{-| The kinds the default slot admits.
-}
type alias Content =
    { sharedText : Shared }


{-| The kinds the `icon` slot admits.
-}
type alias IconSlot =
    { sharedIcon : Shared }


{-| The kinds the `selected-icon` slot admits.
-}
type alias SelectedIconSlot =
    { sharedIcon : Shared }


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    { childAdm | navItem : Ctx }


{-| The `orientation` values valid on this component (compile-tight narrowing).
-}
type alias Orientation =
    { horizontal : Supported
    , vertical : Supported
    }


{-| Standard constructor: `[attributes] [children]`.
-}
view :
    List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
view =
    H.navItem


{-| The layout orientation of the item. (default: `"vertical"`)
-}
orientation : Value Orientation -> Attr { c | orientation : Supported } msg
orientation value_ =
    Ir.attribute "orientation" (Val.toString value_)


{-| See `M3e.Attributes.disabled`.
-}
disabled : Bool -> Attr { c | disabled : Supported } msg
disabled =
    A.disabled


{-| See `M3e.Attributes.disabledInteractive`.
-}
disabledInteractive : Bool -> Attr { c | disabledInteractive : Supported } msg
disabledInteractive =
    A.disabledInteractive


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


{-| See `M3e.Attributes.rel`.
-}
rel : String -> Attr { c | rel : Supported } msg
rel =
    A.rel


{-| See `M3e.Attributes.selected`.
-}
selected : Bool -> Attr { c | selected : Supported } msg
selected =
    A.selected


{-| See `M3e.Attributes.target`.
-}
target : String -> Attr { c | target : Supported } msg
target =
    A.target


{-| See `M3e.Events.onBeforeinput`.
-}
onBeforeinput : msg -> Attr { c | onBeforeinput : Supported } msg
onBeforeinput =
    Ev.onBeforeinput


{-| See `M3e.Events.onInput`.
-}
onInput : msg -> Attr { c | onInput : Supported } msg
onInput =
    Ev.onInput


{-| See `M3e.Events.onChange`.
-}
onChange : msg -> Attr { c | onChange : Supported } msg
onChange =
    Ev.onChange


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


{-| Place an element into the named `selected-icon` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
selectedIcon : Element SelectedIconSlot admittedBy msg -> Element free freeAdmittedBy msg
selectedIcon element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "selected-icon") (El.toNode element))


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
    , disabledInteractive : Available
    , download : Available
    , href : Available
    , id : Available
    , onBeforeinput : Available
    , onChange : Available
    , onClick : Available
    , onInput : Available
    , orientation : Available
    , rel : Available
    , selected : Available
    , slot : Available
    , style : Available
    , target : Available
    }


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    { icon : Available
    , selectedIcon : Available
    }


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg
build =
    B.init "m3e-nav-item" [] []


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


{-| Pipe form of `disabledInteractive` — consumes its capability (write-once).
-}
withDisabledInteractive : Bool -> Builder { a | disabledInteractive : Available } slotCaps msg -> Builder { a | disabledInteractive : Used } slotCaps msg
withDisabledInteractive value_ =
    B.withAttribute (A.disabledInteractive value_)


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


{-| Pipe form of `orientation` — consumes its capability (write-once).
-}
withOrientation : Value Orientation -> Builder { a | orientation : Available } slotCaps msg -> Builder { a | orientation : Used } slotCaps msg
withOrientation value_ =
    B.withAttribute (orientation value_)


{-| Pipe form of `rel` — consumes its capability (write-once).
-}
withRel : String -> Builder { a | rel : Available } slotCaps msg -> Builder { a | rel : Used } slotCaps msg
withRel value_ =
    B.withAttribute (A.rel value_)


{-| Pipe form of `selected` — consumes its capability (write-once).
-}
withSelected : Bool -> Builder { a | selected : Available } slotCaps msg -> Builder { a | selected : Used } slotCaps msg
withSelected value_ =
    B.withAttribute (A.selected value_)


{-| Pipe form of `target` — consumes its capability (write-once).
-}
withTarget : String -> Builder { a | target : Available } slotCaps msg -> Builder { a | target : Used } slotCaps msg
withTarget value_ =
    B.withAttribute (A.target value_)


{-| Pipe form of `onBeforeinput` — consumes its capability (write-once).
-}
withOnBeforeinput : msg -> Builder { a | onBeforeinput : Available } slotCaps msg -> Builder { a | onBeforeinput : Used } slotCaps msg
withOnBeforeinput value_ =
    B.withAttribute (Ev.onBeforeinput value_)


{-| Pipe form of `onInput` — consumes its capability (write-once).
-}
withOnInput : msg -> Builder { a | onInput : Available } slotCaps msg -> Builder { a | onInput : Used } slotCaps msg
withOnInput value_ =
    B.withAttribute (Ev.onInput value_)


{-| Pipe form of `onChange` — consumes its capability (write-once).
-}
withOnChange : msg -> Builder { a | onChange : Available } slotCaps msg -> Builder { a | onChange : Used } slotCaps msg
withOnChange value_ =
    B.withAttribute (Ev.onChange value_)


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


{-| Pipe form of the `selected-icon` slot — consumes its capability (write-once).
-}
withSelectedIcon : Element SelectedIconSlot admittedBy msg -> Builder attrCaps { s | selectedIcon : Available } msg -> Builder attrCaps { s | selectedIcon : Used } msg
withSelectedIcon element =
    B.withChild (El.toNode (selectedIcon element))


{-| Pipe form of a default-slot child (repeatable).
-}
withChild : Element Content (ChildAdmittedBy childAdm) msg -> Builder attrCaps slotCaps msg -> Builder attrCaps slotCaps msg
withChild element =
    B.withChild (El.toNode element)
