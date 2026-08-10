module M3e.Step exposing
    ( view, el, build, toElement
    , Is, Attrs, Content, DoneIconSlot, EditIconSlot, ErrorSlot, ErrorIconSlot, HintSlot, IconSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , completed, disabled, editable, for, invalid, optional, selected, defaultSelected, onBeforeinput, onInput, onChange, onClick
    , doneIcon, editIcon, error, errorIcon, hint, icon, child
    , withChild, withClass, withCompleted, withDisabled, withDoneIcon, withEditIcon, withEditable, withError, withErrorIcon, withFor, withHint, withIcon, withId, withInvalid, withOnBeforeinput, withOnChange, withOnClick, withOnInput, withOptional, withSelected, withSlot, withStyle
    )

{-| The `m3e-step` component — strict per-component surface.

A step in a wizard-like workflow.

@docs view, el, build, toElement
@docs Is, Attrs, Content, DoneIconSlot, EditIconSlot, ErrorSlot, ErrorIconSlot, HintSlot, IconSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs completed, disabled, editable, for, invalid, optional, selected, defaultSelected, onBeforeinput, onInput, onChange, onClick
@docs doneIcon, editIcon, error, errorIcon, hint, icon, child
@docs withChild, withClass, withCompleted, withDisabled, withDoneIcon, withEditIcon, withEditable, withError, withErrorIcon, withFor, withHint, withIcon, withId, withInvalid, withOnBeforeinput, withOnChange, withOnClick, withOnInput, withOptional, withSelected, withSlot, withStyle

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Shared, Supported)
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Events as Ev
import M3e.Html as H
import M3e.Internal.Types.Step
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-step` produces (open — composes into any slot naming it).
-}
type alias Is s =
    M3e.Internal.Types.Step.Is s


{-| The closed attribute-capability row.
-}
type alias Attrs =
    M3e.Internal.Types.Step.Attrs


{-| The kinds the default slot admits.
-}
type alias Content =
    M3e.Internal.Types.Step.Content


{-| The kinds the `done-icon` slot admits.
-}
type alias DoneIconSlot =
    M3e.Internal.Types.Step.DoneIconSlot


{-| The kinds the `edit-icon` slot admits.
-}
type alias EditIconSlot =
    M3e.Internal.Types.Step.EditIconSlot


{-| The kinds the `error` slot admits.
-}
type alias ErrorSlot =
    M3e.Internal.Types.Step.ErrorSlot


{-| The kinds the `error-icon` slot admits.
-}
type alias ErrorIconSlot =
    M3e.Internal.Types.Step.ErrorIconSlot


{-| The kinds the `hint` slot admits.
-}
type alias HintSlot =
    M3e.Internal.Types.Step.HintSlot


{-| The kinds the `icon` slot admits.
-}
type alias IconSlot =
    M3e.Internal.Types.Step.IconSlot


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    M3e.Internal.Types.Step.ChildAdmittedBy childAdm


{-| Standard constructor: `[attributes] [children]`.
-}
view :
    List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
view =
    H.step


{-| Required-content (and action) constructor — omissions are unwritable.
-}
el :
    { content : Element Content (ChildAdmittedBy childAdm) msg }
    -> List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el required_ attrs children =
    view attrs (required_.content :: children)


{-| See `M3e.Attributes.completed`.
-}
completed : Bool -> Attr { c | completed : Supported } msg
completed =
    A.completed


{-| See `M3e.Attributes.disabled`.
-}
disabled : Bool -> Attr { c | disabled : Supported } msg
disabled =
    A.disabled


{-| See `M3e.Attributes.editable`.
-}
editable : Bool -> Attr { c | editable : Supported } msg
editable =
    A.editable


{-| See `M3e.Attributes.for`.
-}
for : String -> Attr { c | for : Supported } msg
for =
    A.for


{-| See `M3e.Attributes.invalid`.
-}
invalid : Bool -> Attr { c | invalid : Supported } msg
invalid =
    A.invalid


{-| See `M3e.Attributes.optional`.
-}
optional : Bool -> Attr { c | optional : Supported } msg
optional =
    A.optional


{-| See `M3e.Attributes.selected`.
-}
selected : Bool -> Attr { c | selected : Supported } msg
selected =
    A.selected


{-| See `M3e.Attributes.defaultSelected`.
-}
defaultSelected : Bool -> Attr { c | selected : Supported } msg
defaultSelected =
    A.defaultSelected


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


{-| See `M3e.Events.onChange`.
-}
onChange : msg -> Attr { c | onChange : Supported } msg
onChange =
    Ev.onChange


{-| See `M3e.Events.onClick`.
-}
onClick : msg -> Attr { c | onClick : Supported } msg
onClick =
    Ev.onClick


{-| Place an element into the named `done-icon` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
doneIcon : Element DoneIconSlot admittedBy msg -> Element free freeAdmittedBy msg
doneIcon element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "done-icon") (El.toNode element))


{-| Place an element into the named `edit-icon` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
editIcon : Element EditIconSlot admittedBy msg -> Element free freeAdmittedBy msg
editIcon element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "edit-icon") (El.toNode element))


{-| Place an element into the named `error` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
error : Element ErrorSlot admittedBy msg -> Element free freeAdmittedBy msg
error element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "error") (El.toNode element))


{-| Place an element into the named `error-icon` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
errorIcon : Element ErrorIconSlot admittedBy msg -> Element free freeAdmittedBy msg
errorIcon element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "error-icon") (El.toNode element))


{-| Place an element into the named `hint` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
hint : Element HintSlot admittedBy msg -> Element free freeAdmittedBy msg
hint element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "hint") (El.toNode element))


{-| Place an element into the named `icon` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
icon : Element IconSlot admittedBy msg -> Element free freeAdmittedBy msg
icon element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "icon") (El.toNode element))


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
    M3e.Internal.Types.Step.Builder attrCaps slotCaps msg s


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    M3e.Internal.Types.Step.AttrCaps


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    M3e.Internal.Types.Step.SlotCaps


{-| Seed the pipe-builder.
-}
build :
    { content : Element Content (ChildAdmittedBy childAdm) msg }
    -> Builder AttrCaps SlotCaps msg kind
build required_ =
    B.init "m3e-step" [] [ El.toNode required_.content ]


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


{-| Pipe form of `completed` — consumes its capability (write-once).
-}
withCompleted : Bool -> Builder { a | completed : Available } slotCaps msg kind -> Builder { a | completed : Used } slotCaps msg kind
withCompleted value_ =
    B.withAttribute (A.completed value_)


{-| Pipe form of `disabled` — consumes its capability (write-once).
-}
withDisabled : Bool -> Builder { a | disabled : Available } slotCaps msg kind -> Builder { a | disabled : Used } slotCaps msg kind
withDisabled value_ =
    B.withAttribute (A.disabled value_)


{-| Pipe form of `editable` — consumes its capability (write-once).
-}
withEditable : Bool -> Builder { a | editable : Available } slotCaps msg kind -> Builder { a | editable : Used } slotCaps msg kind
withEditable value_ =
    B.withAttribute (A.editable value_)


{-| Pipe form of `for` — consumes its capability (write-once).
-}
withFor : String -> Builder { a | for : Available } slotCaps msg kind -> Builder { a | for : Used } slotCaps msg kind
withFor value_ =
    B.withAttribute (A.for value_)


{-| Pipe form of `invalid` — consumes its capability (write-once).
-}
withInvalid : Bool -> Builder { a | invalid : Available } slotCaps msg kind -> Builder { a | invalid : Used } slotCaps msg kind
withInvalid value_ =
    B.withAttribute (A.invalid value_)


{-| Pipe form of `optional` — consumes its capability (write-once).
-}
withOptional : Bool -> Builder { a | optional : Available } slotCaps msg kind -> Builder { a | optional : Used } slotCaps msg kind
withOptional value_ =
    B.withAttribute (A.optional value_)


{-| Pipe form of `selected` — consumes its capability (write-once).
-}
withSelected : Bool -> Builder { a | selected : Available } slotCaps msg kind -> Builder { a | selected : Used } slotCaps msg kind
withSelected value_ =
    B.withAttribute (A.selected value_)


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


{-| Pipe form of `onChange` — consumes its capability (write-once).
-}
withOnChange : msg -> Builder { a | onChange : Available } slotCaps msg kind -> Builder { a | onChange : Used } slotCaps msg kind
withOnChange value_ =
    B.withAttribute (Ev.onChange value_)


{-| Pipe form of `onClick` — consumes its capability (write-once).
-}
withOnClick : msg -> Builder { a | onClick : Available } slotCaps msg kind -> Builder { a | onClick : Used } slotCaps msg kind
withOnClick value_ =
    B.withAttribute (Ev.onClick value_)


{-| Pipe form of the `done-icon` slot — consumes its capability (write-once).
-}
withDoneIcon : Element DoneIconSlot admittedBy msg -> Builder attrCaps { s | doneIcon : Available } msg kind -> Builder attrCaps { s | doneIcon : Used } msg kind
withDoneIcon element =
    B.withChild (El.toNode (doneIcon element))


{-| Pipe form of the `edit-icon` slot — consumes its capability (write-once).
-}
withEditIcon : Element EditIconSlot admittedBy msg -> Builder attrCaps { s | editIcon : Available } msg kind -> Builder attrCaps { s | editIcon : Used } msg kind
withEditIcon element =
    B.withChild (El.toNode (editIcon element))


{-| Pipe form of the `error` slot — consumes its capability (write-once).
-}
withError : Element ErrorSlot admittedBy msg -> Builder attrCaps { s | error : Available } msg kind -> Builder attrCaps { s | error : Used } msg kind
withError element =
    B.withChild (El.toNode (error element))


{-| Pipe form of the `error-icon` slot — consumes its capability (write-once).
-}
withErrorIcon : Element ErrorIconSlot admittedBy msg -> Builder attrCaps { s | errorIcon : Available } msg kind -> Builder attrCaps { s | errorIcon : Used } msg kind
withErrorIcon element =
    B.withChild (El.toNode (errorIcon element))


{-| Pipe form of the `hint` slot — consumes its capability (write-once).
-}
withHint : Element HintSlot admittedBy msg -> Builder attrCaps { s | hint : Available } msg kind -> Builder attrCaps { s | hint : Used } msg kind
withHint element =
    B.withChild (El.toNode (hint element))


{-| Pipe form of the `icon` slot — consumes its capability (write-once).
-}
withIcon : Element IconSlot admittedBy msg -> Builder attrCaps { s | icon : Available } msg kind -> Builder attrCaps { s | icon : Used } msg kind
withIcon element =
    B.withChild (El.toNode (icon element))


{-| Pipe form of a default-slot child (repeatable).
-}
withChild : Element Content (ChildAdmittedBy childAdm) msg -> Builder attrCaps slotCaps msg kind -> Builder attrCaps slotCaps msg kind
withChild element =
    B.withChild (El.toNode element)
