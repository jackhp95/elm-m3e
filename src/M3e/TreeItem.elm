module M3e.TreeItem exposing
    ( view, el, build, toElement
    , Is, Attrs, Content, IconSlot, LabelSlot, OpenToggleIconSlot, SelectedIconSlot, ToggleIconSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , disabled, indeterminate, open, selected, onOpening, onOpened, onClosing, onClosed, onClick
    , icon, label, openToggleIcon, selectedIcon, toggleIcon
    , withChild, withClass, withDisabled, withIcon, withId, withIndeterminate, withLabel, withOnClick, withOnClosed, withOnClosing, withOnOpened, withOnOpening, withOpen, withOpenToggleIcon, withSelected, withSelectedIcon, withSlot, withStyle, withToggleIcon
    )

{-| The `m3e-tree-item` component — strict per-component surface.

An expandable item in a tree.

@docs view, el, build, toElement
@docs Is, Attrs, Content, IconSlot, LabelSlot, OpenToggleIconSlot, SelectedIconSlot, ToggleIconSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs disabled, indeterminate, open, selected, onOpening, onOpened, onClosing, onClosed, onClick
@docs icon, label, openToggleIcon, selectedIcon, toggleIcon
@docs withChild, withClass, withDisabled, withIcon, withId, withIndeterminate, withLabel, withOnClick, withOnClosed, withOnClosing, withOnOpened, withOnOpening, withOpen, withOpenToggleIcon, withSelected, withSelectedIcon, withSlot, withStyle, withToggleIcon

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


{-| The kind row `m3e-tree-item` produces (open — composes into any slot naming it).
-}
type alias Is s =
    { s | treeItem : Brand }


{-| The closed attribute-capability row.
-}
type alias Attrs =
    { class : Supported
    , disabled : Supported
    , id : Supported
    , indeterminate : Supported
    , onClick : Supported
    , onClosed : Supported
    , onClosing : Supported
    , onOpened : Supported
    , onOpening : Supported
    , open : Supported
    , selected : Supported
    , slot : Supported
    , style : Supported
    }


{-| The kinds the default slot admits.
-}
type alias Content =
    { treeItem : Brand }


{-| The kinds the `icon` slot admits.
-}
type alias IconSlot =
    { sharedIcon : Shared }


{-| The kinds the `label` slot admits.
-}
type alias LabelSlot =
    { sharedLink : Shared
    , sharedText : Shared
    }


{-| The kinds the `open-toggle-icon` slot admits.
-}
type alias OpenToggleIconSlot =
    { sharedIcon : Shared }


{-| The kinds the `selected-icon` slot admits.
-}
type alias SelectedIconSlot =
    { sharedIcon : Shared }


{-| The kinds the `toggle-icon` slot admits.
-}
type alias ToggleIconSlot =
    { sharedIcon : Shared }


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    { childAdm | treeItem : Ctx }


{-| Standard constructor: `[attributes] [children]`.
-}
view :
    List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
view =
    H.treeItem


{-| Required-content (and action) constructor — omissions are unwritable.
-}
el :
    { label : Element LabelSlot (ChildAdmittedBy childAdm) msg }
    -> List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el required_ attrs children =
    view attrs (Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "label") (El.toNode required_.label)) :: children)


{-| See `M3e.Attributes.disabled`.
-}
disabled : Bool -> Attr { c | disabled : Supported } msg
disabled =
    A.disabled


{-| See `M3e.Attributes.indeterminate`.
-}
indeterminate : Bool -> Attr { c | indeterminate : Supported } msg
indeterminate =
    A.indeterminate


{-| See `M3e.Attributes.open`.
-}
open : Bool -> Attr { c | open : Supported } msg
open =
    A.open


{-| See `M3e.Attributes.selected`.
-}
selected : Bool -> Attr { c | selected : Supported } msg
selected =
    A.selected


{-| See `M3e.Events.onOpening`.
-}
onOpening : msg -> Attr { c | onOpening : Supported } msg
onOpening =
    Ev.onOpening


{-| See `M3e.Events.onOpened`.
-}
onOpened : msg -> Attr { c | onOpened : Supported } msg
onOpened =
    Ev.onOpened


{-| See `M3e.Events.onClosing`.
-}
onClosing : msg -> Attr { c | onClosing : Supported } msg
onClosing =
    Ev.onClosing


{-| See `M3e.Events.onClosed`.
-}
onClosed : msg -> Attr { c | onClosed : Supported } msg
onClosed =
    Ev.onClosed


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


{-| Place an element into the named `label` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
label : Element LabelSlot admittedBy msg -> Element free freeAdmittedBy msg
label element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "label") (El.toNode element))


{-| Place an element into the named `open-toggle-icon` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
openToggleIcon : Element OpenToggleIconSlot admittedBy msg -> Element free freeAdmittedBy msg
openToggleIcon element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "open-toggle-icon") (El.toNode element))


{-| Place an element into the named `selected-icon` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
selectedIcon : Element SelectedIconSlot admittedBy msg -> Element free freeAdmittedBy msg
selectedIcon element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "selected-icon") (El.toNode element))


