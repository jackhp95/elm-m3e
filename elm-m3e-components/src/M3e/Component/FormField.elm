module M3e.Component.FormField exposing
    ( view, build, toElement
    , Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , FloatLabel, floatLabel, HideSubscript, hideSubscript, Variant, variant
    , hideRequiredMarker
    , error, hint, label, prefix, prefixText, suffix, suffixText, child
    , withChild, withClass, withError, withFloatLabel, withHideRequiredMarker, withHideSubscript, withHint, withId, withLabel, withPrefix, withPrefixText, withSlot, withStyle, withSuffix, withSuffixText, withVariant
    )

{-| The `m3e-form-field` component — strict per-component surface.

A container for form controls that applies Material Design styling and behavior.

@docs view, build, toElement
@docs Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs FloatLabel, floatLabel, HideSubscript, hideSubscript, Variant, variant
@docs hideRequiredMarker
@docs error, hint, label, prefix, prefixText, suffix, suffixText, child
@docs withChild, withClass, withError, withFloatLabel, withHideRequiredMarker, withHideSubscript, withHint, withId, withLabel, withPrefix, withPrefixText, withSlot, withStyle, withSuffix, withSuffixText, withVariant

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import HtmlIr.Value as Val exposing (Value)
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Html as H
import M3e.Internal.Types.FormField
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-form-field` produces (open — composes into any slot naming it).
-}
type alias Is s =
    M3e.Internal.Types.FormField.Is s


{-| The closed attribute-capability row.
-}
type alias Attrs =
    M3e.Internal.Types.FormField.Attrs


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    M3e.Internal.Types.FormField.ChildAdmittedBy childAdm


{-| The `floatLabel` values valid on this component (compile-tight narrowing).
-}
type alias FloatLabel =
    M3e.Internal.Types.FormField.FloatLabel


{-| The `hideSubscript` values valid on this component (compile-tight narrowing).
-}
type alias HideSubscript =
    M3e.Internal.Types.FormField.HideSubscript


{-| The `variant` values valid on this component (compile-tight narrowing).
-}
type alias Variant =
    M3e.Internal.Types.FormField.Variant


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


{-| Place an element into the named `label` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
label : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
label element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "label") (El.toNode element))


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
`Build.Internal`, closed over this component's `Attrs` row and `Is s` kind.
-}
type alias Builder attrCaps slotCaps msg s =
    M3e.Internal.Types.FormField.Builder attrCaps slotCaps msg s


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    M3e.Internal.Types.FormField.AttrCaps


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    M3e.Internal.Types.FormField.SlotCaps


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg kind
build =
    B.init "m3e-form-field" [] []


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


{-| Pipe form of `floatLabel` — consumes its capability (write-once).
-}
withFloatLabel : Value FloatLabel -> Builder { a | floatLabel : Available } slotCaps msg kind -> Builder { a | floatLabel : Used } slotCaps msg kind
withFloatLabel value_ =
    B.withAttribute (floatLabel value_)


{-| Pipe form of `hideRequiredMarker` — consumes its capability (write-once).
-}
withHideRequiredMarker : Bool -> Builder { a | hideRequiredMarker : Available } slotCaps msg kind -> Builder { a | hideRequiredMarker : Used } slotCaps msg kind
withHideRequiredMarker value_ =
    B.withAttribute (A.hideRequiredMarker value_)


{-| Pipe form of `hideSubscript` — consumes its capability (write-once).
-}
withHideSubscript : Value HideSubscript -> Builder { a | hideSubscript : Available } slotCaps msg kind -> Builder { a | hideSubscript : Used } slotCaps msg kind
withHideSubscript value_ =
    B.withAttribute (hideSubscript value_)


{-| Pipe form of `variant` — consumes its capability (write-once).
-}
withVariant : Value Variant -> Builder { a | variant : Available } slotCaps msg kind -> Builder { a | variant : Used } slotCaps msg kind
withVariant value_ =
    B.withAttribute (variant value_)


{-| Pipe form of the `error` slot — consumes its capability (write-once).
-}
withError : Element childAccepts admittedBy msg -> Builder attrCaps { s | error : Available } msg kind -> Builder attrCaps { s | error : Used } msg kind
withError element =
    B.withChild (El.toNode (error element))


{-| Pipe form of the `hint` slot — consumes its capability (write-once).
-}
withHint : Element childAccepts admittedBy msg -> Builder attrCaps { s | hint : Available } msg kind -> Builder attrCaps { s | hint : Used } msg kind
withHint element =
    B.withChild (El.toNode (hint element))


{-| Pipe form of the `label` slot — consumes its capability (write-once).
-}
withLabel : Element childAccepts admittedBy msg -> Builder attrCaps { s | label : Available } msg kind -> Builder attrCaps { s | label : Used } msg kind
withLabel element =
    B.withChild (El.toNode (label element))


{-| Pipe form of the `prefix` slot — consumes its capability (write-once).
-}
withPrefix : Element childAccepts admittedBy msg -> Builder attrCaps { s | prefix : Available } msg kind -> Builder attrCaps { s | prefix : Used } msg kind
withPrefix element =
    B.withChild (El.toNode (prefix element))


{-| Pipe form of the `prefix-text` slot — consumes its capability (write-once).
-}
withPrefixText : Element childAccepts admittedBy msg -> Builder attrCaps { s | prefixText : Available } msg kind -> Builder attrCaps { s | prefixText : Used } msg kind
withPrefixText element =
    B.withChild (El.toNode (prefixText element))


{-| Pipe form of the `suffix` slot — consumes its capability (write-once).
-}
withSuffix : Element childAccepts admittedBy msg -> Builder attrCaps { s | suffix : Available } msg kind -> Builder attrCaps { s | suffix : Used } msg kind
withSuffix element =
    B.withChild (El.toNode (suffix element))


{-| Pipe form of the `suffix-text` slot — consumes its capability (write-once).
-}
withSuffixText : Element childAccepts admittedBy msg -> Builder attrCaps { s | suffixText : Available } msg kind -> Builder attrCaps { s | suffixText : Used } msg kind
withSuffixText element =
    B.withChild (El.toNode (suffixText element))


{-| Pipe form of a default-slot child (repeatable).
-}
withChild : Element childAccepts (ChildAdmittedBy childAdm) msg -> Builder attrCaps slotCaps msg kind -> Builder attrCaps slotCaps msg kind
withChild element =
    B.withChild (El.toNode element)
