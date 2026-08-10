module M3e.Stepper exposing
    ( view, build, toElement
    , Is, Attrs, PanelSlot, StepSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , HeaderPosition, headerPosition, LabelPosition, labelPosition, Orientation, orientation
    , linear, onChange, onBeforeinput, onInput
    , panel, step
    , withClass, withHeaderPosition, withId, withLabelPosition, withLinear, withOnBeforeinput, withOnChange, withOnInput, withOrientation, withPanel, withSlot, withStep, withStyle
    )

{-| The `m3e-stepper` component — strict per-component surface.

Provides a wizard-like workflow by dividing content into logical steps.

@docs view, build, toElement
@docs Is, Attrs, PanelSlot, StepSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs HeaderPosition, headerPosition, LabelPosition, labelPosition, Orientation, orientation
@docs linear, onChange, onBeforeinput, onInput
@docs panel, step
@docs withClass, withHeaderPosition, withId, withLabelPosition, withLinear, withOnBeforeinput, withOnChange, withOnInput, withOrientation, withPanel, withSlot, withStep, withStyle

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import HtmlIr.Value as Val exposing (Value)
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Events as Ev
import M3e.Html as H
import M3e.Internal.Types.Stepper
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-stepper` produces (open — composes into any slot naming it).
-}
type alias Is s =
    M3e.Internal.Types.Stepper.Is s


{-| The closed attribute-capability row.
-}
type alias Attrs =
    M3e.Internal.Types.Stepper.Attrs


{-| The kinds the `panel` slot admits.
-}
type alias PanelSlot =
    M3e.Internal.Types.Stepper.PanelSlot


{-| The kinds the `step` slot admits.
-}
type alias StepSlot =
    M3e.Internal.Types.Stepper.StepSlot


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    M3e.Internal.Types.Stepper.ChildAdmittedBy childAdm


{-| The `headerPosition` values valid on this component (compile-tight narrowing).
-}
type alias HeaderPosition =
    M3e.Internal.Types.Stepper.HeaderPosition


{-| The `labelPosition` values valid on this component (compile-tight narrowing).
-}
type alias LabelPosition =
    M3e.Internal.Types.Stepper.LabelPosition


{-| The `orientation` values valid on this component (compile-tight narrowing).
-}
type alias Orientation =
    M3e.Internal.Types.Stepper.Orientation


{-| Standard constructor: `[attributes] [children]`.
-}
view :
    List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
view =
    H.stepper


{-| The position of the step header, when oriented horizontally. (default: `"above"`)
-}
headerPosition : Value HeaderPosition -> Attr { c | headerPosition : Supported } msg
headerPosition value_ =
    Ir.attribute "header-position" (Val.toString value_)


{-| The position of the step labels, when oriented horizontally. (default: `"end"`)
-}
labelPosition : Value LabelPosition -> Attr { c | labelPosition : Supported } msg
labelPosition value_ =
    Ir.attribute "label-position" (Val.toString value_)


{-| The orientation of the stepper. (default: `"horizontal"`)
-}
orientation : Value Orientation -> Attr { c | orientation : Supported } msg
orientation value_ =
    Ir.attribute "orientation" (Val.toString value_)


{-| See `M3e.Attributes.linear`.
-}
linear : Bool -> Attr { c | linear : Supported } msg
linear =
    A.linear


{-| See `M3e.Events.onChange`.
-}
onChange : msg -> Attr { c | onChange : Supported } msg
onChange =
    Ev.onChange


{-| See `M3e.Events.onBeforeinput`.
-}
onBeforeinput : msg -> Attr { c | onBeforeinput : Supported } msg
onBeforeinput =
    Ev.onBeforeinput


{-| See `M3e.Events.onInput`.
-}
onInput : msg -> Attr { c | onInput : Supported } msg
onInput =
    Ev.onInput


{-| Place an element into the named `panel` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
panel : Element PanelSlot admittedBy msg -> Element free freeAdmittedBy msg
panel element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "panel") (El.toNode element))


{-| Place an element into the named `step` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
step : Element StepSlot admittedBy msg -> Element free freeAdmittedBy msg
step element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "step") (El.toNode element))


{-| The pipe-builder: capabilities are consumed Available→Used, so writing
a singular attribute or slot twice is unwritable. Aliases the shared builder in
`Build.Internal`, closed over this component's `Attrs` row and `Is s` kind.
-}
type alias Builder attrCaps slotCaps msg s =
    M3e.Internal.Types.Stepper.Builder attrCaps slotCaps msg s


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    M3e.Internal.Types.Stepper.AttrCaps


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    {}


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg kind
build =
    B.init "m3e-stepper" [] []


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


{-| Pipe form of `headerPosition` — consumes its capability (write-once).
-}
withHeaderPosition : Value HeaderPosition -> Builder { a | headerPosition : Available } slotCaps msg kind -> Builder { a | headerPosition : Used } slotCaps msg kind
withHeaderPosition value_ =
    B.withAttribute (headerPosition value_)


{-| Pipe form of `labelPosition` — consumes its capability (write-once).
-}
withLabelPosition : Value LabelPosition -> Builder { a | labelPosition : Available } slotCaps msg kind -> Builder { a | labelPosition : Used } slotCaps msg kind
withLabelPosition value_ =
    B.withAttribute (labelPosition value_)


{-| Pipe form of `linear` — consumes its capability (write-once).
-}
withLinear : Bool -> Builder { a | linear : Available } slotCaps msg kind -> Builder { a | linear : Used } slotCaps msg kind
withLinear value_ =
    B.withAttribute (A.linear value_)


{-| Pipe form of `orientation` — consumes its capability (write-once).
-}
withOrientation : Value Orientation -> Builder { a | orientation : Available } slotCaps msg kind -> Builder { a | orientation : Used } slotCaps msg kind
withOrientation value_ =
    B.withAttribute (orientation value_)


{-| Pipe form of `onChange` — consumes its capability (write-once).
-}
withOnChange : msg -> Builder { a | onChange : Available } slotCaps msg kind -> Builder { a | onChange : Used } slotCaps msg kind
withOnChange value_ =
    B.withAttribute (Ev.onChange value_)


{-| Pipe form of `onBeforeinput` — consumes its capability (write-once).
-}
withOnBeforeinput : msg -> Builder { a | onBeforeinput : Available } slotCaps msg kind -> Builder { a | onBeforeinput : Used } slotCaps msg kind
withOnBeforeinput value_ =
    B.withAttribute (Ev.onBeforeinput value_)


{-| Pipe form of `onInput` — consumes its capability (write-once).
-}
withOnInput : msg -> Builder { a | onInput : Available } slotCaps msg kind -> Builder { a | onInput : Used } slotCaps msg kind
withOnInput value_ =
    B.withAttribute (Ev.onInput value_)


{-| Pipe form of the `panel` slot — appends into the child list (repeatable, like `withChild`).
-}
withPanel : Element PanelSlot admittedBy msg -> Builder attrCaps slotCaps msg kind -> Builder attrCaps slotCaps msg kind
withPanel element =
    B.withChild (El.toNode (panel element))


{-| Pipe form of the `step` slot — appends into the child list (repeatable, like `withChild`).
-}
withStep : Element StepSlot admittedBy msg -> Builder attrCaps slotCaps msg kind -> Builder attrCaps slotCaps msg kind
withStep element =
    B.withChild (El.toNode (step element))
