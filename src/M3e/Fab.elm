module M3e.Fab exposing
    ( view, el, build, toElement
    , Is, Attrs, Content, CloseIconSlot, LabelSlot, ChildAdmittedBy, ActionCaps, Builder, AttrCaps, SlotCaps
    , Size, size, Type, type_, Variant, variant
    , disabled, disabledInteractive, download, extended, href, lowered, name, rel, target, value, onClick
    , closeIcon, label
    , withAriaLabel, withChild, withClass, withCloseIcon, withDisabled, withDisabledInteractive, withDownload, withExtended, withHref, withId, withLabel, withLowered, withName, withOnClick, withRel, withSize, withSlot, withStyle, withTarget, withType, withValue, withVariant
    )

{-| The `m3e-fab` component — strict per-component surface.

A floating action button (FAB) used to present important actions.

@docs view, el, build, toElement
@docs Is, Attrs, Content, CloseIconSlot, LabelSlot, ChildAdmittedBy, ActionCaps, Builder, AttrCaps, SlotCaps
@docs Size, size, Type, type_, Variant, variant
@docs disabled, disabledInteractive, download, extended, href, lowered, name, rel, target, value, onClick
@docs closeIcon, label
@docs withAriaLabel, withChild, withClass, withCloseIcon, withDisabled, withDisabledInteractive, withDownload, withExtended, withHref, withId, withLabel, withLowered, withName, withOnClick, withRel, withSize, withSlot, withStyle, withTarget, withType, withValue, withVariant

-}

