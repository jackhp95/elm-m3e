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
import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Value as Val exposing (Value)
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Events as Ev
import M3e.Html as H
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
view =
    H.inputChip


{-| Required-content (and action) constructor — omissions are unwritable.
-}
el :
    { content : Element Content (ChildAdmittedBy childAdm) msg }
    -> List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el required_ attrs children =
    view attrs (required_.content :: children)


{-| The appearance variant of the chip. (default: `"outlined"`)
-}
variant : Value Variant -> Attr { c | variant : Supported } msg
variant value_ =
    Ir.attribute "variant" (Val.toString value_)


{-| See `M3e.Attributes.disabled`.
-}
disabled : Bool -> Attr { c | disabled : Supported } msg
disabled =
    A.disabled


{-| See `M3e.Attributes.disabledInteractive`.
-}
disabledInteractive : Bool -> Attr { c | disabledInteractive : Supported } msg
disabledInteractive =
    A.disabledInteractive


{-| See `M3e.Attributes.removable`.
-}
removable : Bool -> Attr { c | removable : Supported } msg
removable =
    A.removable


{-| See `M3e.Attributes.removeLabel`.
-}
removeLabel : String -> Attr { c | removeLabel : Supported } msg
removeLabel =
    A.removeLabel


{-| See `M3e.Attributes.value`.
-}
value : String -> Attr { c | value : Supported } msg
value =
    A.value


{-| See `M3e.Events.onRemove`.
-}
onRemove : msg -> Attr { c | onRemove : Supported } msg
onRemove =
    Ev.onRemove


{-| See `M3e.Events.onClick`.
-}
onClick : msg -> Attr { c | onClick : Supported } msg
onClick =
    Ev.onClick


{-| Place an element into the named `avatar` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
avatar : Element AvatarSlot admittedBy msg -> Element free freeAdmittedBy msg
avatar element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "avatar") (El.toNode element))


{-| Place an element into the named `icon` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
icon : Element IconSlot admittedBy msg -> Element free freeAdmittedBy msg
icon element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "icon") (El.toNode element))


{-| Place an element into the named `remove-icon` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
removeIcon : Element RemoveIconSlot admittedBy msg -> Element free freeAdmittedBy msg
removeIcon element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "remove-icon") (El.toNode element))


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
    B.init "m3e-input-chip" [] [ El.toNode required_.content ]


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


{-| Pipe form of `disabledInteractive` — consumes its capability (write-once).
-}
withDisabledInteractive : Bool -> Builder { a | disabledInteractive : Available } slotCaps msg -> Builder { a | disabledInteractive : Used } slotCaps msg
withDisabledInteractive value_ =
    B.withAttribute (A.disabledInteractive value_)


{-| Pipe form of `removable` — consumes its capability (write-once).
-}
withRemovable : Bool -> Builder { a | removable : Available } slotCaps msg -> Builder { a | removable : Used } slotCaps msg
withRemovable value_ =
    B.withAttribute (A.removable value_)


{-| Pipe form of `removeLabel` — consumes its capability (write-once).
-}
withRemoveLabel : String -> Builder { a | removeLabel : Available } slotCaps msg -> Builder { a | removeLabel : Used } slotCaps msg
withRemoveLabel value_ =
    B.withAttribute (A.removeLabel value_)


{-| Pipe form of `value` — consumes its capability (write-once).
-}
withValue : String -> Builder { a | value : Available } slotCaps msg -> Builder { a | value : Used } slotCaps msg
withValue value_ =
    B.withAttribute (A.value value_)


{-| Pipe form of `variant` — consumes its capability (write-once).
-}
withVariant : Value Variant -> Builder { a | variant : Available } slotCaps msg -> Builder { a | variant : Used } slotCaps msg
withVariant value_ =
    B.withAttribute (variant value_)


{-| Pipe form of `onRemove` — consumes its capability (write-once).
-}
withOnRemove : msg -> Builder { a | onRemove : Available } slotCaps msg -> Builder { a | onRemove : Used } slotCaps msg
withOnRemove value_ =
    B.withAttribute (Ev.onRemove value_)


{-| Pipe form of `onClick` — consumes its capability (write-once).
-}
withOnClick : msg -> Builder { a | onClick : Available } slotCaps msg -> Builder { a | onClick : Used } slotCaps msg
withOnClick value_ =
    B.withAttribute (Ev.onClick value_)


{-| Pipe form of the `avatar` slot — consumes its capability (write-once).
-}
withAvatar : Element AvatarSlot admittedBy msg -> Builder attrCaps { s | avatar : Available } msg -> Builder attrCaps { s | avatar : Used } msg
withAvatar element =
    B.withChild (El.toNode (avatar element))


{-| Pipe form of the `icon` slot — consumes its capability (write-once).
-}
withIcon : Element IconSlot admittedBy msg -> Builder attrCaps { s | icon : Available } msg -> Builder attrCaps { s | icon : Used } msg
withIcon element =
    B.withChild (El.toNode (icon element))


{-| Pipe form of the `remove-icon` slot — consumes its capability (write-once).
-}
withRemoveIcon : Element RemoveIconSlot admittedBy msg -> Builder attrCaps { s | removeIcon : Available } msg -> Builder attrCaps { s | removeIcon : Used } msg
withRemoveIcon element =
    B.withChild (El.toNode (removeIcon element))


{-| Pipe form of a default-slot child (repeatable).
-}
withChild : Element Content (ChildAdmittedBy childAdm) msg -> Builder attrCaps slotCaps msg -> Builder attrCaps slotCaps msg
withChild element =
    B.withChild (El.toNode element)
