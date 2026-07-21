module M3e.FormField exposing
    ( view, build, toElement
    , Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , FloatLabel, floatLabel, HideSubscript, hideSubscript, Variant, variant
    , hideRequiredMarker
    , error, hint, label, prefix, prefixText, suffix, suffixText
    , withChild, withClass, withError, withFloatLabel, withHideRequiredMarker, withHideSubscript, withHint, withId, withLabel, withPrefix, withPrefixText, withSlot, withStyle, withSuffix, withSuffixText, withVariant
    )

{-| The `m3e-form-field` component — strict per-component surface.

A container for form controls that applies Material Design styling and behavior.

@docs view, build, toElement
@docs Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs FloatLabel, floatLabel, HideSubscript, hideSubscript, Variant, variant
@docs hideRequiredMarker
@docs error, hint, label, prefix, prefixText, suffix, suffixText
@docs withChild, withClass, withError, withFloatLabel, withHideRequiredMarker, withHideSubscript, withHint, withId, withLabel, withPrefix, withPrefixText, withSlot, withStyle, withSuffix, withSuffixText, withVariant

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import HtmlIr.Node exposing (Node)
import HtmlIr.Value exposing (Value)
import M3e.Attributes
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-form-field` produces (open — composes into any slot naming it).
-}
type alias Is s =
    { s | formField : Brand }


{-| The closed attribute-capability row.
-}
type alias Attrs =
    { class : Supported
    , floatLabel : Supported
    , hideRequiredMarker : Supported
    , hideSubscript : Supported
    , id : Supported
    , slot : Supported
    , style : Supported
    , variant : Supported
    }


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    { childAdm | formField : Ctx }


{-| The `floatLabel` values valid on this component (compile-tight narrowing).
-}
type alias FloatLabel =
    { always : Supported
    , auto : Supported
    }


{-| The `hideSubscript` values valid on this component (compile-tight narrowing).
-}
type alias HideSubscript =
    { always : Supported
    , auto : Supported
    , never : Supported
    }


{-| The `variant` values valid on this component (compile-tight narrowing).
-}
type alias Variant =
    { filled : Supported
    , outlined : Supported
    }


{-| Standard constructor: `[attributes] [children]`. The default slot is
kind-permissive (`any`): children of any kind compose, but each child's OWN
admittedBy must still admit this context — a restricted-parent element is
rejected here at compile time.
-}
view :
    List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
view attrs children =
    Ir.fromNode (Ir.node "m3e-form-field" attrs (List.map HtmlIr.Element.toNode children))


{-| Narrowed value setter for `floatLabel`. Tokens come from `M3e.Values`.
-}
floatLabel : Value FloatLabel -> Attr { c | floatLabel : Supported } msg
floatLabel value_ =
    Ir.attribute "float-label" (HtmlIr.Value.toString value_)


{-| Narrowed value setter for `hideSubscript`. Tokens come from `M3e.Values`.
-}
hideSubscript : Value HideSubscript -> Attr { c | hideSubscript : Supported } msg
hideSubscript value_ =
    Ir.attribute "hide-subscript" (HtmlIr.Value.toString value_)


{-| Narrowed value setter for `variant`. Tokens come from `M3e.Values`.
-}
variant : Value Variant -> Attr { c | variant : Supported } msg
variant value_ =
    Ir.attribute "variant" (HtmlIr.Value.toString value_)


{-| See `M3e.Attributes.hideRequiredMarker`.
-}
hideRequiredMarker : Bool -> Attr { c | hideRequiredMarker : Supported } msg
hideRequiredMarker =
    M3e.Attributes.hideRequiredMarker


{-| Place an element into the named `error` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
error : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
error element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "error") (HtmlIr.Element.toNode element))


{-| Place an element into the named `hint` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
hint : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
hint element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "hint") (HtmlIr.Element.toNode element))


{-| Place an element into the named `label` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
label : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
label element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "label") (HtmlIr.Element.toNode element))


{-| Place an element into the named `prefix` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
prefix : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
prefix element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "prefix") (HtmlIr.Element.toNode element))


{-| Place an element into the named `prefix-text` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
prefixText : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
prefixText element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "prefix-text") (HtmlIr.Element.toNode element))


{-| Place an element into the named `suffix` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
suffix : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
suffix element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "suffix") (HtmlIr.Element.toNode element))


{-| Place an element into the named `suffix-text` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
suffixText : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
suffixText element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "suffix-text") (HtmlIr.Element.toNode element))


{-| The pipe-builder: capabilities are consumed Available→Used, so writing
a singular attribute or slot twice is unwritable.
-}
type Builder attrCaps slotCaps msg
    = Builder { attrs : List (Attr Attrs msg), children : List (Node msg) }


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    { class : Available
    , floatLabel : Available
    , hideRequiredMarker : Available
    , hideSubscript : Available
    , id : Available
    , slot : Available
    , style : Available
    , variant : Available
    }


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    { error : Available
    , hint : Available
    , label : Available
    , prefix : Available
    , prefixText : Available
    , suffix : Available
    , suffixText : Available
    }


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg
build =
    Builder { attrs = [], children = [] }


{-| Close the pipe-builder.
-}
toElement : Builder attrCaps slotCaps msg -> Element (Is s) admittedBy msg
toElement (Builder b) =
    Ir.fromNode (Ir.node "m3e-form-field" (List.reverse b.attrs) (List.reverse b.children))


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


{-| Pipe form of `floatLabel` — consumes its capability (write-once).
-}
withFloatLabel : Value FloatLabel -> Builder { a | floatLabel : Available } slotCaps msg -> Builder { a | floatLabel : Used } slotCaps msg
withFloatLabel value_ (Builder b) =
    Builder { b | attrs = floatLabel value_ :: b.attrs }


{-| Pipe form of `hideRequiredMarker` — consumes its capability (write-once).
-}
withHideRequiredMarker : Bool -> Builder { a | hideRequiredMarker : Available } slotCaps msg -> Builder { a | hideRequiredMarker : Used } slotCaps msg
withHideRequiredMarker value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.hideRequiredMarker value_ :: b.attrs }


{-| Pipe form of `hideSubscript` — consumes its capability (write-once).
-}
withHideSubscript : Value HideSubscript -> Builder { a | hideSubscript : Available } slotCaps msg -> Builder { a | hideSubscript : Used } slotCaps msg
withHideSubscript value_ (Builder b) =
    Builder { b | attrs = hideSubscript value_ :: b.attrs }


{-| Pipe form of `variant` — consumes its capability (write-once).
-}
withVariant : Value Variant -> Builder { a | variant : Available } slotCaps msg -> Builder { a | variant : Used } slotCaps msg
withVariant value_ (Builder b) =
    Builder { b | attrs = variant value_ :: b.attrs }


{-| Pipe form of the `error` slot — consumes its capability (write-once).
-}
withError : Element childAccepts admittedBy msg -> Builder attrCaps { s | error : Available } msg -> Builder attrCaps { s | error : Used } msg
withError element (Builder b) =
    Builder { b | children = HtmlIr.Element.toNode (error element) :: b.children }


{-| Pipe form of the `hint` slot — consumes its capability (write-once).
-}
withHint : Element childAccepts admittedBy msg -> Builder attrCaps { s | hint : Available } msg -> Builder attrCaps { s | hint : Used } msg
withHint element (Builder b) =
    Builder { b | children = HtmlIr.Element.toNode (hint element) :: b.children }


{-| Pipe form of the `label` slot — consumes its capability (write-once).
-}
withLabel : Element childAccepts admittedBy msg -> Builder attrCaps { s | label : Available } msg -> Builder attrCaps { s | label : Used } msg
withLabel element (Builder b) =
    Builder { b | children = HtmlIr.Element.toNode (label element) :: b.children }


{-| Pipe form of the `prefix` slot — consumes its capability (write-once).
-}
withPrefix : Element childAccepts admittedBy msg -> Builder attrCaps { s | prefix : Available } msg -> Builder attrCaps { s | prefix : Used } msg
withPrefix element (Builder b) =
    Builder { b | children = HtmlIr.Element.toNode (prefix element) :: b.children }


{-| Pipe form of the `prefix-text` slot — consumes its capability (write-once).
-}
withPrefixText : Element childAccepts admittedBy msg -> Builder attrCaps { s | prefixText : Available } msg -> Builder attrCaps { s | prefixText : Used } msg
withPrefixText element (Builder b) =
    Builder { b | children = HtmlIr.Element.toNode (prefixText element) :: b.children }


{-| Pipe form of the `suffix` slot — consumes its capability (write-once).
-}
withSuffix : Element childAccepts admittedBy msg -> Builder attrCaps { s | suffix : Available } msg -> Builder attrCaps { s | suffix : Used } msg
withSuffix element (Builder b) =
    Builder { b | children = HtmlIr.Element.toNode (suffix element) :: b.children }


{-| Pipe form of the `suffix-text` slot — consumes its capability (write-once).
-}
withSuffixText : Element childAccepts admittedBy msg -> Builder attrCaps { s | suffixText : Available } msg -> Builder attrCaps { s | suffixText : Used } msg
withSuffixText element (Builder b) =
    Builder { b | children = HtmlIr.Element.toNode (suffixText element) :: b.children }


{-| Pipe form of a default-slot child (repeatable).
-}
withChild : Element childAccepts (ChildAdmittedBy childAdm) msg -> Builder attrCaps slotCaps msg -> Builder attrCaps slotCaps msg
withChild element (Builder b) =
    Builder { b | children = HtmlIr.Element.toNode element :: b.children }
