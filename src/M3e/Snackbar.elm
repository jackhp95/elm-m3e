module M3e.Snackbar exposing
    ( view, el, build, toElement
    , Is, Attrs, Content, CloseIconSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , action, closeLabel, dismissible, duration, onBeforetoggle, onToggle
    , closeIcon, child
    , withAction, withChild, withClass, withCloseIcon, withCloseLabel, withDismissible, withDuration, withId, withOnBeforetoggle, withOnToggle, withSlot, withStyle
    )

{-| The `m3e-snackbar` component — strict per-component surface.

Presents short updates about application processes at the bottom of the screen.

@docs view, el, build, toElement
@docs Is, Attrs, Content, CloseIconSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs action, closeLabel, dismissible, duration, onBeforetoggle, onToggle
@docs closeIcon, child
@docs withAction, withChild, withClass, withCloseIcon, withCloseLabel, withDismissible, withDuration, withId, withOnBeforetoggle, withOnToggle, withSlot, withStyle

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


{-| The kind row `m3e-snackbar` produces (open — composes into any slot naming it).
-}
type alias Is s =
    { s | snackbar : Brand }


{-| The closed attribute-capability row.
-}
type alias Attrs =
    { action : Supported
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
view =
    H.snackbar


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
    A.action


{-| See `M3e.Attributes.closeLabel`.
-}
closeLabel : String -> Attr { c | closeLabel : Supported } msg
closeLabel =
    A.closeLabel


{-| See `M3e.Attributes.dismissible`.
-}
dismissible : Bool -> Attr { c | dismissible : Supported } msg
dismissible =
    A.dismissible


{-| See `M3e.Attributes.duration`.
-}
duration : Float -> Attr { c | duration : Supported } msg
duration =
    A.duration


{-| See `M3e.Events.onBeforetoggle`.
-}
onBeforetoggle : msg -> Attr { c | onBeforetoggle : Supported } msg
onBeforetoggle =
    Ev.onBeforetoggle


{-| See `M3e.Events.onToggle`.
-}
onToggle : msg -> Attr { c | onToggle : Supported } msg
onToggle =
    Ev.onToggle


{-| Place an element into the named `close-icon` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
closeIcon : Element CloseIconSlot admittedBy msg -> Element free freeAdmittedBy msg
closeIcon element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "close-icon") (El.toNode element))


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
    { action : Available
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
    B.init "m3e-snackbar" [] [ El.toNode required_.content ]


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


{-| Pipe form of `action` — consumes its capability (write-once).
-}
withAction : String -> Builder { a | action : Available } slotCaps msg -> Builder { a | action : Used } slotCaps msg
withAction value_ =
    B.withAttribute (A.action value_)


{-| Pipe form of `closeLabel` — consumes its capability (write-once).
-}
withCloseLabel : String -> Builder { a | closeLabel : Available } slotCaps msg -> Builder { a | closeLabel : Used } slotCaps msg
withCloseLabel value_ =
    B.withAttribute (A.closeLabel value_)


{-| Pipe form of `dismissible` — consumes its capability (write-once).
-}
withDismissible : Bool -> Builder { a | dismissible : Available } slotCaps msg -> Builder { a | dismissible : Used } slotCaps msg
withDismissible value_ =
    B.withAttribute (A.dismissible value_)


{-| Pipe form of `duration` — consumes its capability (write-once).
-}
withDuration : Float -> Builder { a | duration : Available } slotCaps msg -> Builder { a | duration : Used } slotCaps msg
withDuration value_ =
    B.withAttribute (A.duration value_)


{-| Pipe form of `onBeforetoggle` — consumes its capability (write-once).
-}
withOnBeforetoggle : msg -> Builder { a | onBeforetoggle : Available } slotCaps msg -> Builder { a | onBeforetoggle : Used } slotCaps msg
withOnBeforetoggle value_ =
    B.withAttribute (Ev.onBeforetoggle value_)


{-| Pipe form of `onToggle` — consumes its capability (write-once).
-}
withOnToggle : msg -> Builder { a | onToggle : Available } slotCaps msg -> Builder { a | onToggle : Used } slotCaps msg
withOnToggle value_ =
    B.withAttribute (Ev.onToggle value_)


{-| Pipe form of the `close-icon` slot — consumes its capability (write-once).
-}
withCloseIcon : Element CloseIconSlot admittedBy msg -> Builder attrCaps { s | closeIcon : Available } msg -> Builder attrCaps { s | closeIcon : Used } msg
withCloseIcon element =
    B.withChild (El.toNode (closeIcon element))


{-| Pipe form of a default-slot child (repeatable).
-}
withChild : Element Content (ChildAdmittedBy childAdm) msg -> Builder attrCaps slotCaps msg -> Builder attrCaps slotCaps msg
withChild element =
    B.withChild (El.toNode element)
