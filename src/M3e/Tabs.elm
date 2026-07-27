module M3e.Tabs exposing
    ( view, build, toElement
    , Is, Attrs, Content, NextIconSlot, PanelSlot, PrevIconSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , HeaderPosition, headerPosition, Variant, variant
    , disablePagination, nextPageLabel, previousPageLabel, stretch, onChange, onBeforeinput, onInput
    , nextIcon, panel, prevIcon, child
    , withChild, withClass, withDisablePagination, withHeaderPosition, withId, withNextIcon, withNextPageLabel, withOnBeforeinput, withOnChange, withOnInput, withPrevIcon, withPreviousPageLabel, withSlot, withStretch, withStyle, withVariant
    )

{-| The `m3e-tabs` component — strict per-component surface.

Organizes content into separate views where only one view can be visible at a time.

@docs view, build, toElement
@docs Is, Attrs, Content, NextIconSlot, PanelSlot, PrevIconSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs HeaderPosition, headerPosition, Variant, variant
@docs disablePagination, nextPageLabel, previousPageLabel, stretch, onChange, onBeforeinput, onInput
@docs nextIcon, panel, prevIcon, child
@docs withChild, withClass, withDisablePagination, withHeaderPosition, withId, withNextIcon, withNextPageLabel, withOnBeforeinput, withOnChange, withOnInput, withPrevIcon, withPreviousPageLabel, withSlot, withStretch, withStyle, withVariant

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


{-| The kind row `m3e-tabs` produces (open — composes into any slot naming it).
-}
type alias Is s =
    { s | tabs : Brand }


{-| The closed attribute-capability row.
-}
type alias Attrs =
    { class : Supported
    , disablePagination : Supported
    , headerPosition : Supported
    , id : Supported
    , nextPageLabel : Supported
    , onBeforeinput : Supported
    , onChange : Supported
    , onInput : Supported
    , previousPageLabel : Supported
    , slot : Supported
    , stretch : Supported
    , style : Supported
    , variant : Supported
    }


{-| The kinds the default slot admits.
-}
type alias Content =
    { tab : Brand }


{-| The kinds the `next-icon` slot admits.
-}
type alias NextIconSlot =
    { sharedIcon : Shared }


{-| The kinds the `panel` slot admits.
-}
type alias PanelSlot =
    { tabPanel : Brand }


{-| The kinds the `prev-icon` slot admits.
-}
type alias PrevIconSlot =
    { sharedIcon : Shared }


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    { childAdm | tabs : Ctx }


{-| The `headerPosition` values valid on this component (compile-tight narrowing).
-}
type alias HeaderPosition =
    { after : Supported
    , before : Supported
    }


{-| The `variant` values valid on this component (compile-tight narrowing).
-}
type alias Variant =
    { primary : Supported
    , secondary : Supported
    }


{-| Standard constructor: `[attributes] [children]`.
-}
view :
    List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
view =
    H.tabs


{-| The position of the tab headers. (default: `"before"`)
-}
headerPosition : Value HeaderPosition -> Attr { c | headerPosition : Supported } msg
headerPosition value_ =
    Ir.attribute "header-position" (Val.toString value_)


{-| The appearance variant of the tabs. (default: `"secondary"`)
-}
variant : Value Variant -> Attr { c | variant : Supported } msg
variant value_ =
    Ir.attribute "variant" (Val.toString value_)


{-| See `M3e.Attributes.disablePagination`.
-}
disablePagination : String -> Attr { c | disablePagination : Supported } msg
disablePagination =
    A.disablePagination


{-| See `M3e.Attributes.nextPageLabel`.
-}
nextPageLabel : String -> Attr { c | nextPageLabel : Supported } msg
nextPageLabel =
    A.nextPageLabel


{-| See `M3e.Attributes.previousPageLabel`.
-}
previousPageLabel : String -> Attr { c | previousPageLabel : Supported } msg
previousPageLabel =
    A.previousPageLabel


{-| See `M3e.Attributes.stretch`.
-}
stretch : Bool -> Attr { c | stretch : Supported } msg
stretch =
    A.stretch


{-| See `M3e.Events.onChange`.
-}
onChange : msg -> Attr { c | onChange : Supported } msg
onChange =
    Ev.onChange


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


{-| Place an element into the named `next-icon` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
nextIcon : Element NextIconSlot admittedBy msg -> Element free freeAdmittedBy msg
nextIcon element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "next-icon") (El.toNode element))


