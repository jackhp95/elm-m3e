module M3e.FormField exposing
    ( view, build, toElement
    , Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , FloatLabel, floatLabel, HideSubscript, hideSubscript, Variant, variant
    , hideRequiredMarker
    , error, hint, prefix, prefixText, suffix, suffixText, child
    , withChild, withClass, withError, withFloatLabel, withHideRequiredMarker, withHideSubscript, withHint, withId, withPrefix, withPrefixText, withSlot, withStyle, withSuffix, withSuffixText, withVariant
    )

{-| The `m3e-form-field` component — strict per-component surface.

A container for form controls that applies Material Design styling and behavior.

@docs view, build, toElement
@docs Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs FloatLabel, floatLabel, HideSubscript, hideSubscript, Variant, variant
@docs hideRequiredMarker
@docs error, hint, prefix, prefixText, suffix, suffixText, child
@docs withChild, withClass, withError, withFloatLabel, withHideRequiredMarker, withHideSubscript, withHint, withId, withPrefix, withPrefixText, withSlot, withStyle, withSuffix, withSuffixText, withVariant

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
view =
    H.formField


{-| Specifies whether the label should float always or only when necessary. (default: `"auto"`)
-}
floatLabel : Value FloatLabel -> Attr { c | floatLabel : Supported } msg
floatLabel value_ =
    Ir.attribute "float-label" (Val.toString value_)


{-| Whether subscript content is hidden. (default: `"auto"`)
-}
hideSubscript : Value HideSubscript -> Attr { c | hideSubscript : Supported } msg
hideSubscript value_ =
    Ir.attribute "hide-subscript" (Val.toString value_)


{-| The appearance variant of the field. (default: `"outlined"`)
-}
variant : Value Variant -> Attr { c | variant : Supported } msg
variant value_ =
    Ir.attribute "variant" (Val.toString value_)


{-| See `M3e.Attributes.hideRequiredMarker`.
-}
hideRequiredMarker : Bool -> Attr { c | hideRequiredMarker : Supported } msg
hideRequiredMarker =
    A.hideRequiredMarker


{-| Place an element into the named `error` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
error : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
error element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "error") (El.toNode element))


{-| Place an element into the named `hint` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
hint : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
hint element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "hint") (El.toNode element))


{-| Place an element into the named `prefix` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
prefix : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
prefix element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "prefix") (El.toNode element))


{-| Place an element into the named `prefix-text` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
prefixText : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
prefixText element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "prefix-text") (El.toNode element))


{-| Place an element into the named `suffix` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
suffix : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
suffix element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "suffix") (El.toNode element))


{-| Place an element into the named `suffix-text` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
suffixText : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
suffixText element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "suffix-text") (El.toNode element))


{-| Place a pre-built element into the default (unnamed) slot (input
constrained to the slot's kinds; output row free so it composes into the
child list). The list-form sibling of the builder's `withChild`.
-}
child : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
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
    , prefix : Available
    , prefixText : Available
    , suffix : Available
    , suffixText : Available
    }


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg
build =
    B.init "m3e-form-field" [] []


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


{-| Pipe form of `floatLabel` — consumes its capability (write-once).
-}
withFloatLabel : Value FloatLabel -> Builder { a | floatLabel : Available } slotCaps msg -> Builder { a | floatLabel : Used } slotCaps msg
withFloatLabel value_ =
    B.withAttribute (floatLabel value_)


{-| Pipe form of `hideRequiredMarker` — consumes its capability (write-once).
-}
withHideRequiredMarker : Bool -> Builder { a | hideRequiredMarker : Available } slotCaps msg -> Builder { a | hideRequiredMarker : Used } slotCaps msg
withHideRequiredMarker value_ =
    B.withAttribute (A.hideRequiredMarker value_)


{-| Pipe form of `hideSubscript` — consumes its capability (write-once).
-}
withHideSubscript : Value HideSubscript -> Builder { a | hideSubscript : Available } slotCaps msg -> Builder { a | hideSubscript : Used } slotCaps msg
withHideSubscript value_ =
    B.withAttribute (hideSubscript value_)


{-| Pipe form of `variant` — consumes its capability (write-once).
-}
withVariant : Value Variant -> Builder { a | variant : Available } slotCaps msg -> Builder { a | variant : Used } slotCaps msg
withVariant value_ =
    B.withAttribute (variant value_)


{-| Pipe form of the `error` slot — consumes its capability (write-once).
-}
withError : Element childAccepts admittedBy msg -> Builder attrCaps { s | error : Available } msg -> Builder attrCaps { s | error : Used } msg
withError element =
    B.withChild (El.toNode (error element))


{-| Pipe form of the `hint` slot — consumes its capability (write-once).
-}
withHint : Element childAccepts admittedBy msg -> Builder attrCaps { s | hint : Available } msg -> Builder attrCaps { s | hint : Used } msg
withHint element =
    B.withChild (El.toNode (hint element))


{-| Pipe form of the `prefix` slot — consumes its capability (write-once).
-}
withPrefix : Element childAccepts admittedBy msg -> Builder attrCaps { s | prefix : Available } msg -> Builder attrCaps { s | prefix : Used } msg
withPrefix element =
    B.withChild (El.toNode (prefix element))


{-| Pipe form of the `prefix-text` slot — consumes its capability (write-once).
-}
withPrefixText : Element childAccepts admittedBy msg -> Builder attrCaps { s | prefixText : Available } msg -> Builder attrCaps { s | prefixText : Used } msg
withPrefixText element =
    B.withChild (El.toNode (prefixText element))


{-| Pipe form of the `suffix` slot — consumes its capability (write-once).
-}
withSuffix : Element childAccepts admittedBy msg -> Builder attrCaps { s | suffix : Available } msg -> Builder attrCaps { s | suffix : Used } msg
withSuffix element =
    B.withChild (El.toNode (suffix element))


{-| Pipe form of the `suffix-text` slot — consumes its capability (write-once).
-}
withSuffixText : Element childAccepts admittedBy msg -> Builder attrCaps { s | suffixText : Available } msg -> Builder attrCaps { s | suffixText : Used } msg
withSuffixText element =
    B.withChild (El.toNode (suffixText element))


{-| Pipe form of a default-slot child (repeatable).
-}
withChild : Element childAccepts (ChildAdmittedBy childAdm) msg -> Builder attrCaps slotCaps msg -> Builder attrCaps slotCaps msg
withChild element =
    B.withChild (El.toNode element)
