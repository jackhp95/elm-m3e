module M3e.Stepper exposing
    ( view, build, toElement
    , Is, Attrs, PanelSlot, StepSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , HeaderPosition, headerPosition, LabelPosition, labelPosition, Orientation, orientation
    , linear, onChange, onBeforeinput, onInput
    , panel, step
    , withClass, withHeaderPosition, withId, withLabelPosition, withLinear, withOnBeforeinput, withOnChange, withOnInput, withOrientation, withSlot, withStyle
    )

{-| The `m3e-stepper` component — strict per-component surface.

Provides a wizard-like workflow by dividing content into logical steps.

@docs view, build, toElement
@docs Is, Attrs, PanelSlot, StepSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs HeaderPosition, headerPosition, LabelPosition, labelPosition, Orientation, orientation
@docs linear, onChange, onBeforeinput, onInput
@docs panel, step
@docs withClass, withHeaderPosition, withId, withLabelPosition, withLinear, withOnBeforeinput, withOnChange, withOnInput, withOrientation, withSlot, withStyle

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
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-stepper` produces (open — composes into any slot naming it).
-}
type alias Is s =
    { s | stepper : Brand }


{-| The closed attribute-capability row.
-}
type alias Attrs =
    { class : Supported
    , headerPosition : Supported
    , id : Supported
    , labelPosition : Supported
    , linear : Supported
    , onBeforeinput : Supported
    , onChange : Supported
    , onInput : Supported
    , orientation : Supported
    , slot : Supported
    , style : Supported
    }


{-| The kinds the `panel` slot admits.
-}
type alias PanelSlot =
    { stepPanel : Brand }


{-| The kinds the `step` slot admits.
-}
type alias StepSlot =
    { step : Brand }


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    { childAdm | stepper : Ctx }


{-| The `headerPosition` values valid on this component (compile-tight narrowing).
-}
type alias HeaderPosition =
    { above : Supported
    , below : Supported
    }


{-| The `labelPosition` values valid on this component (compile-tight narrowing).
-}
type alias LabelPosition =
    { below : Supported
    , end : Supported
    }


{-| The `orientation` values valid on this component (compile-tight narrowing).
-}
type alias Orientation =
    { auto : Supported
    , horizontal : Supported
    , vertical : Supported
    }


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
`Build.Internal`, closed over this component's `Attrs` row.
-}
type alias Builder attrCaps slotCaps msg =
    B.Builder Attrs attrCaps slotCaps msg


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    { class : Available
    , headerPosition : Available
    , id : Available
    , labelPosition : Available
    , linear : Available
    , onBeforeinput : Available
    , onChange : Available
    , onInput : Available
    , orientation : Available
    , slot : Available
    , style : Available
    }


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    {}


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg
build =
    B.init "m3e-stepper" [] []


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


{-| Pipe form of `headerPosition` — consumes its capability (write-once).
-}
withHeaderPosition : Value HeaderPosition -> Builder { a | headerPosition : Available } slotCaps msg -> Builder { a | headerPosition : Used } slotCaps msg
withHeaderPosition value_ =
    B.withAttribute (headerPosition value_)


{-| Pipe form of `labelPosition` — consumes its capability (write-once).
-}
withLabelPosition : Value LabelPosition -> Builder { a | labelPosition : Available } slotCaps msg -> Builder { a | labelPosition : Used } slotCaps msg
withLabelPosition value_ =
    B.withAttribute (labelPosition value_)


{-| Pipe form of `linear` — consumes its capability (write-once).
-}
withLinear : Bool -> Builder { a | linear : Available } slotCaps msg -> Builder { a | linear : Used } slotCaps msg
withLinear value_ =
    B.withAttribute (A.linear value_)


{-| Pipe form of `orientation` — consumes its capability (write-once).
-}
withOrientation : Value Orientation -> Builder { a | orientation : Available } slotCaps msg -> Builder { a | orientation : Used } slotCaps msg
withOrientation value_ =
    B.withAttribute (orientation value_)


{-| Pipe form of `onChange` — consumes its capability (write-once).
-}
withOnChange : msg -> Builder { a | onChange : Available } slotCaps msg -> Builder { a | onChange : Used } slotCaps msg
withOnChange value_ =
    B.withAttribute (Ev.onChange value_)


{-| Pipe form of `onBeforeinput` — consumes its capability (write-once).
-}
withOnBeforeinput : msg -> Builder { a | onBeforeinput : Available } slotCaps msg -> Builder { a | onBeforeinput : Used } slotCaps msg
withOnBeforeinput value_ =
    B.withAttribute (Ev.onBeforeinput value_)


{-| Pipe form of `onInput` — consumes its capability (write-once).
-}
withOnInput : msg -> Builder { a | onInput : Available } slotCaps msg -> Builder { a | onInput : Used } slotCaps msg
withOnInput value_ =
    B.withAttribute (Ev.onInput value_)
