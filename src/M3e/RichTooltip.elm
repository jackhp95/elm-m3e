module M3e.RichTooltip exposing
    ( view, el, build, toElement
    , Is, Attrs, Content, SubheadSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , Position, position, TouchGestures, touchGestures
    , disabled, for, hideDelay, showDelay, onBeforetoggle, onToggle
    , actions, subhead
    , withActions, withAriaLabel, withChild, withClass, withDisabled, withFor, withHideDelay, withId, withOnBeforetoggle, withOnToggle, withPosition, withShowDelay, withSlot, withStyle, withSubhead, withTouchGestures
    )

{-| The `m3e-rich-tooltip` component — strict per-component surface.

Provides contextual details for a control, such as explaining the value or purpose of a feature.

@docs view, el, build, toElement
@docs Is, Attrs, Content, SubheadSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs Position, position, TouchGestures, touchGestures
@docs disabled, for, hideDelay, showDelay, onBeforetoggle, onToggle
@docs actions, subhead
@docs withActions, withAriaLabel, withChild, withClass, withDisabled, withFor, withHideDelay, withId, withOnBeforetoggle, withOnToggle, withPosition, withShowDelay, withSlot, withStyle, withSubhead, withTouchGestures

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


{-| The kind row `m3e-rich-tooltip` produces (open — composes into any slot naming it).
-}
type alias Is s =
    { s | richTooltip : Brand }


{-| The closed attribute-capability row.
-}
type alias Attrs =
    { ariaLabel : Supported
    , class : Supported
    , disabled : Supported
    , for : Supported
    , hideDelay : Supported
    , id : Supported
    , onBeforetoggle : Supported
    , onToggle : Supported
    , position : Supported
    , showDelay : Supported
    , slot : Supported
    , style : Supported
    , touchGestures : Supported
    }


{-| The kinds the default slot admits.
-}
type alias Content =
    { sharedText : Shared }


{-| The kinds the `subhead` slot admits.
-}
type alias SubheadSlot =
    { sharedText : Shared }


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    { childAdm | richTooltip : Ctx }


{-| The `position` values valid on this component (compile-tight narrowing).
-}
type alias Position =
    { above : Supported
    , aboveAfter : Supported
    , aboveBefore : Supported
    , after : Supported
    , before : Supported
    , below : Supported
    , belowAfter : Supported
    , belowBefore : Supported
    }


{-| The `touchGestures` values valid on this component (compile-tight narrowing).
-}
type alias TouchGestures =
    { auto : Supported
    , off : Supported
    , on : Supported
    }


{-| Standard constructor: `[attributes] [children]`.
-}
view :
    List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
view attrs children =
    Ir.fromNode (Ir.node "m3e-rich-tooltip" attrs (List.map HtmlIr.Element.toNode children))


{-| Required-content (and action) constructor — omissions are unwritable.
-}
el :
    { content : Element Content (ChildAdmittedBy childAdm) msg }
    -> List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el required_ attrs children =
    view attrs (required_.content :: children)


{-| Narrowed value setter for `position`. Tokens come from `M3e.Values`.
-}
position : Value Position -> Attr { c | position : Supported } msg
position value_ =
    Ir.attribute "position" (HtmlIr.Value.toString value_)


{-| Narrowed value setter for `touchGestures`. Tokens come from `M3e.Values`.
-}
touchGestures : Value TouchGestures -> Attr { c | touchGestures : Supported } msg
touchGestures value_ =
    Ir.attribute "touch-gestures" (HtmlIr.Value.toString value_)


{-| See `M3e.Attributes.disabled`.
-}
disabled : Bool -> Attr { c | disabled : Supported } msg
disabled =
    M3e.Attributes.disabled


{-| See `M3e.Attributes.for`.
-}
for : String -> Attr { c | for : Supported } msg
for =
    M3e.Attributes.for


{-| See `M3e.Attributes.hideDelay`.
-}
hideDelay : Float -> Attr { c | hideDelay : Supported } msg
hideDelay =
    M3e.Attributes.hideDelay


{-| See `M3e.Attributes.showDelay`.
-}
showDelay : Float -> Attr { c | showDelay : Supported } msg
showDelay =
    M3e.Attributes.showDelay


{-| See `M3e.Events.onBeforetoggle`.
-}
onBeforetoggle : msg -> Attr { c | onBeforetoggle : Supported } msg
onBeforetoggle =
    M3e.Events.onBeforetoggle


{-| See `M3e.Events.onToggle`.
-}
onToggle : msg -> Attr { c | onToggle : Supported } msg
onToggle =
    M3e.Events.onToggle


{-| Place an element into the named `actions` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
actions : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
actions element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "actions") (HtmlIr.Element.toNode element))


