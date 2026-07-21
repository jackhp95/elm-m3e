module M3e.IconButton exposing
    ( view, el, build, toElement
    , Is, Attrs, Content, SelectedSlot, ChildAdmittedBy, ActionCaps, Builder, AttrCaps, SlotCaps
    , Shape, shape, Size, size, Type, type_, Variant, variant, Width, width
    , disabled, disabledInteractive, download, href, name, rel, target, toggle, value, onBeforeinput, onInput, onChange, onClick
    , selected
    , withChild, withClass, withDisabled, withDisabledInteractive, withDownload, withHref, withId, withName, withOnBeforeinput, withOnChange, withOnClick, withOnInput, withRel, withSelected, withSelectedSlot, withShape, withSize, withSlot, withStyle, withTarget, withToggle, withType, withValue, withVariant, withWidth
    )

{-| The `m3e-icon-button` component — strict per-component surface.

An icon button users interact with to perform a supplementary action.

@docs view, el, build, toElement
@docs Is, Attrs, Content, SelectedSlot, ChildAdmittedBy, ActionCaps, Builder, AttrCaps, SlotCaps
@docs Shape, shape, Size, size, Type, type_, Variant, variant, Width, width
@docs disabled, disabledInteractive, download, href, name, rel, target, toggle, value, onBeforeinput, onInput, onChange, onClick
@docs selected
@docs withChild, withClass, withDisabled, withDisabledInteractive, withDownload, withHref, withId, withName, withOnBeforeinput, withOnChange, withOnClick, withOnInput, withRel, withSelected, withSelectedSlot, withShape, withSize, withSlot, withStyle, withTarget, withToggle, withType, withValue, withVariant, withWidth

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Node exposing (Node)
import HtmlIr.Value exposing (Value)
import M3e.Action
import M3e.Attributes
import M3e.Events
import M3e.Kind exposing (Available, Brand, Ctx, Used)
import M3e.Values


{-| The kind row `m3e-icon-button` produces (open — composes into any slot naming it).
-}
type alias Is s =
    { s | iconButton : Brand }


{-| The closed attribute-capability row.
-}
type alias Attrs =
    { class : Supported
    , disabled : Supported
    , disabledInteractive : Supported
    , download : Supported
    , href : Supported
    , id : Supported
    , name : Supported
    , onBeforeinput : Supported
    , onChange : Supported
    , onClick : Supported
    , onInput : Supported
    , rel : Supported
    , selected : Supported
    , shape : Supported
    , size : Supported
    , slot : Supported
    , style : Supported
    , target : Supported
    , toggle : Supported
    , type_ : Supported
    , value : Supported
    , variant : Supported
    , width : Supported
    }


{-| The kinds the default slot admits.
-}
type alias Content =
    { bottomSheetAction : Brand
    , bottomSheetTrigger : Brand
    , datepickerToggle : Brand
    , dialogAction : Brand
    , dialogTrigger : Brand
    , drawerToggle : Brand
    , fabMenuTrigger : Brand
    , menuTrigger : Brand
    , navRailToggle : Brand
    , richTooltipAction : Brand
    , sharedIcon : Shared
    , stepperNext : Brand
    , stepperPrevious : Brand
    , stepperReset : Brand
    }


{-| The kinds the `selected` slot admits.
-}
type alias SelectedSlot =
    { sharedIcon : Shared }


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    { childAdm | iconButton : Ctx }


{-| The `shape` values valid on this component (compile-tight narrowing).
-}
type alias Shape =
    { rounded : Supported
    , square : Supported
    }


{-| The `size` values valid on this component (compile-tight narrowing).
-}
type alias Size =
    { extraLarge : Supported
    , extraSmall : Supported
    , large : Supported
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
    { filled : Supported
    , outlined : Supported
    , standard : Supported
    , tonal : Supported
    }


{-| The `width` values valid on this component (compile-tight narrowing).
-}
type alias Width =
    { default : Supported
    , narrow : Supported
    , wide : Supported
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
    , stepperNext : Supported
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
    Ir.fromNode (Ir.node "m3e-icon-button" attrs (List.map HtmlIr.Element.toNode children))


{-| Required-content (and action) constructor — omissions are unwritable.
-}
el :
    { content : Element Content (ChildAdmittedBy childAdm) msg
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
        (Ir.node "m3e-icon-button"
            (M3e.Action.toAttrs required_.action ++ attrs)
            (List.map HtmlIr.Element.toNode (actioned :: children))
        )


{-| Narrowed value setter for `shape`. Tokens come from `M3e.Values`.
-}
shape : Value Shape -> Attr { c | shape : Supported } msg
shape value_ =
    Ir.attribute "shape" (HtmlIr.Value.toString value_)


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


{-| Narrowed value setter for `width`. Tokens come from `M3e.Values`.
-}
width : Value Width -> Attr { c | width : Supported } msg
width value_ =
    Ir.attribute "width" (HtmlIr.Value.toString value_)


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


{-| See `M3e.Attributes.href`.
-}
href : String -> Attr { c | href : Supported } msg
href =
    M3e.Attributes.href


{-| See `M3e.Attributes.name`.
-}
name : Value M3e.Values.Name -> Attr { c | name : Supported } msg
name =
    M3e.Attributes.name


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


{-| See `M3e.Attributes.toggle`.
-}
toggle : Bool -> Attr { c | toggle : Supported } msg
toggle =
    M3e.Attributes.toggle


{-| See `M3e.Attributes.value`.
-}
value : String -> Attr { c | value : Supported } msg
value =
    M3e.Attributes.value


{-| See `M3e.Events.onBeforeinput`.
-}
onBeforeinput : msg -> Attr { c | onBeforeinput : Supported } msg
onBeforeinput =
    M3e.Events.onBeforeinput


{-| See `M3e.Events.onInput`.
-}
onInput : msg -> Attr { c | onInput : Supported } msg
onInput =
    M3e.Events.onInput


{-| See `M3e.Events.onChange`.
-}
onChange : msg -> Attr { c | onChange : Supported } msg
onChange =
    M3e.Events.onChange


{-| See `M3e.Events.onClick`.
-}
onClick : msg -> Attr { c | onClick : Supported } msg
onClick =
    M3e.Events.onClick


{-| Place an element into the named `selected` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
selected : Element SelectedSlot admittedBy msg -> Element free freeAdmittedBy msg
selected element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "selected") (HtmlIr.Element.toNode element))


{-| The pipe-builder: capabilities are consumed Available→Used, so writing
a singular attribute or slot twice is unwritable.
-}
type Builder attrCaps slotCaps msg
    = Builder { attrs : List (Attr Attrs msg), children : List (Node msg) }


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    { class : Available
    , disabled : Available
    , disabledInteractive : Available
    , download : Available
    , href : Available
    , id : Available
    , name : Available
    , onBeforeinput : Available
    , onChange : Available
    , onClick : Available
    , onInput : Available
    , rel : Available
    , selected : Available
    , shape : Available
    , size : Available
    , slot : Available
    , style : Available
    , target : Available
    , toggle : Available
    , type_ : Available
    , value : Available
    , variant : Available
    , width : Available
    }


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    { selected : Available
    }


{-| Seed the pipe-builder.
-}
build :
    { content : Element Content (ChildAdmittedBy childAdm) msg
    , action : M3e.Action.Action ActionCaps msg
    }
    -> Builder AttrCaps SlotCaps msg
build required_ =
    Builder { attrs = M3e.Action.toAttrs required_.action, children = [ M3e.Action.wrapContent required_.action (HtmlIr.Element.toNode required_.content) ] }


{-| Close the pipe-builder.
-}
toElement : Builder attrCaps slotCaps msg -> Element (Is s) admittedBy msg
toElement (Builder b) =
    Ir.fromNode (Ir.node "m3e-icon-button" (List.reverse b.attrs) (List.reverse b.children))


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


{-| Pipe form of `href` — consumes its capability (write-once).
-}
withHref : String -> Builder { a | href : Available } slotCaps msg -> Builder { a | href : Used } slotCaps msg
withHref value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.href value_ :: b.attrs }


{-| Pipe form of `name` — consumes its capability (write-once).
-}
withName : Value M3e.Values.Name -> Builder { a | name : Available } slotCaps msg -> Builder { a | name : Used } slotCaps msg
withName value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.name value_ :: b.attrs }


{-| Pipe form of `rel` — consumes its capability (write-once).
-}
withRel : String -> Builder { a | rel : Available } slotCaps msg -> Builder { a | rel : Used } slotCaps msg
withRel value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.rel value_ :: b.attrs }


