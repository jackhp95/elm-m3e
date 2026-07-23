module M3e.Fab exposing
    ( view, el, build, toElement
    , Is, Attrs, Content, CloseIconSlot, LabelSlot, ChildAdmittedBy, ActionCaps, Builder, AttrCaps, SlotCaps
    , Size, size, Type, type_, Variant, variant
    , disabled, disabledInteractive, download, extended, href, lowered, name, rel, target, value, onClick
    , closeIcon, label, child
    , withChild, withClass, withCloseIcon, withDisabled, withDisabledInteractive, withDownload, withExtended, withHref, withId, withLabel, withLowered, withName, withOnClick, withRel, withSize, withSlot, withStyle, withTarget, withType, withValue, withVariant
    )

{-| The `m3e-fab` component — strict per-component surface.

A floating action button (FAB) used to present important actions.

@docs view, el, build, toElement
@docs Is, Attrs, Content, CloseIconSlot, LabelSlot, ChildAdmittedBy, ActionCaps, Builder, AttrCaps, SlotCaps
@docs Size, size, Type, type_, Variant, variant
@docs disabled, disabledInteractive, download, extended, href, lowered, name, rel, target, value, onClick
@docs closeIcon, label, child
@docs withChild, withClass, withCloseIcon, withDisabled, withDisabledInteractive, withDownload, withExtended, withHref, withId, withLabel, withLowered, withName, withOnClick, withRel, withSize, withSlot, withStyle, withTarget, withType, withValue, withVariant

-}

