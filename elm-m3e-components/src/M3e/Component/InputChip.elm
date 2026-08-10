module M3e.Component.InputChip exposing
    ( view, el, build, toElement
    , Is, Attrs, Content, AvatarSlot, IconSlot, RemoveIconSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , Variant, variant
    , disabled, disabledInteractive, removable, removeLabel, value, defaultValue, onRemove, onClick
    , avatar, icon, removeIcon, child
    , withAvatar, withChild, withClass, withDisabled, withDisabledInteractive, withIcon, withId, withOnClick, withOnRemove, withRemovable, withRemoveIcon, withRemoveLabel, withSlot, withStyle, withValue, withVariant
    )

{-| The `m3e-input-chip` component — strict per-component surface.

A chip which represents a discrete piece of information entered by a user.

@docs view, el, build, toElement
@docs Is, Attrs, Content, AvatarSlot, IconSlot, RemoveIconSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs Variant, variant
@docs disabled, disabledInteractive, removable, removeLabel, value, defaultValue, onRemove, onClick
@docs avatar, icon, removeIcon, child
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
import M3e.Internal.Types.InputChip
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-input-chip` produces (open — composes into any slot naming it).
-}
type alias Is s =
    M3e.Internal.Types.InputChip.Is s


{-| The closed attribute-capability row.
-}
type alias Attrs =
    M3e.Internal.Types.InputChip.Attrs


{-| The kinds the default slot admits.
-}
type alias Content =
    M3e.Internal.Types.InputChip.Content


{-| The kinds the `avatar` slot admits.
-}
type alias AvatarSlot =
    M3e.Internal.Types.InputChip.AvatarSlot


{-| The kinds the `icon` slot admits.
-}
type alias IconSlot =
    M3e.Internal.Types.InputChip.IconSlot


{-| The kinds the `remove-icon` slot admits.
-}
type alias RemoveIconSlot =
    M3e.Internal.Types.InputChip.RemoveIconSlot


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    M3e.Internal.Types.InputChip.ChildAdmittedBy childAdm


{-| The `variant` values valid on this component (compile-tight narrowing).
-}
type alias Variant =
    M3e.Internal.Types.InputChip.Variant


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


{-| See `M3e.Attributes.defaultValue`.
-}
defaultValue : String -> Attr { c | value : Supported } msg
defaultValue =
    A.defaultValue


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


{-| Place a pre-built element into the default (unnamed) slot (input
constrained to the slot's kinds; output row free so it composes into the
child list). The list-form sibling of the builder's `withChild`.
-}
child : Element Content admittedBy msg -> Element free freeAdmittedBy msg
child element =
    Ir.fromNode (El.toNode element)


{-| The pipe-builder: capabilities are consumed Available→Used, so writing
a singular attribute or slot twice is unwritable. Aliases the shared builder in
`Build.Internal`, closed over this component's `Attrs` row and `Is s` kind.
-}
type alias Builder attrCaps slotCaps msg s =
    M3e.Internal.Types.InputChip.Builder attrCaps slotCaps msg s


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    M3e.Internal.Types.InputChip.AttrCaps


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    M3e.Internal.Types.InputChip.SlotCaps


{-| Seed the pipe-builder.
-}
build :
    { content : Element Content (ChildAdmittedBy childAdm) msg }
    -> Builder AttrCaps SlotCaps msg kind
build required_ =
    B.init "m3e-input-chip" ([]) [ El.toNode required_.content ]


{-| Close the pipe-builder (`toElement` is defined once in `Build.Internal`).
-}
toElement : Builder attrCaps slotCaps msg kind -> Element (Is kind) admittedBy msg
toElement =
    B.toElement


{-| Pipe form of `class` — consumes its capability (write-once).
-}
withClass : String -> Builder { a | class : Available } slotCaps msg kind -> Builder { a | class : Used } slotCaps msg kind
withClass value_ =
    B.withAttribute (A.class value_)


{-| Pipe form of `id` — consumes its capability (write-once).
-}
withId : String -> Builder { a | id : Available } slotCaps msg kind -> Builder { a | id : Used } slotCaps msg kind
withId value_ =
    B.withAttribute (A.id value_)


{-| Pipe form of `slot` — consumes its capability (write-once).
-}
withSlot : String -> Builder { a | slot : Available } slotCaps msg kind -> Builder { a | slot : Used } slotCaps msg kind
withSlot value_ =
    B.withAttribute (A.slot value_)


{-| Pipe form of `style` — consumes its capability (write-once).
-}
withStyle : String -> String -> Builder { a | style : Available } slotCaps msg kind -> Builder { a | style : Used } slotCaps msg kind
withStyle property value_ =
    B.withAttribute (A.style property value_)


{-| Pipe form of `disabled` — consumes its capability (write-once).
-}
withDisabled : Bool -> Builder { a | disabled : Available } slotCaps msg kind -> Builder { a | disabled : Used } slotCaps msg kind
withDisabled value_ =
    B.withAttribute (A.disabled value_)


{-| Pipe form of `disabledInteractive` — consumes its capability (write-once).
-}
withDisabledInteractive : Bool -> Builder { a | disabledInteractive : Available } slotCaps msg kind -> Builder { a | disabledInteractive : Used } slotCaps msg kind
withDisabledInteractive value_ =
    B.withAttribute (A.disabledInteractive value_)


{-| Pipe form of `removable` — consumes its capability (write-once).
-}
withRemovable : Bool -> Builder { a | removable : Available } slotCaps msg kind -> Builder { a | removable : Used } slotCaps msg kind
withRemovable value_ =
    B.withAttribute (A.removable value_)


{-| Pipe form of `removeLabel` — consumes its capability (write-once).
-}
withRemoveLabel : String -> Builder { a | removeLabel : Available } slotCaps msg kind -> Builder { a | removeLabel : Used } slotCaps msg kind
withRemoveLabel value_ =
    B.withAttribute (A.removeLabel value_)


{-| Pipe form of `value` — consumes its capability (write-once).
-}
withValue : String -> Builder { a | value : Available } slotCaps msg kind -> Builder { a | value : Used } slotCaps msg kind
withValue value_ =
    B.withAttribute (A.value value_)


{-| Pipe form of `variant` — consumes its capability (write-once).
-}
withVariant : Value Variant -> Builder { a | variant : Available } slotCaps msg kind -> Builder { a | variant : Used } slotCaps msg kind
withVariant value_ =
    B.withAttribute (variant value_)


{-| Pipe form of `onRemove` — consumes its capability (write-once).
-}
withOnRemove : msg -> Builder { a | onRemove : Available } slotCaps msg kind -> Builder { a | onRemove : Used } slotCaps msg kind
withOnRemove value_ =
    B.withAttribute (Ev.onRemove value_)


{-| Pipe form of `onClick` — consumes its capability (write-once).
-}
withOnClick : msg -> Builder { a | onClick : Available } slotCaps msg kind -> Builder { a | onClick : Used } slotCaps msg kind
withOnClick value_ =
    B.withAttribute (Ev.onClick value_)


{-| Pipe form of the `avatar` slot — consumes its capability (write-once).
-}
withAvatar : Element AvatarSlot admittedBy msg -> Builder attrCaps { s | avatar : Available } msg kind -> Builder attrCaps { s | avatar : Used } msg kind
withAvatar element =
    B.withChild (El.toNode (avatar element))


{-| Pipe form of the `icon` slot — consumes its capability (write-once).
-}
withIcon : Element IconSlot admittedBy msg -> Builder attrCaps { s | icon : Available } msg kind -> Builder attrCaps { s | icon : Used } msg kind
withIcon element =
    B.withChild (El.toNode (icon element))


{-| Pipe form of the `remove-icon` slot — consumes its capability (write-once).
-}
withRemoveIcon : Element RemoveIconSlot admittedBy msg -> Builder attrCaps { s | removeIcon : Available } msg kind -> Builder attrCaps { s | removeIcon : Used } msg kind
withRemoveIcon element =
    B.withChild (El.toNode (removeIcon element))


{-| Pipe form of a default-slot child (repeatable).
-}
withChild : Element Content (ChildAdmittedBy childAdm) msg -> Builder attrCaps slotCaps msg kind -> Builder attrCaps slotCaps msg kind
withChild element =
    B.withChild (El.toNode element)
