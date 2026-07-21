module M3e.Snackbar exposing
    ( view, el, build, toElement
    , Is, Attrs, Content, CloseIconSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , action, closeLabel, dismissible, duration, onBeforetoggle, onToggle
    , closeIcon
    , withAction, withAriaLabel, withChild, withClass, withCloseIcon, withCloseLabel, withDismissible, withDuration, withId, withOnBeforetoggle, withOnToggle, withSlot, withStyle
    )

{-| The `m3e-snackbar` component — strict per-component surface.

Presents short updates about application processes at the bottom of the screen.

@docs view, el, build, toElement
@docs Is, Attrs, Content, CloseIconSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs action, closeLabel, dismissible, duration, onBeforetoggle, onToggle
@docs closeIcon
@docs withAction, withAriaLabel, withChild, withClass, withCloseIcon, withCloseLabel, withDismissible, withDuration, withId, withOnBeforetoggle, withOnToggle, withSlot, withStyle

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Node exposing (Node)
import M3e.Attributes
import M3e.Events
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-snackbar` produces (open — composes into any slot naming it).
-}
type alias Is s =
    { s | snackbar : Brand }


{-| The closed attribute-capability row.
-}
type alias Attrs =
    { action : Supported
    , ariaLabel : Supported
    , class : Supported
    , closeLabel : Supported
    , dismissible : Supported
    , duration : Supported
    , id : Supported
    , onBeforetoggle : Supported
    , onToggle : Supported
    , slot : Supported
    , style : Supported
    }


{-| The kinds the default slot admits.
-}
type alias Content =
    { sharedText : Shared }


{-| The kinds the `close-icon` slot admits.
-}
type alias CloseIconSlot =
    { sharedIcon : Shared }


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    { childAdm | snackbar : Ctx }


{-| Standard constructor: `[attributes] [children]`.
-}
view :
    List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
view attrs children =
    Ir.fromNode (Ir.node "m3e-snackbar" attrs (List.map HtmlIr.Element.toNode children))


{-| Required-content (and action) constructor — omissions are unwritable.
-}
el :
    { content : Element Content (ChildAdmittedBy childAdm) msg }
    -> List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el required_ attrs children =
    view attrs (required_.content :: children)


{-| See `M3e.Attributes.action`.
-}
action : String -> Attr { c | action : Supported } msg
action =
    M3e.Attributes.action


{-| See `M3e.Attributes.closeLabel`.
-}
closeLabel : String -> Attr { c | closeLabel : Supported } msg
closeLabel =
    M3e.Attributes.closeLabel


{-| See `M3e.Attributes.dismissible`.
-}
dismissible : Bool -> Attr { c | dismissible : Supported } msg
dismissible =
    M3e.Attributes.dismissible


{-| See `M3e.Attributes.duration`.
-}
duration : Float -> Attr { c | duration : Supported } msg
duration =
    M3e.Attributes.duration


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


{-| Place an element into the named `close-icon` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
closeIcon : Element CloseIconSlot admittedBy msg -> Element free freeAdmittedBy msg
closeIcon element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "close-icon") (HtmlIr.Element.toNode element))


{-| The pipe-builder: capabilities are consumed Available→Used, so writing
a singular attribute or slot twice is unwritable.
-}
type Builder attrCaps slotCaps msg
    = Builder { attrs : List (Attr Attrs msg), children : List (Node msg) }


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    { action : Available
    , ariaLabel : Available
    , class : Available
    , closeLabel : Available
    , dismissible : Available
    , duration : Available
    , id : Available
    , onBeforetoggle : Available
    , onToggle : Available
    , slot : Available
    , style : Available
    }


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    { closeIcon : Available
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
    Ir.fromNode (Ir.node "m3e-snackbar" (List.reverse b.attrs) (List.reverse b.children))


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


{-| Pipe form of `action` — consumes its capability (write-once).
-}
withAction : String -> Builder { a | action : Available } slotCaps msg -> Builder { a | action : Used } slotCaps msg
withAction value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.action value_ :: b.attrs }


{-| Pipe form of `closeLabel` — consumes its capability (write-once).
-}
withCloseLabel : String -> Builder { a | closeLabel : Available } slotCaps msg -> Builder { a | closeLabel : Used } slotCaps msg
withCloseLabel value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.closeLabel value_ :: b.attrs }


{-| Pipe form of `dismissible` — consumes its capability (write-once).
-}
withDismissible : Bool -> Builder { a | dismissible : Available } slotCaps msg -> Builder { a | dismissible : Used } slotCaps msg
withDismissible value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.dismissible value_ :: b.attrs }


{-| Pipe form of `duration` — consumes its capability (write-once).
-}
withDuration : Float -> Builder { a | duration : Available } slotCaps msg -> Builder { a | duration : Used } slotCaps msg
withDuration value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.duration value_ :: b.attrs }


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


{-| Pipe form of the `close-icon` slot — consumes its capability (write-once).
-}
withCloseIcon : Element CloseIconSlot admittedBy msg -> Builder attrCaps { s | closeIcon : Available } msg -> Builder attrCaps { s | closeIcon : Used } msg
withCloseIcon element (Builder b) =
    Builder { b | children = HtmlIr.Element.toNode (closeIcon element) :: b.children }


{-| Pipe form of a default-slot child (repeatable).
-}
withChild : Element Content (ChildAdmittedBy childAdm) msg -> Builder attrCaps slotCaps msg -> Builder attrCaps slotCaps msg
withChild element (Builder b) =
    Builder { b | children = HtmlIr.Element.toNode element :: b.children }