{-| Place an element into the named `subhead` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
subhead : Element SubheadSlot admittedBy msg -> Element free freeAdmittedBy msg
subhead element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "subhead") (HtmlIr.Element.toNode element))


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
    , for : Available
    , hideDelay : Available
    , id : Available
    , onBeforetoggle : Available
    , onToggle : Available
    , position : Available
    , showDelay : Available
    , slot : Available
    , style : Available
    , touchGestures : Available
    }


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    { actions : Available
    , subhead : Available
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
    Ir.fromNode (Ir.node "m3e-rich-tooltip" (List.reverse b.attrs) (List.reverse b.children))


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


{-| Pipe form of `for` — consumes its capability (write-once).
-}
withFor : String -> Builder { a | for : Available } slotCaps msg -> Builder { a | for : Used } slotCaps msg
withFor value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.for value_ :: b.attrs }


{-| Pipe form of `hideDelay` — consumes its capability (write-once).
-}
withHideDelay : Float -> Builder { a | hideDelay : Available } slotCaps msg -> Builder { a | hideDelay : Used } slotCaps msg
withHideDelay value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.hideDelay value_ :: b.attrs }


{-| Pipe form of `position` — consumes its capability (write-once).
-}
withPosition : Value Position -> Builder { a | position : Available } slotCaps msg -> Builder { a | position : Used } slotCaps msg
withPosition value_ (Builder b) =
    Builder { b | attrs = position value_ :: b.attrs }


{-| Pipe form of `showDelay` — consumes its capability (write-once).
-}
withShowDelay : Float -> Builder { a | showDelay : Available } slotCaps msg -> Builder { a | showDelay : Used } slotCaps msg
withShowDelay value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.showDelay value_ :: b.attrs }


{-| Pipe form of `touchGestures` — consumes its capability (write-once).
-}
withTouchGestures : Value TouchGestures -> Builder { a | touchGestures : Available } slotCaps msg -> Builder { a | touchGestures : Used } slotCaps msg
withTouchGestures value_ (Builder b) =
    Builder { b | attrs = touchGestures value_ :: b.attrs }


{-| Pipe form of `onBeforetoggle` — consumes its capability (write-once).
-}
withOnBeforetoggle : msg -> Builder { a | onBeforetoggle : Available } slotCaps msg -> Builder { a | onBeforetoggle : Used } slotCaps msg
withOnBeforetoggle value_ (Builder b) =
    Builder { b | attrs = M3e.Events.onBeforetoggle value_ :: b.attrs }


{-| Pipe form of `onToggle` — consumes its capability (write-once).
-}
withOnToggle : msg -> Builder { a | onToggle : Available } slotCaps msg -> Builder { a | onToggle : Used } slotCaps msg
withOnToggle value_ (Builder b) =
    Builder { b | attrs = M3e.Events.onToggle value_ :: b.attrs }


{-| Pipe form of the `actions` slot — consumes its capability (write-once).
-}
withActions : Element childAccepts admittedBy msg -> Builder attrCaps { s | actions : Available } msg -> Builder attrCaps { s | actions : Used } msg
withActions element (Builder b) =
    Builder { b | children = HtmlIr.Element.toNode (actions element) :: b.children }


{-| Pipe form of the `subhead` slot — consumes its capability (write-once).
-}
withSubhead : Element SubheadSlot admittedBy msg -> Builder attrCaps { s | subhead : Available } msg -> Builder attrCaps { s | subhead : Used } msg
withSubhead element (Builder b) =
    Builder { b | children = HtmlIr.Element.toNode (subhead element) :: b.children }


{-| Pipe form of a default-slot child (repeatable).
-}
withChild : Element Content (ChildAdmittedBy childAdm) msg -> Builder attrCaps slotCaps msg -> Builder attrCaps slotCaps msg
withChild element (Builder b) =
    Builder { b | children = HtmlIr.Element.toNode element :: b.children }