import Html.Attributes
import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Value as Val exposing (Value)
import Json.Encode
import M3e.Action as Ac
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Events as Ev
import M3e.Html as H
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-fab` produces (open — composes into any slot naming it).
-}
type alias Is s =
    { s | fab : Brand }


{-| The closed attribute-capability row.
-}
type alias Attrs =
    { class : Supported
    , disabled : Supported
    , disabledInteractive : Supported
    , download : Supported
    , extended : Supported
    , href : Supported
    , id : Supported
    , lowered : Supported
    , name : Supported
    , onClick : Supported
    , rel : Supported
    , size : Supported
    , slot : Supported
    , style : Supported
    , target : Supported
    , type_ : Supported
    , value : Supported
    , variant : Supported
    }


{-| The kinds the default slot admits.
-}
type alias Content =
    { sharedIcon : Shared }


{-| The kinds the `close-icon` slot admits.
-}
type alias CloseIconSlot =
    { sharedIcon : Shared }


{-| The kinds the `label` slot admits.
-}
type alias LabelSlot =
    { sharedText : Shared }


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    { childAdm | fab : Ctx }


{-| The `size` values valid on this component (compile-tight narrowing).
-}
type alias Size =
    { large : Supported
    , medium : Supported
    , small : Supported
    }


{-| The `type_` values valid on this component (compile-tight narrowing).
-}
type alias Type =
    { button : Supported
    , reset : Supported
    , submit : Supported
    }


{-| The `variant` values valid on this component (compile-tight narrowing).
-}
type alias Variant =
    { primary : Supported
    , primaryContainer : Supported
    , secondary : Supported
    , secondaryContainer : Supported
    , surface : Supported
    , tertiary : Supported
    , tertiaryContainer : Supported
    }


{-| The behaviours this component's required action admits (see `M3e.Action`).
-}
type alias ActionCaps =
    { bottomSheetAction : Supported
    , bottomSheetTrigger : Supported
    , click : Supported
    , datepickerToggle : Supported
    , dialogAction : Supported
    , dialogTrigger : Supported
    , drawerToggle : Supported
    , fabMenuTrigger : Supported
    , link : Supported
    , menuTrigger : Supported
    , navRailToggle : Supported
    , richTooltipAction : Supported
    , stepperPrevious : Supported
    , stepperReset : Supported
    }


{-| Standard constructor: `[attributes] [children]`.
-}
view :
    List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
view =
    H.fab


{-| Required-content (and action) constructor — omissions are unwritable.
-}
el :
    { content : Element Content (ChildAdmittedBy childAdm) msg
    , ariaLabel : String
    , action : Ac.Action ActionCaps msg
    }
    -> List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el required_ attrs children =
    let
        actioned =
            Ir.fromNode (Ac.wrapContent required_.action (El.toNode required_.content))
    in
    view
        (Ir.attribute "aria-label" required_.ariaLabel :: Ac.toAttrs required_.action ++ attrs)
        (actioned :: children)


{-| The size of the button. (default: `"medium"`)
-}
size : Value Size -> Attr { c | size : Supported } msg
size value_ =
    Ir.attribute "size" (Val.toString value_)


{-| The type of the element. (default: `"button"`)
-}
type_ : Value Type -> Attr { c | type_ : Supported } msg
type_ value_ =
    Ir.attribute "type" (Val.toString value_)


{-| The appearance variant of the button. (default: `"primary-container"`)
-}
variant : Value Variant -> Attr { c | variant : Supported } msg
variant value_ =
    Ir.attribute "variant" (Val.toString value_)


{-| See `M3e.Attributes.disabled`.
-}
disabled : Bool -> Attr { c | disabled : Supported } msg
disabled =
    A.disabled


{-| See `M3e.Attributes.disabledInteractive`.
-}
disabledInteractive : Bool -> Attr { c | disabledInteractive : Supported } msg
disabledInteractive =
    A.disabledInteractive


{-| See `M3e.Attributes.download`.
-}
download : String -> Attr { c | download : Supported } msg
download =
    A.download


{-| See `M3e.Attributes.extended`.
-}
extended : Bool -> Attr { c | extended : Supported } msg
extended =
    A.extended


{-| See `M3e.Attributes.href`.
-}
href : String -> Attr { c | href : Supported } msg
href =
    A.href


{-| See `M3e.Attributes.lowered`.
-}
lowered : Bool -> Attr { c | lowered : Supported } msg
lowered =
    A.lowered


{-| The name of the element, submitted as a pair with the element's `value` as part of form data, when the element is used to submit a form.
-}
name : String -> Attr { c | name : Supported } msg
name value_ =
    Ir.attribute "name" value_


{-| See `M3e.Attributes.rel`.
-}
rel : String -> Attr { c | rel : Supported } msg
rel =
    A.rel


{-| See `M3e.Attributes.target`.
-}
target : String -> Attr { c | target : Supported } msg
target =
    A.target


{-| See `M3e.Attributes.value`.
-}
value : String -> Attr { c | value : Supported } msg
value =
    A.value


{-| See `M3e.Events.onClick`.
-}
onClick : msg -> Attr { c | onClick : Supported } msg
onClick =
    Ev.onClick


{-| Place an element into the named `close-icon` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
closeIcon : Element CloseIconSlot admittedBy msg -> Element free freeAdmittedBy msg
closeIcon element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "close-icon") (El.toNode element))


{-| Place an element into the named `label` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
label : Element LabelSlot admittedBy msg -> Element free freeAdmittedBy msg
label element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "label") (El.toNode element))


{-| Place a pre-built element into the default (unnamed) slot (input
constrained to the slot's kinds; output row free so it composes into the
child list). The list-form sibling of the builder's `withChild`.
-}
child : Element Content admittedBy msg -> Element free freeAdmittedBy msg
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
    , disabled : Available
    , disabledInteractive : Available
    , download : Available
    , extended : Available
    , href : Available
    , id : Available
    , lowered : Available
    , name : Available
    , onClick : Available
    , rel : Available
    , size : Available
    , slot : Available
    , style : Available
    , target : Available
    , type_ : Available
    , value : Available
    , variant : Available
    }


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    { closeIcon : Available
    , label : Available
    }


{-| Seed the pipe-builder.
-}
build :
    { content : Element Content (ChildAdmittedBy childAdm) msg
    , ariaLabel : String
    , action : Ac.Action ActionCaps msg
    }
    -> Builder AttrCaps SlotCaps msg
build required_ =
    B.init "m3e-fab" (Ir.attribute "aria-label" required_.ariaLabel :: Ac.toAttrs required_.action) [ Ac.wrapContent required_.action (El.toNode required_.content) ]


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


{-| Pipe form of `disabledInteractive` — consumes its capability (write-once).
-}
withDisabledInteractive : Bool -> Builder { a | disabledInteractive : Available } slotCaps msg -> Builder { a | disabledInteractive : Used } slotCaps msg
withDisabledInteractive value_ =
    B.withAttribute (A.disabledInteractive value_)


{-| Pipe form of `download` — consumes its capability (write-once).
-}
withDownload : String -> Builder { a | download : Available } slotCaps msg -> Builder { a | download : Used } slotCaps msg
withDownload value_ =
    B.withAttribute (A.download value_)


{-| Pipe form of `extended` — consumes its capability (write-once).
-}
withExtended : Bool -> Builder { a | extended : Available } slotCaps msg -> Builder { a | extended : Used } slotCaps msg
withExtended value_ =
    B.withAttribute (A.extended value_)


{-| Pipe form of `href` — consumes its capability (write-once).
-}
withHref : String -> Builder { a | href : Available } slotCaps msg -> Builder { a | href : Used } slotCaps msg
withHref value_ =
    B.withAttribute (A.href value_)


{-| Pipe form of `lowered` — consumes its capability (write-once).
-}
withLowered : Bool -> Builder { a | lowered : Available } slotCaps msg -> Builder { a | lowered : Used } slotCaps msg
withLowered value_ =
    B.withAttribute (A.lowered value_)


{-| Pipe form of `name` — consumes its capability (write-once).
-}
withName : String -> Builder { a | name : Available } slotCaps msg -> Builder { a | name : Used } slotCaps msg
withName value_ =
    B.withAttribute (Ir.attribute "name" value_)


{-| Pipe form of `rel` — consumes its capability (write-once).
-}
withRel : String -> Builder { a | rel : Available } slotCaps msg -> Builder { a | rel : Used } slotCaps msg
withRel value_ =
    B.withAttribute (A.rel value_)


{-| Pipe form of `size` — consumes its capability (write-once).
-}
withSize : Value Size -> Builder { a | size : Available } slotCaps msg -> Builder { a | size : Used } slotCaps msg
withSize value_ =
    B.withAttribute (size value_)


{-| Pipe form of `target` — consumes its capability (write-once).
-}
withTarget : String -> Builder { a | target : Available } slotCaps msg -> Builder { a | target : Used } slotCaps msg
withTarget value_ =
    B.withAttribute (A.target value_)


{-| Pipe form of `type_` — consumes its capability (write-once).
-}
withType : Value Type -> Builder { a | type_ : Available } slotCaps msg -> Builder { a | type_ : Used } slotCaps msg
withType value_ =
    B.withAttribute (type_ value_)


{-| Pipe form of `value` — consumes its capability (write-once).
-}
withValue : String -> Builder { a | value : Available } slotCaps msg -> Builder { a | value : Used } slotCaps msg
withValue value_ =
    B.withAttribute (A.value value_)


{-| Pipe form of `variant` — consumes its capability (write-once).
-}
withVariant : Value Variant -> Builder { a | variant : Available } slotCaps msg -> Builder { a | variant : Used } slotCaps msg
withVariant value_ =
    B.withAttribute (variant value_)


{-| Pipe form of `onClick` — consumes its capability (write-once).
-}
withOnClick : msg -> Builder { a | onClick : Available } slotCaps msg -> Builder { a | onClick : Used } slotCaps msg
withOnClick value_ =
    B.withAttribute (Ev.onClick value_)


{-| Pipe form of the `close-icon` slot — consumes its capability (write-once).
-}
withCloseIcon : Element CloseIconSlot admittedBy msg -> Builder attrCaps { s | closeIcon : Available } msg -> Builder attrCaps { s | closeIcon : Used } msg
withCloseIcon element =
    B.withChild (El.toNode (closeIcon element))


{-| Pipe form of the `label` slot — consumes its capability (write-once).
-}
withLabel : Element LabelSlot admittedBy msg -> Builder attrCaps { s | label : Available } msg -> Builder attrCaps { s | label : Used } msg
withLabel element =
    B.withChild (El.toNode (label element))


{-| Pipe form of a default-slot child (repeatable).
-}
withChild : Element Content (ChildAdmittedBy childAdm) msg -> Builder attrCaps slotCaps msg -> Builder attrCaps slotCaps msg
withChild element =
    B.withChild (El.toNode element)
