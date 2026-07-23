module M3e.Step exposing
    ( view, el, build, toElement
    , Is, Attrs, Content, DoneIconSlot, EditIconSlot, ErrorSlot, ErrorIconSlot, HintSlot, IconSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , completed, disabled, editable, for, invalid, optional, selected, onBeforeinput, onInput, onChange, onClick
    , doneIcon, editIcon, error, errorIcon, hint, icon
    , withChild, withClass, withCompleted, withDisabled, withDoneIcon, withEditIcon, withEditable, withError, withErrorIcon, withFor, withHint, withIcon, withId, withInvalid, withOnBeforeinput, withOnChange, withOnClick, withOnInput, withOptional, withSelected, withSlot, withStyle
    )

{-| The `m3e-step` component — strict per-component surface.

A step in a wizard-like workflow.

@docs view, el, build, toElement
@docs Is, Attrs, Content, DoneIconSlot, EditIconSlot, ErrorSlot, ErrorIconSlot, HintSlot, IconSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs completed, disabled, editable, for, invalid, optional, selected, onBeforeinput, onInput, onChange, onClick
@docs doneIcon, editIcon, error, errorIcon, hint, icon
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
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-step` produces (open — composes into any slot naming it).
-}
type alias Is s =
    { s | step : Brand }


{-| The closed attribute-capability row.
-}
type alias Attrs =
    { class : Supported
    , completed : Supported
    , disabled : Supported
    , editable : Supported
    , for : Supported
    , id : Supported
    , invalid : Supported
    , onBeforeinput : Supported
    , onChange : Supported
    , onClick : Supported
    , onInput : Supported
    , optional : Supported
    , selected : Supported
    , slot : Supported
    , style : Supported
    }


{-| The kinds the default slot admits.
-}
type alias Content =
    { sharedText : Shared }


{-| The kinds the `done-icon` slot admits.
-}
type alias DoneIconSlot =
    { sharedIcon : Shared }


{-| The kinds the `edit-icon` slot admits.
-}
type alias EditIconSlot =
    { sharedIcon : Shared }


{-| The kinds the `error` slot admits.
-}
type alias ErrorSlot =
    { sharedText : Shared }


{-| The kinds the `error-icon` slot admits.
-}
type alias ErrorIconSlot =
    { sharedIcon : Shared }


{-| The kinds the `hint` slot admits.
-}
type alias HintSlot =
    { sharedText : Shared }


{-| The kinds the `icon` slot admits.
-}
type alias IconSlot =
    { sharedIcon : Shared }


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    { childAdm | step : Ctx }


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
    , completed : Available
    , disabled : Available
    , editable : Available
    , for : Available
    , id : Available
    , invalid : Available
    , onBeforeinput : Available
    , onChange : Available
    , onClick : Available
    , onInput : Available
    , optional : Available
    , selected : Available
    , slot : Available
    , style : Available
    }


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    { doneIcon : Available
    , editIcon : Available
    , error : Available
    , errorIcon : Available
    , hint : Available
    , icon : Available
    }


{-| Seed the pipe-builder.
-}
build :
    { content : Element Content (ChildAdmittedBy childAdm) msg }
    -> Builder AttrCaps SlotCaps msg
build required_ =
    B.init "m3e-step" [] [ El.toNode required_.content ]


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


{-| Pipe form of `completed` — consumes its capability (write-once).
-}
withCompleted : Bool -> Builder { a | completed : Available } slotCaps msg -> Builder { a | completed : Used } slotCaps msg
withCompleted value_ =
    B.withAttribute (A.completed value_)


{-| Pipe form of `disabled` — consumes its capability (write-once).
-}
withDisabled : Bool -> Builder { a | disabled : Available } slotCaps msg -> Builder { a | disabled : Used } slotCaps msg
withDisabled value_ =
    B.withAttribute (A.disabled value_)


{-| Pipe form of `editable` — consumes its capability (write-once).
-}
withEditable : Bool -> Builder { a | editable : Available } slotCaps msg -> Builder { a | editable : Used } slotCaps msg
withEditable value_ =
    B.withAttribute (A.editable value_)


{-| Pipe form of `for` — consumes its capability (write-once).
-}
withFor : String -> Builder { a | for : Available } slotCaps msg -> Builder { a | for : Used } slotCaps msg
withFor value_ =
    B.withAttribute (A.for value_)


{-| Pipe form of `invalid` — consumes its capability (write-once).
-}
withInvalid : Bool -> Builder { a | invalid : Available } slotCaps msg -> Builder { a | invalid : Used } slotCaps msg
withInvalid value_ =
    B.withAttribute (A.invalid value_)


{-| Pipe form of `optional` — consumes its capability (write-once).
-}
withOptional : Bool -> Builder { a | optional : Available } slotCaps msg -> Builder { a | optional : Used } slotCaps msg
withOptional value_ =
    B.withAttribute (A.optional value_)


{-| Pipe form of `selected` — consumes its capability (write-once).
-}
withSelected : Bool -> Builder { a | selected : Available } slotCaps msg -> Builder { a | selected : Used } slotCaps msg
withSelected value_ =
    B.withAttribute (A.selected value_)


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


{-| Pipe form of `onChange` — consumes its capability (write-once).
-}
withOnChange : msg -> Builder { a | onChange : Available } slotCaps msg -> Builder { a | onChange : Used } slotCaps msg
withOnChange value_ =
    B.withAttribute (Ev.onChange value_)


{-| Pipe form of `onClick` — consumes its capability (write-once).
-}
withOnClick : msg -> Builder { a | onClick : Available } slotCaps msg -> Builder { a | onClick : Used } slotCaps msg
withOnClick value_ =
    B.withAttribute (Ev.onClick value_)


{-| Pipe form of the `done-icon` slot — consumes its capability (write-once).
-}
withDoneIcon : Element DoneIconSlot admittedBy msg -> Builder attrCaps { s | doneIcon : Available } msg -> Builder attrCaps { s | doneIcon : Used } msg
withDoneIcon element =
    B.withChild (El.toNode (doneIcon element))


{-| Pipe form of the `edit-icon` slot — consumes its capability (write-once).
-}
withEditIcon : Element EditIconSlot admittedBy msg -> Builder attrCaps { s | editIcon : Available } msg -> Builder attrCaps { s | editIcon : Used } msg
withEditIcon element =
    B.withChild (El.toNode (editIcon element))


{-| Pipe form of the `error` slot — consumes its capability (write-once).
-}
withError : Element ErrorSlot admittedBy msg -> Builder attrCaps { s | error : Available } msg -> Builder attrCaps { s | error : Used } msg
withError element =
    B.withChild (El.toNode (error element))


{-| Pipe form of the `error-icon` slot — consumes its capability (write-once).
-}
withErrorIcon : Element ErrorIconSlot admittedBy msg -> Builder attrCaps { s | errorIcon : Available } msg -> Builder attrCaps { s | errorIcon : Used } msg
withErrorIcon element =
    B.withChild (El.toNode (errorIcon element))


{-| Pipe form of the `hint` slot — consumes its capability (write-once).
-}
withHint : Element HintSlot admittedBy msg -> Builder attrCaps { s | hint : Available } msg -> Builder attrCaps { s | hint : Used } msg
withHint element =
    B.withChild (El.toNode (hint element))


{-| Pipe form of the `icon` slot — consumes its capability (write-once).
-}
withIcon : Element IconSlot admittedBy msg -> Builder attrCaps { s | icon : Available } msg -> Builder attrCaps { s | icon : Used } msg
withIcon element =
    B.withChild (El.toNode (icon element))


{-| Pipe form of a default-slot child (repeatable).
-}
withChild : Element Content (ChildAdmittedBy childAdm) msg -> Builder attrCaps slotCaps msg -> Builder attrCaps slotCaps msg
withChild element =
    B.withChild (El.toNode element)