{-| Place an element into the named `panel` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
panel : Element PanelSlot admittedBy msg -> Element free freeAdmittedBy msg
panel element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "panel") (El.toNode element))


{-| Place an element into the named `prev-icon` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
prevIcon : Element PrevIconSlot admittedBy msg -> Element free freeAdmittedBy msg
prevIcon element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "prev-icon") (El.toNode element))


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
    , disablePagination : Available
    , headerPosition : Available
    , id : Available
    , nextPageLabel : Available
    , onBeforeinput : Available
    , onChange : Available
    , onInput : Available
    , previousPageLabel : Available
    , slot : Available
    , stretch : Available
    , style : Available
    , variant : Available
    }


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    { nextIcon : Available
    , prevIcon : Available
    }


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg
build =
    B.init "m3e-tabs" [] []


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


{-| Pipe form of `disablePagination` — consumes its capability (write-once).
-}
withDisablePagination : String -> Builder { a | disablePagination : Available } slotCaps msg -> Builder { a | disablePagination : Used } slotCaps msg
withDisablePagination value_ =
    B.withAttribute (A.disablePagination value_)


{-| Pipe form of `headerPosition` — consumes its capability (write-once).
-}
withHeaderPosition : Value HeaderPosition -> Builder { a | headerPosition : Available } slotCaps msg -> Builder { a | headerPosition : Used } slotCaps msg
withHeaderPosition value_ =
    B.withAttribute (headerPosition value_)


{-| Pipe form of `nextPageLabel` — consumes its capability (write-once).
-}
withNextPageLabel : String -> Builder { a | nextPageLabel : Available } slotCaps msg -> Builder { a | nextPageLabel : Used } slotCaps msg
withNextPageLabel value_ =
    B.withAttribute (A.nextPageLabel value_)


{-| Pipe form of `previousPageLabel` — consumes its capability (write-once).
-}
withPreviousPageLabel : String -> Builder { a | previousPageLabel : Available } slotCaps msg -> Builder { a | previousPageLabel : Used } slotCaps msg
withPreviousPageLabel value_ =
    B.withAttribute (A.previousPageLabel value_)


{-| Pipe form of `stretch` — consumes its capability (write-once).
-}
withStretch : Bool -> Builder { a | stretch : Available } slotCaps msg -> Builder { a | stretch : Used } slotCaps msg
withStretch value_ =
    B.withAttribute (A.stretch value_)


{-| Pipe form of `variant` — consumes its capability (write-once).
-}
withVariant : Value Variant -> Builder { a | variant : Available } slotCaps msg -> Builder { a | variant : Used } slotCaps msg
withVariant value_ =
    B.withAttribute (variant value_)


{-| Pipe form of `onChange` — consumes its capability (write-once).
-}
withOnChange : msg -> Builder { a | onChange : Available } slotCaps msg -> Builder { a | onChange : Used } slotCaps msg
withOnChange value_ =
    B.withAttribute (Ev.onChange value_)


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


{-| Pipe form of the `next-icon` slot — consumes its capability (write-once).
-}
withNextIcon : Element NextIconSlot admittedBy msg -> Builder attrCaps { s | nextIcon : Available } msg -> Builder attrCaps { s | nextIcon : Used } msg
withNextIcon element =
    B.withChild (El.toNode (nextIcon element))


{-| Pipe form of the `prev-icon` slot — consumes its capability (write-once).
-}
withPrevIcon : Element PrevIconSlot admittedBy msg -> Builder attrCaps { s | prevIcon : Available } msg -> Builder attrCaps { s | prevIcon : Used } msg
withPrevIcon element =
    B.withChild (El.toNode (prevIcon element))


{-| Pipe form of a default-slot child (repeatable).
-}
withChild : Element Content (ChildAdmittedBy childAdm) msg -> Builder attrCaps slotCaps msg -> Builder attrCaps slotCaps msg
withChild element =
    B.withChild (El.toNode element)
