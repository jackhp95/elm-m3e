module M3e.Tabs exposing
    ( view, build, toElement
    , Is, Attrs, Content, NextIconSlot, PanelSlot, PrevIconSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , HeaderPosition, headerPosition, Variant, variant
    , disablePagination, nextPageLabel, previousPageLabel, stretch, onChange, onBeforeinput, onInput
    , nextIcon, panel, prevIcon
    , withAriaLabel, withChild, withClass, withDisablePagination, withHeaderPosition, withId, withNextIcon, withNextPageLabel, withOnBeforeinput, withOnChange, withOnInput, withPrevIcon, withPreviousPageLabel, withSlot, withStretch, withStyle, withVariant
    )

{-| The `m3e-tabs` component — strict per-component surface.

Organizes content into separate views where only one view can be visible at a time.

@docs view, build, toElement
@docs Is, Attrs, Content, NextIconSlot, PanelSlot, PrevIconSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs HeaderPosition, headerPosition, Variant, variant
@docs disablePagination, nextPageLabel, previousPageLabel, stretch, onChange, onBeforeinput, onInput
@docs nextIcon, panel, prevIcon
@docs withAriaLabel, withChild, withClass, withDisablePagination, withHeaderPosition, withId, withNextIcon, withNextPageLabel, withOnBeforeinput, withOnChange, withOnInput, withPrevIcon, withPreviousPageLabel, withSlot, withStretch, withStyle, withVariant

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Node exposing (Node)
import HtmlIr.Value exposing (Value)
import M3e.Attributes
import M3e.Events
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-tabs` produces (open — composes into any slot naming it).
-}
type alias Is s =
    { s | tabs : Brand }


{-| The closed attribute-capability row.
-}
type alias Attrs =
    { ariaLabel : Supported
    , class : Supported
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
view attrs children =
    Ir.fromNode (Ir.node "m3e-tabs" attrs (List.map HtmlIr.Element.toNode children))


{-| Narrowed value setter for `headerPosition`. Tokens come from `M3e.Values`.
-}
headerPosition : Value HeaderPosition -> Attr { c | headerPosition : Supported } msg
headerPosition value_ =
    Ir.attribute "header-position" (HtmlIr.Value.toString value_)


{-| Narrowed value setter for `variant`. Tokens come from `M3e.Values`.
-}
variant : Value Variant -> Attr { c | variant : Supported } msg
variant value_ =
    Ir.attribute "variant" (HtmlIr.Value.toString value_)


{-| See `M3e.Attributes.disablePagination`.
-}
disablePagination : String -> Attr { c | disablePagination : Supported } msg
disablePagination =
    M3e.Attributes.disablePagination


{-| See `M3e.Attributes.nextPageLabel`.
-}
nextPageLabel : String -> Attr { c | nextPageLabel : Supported } msg
nextPageLabel =
    M3e.Attributes.nextPageLabel


{-| See `M3e.Attributes.previousPageLabel`.
-}
previousPageLabel : String -> Attr { c | previousPageLabel : Supported } msg
previousPageLabel =
    M3e.Attributes.previousPageLabel


{-| See `M3e.Attributes.stretch`.
-}
stretch : Bool -> Attr { c | stretch : Supported } msg
stretch =
    M3e.Attributes.stretch


{-| See `M3e.Events.onChange`.
-}
onChange : msg -> Attr { c | onChange : Supported } msg
onChange =
    M3e.Events.onChange


{-| See `M3e.Events.onBeforeinput`.
-}
onBeforeinput : msg -> Attr { c | onBeforeinput : Supported } msg
onBeforeinput =
    M3e.Events.onBeforeinput


{-| See `M3e.Events.onInput`.
-}
onInput : msg -> Attr { c | onInput : Supported } msg
onInput =
    M3e.Events.onInput


{-| Place an element into the named `next-icon` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
nextIcon : Element NextIconSlot admittedBy msg -> Element free freeAdmittedBy msg
nextIcon element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "next-icon") (HtmlIr.Element.toNode element))


{-| Place an element into the named `panel` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
panel : Element PanelSlot admittedBy msg -> Element free freeAdmittedBy msg
panel element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "panel") (HtmlIr.Element.toNode element))


{-| Place an element into the named `prev-icon` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
prevIcon : Element PrevIconSlot admittedBy msg -> Element free freeAdmittedBy msg
prevIcon element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "prev-icon") (HtmlIr.Element.toNode element))


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
    Builder { attrs = [], children = [] }


{-| Close the pipe-builder.
-}
toElement : Builder attrCaps slotCaps msg -> Element (Is s) admittedBy msg
toElement (Builder b) =
    Ir.fromNode (Ir.node "m3e-tabs" (List.reverse b.attrs) (List.reverse b.children))


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


{-| Pipe form of `disablePagination` — consumes its capability (write-once).
-}
withDisablePagination : String -> Builder { a | disablePagination : Available } slotCaps msg -> Builder { a | disablePagination : Used } slotCaps msg
withDisablePagination value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.disablePagination value_ :: b.attrs }


{-| Pipe form of `headerPosition` — consumes its capability (write-once).
-}
withHeaderPosition : Value HeaderPosition -> Builder { a | headerPosition : Available } slotCaps msg -> Builder { a | headerPosition : Used } slotCaps msg
withHeaderPosition value_ (Builder b) =
    Builder { b | attrs = headerPosition value_ :: b.attrs }


{-| Pipe form of `nextPageLabel` — consumes its capability (write-once).
-}
withNextPageLabel : String -> Builder { a | nextPageLabel : Available } slotCaps msg -> Builder { a | nextPageLabel : Used } slotCaps msg
withNextPageLabel value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.nextPageLabel value_ :: b.attrs }


{-| Pipe form of `previousPageLabel` — consumes its capability (write-once).
-}
withPreviousPageLabel : String -> Builder { a | previousPageLabel : Available } slotCaps msg -> Builder { a | previousPageLabel : Used } slotCaps msg
withPreviousPageLabel value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.previousPageLabel value_ :: b.attrs }


{-| Pipe form of `stretch` — consumes its capability (write-once).
-}
withStretch : Bool -> Builder { a | stretch : Available } slotCaps msg -> Builder { a | stretch : Used } slotCaps msg
withStretch value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.stretch value_ :: b.attrs }


{-| Pipe form of `variant` — consumes its capability (write-once).
-}
withVariant : Value Variant -> Builder { a | variant : Available } slotCaps msg -> Builder { a | variant : Used } slotCaps msg
withVariant value_ (Builder b) =
    Builder { b | attrs = variant value_ :: b.attrs }


{-| Pipe form of `onChange` — consumes its capability (write-once).
-}
withOnChange : msg -> Builder { a | onChange : Available } slotCaps msg -> Builder { a | onChange : Used } slotCaps msg
withOnChange value_ (Builder b) =
    Builder { b | attrs = M3e.Events.onChange value_ :: b.attrs }


{-| Pipe form of `onBeforeinput` — consumes its capability (write-once).
-}
withOnBeforeinput : msg -> Builder { a | onBeforeinput : Available } slotCaps msg -> Builder { a | onBeforeinput : Used } slotCaps msg
withOnBeforeinput value_ (Builder b) =
    Builder { b | attrs = M3e.Events.onBeforeinput value_ :: b.attrs }


{-| Pipe form of `onInput` — consumes its capability (write-once).
-}
withOnInput : msg -> Builder { a | onInput : Available } slotCaps msg -> Builder { a | onInput : Used } slotCaps msg
withOnInput value_ (Builder b) =
    Builder { b | attrs = M3e.Events.onInput value_ :: b.attrs }


{-| Pipe form of the `next-icon` slot — consumes its capability (write-once).
-}
withNextIcon : Element NextIconSlot admittedBy msg -> Builder attrCaps { s | nextIcon : Available } msg -> Builder attrCaps { s | nextIcon : Used } msg
withNextIcon element (Builder b) =
    Builder { b | children = HtmlIr.Element.toNode (nextIcon element) :: b.children }


{-| Pipe form of the `prev-icon` slot — consumes its capability (write-once).
-}
withPrevIcon : Element PrevIconSlot admittedBy msg -> Builder attrCaps { s | prevIcon : Available } msg -> Builder attrCaps { s | prevIcon : Used } msg
withPrevIcon element (Builder b) =
    Builder { b | children = HtmlIr.Element.toNode (prevIcon element) :: b.children }


{-| Pipe form of a default-slot child (repeatable).
-}
withChild : Element Content (ChildAdmittedBy childAdm) msg -> Builder attrCaps slotCaps msg -> Builder attrCaps slotCaps msg
withChild element (Builder b) =
    Builder { b | children = HtmlIr.Element.toNode element :: b.children }
