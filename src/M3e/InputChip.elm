module M3e.InputChip exposing
    ( view, el, build, toElement
    , Is, Attrs, Content, AvatarSlot, IconSlot, RemoveIconSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , Variant, variant
    , disabled, disabledInteractive, removable, removeLabel, value, onRemove, onClick
    , avatar, icon, removeIcon
    , withAvatar, withChild, withClass, withDisabled, withDisabledInteractive, withIcon, withId, withOnClick, withOnRemove, withRemovable, withRemoveIcon, withRemoveLabel, withSlot, withStyle, withValue, withVariant
    )

{-| The `m3e-input-chip` component — strict per-component surface.

A chip which represents a discrete piece of information entered by a user.

@docs view, el, build, toElement
@docs Is, Attrs, Content, AvatarSlot, IconSlot, RemoveIconSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs Variant, variant
@docs disabled, disabledInteractive, removable, removeLabel, value, onRemove, onClick
@docs avatar, icon, removeIcon
@docs withAvatar, withChild, withClass, withDisabled, withDisabledInteractive, withIcon, withId, withOnClick, withOnRemove, withRemovable, withRemoveIcon, withRemoveLabel, withSlot, withStyle, withValue, withVariant

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


{-| The kind row `m3e-input-chip` produces (open — composes into any slot naming it).
-}
type alias Is s =
    { s | inputChip : Brand }


{-| The closed attribute-capability row.
-}
type alias Attrs =
    { class : Supported
    , disabled : Supported
    , disabledInteractive : Supported
    , id : Supported
    , onClick : Supported
    , onRemove : Supported
    , removable : Supported
    , removeLabel : Supported
    , slot : Supported
    , style : Supported
    , value : Supported
    , variant : Supported
    }


{-| The kinds the default slot admits.
-}
type alias Content =
    { sharedText : Shared }


{-| The kinds the `avatar` slot admits.
-}
type alias AvatarSlot =
    { avatar : Brand }


{-| The kinds the `icon` slot admits.
-}
type alias IconSlot =
    { sharedIcon : Shared }


{-| The kinds the `remove-icon` slot admits.
-}
type alias RemoveIconSlot =
    { sharedIcon : Shared }


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    { childAdm | inputChip : Ctx }


{-| The `variant` values valid on this component (compile-tight narrowing).
-}
type alias Variant =
    { elevated : Supported
    , outlined : Supported
    }


{-| Standard constructor: `[attributes] [children]`.
-}
view :
    List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
view attrs children =
    Ir.fromNode (Ir.node "m3e-input-chip" attrs (List.map HtmlIr.Element.toNode children))


{-| Required-content constructor — missing required content is unwritable.
-}
el :
    { content : Element Content (ChildAdmittedBy childAdm) msg }
    -> List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el required_ attrs children =
    view attrs (required_.content :: children)


{-| Narrowed value setter for `variant`. Tokens come from `M3e.Values`.
-}
variant : Value Variant -> Attr { c | variant : Supported } msg
variant value_ =
    Ir.attribute "variant" (HtmlIr.Value.toString value_)


{-| See `M3e.Attributes.disabled`.
-}
disabled : Bool -> Attr { c | disabled : Supported } msg
disabled =
    M3e.Attributes.disabled


{-| See `M3e.Attributes.disabledInteractive`.
-}
disabledInteractive : Bool -> Attr { c | disabledInteractive : Supported } msg
disabledInteractive =
    M3e.Attributes.disabledInteractive


{-| See `M3e.Attributes.removable`.
-}
removable : Bool -> Attr { c | removable : Supported } msg
removable =
    M3e.Attributes.removable


{-| See `M3e.Attributes.removeLabel`.
-}
removeLabel : String -> Attr { c | removeLabel : Supported } msg
removeLabel =
    M3e.Attributes.removeLabel


{-| See `M3e.Attributes.value`.
-}
value : String -> Attr { c | value : Supported } msg
value =
    M3e.Attributes.value


{-| See `M3e.Events.onRemove`.
-}
onRemove : msg -> Attr { c | onRemove : Supported } msg
onRemove =
    M3e.Events.onRemove


{-| See `M3e.Events.onClick`.
-}
onClick : msg -> Attr { c | onClick : Supported } msg
onClick =
    M3e.Events.onClick


{-| Place an element into the named `avatar` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
avatar : Element AvatarSlot admittedBy msg -> Element free freeAdmittedBy msg
avatar element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "avatar") (HtmlIr.Element.toNode element))