import Html.Attributes
import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Node exposing (Node)
import HtmlIr.Value exposing (Value)
import Json.Encode
import M3e.Action
import M3e.Attributes
import M3e.Events
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-fab` produces (open — composes into any slot naming it).
-}
type alias Is s =
    { s | fab : Brand }


{-| The closed attribute-capability row.
-}
type alias Attrs =
    { ariaLabel : Supported
    , class : Supported
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
view attrs children =
    Ir.fromNode (Ir.node "m3e-fab" attrs (List.map HtmlIr.Element.toNode children))


{-| Required-content (and action) constructor — omissions are unwritable.
-}
el :
    { content : Element Content (ChildAdmittedBy childAdm) msg
    , ariaLabel : String
    , action : M3e.Action.Action ActionCaps msg
    }
    -> List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el required_ attrs children =
    let
        actioned =
            Ir.fromNode (M3e.Action.wrapContent required_.action (HtmlIr.Element.toNode required_.content))
    in
    Ir.fromNode
        (Ir.node "m3e-fab"
            (M3e.Attributes.ariaLabel required_.ariaLabel :: M3e.Action.toAttrs required_.action ++ attrs)
            (List.map HtmlIr.Element.toNode (actioned :: children))
        )


{-| Narrowed value setter for `size`. Tokens come from `M3e.Values`.
-}
size : Value Size -> Attr { c | size : Supported } msg
size value_ =
    Ir.attribute "size" (HtmlIr.Value.toString value_)


{-| Narrowed value setter for `type_`. Tokens come from `M3e.Values`.
-}
type_ : Value Type -> Attr { c | type_ : Supported } msg
type_ value_ =
    Ir.attribute "type" (HtmlIr.Value.toString value_)


{-| Narrowed value setter for `variant`. Tokens come from `M3e.Values`.
-}
variant : Value Variant -> Attr { c | variant : Supported } msg
variant value_ =
    Ir.attribute "variant" (HtmlIr.Value.toString value_)


{-| See `M3e.Attributes.disabled`.
-}
disabled : Bool -> Attr { c | disabled : Supported } msg
disabled =
    M3e.Attributes.disabled


{-| See `M3e.Attributes.disabledInteractive`.
-}
disabledInteractive : Bool -> Attr { c | disabledInteractive : Supported } msg
disabledInteractive =
    M3e.Attributes.disabledInteractive


{-| See `M3e.Attributes.download`.
-}
download : String -> Attr { c | download : Supported } msg
download =
    M3e.Attributes.download


{-| See `M3e.Attributes.extended`.
-}
extended : Bool -> Attr { c | extended : Supported } msg
extended =
    M3e.Attributes.extended


{-| See `M3e.Attributes.href`.
-}
href : String -> Attr { c | href : Supported } msg
href =
    M3e.Attributes.href


{-| See `M3e.Attributes.lowered`.
-}
lowered : Bool -> Attr { c | lowered : Supported } msg
lowered =
    M3e.Attributes.lowered


{-| The `name` attribute (this component's type differs from the shared canonical).
-}
name : String -> Attr { c | name : Supported } msg
name value_ =
    Ir.attribute "name" value_


{-| See `M3e.Attributes.rel`.
-}
rel : String -> Attr { c | rel : Supported } msg
rel =
    M3e.Attributes.rel


{-| See `M3e.Attributes.target`.
-}
target : String -> Attr { c | target : Supported } msg
target =
    M3e.Attributes.target


{-| See `M3e.Attributes.value`.
-}
value : String -> Attr { c | value : Supported } msg
value =
    M3e.Attributes.value


{-| See `M3e.Events.onClick`.
-}
onClick : msg -> Attr { c | onClick : Supported } msg
onClick =
    M3e.Events.onClick


{-| Place an element into the named `close-icon` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
closeIcon : Element CloseIconSlot admittedBy msg -> Element free freeAdmittedBy msg
closeIcon element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "close-icon") (HtmlIr.Element.toNode element))


{-| Place an element into the named `label` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
label : Element LabelSlot admittedBy msg -> Element free freeAdmittedBy msg
label element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "label") (HtmlIr.Element.toNode element))


{-| The pipe-builder: capabilities are consumed Available→Used, so writing
a singular attribute or slot twice is unwritable.
-}
type Builder attrCaps slotCaps msg
    = Builder { attrs : List (Attr Attrs msg), children : List (Node msg) }


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    { ariaLabel : Available
    , class : Available
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
    , action : M3e.Action.Action ActionCaps msg
    }
    -> Builder AttrCaps SlotCaps msg
build required_ =
    Builder { attrs = M3e.Attributes.ariaLabel required_.ariaLabel :: M3e.Action.toAttrs required_.action, children = [ M3e.Action.wrapContent required_.action (HtmlIr.Element.toNode required_.content) ] }


{-| Close the pipe-builder.
-}
toElement : Builder attrCaps slotCaps msg -> Element (Is s) admittedBy msg
toElement (Builder b) =
    Ir.fromNode (Ir.node "m3e-fab" (List.reverse b.attrs) (List.reverse b.children))


{-| Pipe form of `ariaLabel` — consumes its capability (write-once).
-}
withAriaLabel : String -> Builder { a | ariaLabel : Available } slotCaps msg -> Builder { a | ariaLabel : Used } slotCaps msg
withAriaLabel value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.ariaLabel value_ :: b.attrs }


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


{-| Pipe form of `disabled` — consumes its capability (write-once).
-}
withDisabled : Bool -> Builder { a | disabled : Available } slotCaps msg -> Builder { a | disabled : Used } slotCaps msg
withDisabled value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.disabled value_ :: b.attrs }


{-| Pipe form of `disabledInteractive` — consumes its capability (write-once).
-}
withDisabledInteractive : Bool -> Builder { a | disabledInteractive : Available } slotCaps msg -> Builder { a | disabledInteractive : Used } slotCaps msg
withDisabledInteractive value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.disabledInteractive value_ :: b.attrs }


{-| Pipe form of `download` — consumes its capability (write-once).
-}
withDownload : String -> Builder { a | download : Available } slotCaps msg -> Builder { a | download : Used } slotCaps msg
withDownload value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.download value_ :: b.attrs }


{-| Pipe form of `extended` — consumes its capability (write-once).
-}
withExtended : Bool -> Builder { a | extended : Available } slotCaps msg -> Builder { a | extended : Used } slotCaps msg
withExtended value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.extended value_ :: b.attrs }


{-| Pipe form of `href` — consumes its capability (write-once).
-}
withHref : String -> Builder { a | href : Available } slotCaps msg -> Builder { a | href : Used } slotCaps msg
withHref value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.href value_ :: b.attrs }


{-| Pipe form of `lowered` — consumes its capability (write-once).
-}
withLowered : Bool -> Builder { a | lowered : Available } slotCaps msg -> Builder { a | lowered : Used } slotCaps msg
withLowered value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.lowered value_ :: b.attrs }


{-| Pipe form of `name` — consumes its capability (write-once).
-}
withName : String -> Builder { a | name : Available } slotCaps msg -> Builder { a | name : Used } slotCaps msg
withName value_ (Builder b) =
    Builder { b | attrs = Ir.attribute "name" value_ :: b.attrs }


{-| Pipe form of `rel` — consumes its capability (write-once).
-}
withRel : String -> Builder { a | rel : Available } slotCaps msg -> Builder { a | rel : Used } slotCaps msg
withRel value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.rel value_ :: b.attrs }


{-| Pipe form of `size` — consumes its capability (write-once).
-}
withSize : Value Size -> Builder { a | size : Available } slotCaps msg -> Builder { a | size : Used } slotCaps msg
withSize value_ (Builder b) =
    Builder { b | attrs = size value_ :: b.attrs }


{-| Pipe form of `target` — consumes its capability (write-once).
-}
withTarget : String -> Builder { a | target : Available } slotCaps msg -> Builder { a | target : Used } slotCaps msg
withTarget value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.target value_ :: b.attrs }


{-| Pipe form of `type_` — consumes its capability (write-once).
-}
withType : Value Type -> Builder { a | type_ : Available } slotCaps msg -> Builder { a | type_ : Used } slotCaps msg
withType value_ (Builder b) =
    Builder { b | attrs = type_ value_ :: b.attrs }


{-| Pipe form of `value` — consumes its capability (write-once).
-}
withValue : String -> Builder { a | value : Available } slotCaps msg -> Builder { a | value : Used } slotCaps msg
withValue value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.value value_ :: b.attrs }


{-| Pipe form of `variant` — consumes its capability (write-once).
-}
withVariant : Value Variant -> Builder { a | variant : Available } slotCaps msg -> Builder { a | variant : Used } slotCaps msg
withVariant value_ (Builder b) =
    Builder { b | attrs = variant value_ :: b.attrs }


{-| Pipe form of `onClick` — consumes its capability (write-once).
-}
withOnClick : msg -> Builder { a | onClick : Available } slotCaps msg -> Builder { a | onClick : Used } slotCaps msg
withOnClick value_ (Builder b) =
    Builder { b | attrs = M3e.Events.onClick value_ :: b.attrs }


{-| Pipe form of the `close-icon` slot — consumes its capability (write-once).
-}
withCloseIcon : Element CloseIconSlot admittedBy msg -> Builder attrCaps { s | closeIcon : Available } msg -> Builder attrCaps { s | closeIcon : Used } msg
withCloseIcon element (Builder b) =
    Builder { b | children = HtmlIr.Element.toNode (closeIcon element) :: b.children }


{-| Pipe form of the `label` slot — consumes its capability (write-once).
-}
withLabel : Element LabelSlot admittedBy msg -> Builder attrCaps { s | label : Available } msg -> Builder attrCaps { s | label : Used } msg
withLabel element (Builder b) =
    Builder { b | children = HtmlIr.Element.toNode (label element) :: b.children }


{-| Pipe form of a default-slot child (repeatable).
-}
withChild : Element Content (ChildAdmittedBy childAdm) msg -> Builder attrCaps slotCaps msg -> Builder attrCaps slotCaps msg
withChild element (Builder b) =
    Builder { b | children = HtmlIr.Element.toNode element :: b.children }