{-| Pipe form of `selected` — consumes its capability (write-once).
-}
withSelected : Bool -> Builder { a | selected : Available } slotCaps msg -> Builder { a | selected : Used } slotCaps msg
withSelected value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.selected value_ :: b.attrs }


{-| Pipe form of `shape` — consumes its capability (write-once).
-}
withShape : Value Shape -> Builder { a | shape : Available } slotCaps msg -> Builder { a | shape : Used } slotCaps msg
withShape value_ (Builder b) =
    Builder { b | attrs = shape value_ :: b.attrs }


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


{-| Pipe form of `toggle` — consumes its capability (write-once).
-}
withToggle : Bool -> Builder { a | toggle : Available } slotCaps msg -> Builder { a | toggle : Used } slotCaps msg
withToggle value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.toggle value_ :: b.attrs }


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


{-| Pipe form of `width` — consumes its capability (write-once).
-}
withWidth : Value Width -> Builder { a | width : Available } slotCaps msg -> Builder { a | width : Used } slotCaps msg
withWidth value_ (Builder b) =
    Builder { b | attrs = width value_ :: b.attrs }


{-| Pipe form of `onBeforeinput` — consumes its capability (write-once).
-}
withOnBeforeinput : msg -> Builder { a | onBeforeinput : Available } slotCaps msg -> Builder { a | onBeforeinput : Used } slotCaps msg
withOnBeforeinput value_ (Builder b) =
    Builder { b | attrs = M3e.Events.onBeforeinput value_ :: b.attrs }


