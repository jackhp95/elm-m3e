module M3e.Menu exposing
    ( view, build, toElement
    , Is, Attrs, Content, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , PositionX, positionX, PositionY, positionY, Variant, variant
    , submenu, onBeforetoggle, onToggle
    , withAriaLabel, withChild, withClass, withId, withOnBeforetoggle, withOnToggle, withPositionX, withPositionY, withSlot, withStyle, withSubmenu, withVariant
    )

{-| The `m3e-menu` component — strict per-component surface.

Presents a list of choices on a temporary surface.

@docs view, build, toElement
@docs Is, Attrs, Content, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs PositionX, positionX, PositionY, positionY, Variant, variant
@docs submenu, onBeforetoggle, onToggle
@docs withAriaLabel, withChild, withClass, withId, withOnBeforetoggle, withOnToggle, withPositionX, withPositionY, withSlot, withStyle, withSubmenu, withVariant

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import HtmlIr.Node exposing (Node)
import HtmlIr.Value exposing (Value)
import Json.Decode
import M3e.Attributes
import M3e.Events
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-menu` produces (open — composes into any slot naming it).
-}
type alias Is s =
    { s | menu : Brand }


{-| The closed attribute-capability row.
-}
type alias Attrs =
    { ariaLabel : Supported
    , class : Supported
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
view attrs children =
    Ir.fromNode (Ir.node "m3e-menu" attrs (List.map HtmlIr.Element.toNode children))


{-| Narrowed value setter for `positionX`. Tokens come from `M3e.Values`.
-}
positionX : Value PositionX -> Attr { c | positionX : Supported } msg
positionX value_ =
    Ir.attribute "position-x" (HtmlIr.Value.toString value_)


{-| Narrowed value setter for `positionY`. Tokens come from `M3e.Values`.
-}
positionY : Value PositionY -> Attr { c | positionY : Supported } msg
positionY value_ =
    Ir.attribute "position-y" (HtmlIr.Value.toString value_)


{-| Narrowed value setter for `variant`. Tokens come from `M3e.Values`.
-}
variant : Value Variant -> Attr { c | variant : Supported } msg
variant value_ =
    Ir.attribute "variant" (HtmlIr.Value.toString value_)


{-| See `M3e.Attributes.submenu`.
-}
submenu : Bool -> Attr { c | submenu : Supported } msg
submenu =
    M3e.Attributes.submenu


{-| See `M3e.Events.onBeforetoggle`.
-}
onBeforetoggle : msg -> Attr { c | onBeforetoggle : Supported } msg
onBeforetoggle =
    M3e.Events.onBeforetoggle


{-| Typed `toggle` event: decodes `newState` as String.
-}
onToggle : (String -> msg) -> Attr { c | onToggle : Supported } msg
onToggle toMsg =
    Ir.on "toggle" (Json.Decode.map toMsg (Json.Decode.at [ "newState" ] Json.Decode.string))


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
    Builder { attrs = [], children = [] }


{-| Close the pipe-builder.
-}
toElement : Builder attrCaps slotCaps msg -> Element (Is s) admittedBy msg
toElement (Builder b) =
    Ir.fromNode (Ir.node "m3e-menu" (List.reverse b.attrs) (List.reverse b.children))


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


{-| Pipe form of `positionX` — consumes its capability (write-once).
-}
withPositionX : Value PositionX -> Builder { a | positionX : Available } slotCaps msg -> Builder { a | positionX : Used } slotCaps msg
withPositionX value_ (Builder b) =
    Builder { b | attrs = positionX value_ :: b.attrs }


{-| Pipe form of `positionY` — consumes its capability (write-once).
-}
withPositionY : Value PositionY -> Builder { a | positionY : Available } slotCaps msg -> Builder { a | positionY : Used } slotCaps msg
withPositionY value_ (Builder b) =
    Builder { b | attrs = positionY value_ :: b.attrs }


{-| Pipe form of `submenu` — consumes its capability (write-once).
-}
withSubmenu : Bool -> Builder { a | submenu : Available } slotCaps msg -> Builder { a | submenu : Used } slotCaps msg
withSubmenu value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.submenu value_ :: b.attrs }


{-| Pipe form of `variant` — consumes its capability (write-once).
-}
withVariant : Value Variant -> Builder { a | variant : Available } slotCaps msg -> Builder { a | variant : Used } slotCaps msg
withVariant value_ (Builder b) =
    Builder { b | attrs = variant value_ :: b.attrs }


{-| Pipe form of `onBeforetoggle` — consumes its capability (write-once).
-}
withOnBeforetoggle : msg -> Builder { a | onBeforetoggle : Available } slotCaps msg -> Builder { a | onBeforetoggle : Used } slotCaps msg
withOnBeforetoggle value_ (Builder b) =
    Builder { b | attrs = M3e.Events.onBeforetoggle value_ :: b.attrs }


{-| Pipe form of `onToggle` — consumes its capability (write-once).
-}
withOnToggle : (String -> msg) -> Builder { a | onToggle : Available } slotCaps msg -> Builder { a | onToggle : Used } slotCaps msg
withOnToggle value_ (Builder b) =
    Builder { b | attrs = onToggle value_ :: b.attrs }


{-| Pipe form of a default-slot child (repeatable).
-}
withChild : Element Content (ChildAdmittedBy childAdm) msg -> Builder attrCaps slotCaps msg -> Builder attrCaps slotCaps msg
withChild element (Builder b) =
    Builder { b | children = HtmlIr.Element.toNode element :: b.children }