{-| Place an element into the named `icon` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
icon : Element IconSlot admittedBy msg -> Element free freeAdmittedBy msg
icon element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "icon") (HtmlIr.Element.toNode element))


{-| Place an element into the named `remove-icon` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
removeIcon : Element RemoveIconSlot admittedBy msg -> Element free freeAdmittedBy msg
removeIcon element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "remove-icon") (HtmlIr.Element.toNode element))


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
    , disabledInteractive : Available
    , id : Available
    , onClick : Available
    , onRemove : Available
    , removable : Available
    , removeLabel : Available
    , slot : Available
    , style : Available
    , value : Available
    , variant : Available
    }


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    { avatar : Available
    , icon : Available
    , removeIcon : Available
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
    Ir.fromNode (Ir.node "m3e-input-chip" (List.reverse b.attrs) (List.reverse b.children))


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


{-| Pipe form of `disabledInteractive` — consumes its capability (write-once).
-}
withDisabledInteractive : Bool -> Builder { a | disabledInteractive : Available } slotCaps msg -> Builder { a | disabledInteractive : Used } slotCaps msg
withDisabledInteractive value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.disabledInteractive value_ :: b.attrs }


{-| Pipe form of `removable` — consumes its capability (write-once).
-}
withRemovable : Bool -> Builder { a | removable : Available } slotCaps msg -> Builder { a | removable : Used } slotCaps msg
withRemovable value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.removable value_ :: b.attrs }


{-| Pipe form of `removeLabel` — consumes its capability (write-once).
-}
withRemoveLabel : String -> Builder { a | removeLabel : Available } slotCaps msg -> Builder { a | removeLabel : Used } slotCaps msg
withRemoveLabel value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.removeLabel value_ :: b.attrs }


{-| Pipe form of `value` — consumes its capability (write-once).
-}
withValue : String -> Builder { a | value : Available } slotCaps msg -> Builder { a | value : Used } slotCaps msg
withValue value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.value value_ :: b.attrs }


{-| Pipe form of `variant` — consumes its capability (write-once).
-}
withVariant : Value Variant -> Builder { a | variant : Available } slotCaps msg -> Builder { a | variant : Used } slotCaps msg
withVariant value_ (Builder b) =
    Builder { b | attrs = variant value_ :: b.attrs }


{-| Pipe form of `onRemove` — consumes its capability (write-once).
-}
withOnRemove : msg -> Builder { a | onRemove : Available } slotCaps msg -> Builder { a | onRemove : Used } slotCaps msg
withOnRemove value_ (Builder b) =
    Builder { b | attrs = M3e.Events.onRemove value_ :: b.attrs }


{-| Pipe form of `onClick` — consumes its capability (write-once).
-}
withOnClick : msg -> Builder { a | onClick : Available } slotCaps msg -> Builder { a | onClick : Used } slotCaps msg
withOnClick value_ (Builder b) =
    Builder { b | attrs = M3e.Events.onClick value_ :: b.attrs }


{-| Pipe form of the `avatar` slot — consumes its capability (write-once).
-}
withAvatar : Element AvatarSlot admittedBy msg -> Builder attrCaps { s | avatar : Available } msg -> Builder attrCaps { s | avatar : Used } msg
withAvatar element (Builder b) =
    Builder { b | children = HtmlIr.Element.toNode (avatar element) :: b.children }


{-| Pipe form of the `icon` slot — consumes its capability (write-once).
-}
withIcon : Element IconSlot admittedBy msg -> Builder attrCaps { s | icon : Available } msg -> Builder attrCaps { s | icon : Used } msg
withIcon element (Builder b) =
    Builder { b | children = HtmlIr.Element.toNode (icon element) :: b.children }


{-| Pipe form of the `remove-icon` slot — consumes its capability (write-once).
-}
withRemoveIcon : Element RemoveIconSlot admittedBy msg -> Builder attrCaps { s | removeIcon : Available } msg -> Builder attrCaps { s | removeIcon : Used } msg
withRemoveIcon element (Builder b) =
    Builder { b | children = HtmlIr.Element.toNode (removeIcon element) :: b.children }


{-| Pipe form of a default-slot child (repeatable).
-}
withChild : Element Content (ChildAdmittedBy childAdm) msg -> Builder attrCaps slotCaps msg -> Builder attrCaps slotCaps msg
withChild element (Builder b) =
    Builder { b | children = HtmlIr.Element.toNode element :: b.children }
