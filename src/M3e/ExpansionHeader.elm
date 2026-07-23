module M3e.ExpansionHeader exposing
    ( view, build, toElement
    , Is, Attrs, Content, ToggleIconSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , ToggleDirection, toggleDirection, TogglePosition, togglePosition
    , disabled, hideToggle, onClick
    , toggleIcon, child
    , withChild, withClass, withDisabled, withHideToggle, withId, withOnClick, withSlot, withStyle, withToggleDirection, withToggleIcon, withTogglePosition
    )

{-| The `m3e-expansion-header` component — strict per-component surface.

A button used to toggle the expanded state of an expansion panel.

@docs view, build, toElement
@docs Is, Attrs, Content, ToggleIconSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs ToggleDirection, toggleDirection, TogglePosition, togglePosition
@docs disabled, hideToggle, onClick
@docs toggleIcon, child
@docs withChild, withClass, withDisabled, withHideToggle, withId, withOnClick, withSlot, withStyle, withToggleDirection, withToggleIcon, withTogglePosition

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


{-| The kind row `m3e-expansion-header` produces (open — composes into any slot naming it).
-}
type alias Is s =
    { s | expansionHeader : Brand }


{-| The closed attribute-capability row.
-}
type alias Attrs =
    { class : Supported
    , disabled : Supported
    , hideToggle : Supported
    , id : Supported
    , onClick : Supported
    , slot : Supported
    , style : Supported
    , toggleDirection : Supported
    , togglePosition : Supported
    }


{-| The kinds the default slot admits.
-}
type alias Content =
    { sharedText : Shared }


{-| The kinds the `toggle-icon` slot admits.
-}
type alias ToggleIconSlot =
    { sharedIcon : Shared }


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    { childAdm | expansionHeader : Ctx }


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


{-| Standard constructor: `[attributes] [children]`.
-}
view :
    List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
view =
    H.expansionHeader


{-| The direction of the expansion toggle. (default: `"vertical"`)
-}
toggleDirection : Value ToggleDirection -> Attr { c | toggleDirection : Supported } msg
toggleDirection value_ =
    Ir.attribute "toggle-direction" (Val.toString value_)


{-| The position of the expansion toggle. (default: `"after"`)
-}
togglePosition : Value TogglePosition -> Attr { c | togglePosition : Supported } msg
togglePosition value_ =
    Ir.attribute "toggle-position" (Val.toString value_)


{-| See `M3e.Attributes.disabled`.
-}
disabled : Bool -> Attr { c | disabled : Supported } msg
disabled =
    A.disabled


{-| See `M3e.Attributes.hideToggle`.
-}
hideToggle : Bool -> Attr { c | hideToggle : Supported } msg
hideToggle =
    A.hideToggle


{-| See `M3e.Events.onClick`.
-}
onClick : msg -> Attr { c | onClick : Supported } msg
onClick =
    Ev.onClick


{-| Place an element into the named `toggle-icon` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
toggleIcon : Element ToggleIconSlot admittedBy msg -> Element free freeAdmittedBy msg
toggleIcon element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "toggle-icon") (El.toNode element))


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
    , disabled : Available
    , hideToggle : Available
    , id : Available
    , onClick : Available
    , slot : Available
    , style : Available
    , toggleDirection : Available
    , togglePosition : Available
    }


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    { toggleIcon : Available
    }


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg
build =
    B.init "m3e-expansion-header" [] []


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


{-| Pipe form of `hideToggle` — consumes its capability (write-once).
-}
withHideToggle : Bool -> Builder { a | hideToggle : Available } slotCaps msg -> Builder { a | hideToggle : Used } slotCaps msg
withHideToggle value_ =
    B.withAttribute (A.hideToggle value_)


{-| Pipe form of `toggleDirection` — consumes its capability (write-once).
-}
withToggleDirection : Value ToggleDirection -> Builder { a | toggleDirection : Available } slotCaps msg -> Builder { a | toggleDirection : Used } slotCaps msg
withToggleDirection value_ =
    B.withAttribute (toggleDirection value_)


{-| Pipe form of `togglePosition` — consumes its capability (write-once).
-}
withTogglePosition : Value TogglePosition -> Builder { a | togglePosition : Available } slotCaps msg -> Builder { a | togglePosition : Used } slotCaps msg
withTogglePosition value_ =
    B.withAttribute (togglePosition value_)


{-| Pipe form of `onClick` — consumes its capability (write-once).
-}
withOnClick : msg -> Builder { a | onClick : Available } slotCaps msg -> Builder { a | onClick : Used } slotCaps msg
withOnClick value_ =
    B.withAttribute (Ev.onClick value_)


{-| Pipe form of the `toggle-icon` slot — consumes its capability (write-once).
-}
withToggleIcon : Element ToggleIconSlot admittedBy msg -> Builder attrCaps { s | toggleIcon : Available } msg -> Builder attrCaps { s | toggleIcon : Used } msg
withToggleIcon element =
    B.withChild (El.toNode (toggleIcon element))


{-| Pipe form of a default-slot child (repeatable).
-}
withChild : Element Content (ChildAdmittedBy childAdm) msg -> Builder attrCaps slotCaps msg -> Builder attrCaps slotCaps msg
withChild element =
    B.withChild (El.toNode element)
