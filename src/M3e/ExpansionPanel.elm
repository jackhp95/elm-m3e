module M3e.ExpansionPanel exposing
    ( view, el, build, toElement
    , Is, Attrs, ToggleIconSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , ToggleDirection, toggleDirection, TogglePosition, togglePosition
    , disabled, hideToggle, open, onOpening, onOpened, onClosing, onClosed
    , actions, header, toggleIcon
    , withChild, withClass, withDisabled, withHeader, withHideToggle, withId, withOnClosed, withOnClosing, withOnOpened, withOnOpening, withOpen, withSlot, withStyle, withToggleDirection, withToggleIcon, withTogglePosition
    )

{-| The `m3e-expansion-panel` component — strict per-component surface.

An expandable details-summary view.

@docs view, el, build, toElement
@docs Is, Attrs, ToggleIconSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs ToggleDirection, toggleDirection, TogglePosition, togglePosition
@docs disabled, hideToggle, open, onOpening, onOpened, onClosing, onClosed
@docs actions, header, toggleIcon
@docs withChild, withClass, withDisabled, withHeader, withHideToggle, withId, withOnClosed, withOnClosing, withOnOpened, withOnOpening, withOpen, withSlot, withStyle, withToggleDirection, withToggleIcon, withTogglePosition

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


{-| The kind row `m3e-expansion-panel` produces (open — composes into any slot naming it).
-}
type alias Is s =
    { s | expansionPanel : Brand }


{-| The closed attribute-capability row.
-}
type alias Attrs =
    { class : Supported
    , disabled : Supported
    , hideToggle : Supported
    , id : Supported
    , onClosed : Supported
    , onClosing : Supported
    , onOpened : Supported
    , onOpening : Supported
    , open : Supported
    , slot : Supported
    , style : Supported
    , toggleDirection : Supported
    , togglePosition : Supported
    }


{-| The kinds the `toggle-icon` slot admits.
-}
type alias ToggleIconSlot =
    { sharedIcon : Shared }


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    { childAdm | expansionPanel : Ctx }


{-| The `toggleDirection` values valid on this component (compile-tight narrowing).
-}
type alias ToggleDirection =
    { horizontal : Supported
    , vertical : Supported
    }


{-| The `togglePosition` values valid on this component (compile-tight narrowing).
-}
type alias TogglePosition =
    { after : Supported
    , before : Supported
    }


{-| Standard constructor: `[attributes] [children]`. The default slot is
kind-permissive (`any`): children of any kind compose, but each child's OWN
admittedBy must still admit this context — a restricted-parent element is
rejected here at compile time.
-}
view :
    List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
view attrs children =
    Ir.fromNode (Ir.node "m3e-expansion-panel" attrs (List.map HtmlIr.Element.toNode children))


{-| Required-content (and action) constructor — omissions are unwritable.
-}
el :
    { header : Element childAccepts (ChildAdmittedBy childAdm) msg }
    -> List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el required_ attrs children =
    view attrs (Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "header") (HtmlIr.Element.toNode required_.header)) :: children)


{-| Narrowed value setter for `toggleDirection`. Tokens come from `M3e.Values`.
-}
toggleDirection : Value ToggleDirection -> Attr { c | toggleDirection : Supported } msg
toggleDirection value_ =
    Ir.attribute "toggle-direction" (HtmlIr.Value.toString value_)


{-| Narrowed value setter for `togglePosition`. Tokens come from `M3e.Values`.
-}
togglePosition : Value TogglePosition -> Attr { c | togglePosition : Supported } msg
togglePosition value_ =
    Ir.attribute "toggle-position" (HtmlIr.Value.toString value_)


{-| See `M3e.Attributes.disabled`.
-}
disabled : Bool -> Attr { c | disabled : Supported } msg
disabled =
    M3e.Attributes.disabled


{-| See `M3e.Attributes.hideToggle`.
-}
hideToggle : Bool -> Attr { c | hideToggle : Supported } msg
hideToggle =
    M3e.Attributes.hideToggle


{-| See `M3e.Attributes.open`.
-}
open : Bool -> Attr { c | open : Supported } msg
open =
    M3e.Attributes.open


{-| See `M3e.Events.onOpening`.
-}
onOpening : msg -> Attr { c | onOpening : Supported } msg
onOpening =
    M3e.Events.onOpening


{-| See `M3e.Events.onOpened`.
-}
onOpened : msg -> Attr { c | onOpened : Supported } msg
onOpened =
    M3e.Events.onOpened


{-| See `M3e.Events.onClosing`.
-}
onClosing : msg -> Attr { c | onClosing : Supported } msg
onClosing =
    M3e.Events.onClosing


{-| See `M3e.Events.onClosed`.
-}
onClosed : msg -> Attr { c | onClosed : Supported } msg
onClosed =
    M3e.Events.onClosed


{-| Place an element into the named `actions` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
actions : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
actions element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "actions") (HtmlIr.Element.toNode element))


{-| Place an element into the named `header` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
header : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
header element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "header") (HtmlIr.Element.toNode element))


