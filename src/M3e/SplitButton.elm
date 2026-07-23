module M3e.SplitButton exposing
    ( view, el, build, toElement
    , Is, Attrs, LeadingButtonSlot, TrailingButtonSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , Size, size, Variant, variant
    , leadingButton, trailingButton
    , withClass, withId, withLeadingButton, withSize, withSlot, withStyle, withTrailingButton, withVariant
    )

{-| The `m3e-split-button` component — strict per-component surface.

A button used to show an action with a menu of related actions.

@docs view, el, build, toElement
@docs Is, Attrs, LeadingButtonSlot, TrailingButtonSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs Size, size, Variant, variant
@docs leadingButton, trailingButton
@docs withClass, withId, withLeadingButton, withSize, withSlot, withStyle, withTrailingButton, withVariant

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import HtmlIr.Value as Val exposing (Value)
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Html as H
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-split-button` produces (open — composes into any slot naming it).
-}
type alias Is s =
    { s | splitButton : Brand }


{-| The closed attribute-capability row.
-}
type alias Attrs =
    { class : Supported
    , id : Supported
    , size : Supported
    , slot : Supported
    , style : Supported
    , variant : Supported
    }


{-| The kinds the `leading-button` slot admits.
-}
type alias LeadingButtonSlot =
    { button : Brand }


{-| The kinds the `trailing-button` slot admits.
-}
type alias TrailingButtonSlot =
    { iconButton : Brand }


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    { childAdm | splitButton : Ctx }


{-| The `size` values valid on this component (compile-tight narrowing).
-}
type alias Size =
    { extraLarge : Supported
    , extraSmall : Supported
    , large : Supported
    , medium : Supported
    , small : Supported
    }


{-| The `variant` values valid on this component (compile-tight narrowing).
-}
type alias Variant =
    { elevated : Supported
    , filled : Supported
    , outlined : Supported
    , tonal : Supported
    }


{-| Standard constructor: `[attributes] [children]`.
-}
view :
    List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
view =
    H.splitButton


{-| Required-content (and action) constructor — omissions are unwritable.
-}
el :
    { leadingButton : Element LeadingButtonSlot (ChildAdmittedBy childAdm) msg
    , trailingButton : Element TrailingButtonSlot (ChildAdmittedBy childAdm) msg
    }
    -> List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el required_ attrs children =
    view attrs (Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "leading-button") (El.toNode required_.leadingButton)) :: Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "trailing-button") (El.toNode required_.trailingButton)) :: children)


{-| The size of the button. (default: `"small"`)
-}
size : Value Size -> Attr { c | size : Supported } msg
size value_ =
    Ir.attribute "size" (Val.toString value_)


{-| The appearance variant of the button. (default: `"filled"`)
-}
variant : Value Variant -> Attr { c | variant : Supported } msg
variant value_ =
    Ir.attribute "variant" (Val.toString value_)


{-| Place an element into the named `leading-button` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
leadingButton : Element LeadingButtonSlot admittedBy msg -> Element free freeAdmittedBy msg
leadingButton element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "leading-button") (El.toNode element))


{-| Place an element into the named `trailing-button` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
trailingButton : Element TrailingButtonSlot admittedBy msg -> Element free freeAdmittedBy msg
trailingButton element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "trailing-button") (El.toNode element))


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
    , size : Available
    , slot : Available
    , style : Available
    , variant : Available
    }


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    { leadingButton : Available
    , trailingButton : Available
    }


{-| Seed the pipe-builder.
-}
build :
    { leadingButton : Element LeadingButtonSlot (ChildAdmittedBy childAdm) msg
    , trailingButton : Element TrailingButtonSlot (ChildAdmittedBy childAdm) msg
    }
    -> Builder AttrCaps SlotCaps msg
build required_ =
    B.init "m3e-split-button" [] [ El.toNode (leadingButton required_.leadingButton), El.toNode (trailingButton required_.trailingButton) ]


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


{-| Pipe form of `size` — consumes its capability (write-once).
-}
withSize : Value Size -> Builder { a | size : Available } slotCaps msg -> Builder { a | size : Used } slotCaps msg
withSize value_ =
    B.withAttribute (size value_)


{-| Pipe form of `variant` — consumes its capability (write-once).
-}
withVariant : Value Variant -> Builder { a | variant : Available } slotCaps msg -> Builder { a | variant : Used } slotCaps msg
withVariant value_ =
    B.withAttribute (variant value_)


{-| Pipe form of the `leading-button` slot — consumes its capability (write-once).
-}
withLeadingButton : Element LeadingButtonSlot admittedBy msg -> Builder attrCaps { s | leadingButton : Available } msg -> Builder attrCaps { s | leadingButton : Used } msg
withLeadingButton element =
    B.withChild (El.toNode (leadingButton element))


{-| Pipe form of the `trailing-button` slot — consumes its capability (write-once).
-}
withTrailingButton : Element TrailingButtonSlot admittedBy msg -> Builder attrCaps { s | trailingButton : Available } msg -> Builder attrCaps { s | trailingButton : Used } msg
withTrailingButton element =
    B.withChild (El.toNode (trailingButton element))
