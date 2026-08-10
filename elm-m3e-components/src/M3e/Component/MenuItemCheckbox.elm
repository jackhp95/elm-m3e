module M3e.Component.MenuItemCheckbox exposing
    ( view, build, toElement
    , Is, Attrs, Content, IconSlot, TrailingIconSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , checked, disabled, defaultChecked, onClick
    , icon, trailingIcon, child
    , withChecked, withChild, withClass, withDisabled, withIcon, withId, withOnClick, withSlot, withStyle, withTrailingIcon
    )

{-| The `m3e-menu-item-checkbox` component — strict per-component surface.

An item of a menu which supports a checkable state.

@docs view, build, toElement
@docs Is, Attrs, Content, IconSlot, TrailingIconSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs checked, disabled, defaultChecked, onClick
@docs icon, trailingIcon, child
@docs withChecked, withChild, withClass, withDisabled, withIcon, withId, withOnClick, withSlot, withStyle, withTrailingIcon

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Shared, Supported)
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Events as Ev
import M3e.Html as H
import M3e.Internal.Types.MenuItemCheckbox
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-menu-item-checkbox` produces (open — composes into any slot naming it).
-}
type alias Is s =
    M3e.Internal.Types.MenuItemCheckbox.Is s


{-| The closed attribute-capability row.
-}
type alias Attrs =
    M3e.Internal.Types.MenuItemCheckbox.Attrs


{-| The kinds the default slot admits.
-}
type alias Content =
    M3e.Internal.Types.MenuItemCheckbox.Content


{-| The kinds the `icon` slot admits.
-}
type alias IconSlot =
    M3e.Internal.Types.MenuItemCheckbox.IconSlot


{-| The kinds the `trailing-icon` slot admits.
-}
type alias TrailingIconSlot =
    M3e.Internal.Types.MenuItemCheckbox.TrailingIconSlot


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    M3e.Internal.Types.MenuItemCheckbox.ChildAdmittedBy childAdm


{-| Standard constructor: `[attributes] [children]`.
-}
view :
    List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
view =
    H.menuItemCheckbox


{-| See `M3e.Attributes.checked`.
-}
checked : Bool -> Attr { c | checked : Supported } msg
checked =
    A.checked


{-| See `M3e.Attributes.disabled`.
-}
disabled : Bool -> Attr { c | disabled : Supported } msg
disabled =
    A.disabled


{-| See `M3e.Attributes.defaultChecked`.
-}
defaultChecked : Bool -> Attr { c | checked : Supported } msg
defaultChecked =
    A.defaultChecked


{-| See `M3e.Events.onClick`.
-}
onClick : msg -> Attr { c | onClick : Supported } msg
onClick =
    Ev.onClick


{-| Place an element into the named `icon` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
icon : Element IconSlot admittedBy msg -> Element free freeAdmittedBy msg
icon element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "icon") (El.toNode element))


{-| Place an element into the named `trailing-icon` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
trailingIcon : Element TrailingIconSlot admittedBy msg -> Element free freeAdmittedBy msg
trailingIcon element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "trailing-icon") (El.toNode element))


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
    M3e.Internal.Types.MenuItemCheckbox.Builder attrCaps slotCaps msg s


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    M3e.Internal.Types.MenuItemCheckbox.AttrCaps


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    M3e.Internal.Types.MenuItemCheckbox.SlotCaps


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg kind
build =
    B.init "m3e-menu-item-checkbox" [] []


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


{-| Pipe form of `checked` — consumes its capability (write-once).
-}
withChecked : Bool -> Builder { a | checked : Available } slotCaps msg kind -> Builder { a | checked : Used } slotCaps msg kind
withChecked value_ =
    B.withAttribute (A.checked value_)


{-| Pipe form of `disabled` — consumes its capability (write-once).
-}
withDisabled : Bool -> Builder { a | disabled : Available } slotCaps msg kind -> Builder { a | disabled : Used } slotCaps msg kind
withDisabled value_ =
    B.withAttribute (A.disabled value_)


{-| Pipe form of `onClick` — consumes its capability (write-once).
-}
withOnClick : msg -> Builder { a | onClick : Available } slotCaps msg kind -> Builder { a | onClick : Used } slotCaps msg kind
withOnClick value_ =
    B.withAttribute (Ev.onClick value_)


{-| Pipe form of the `icon` slot — consumes its capability (write-once).
-}
withIcon : Element IconSlot admittedBy msg -> Builder attrCaps { s | icon : Available } msg kind -> Builder attrCaps { s | icon : Used } msg kind
withIcon element =
    B.withChild (El.toNode (icon element))


{-| Pipe form of the `trailing-icon` slot — consumes its capability (write-once).
-}
withTrailingIcon : Element TrailingIconSlot admittedBy msg -> Builder attrCaps { s | trailingIcon : Available } msg kind -> Builder attrCaps { s | trailingIcon : Used } msg kind
withTrailingIcon element =
    B.withChild (El.toNode (trailingIcon element))


{-| Pipe form of a default-slot child (repeatable).
-}
withChild : Element Content (ChildAdmittedBy childAdm) msg -> Builder attrCaps slotCaps msg kind -> Builder attrCaps slotCaps msg kind
withChild element =
    B.withChild (El.toNode element)