{-| Place an element into the named `toggle-icon` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
toggleIcon : Element ToggleIconSlot admittedBy msg -> Element free freeAdmittedBy msg
toggleIcon element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "toggle-icon") (HtmlIr.Element.toNode element))


{-| The pipe-builder: capabilities are consumed Available→Used, so writing
a singular attribute or slot twice is unwritable.
-}
type Builder attrCaps slotCaps msg
    = Builder { attrs : List (Attr Attrs msg), children : List (Node msg) }


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    { class : Available
    , disabled : Available
    , hideToggle : Available
    , id : Available
    , onClosed : Available
    , onClosing : Available
    , onOpened : Available
    , onOpening : Available
    , open : Available
    , slot : Available
    , style : Available
    , toggleDirection : Available
    , togglePosition : Available
    }


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    { header : Available
    , toggleIcon : Available
    }


{-| Seed the pipe-builder.
-}
build :
    { header : Element childAccepts (ChildAdmittedBy childAdm) msg }
    -> Builder AttrCaps SlotCaps msg
build required_ =
    Builder { attrs = [], children = [ HtmlIr.Element.toNode (header required_.header) ] }


{-| Close the pipe-builder.
-}
toElement : Builder attrCaps slotCaps msg -> Element (Is s) admittedBy msg
toElement (Builder b) =
    Ir.fromNode (Ir.node "m3e-expansion-panel" (List.reverse b.attrs) (List.reverse b.children))


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


{-| Pipe form of `hideToggle` — consumes its capability (write-once).
-}
withHideToggle : Bool -> Builder { a | hideToggle : Available } slotCaps msg -> Builder { a | hideToggle : Used } slotCaps msg
withHideToggle value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.hideToggle value_ :: b.attrs }


{-| Pipe form of `open` — consumes its capability (write-once).
-}
withOpen : Bool -> Builder { a | open : Available } slotCaps msg -> Builder { a | open : Used } slotCaps msg
withOpen value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.open value_ :: b.attrs }


{-| Pipe form of `toggleDirection` — consumes its capability (write-once).
-}
withToggleDirection : Value ToggleDirection -> Builder { a | toggleDirection : Available } slotCaps msg -> Builder { a | toggleDirection : Used } slotCaps msg
withToggleDirection value_ (Builder b) =
    Builder { b | attrs = toggleDirection value_ :: b.attrs }


{-| Pipe form of `togglePosition` — consumes its capability (write-once).
-}
withTogglePosition : Value TogglePosition -> Builder { a | togglePosition : Available } slotCaps msg -> Builder { a | togglePosition : Used } slotCaps msg
withTogglePosition value_ (Builder b) =
    Builder { b | attrs = togglePosition value_ :: b.attrs }


{-| Pipe form of `onOpening` — consumes its capability (write-once).
-}
withOnOpening : msg -> Builder { a | onOpening : Available } slotCaps msg -> Builder { a | onOpening : Used } slotCaps msg
withOnOpening value_ (Builder b) =
    Builder { b | attrs = M3e.Events.onOpening value_ :: b.attrs }


{-| Pipe form of `onOpened` — consumes its capability (write-once).
-}
withOnOpened : msg -> Builder { a | onOpened : Available } slotCaps msg -> Builder { a | onOpened : Used } slotCaps msg
withOnOpened value_ (Builder b) =
    Builder { b | attrs = M3e.Events.onOpened value_ :: b.attrs }


{-| Pipe form of `onClosing` — consumes its capability (write-once).
-}
withOnClosing : msg -> Builder { a | onClosing : Available } slotCaps msg -> Builder { a | onClosing : Used } slotCaps msg
withOnClosing value_ (Builder b) =
    Builder { b | attrs = M3e.Events.onClosing value_ :: b.attrs }


{-| Pipe form of `onClosed` — consumes its capability (write-once).
-}
withOnClosed : msg -> Builder { a | onClosed : Available } slotCaps msg -> Builder { a | onClosed : Used } slotCaps msg
withOnClosed value_ (Builder b) =
    Builder { b | attrs = M3e.Events.onClosed value_ :: b.attrs }


{-| Pipe form of the `header` slot — consumes its capability (write-once).
-}
withHeader : Element childAccepts admittedBy msg -> Builder attrCaps { s | header : Available } msg -> Builder attrCaps { s | header : Used } msg
withHeader element (Builder b) =
    Builder { b | children = HtmlIr.Element.toNode (header element) :: b.children }


{-| Pipe form of the `toggle-icon` slot — consumes its capability (write-once).
-}
withToggleIcon : Element ToggleIconSlot admittedBy msg -> Builder attrCaps { s | toggleIcon : Available } msg -> Builder attrCaps { s | toggleIcon : Used } msg
withToggleIcon element (Builder b) =
    Builder { b | children = HtmlIr.Element.toNode (toggleIcon element) :: b.children }


{-| Pipe form of a default-slot child (repeatable).
-}
withChild : Element childAccepts (ChildAdmittedBy childAdm) msg -> Builder attrCaps slotCaps msg -> Builder attrCaps slotCaps msg
withChild element (Builder b) =
    Builder { b | children = HtmlIr.Element.toNode element :: b.children }