{-| Pipe form of `onInput` — consumes its capability (write-once).
-}
withOnInput : msg -> Builder { a | onInput : Available } slotCaps msg -> Builder { a | onInput : Used } slotCaps msg
withOnInput value_ (Builder b) =
    Builder { b | attrs = M3e.Events.onInput value_ :: b.attrs }


{-| Pipe form of `onChange` — consumes its capability (write-once).
-}
withOnChange : msg -> Builder { a | onChange : Available } slotCaps msg -> Builder { a | onChange : Used } slotCaps msg
withOnChange value_ (Builder b) =
    Builder { b | attrs = M3e.Events.onChange value_ :: b.attrs }


{-| Pipe form of `onClick` — consumes its capability (write-once).
-}
withOnClick : msg -> Builder { a | onClick : Available } slotCaps msg -> Builder { a | onClick : Used } slotCaps msg
withOnClick value_ (Builder b) =
    Builder { b | attrs = M3e.Events.onClick value_ :: b.attrs }


{-| Pipe form of the `selected` slot — consumes its capability (write-once).
-}
withSelectedSlot : Element SelectedSlot admittedBy msg -> Builder attrCaps { s | selected : Available } msg -> Builder attrCaps { s | selected : Used } msg
withSelectedSlot element (Builder b) =
    Builder { b | children = HtmlIr.Element.toNode (selected element) :: b.children }


{-| Pipe form of a default-slot child (repeatable).
-}
withChild : Element Content (ChildAdmittedBy childAdm) msg -> Builder attrCaps slotCaps msg -> Builder attrCaps slotCaps msg
withChild element (Builder b) =
    Builder { b | children = HtmlIr.Element.toNode element :: b.children }