{-| Place an element into the named `toggle-icon` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
toggleIcon : Element ToggleIconSlot admittedBy msg -> Element free freeAdmittedBy msg
toggleIcon element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "toggle-icon") (El.toNode element))


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
    , disabled : Available
    , id : Available
    , indeterminate : Available
    , onClick : Available
    , onClosed : Available
    , onClosing : Available
    , onOpened : Available
    , onOpening : Available
    , open : Available
    , selected : Available
    , slot : Available
    , style : Available
    }


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    { icon : Available
    , label : Available
    , openToggleIcon : Available
    , selectedIcon : Available
    , toggleIcon : Available
    }


{-| Seed the pipe-builder.
-}
build :
    { label : Element LabelSlot (ChildAdmittedBy childAdm) msg }
    -> Builder AttrCaps SlotCaps msg
build required_ =
    B.init "m3e-tree-item" [] [ El.toNode (label required_.label) ]


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


{-| Pipe form of `disabled` — consumes its capability (write-once).
-}
withDisabled : Bool -> Builder { a | disabled : Available } slotCaps msg -> Builder { a | disabled : Used } slotCaps msg
withDisabled value_ =
    B.withAttribute (A.disabled value_)


{-| Pipe form of `indeterminate` — consumes its capability (write-once).
-}
withIndeterminate : Bool -> Builder { a | indeterminate : Available } slotCaps msg -> Builder { a | indeterminate : Used } slotCaps msg
withIndeterminate value_ =
    B.withAttribute (A.indeterminate value_)


{-| Pipe form of `open` — consumes its capability (write-once).
-}
withOpen : Bool -> Builder { a | open : Available } slotCaps msg -> Builder { a | open : Used } slotCaps msg
withOpen value_ =
    B.withAttribute (A.open value_)


{-| Pipe form of `selected` — consumes its capability (write-once).
-}
withSelected : Bool -> Builder { a | selected : Available } slotCaps msg -> Builder { a | selected : Used } slotCaps msg
withSelected value_ =
    B.withAttribute (A.selected value_)


{-| Pipe form of `onOpening` — consumes its capability (write-once).
-}
withOnOpening : msg -> Builder { a | onOpening : Available } slotCaps msg -> Builder { a | onOpening : Used } slotCaps msg
withOnOpening value_ =
    B.withAttribute (Ev.onOpening value_)


{-| Pipe form of `onOpened` — consumes its capability (write-once).
-}
withOnOpened : msg -> Builder { a | onOpened : Available } slotCaps msg -> Builder { a | onOpened : Used } slotCaps msg
withOnOpened value_ =
    B.withAttribute (Ev.onOpened value_)


{-| Pipe form of `onClosing` — consumes its capability (write-once).
-}
withOnClosing : msg -> Builder { a | onClosing : Available } slotCaps msg -> Builder { a | onClosing : Used } slotCaps msg
withOnClosing value_ =
    B.withAttribute (Ev.onClosing value_)


{-| Pipe form of `onClosed` — consumes its capability (write-once).
-}
withOnClosed : msg -> Builder { a | onClosed : Available } slotCaps msg -> Builder { a | onClosed : Used } slotCaps msg
withOnClosed value_ =
    B.withAttribute (Ev.onClosed value_)


{-| Pipe form of `onClick` — consumes its capability (write-once).
-}
withOnClick : msg -> Builder { a | onClick : Available } slotCaps msg -> Builder { a | onClick : Used } slotCaps msg
withOnClick value_ =
    B.withAttribute (Ev.onClick value_)


{-| Pipe form of the `icon` slot — consumes its capability (write-once).
-}
withIcon : Element IconSlot admittedBy msg -> Builder attrCaps { s | icon : Available } msg -> Builder attrCaps { s | icon : Used } msg
withIcon element =
    B.withChild (El.toNode (icon element))


{-| Pipe form of the `label` slot — consumes its capability (write-once).
-}
withLabel : Element LabelSlot admittedBy msg -> Builder attrCaps { s | label : Available } msg -> Builder attrCaps { s | label : Used } msg
withLabel element =
    B.withChild (El.toNode (label element))


{-| Pipe form of the `open-toggle-icon` slot — consumes its capability (write-once).
-}
withOpenToggleIcon : Element OpenToggleIconSlot admittedBy msg -> Builder attrCaps { s | openToggleIcon : Available } msg -> Builder attrCaps { s | openToggleIcon : Used } msg
withOpenToggleIcon element =
    B.withChild (El.toNode (openToggleIcon element))


{-| Pipe form of the `selected-icon` slot — consumes its capability (write-once).
-}
withSelectedIcon : Element SelectedIconSlot admittedBy msg -> Builder attrCaps { s | selectedIcon : Available } msg -> Builder attrCaps { s | selectedIcon : Used } msg
withSelectedIcon element =
    B.withChild (El.toNode (selectedIcon element))


{-| Pipe form of the `toggle-icon` slot — consumes its capability (write-once).
-}
withToggleIcon : Element ToggleIconSlot admittedBy msg -> Builder attrCaps { s | toggleIcon : Available } msg -> Builder attrCaps { s | toggleIcon : Used } msg
withToggleIcon element =
    B.withChild (El.toNode (toggleIcon element))


{-| Pipe form of a default-slot child (repeatable).
-}
withChild : Element Content (ChildAdmittedBy childAdm) msg -> Builder attrCaps slotCaps msg -> Builder attrCaps slotCaps msg
withChild element =
    B.withChild (El.toNode element)
