module M3e.Menu exposing
    ( view, build, toElement
    , Is, Attrs, Content, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , PositionX, positionX, PositionY, positionY, Variant, variant
    , submenu, onBeforetoggle, onToggle
    , child
    , withChild, withClass, withId, withOnBeforetoggle, withOnToggle, withPositionX, withPositionY, withSlot, withStyle, withSubmenu, withVariant
    )

{-| The `m3e-menu` component — strict per-component surface.

Presents a list of choices on a temporary surface.

@docs view, build, toElement
@docs Is, Attrs, Content, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs PositionX, positionX, PositionY, positionY, Variant, variant
@docs submenu, onBeforetoggle, onToggle
@docs child
@docs withChild, withClass, withId, withOnBeforetoggle, withOnToggle, withPositionX, withPositionY, withSlot, withStyle, withSubmenu, withVariant

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import HtmlIr.Value as Val exposing (Value)
import Json.Decode
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Events as Ev
import M3e.Html as H
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-menu` produces (open — composes into any slot naming it).
-}
type alias Is s =
    { s | menu : Brand }


{-| The closed attribute-capability row.
-}
type alias Attrs =
    { class : Supported
    , id : Supported
    , onBeforetoggle : Supported
    , onToggle : Supported
    , positionX : Supported
    , positionY : Supported
    , slot : Supported
    , style : Supported
    , submenu : Supported
    , variant : Supported
    }


{-| The kinds the default slot admits.
-}
type alias Content =
    { divider : Brand
    , menuItem : Brand
    , menuItemCheckbox : Brand
    , menuItemGroup : Brand
    , menuItemRadio : Brand
    }


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    { childAdm | menu : Ctx }


{-| The `positionX` values valid on this component (compile-tight narrowing).
-}
type alias PositionX =
    { after : Supported
    , before : Supported
    }


{-| The `positionY` values valid on this component (compile-tight narrowing).
-}
type alias PositionY =
    { above : Supported
    , below : Supported
    }


{-| The `variant` values valid on this component (compile-tight narrowing).
-}
type alias Variant =
    { standard : Supported
    , vibrant : Supported
    }


{-| Standard constructor: `[attributes] [children]`.
-}
view :
    List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
view =
    H.menu


{-| The position of the menu, on the x-axis. (default: `"after"`)
-}
positionX : Value PositionX -> Attr { c | positionX : Supported } msg
positionX value_ =
    Ir.attribute "position-x" (Val.toString value_)


{-| The position of the menu, on the y-axis. (default: `"below"`)
-}
positionY : Value PositionY -> Attr { c | positionY : Supported } msg
positionY value_ =
    Ir.attribute "position-y" (Val.toString value_)


{-| The appearance variant of the menu. (default: `"standard"`)
-}
variant : Value Variant -> Attr { c | variant : Supported } msg
variant value_ =
    Ir.attribute "variant" (Val.toString value_)


{-| See `M3e.Attributes.submenu`.
-}
submenu : Bool -> Attr { c | submenu : Supported } msg
submenu =
    A.submenu


{-| See `M3e.Events.onBeforetoggle`.
-}
onBeforetoggle : msg -> Attr { c | onBeforetoggle : Supported } msg
onBeforetoggle =
    Ev.onBeforetoggle


{-| Typed `toggle` event: decodes `newState` as String.
-}
onToggle : (String -> msg) -> Attr { c | onToggle : Supported } msg
onToggle toMsg =
    Ir.on "toggle" (Json.Decode.map toMsg (Json.Decode.at [ "newState" ] Json.Decode.string))


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
    , id : Available
    , onBeforetoggle : Available
    , onToggle : Available
    , positionX : Available
    , positionY : Available
    , slot : Available
    , style : Available
    , submenu : Available
    , variant : Available
    }


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    {}


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg
build =
    B.init "m3e-menu" [] []


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


{-| Pipe form of `positionX` — consumes its capability (write-once).
-}
withPositionX : Value PositionX -> Builder { a | positionX : Available } slotCaps msg -> Builder { a | positionX : Used } slotCaps msg
withPositionX value_ =
    B.withAttribute (positionX value_)


{-| Pipe form of `positionY` — consumes its capability (write-once).
-}
withPositionY : Value PositionY -> Builder { a | positionY : Available } slotCaps msg -> Builder { a | positionY : Used } slotCaps msg
withPositionY value_ =
    B.withAttribute (positionY value_)


{-| Pipe form of `submenu` — consumes its capability (write-once).
-}
withSubmenu : Bool -> Builder { a | submenu : Available } slotCaps msg -> Builder { a | submenu : Used } slotCaps msg
withSubmenu value_ =
    B.withAttribute (A.submenu value_)


{-| Pipe form of `variant` — consumes its capability (write-once).
-}
withVariant : Value Variant -> Builder { a | variant : Available } slotCaps msg -> Builder { a | variant : Used } slotCaps msg
withVariant value_ =
    B.withAttribute (variant value_)


{-| Pipe form of `onBeforetoggle` — consumes its capability (write-once).
-}
withOnBeforetoggle : msg -> Builder { a | onBeforetoggle : Available } slotCaps msg -> Builder { a | onBeforetoggle : Used } slotCaps msg
withOnBeforetoggle value_ =
    B.withAttribute (Ev.onBeforetoggle value_)


{-| Pipe form of `onToggle` — consumes its capability (write-once).
-}
withOnToggle : (String -> msg) -> Builder { a | onToggle : Available } slotCaps msg -> Builder { a | onToggle : Used } slotCaps msg
withOnToggle value_ =
    B.withAttribute (onToggle value_)


{-| Pipe form of a default-slot child (repeatable).
-}
withChild : Element Content (ChildAdmittedBy childAdm) msg -> Builder attrCaps slotCaps msg -> Builder attrCaps slotCaps msg
withChild element =
    B.withChild (El.toNode element)
