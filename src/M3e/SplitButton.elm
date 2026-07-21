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
import HtmlIr.Element exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import HtmlIr.Node exposing (Node)
import HtmlIr.Value exposing (Value)
import M3e.Attributes
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
view attrs children =
    Ir.fromNode (Ir.node "m3e-split-button" attrs (List.map HtmlIr.Element.toNode children))


{-| Required-content constructor — missing required content is unwritable.
-}
el :
    { leadingButton : Element LeadingButtonSlot (ChildAdmittedBy childAdm) msg
    , trailingButton : Element TrailingButtonSlot (ChildAdmittedBy childAdm) msg
    }
    -> List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el required_ attrs children =
    view attrs (Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "leading-button") (HtmlIr.Element.toNode required_.leadingButton)) :: Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "trailing-button") (HtmlIr.Element.toNode required_.trailingButton)) :: children)


{-| Narrowed value setter for `size`. Tokens come from `M3e.Values`.
-}
size : Value Size -> Attr { c | size : Supported } msg
size value_ =
    Ir.attribute "size" (HtmlIr.Value.toString value_)


{-| Narrowed value setter for `variant`. Tokens come from `M3e.Values`.
-}
variant : Value Variant -> Attr { c | variant : Supported } msg
variant value_ =
    Ir.attribute "variant" (HtmlIr.Value.toString value_)


{-| Place an element into the named `leading-button` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
leadingButton : Element LeadingButtonSlot admittedBy msg -> Element free freeAdmittedBy msg
leadingButton element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "leading-button") (HtmlIr.Element.toNode element))


{-| Place an element into the named `trailing-button` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
trailingButton : Element TrailingButtonSlot admittedBy msg -> Element free freeAdmittedBy msg
trailingButton element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "trailing-button") (HtmlIr.Element.toNode element))


{-| The pipe-builder: capabilities are consumed Available→Used, so writing
a singular attribute or slot twice is unwritable.
-}
type Builder attrCaps slotCaps msg
    = Builder { attrs : List (Attr Attrs msg), children : List (Node msg) }


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
    Builder { attrs = [], children = [ HtmlIr.Element.toNode (leadingButton required_.leadingButton), HtmlIr.Element.toNode (trailingButton required_.trailingButton) ] }


{-| Close the pipe-builder.
-}
toElement : Builder attrCaps slotCaps msg -> Element (Is s) admittedBy msg
toElement (Builder b) =
    Ir.fromNode (Ir.node "m3e-split-button" (List.reverse b.attrs) (List.reverse b.children))


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


{-| Pipe form of `size` — consumes its capability (write-once).
-}
withSize : Value Size -> Builder { a | size : Available } slotCaps msg -> Builder { a | size : Used } slotCaps msg
withSize value_ (Builder b) =
    Builder { b | attrs = size value_ :: b.attrs }


{-| Pipe form of `variant` — consumes its capability (write-once).
-}
withVariant : Value Variant -> Builder { a | variant : Available } slotCaps msg -> Builder { a | variant : Used } slotCaps msg
withVariant value_ (Builder b) =
    Builder { b | attrs = variant value_ :: b.attrs }


{-| Pipe form of the `leading-button` slot — consumes its capability (write-once).
-}
withLeadingButton : Element LeadingButtonSlot admittedBy msg -> Builder attrCaps { s | leadingButton : Available } msg -> Builder attrCaps { s | leadingButton : Used } msg
withLeadingButton element (Builder b) =
    Builder { b | children = HtmlIr.Element.toNode (leadingButton element) :: b.children }


{-| Pipe form of the `trailing-button` slot — consumes its capability (write-once).
-}
withTrailingButton : Element TrailingButtonSlot admittedBy msg -> Builder attrCaps { s | trailingButton : Available } msg -> Builder attrCaps { s | trailingButton : Used } msg
withTrailingButton element (Builder b) =
    Builder { b | children = HtmlIr.Element.toNode (trailingButton element) :: b.children }
