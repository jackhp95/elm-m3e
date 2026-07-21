module M3e.Card exposing
    ( view, build, toElement
    , Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , Orientation, orientation, Type, type_, Variant, variant
    , actionable, disabled, disabledInteractive, download, href, inline, name, rel, target, value, onClick
    , actions, content, footer, header
    , withActionable, withActions, withAriaLabel, withChild, withClass, withContent, withDisabled, withDisabledInteractive, withDownload, withFooter, withHeader, withHref, withId, withInline, withName, withOnClick, withOrientation, withRel, withSlot, withStyle, withTarget, withType, withValue, withVariant
    )

{-| The `m3e-card` component — strict per-component surface.

A content container for text, images (or other media), and actions in the context of a single subject.

@docs view, build, toElement
@docs Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs Orientation, orientation, Type, type_, Variant, variant
@docs actionable, disabled, disabledInteractive, download, href, inline, name, rel, target, value, onClick
@docs actions, content, footer, header
@docs withActionable, withActions, withAriaLabel, withChild, withClass, withContent, withDisabled, withDisabledInteractive, withDownload, withFooter, withHeader, withHref, withId, withInline, withName, withOnClick, withOrientation, withRel, withSlot, withStyle, withTarget, withType, withValue, withVariant

-}

import Html.Attributes
import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import HtmlIr.Node exposing (Node)
import HtmlIr.Value exposing (Value)
import Json.Encode
import M3e.Attributes
import M3e.Events
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-card` produces (open — composes into any slot naming it).
-}
type alias Is s =
    { s | card : Brand }


{-| The closed attribute-capability row.
-}
type alias Attrs =
    { actionable : Supported
    , ariaLabel : Supported
    , class : Supported
    , disabled : Supported
    , disabledInteractive : Supported
    , download : Supported
    , href : Supported
    , id : Supported
    , inline : Supported
    , name : Supported
    , onClick : Supported
    , orientation : Supported
    , rel : Supported
    , slot : Supported
    , style : Supported
    , target : Supported
    , type_ : Supported
    , value : Supported
    , variant : Supported
    }


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    { childAdm | card : Ctx }


{-| The `orientation` values valid on this component (compile-tight narrowing).
-}
type alias Orientation =
    { horizontal : Supported
    , vertical : Supported
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
    { elevated : Supported
    , filled : Supported
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
view attrs children =
    Ir.fromNode (Ir.node "m3e-card" attrs (List.map HtmlIr.Element.toNode children))


{-| Narrowed value setter for `orientation`. Tokens come from `M3e.Values`.
-}
orientation : Value Orientation -> Attr { c | orientation : Supported } msg
orientation value_ =
    Ir.attribute "orientation" (HtmlIr.Value.toString value_)


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


{-| See `M3e.Attributes.actionable`.
-}
actionable : Bool -> Attr { c | actionable : Supported } msg
actionable =
    M3e.Attributes.actionable


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


{-| See `M3e.Attributes.inline`.
-}
inline : Bool -> Attr { c | inline : Supported } msg
inline =
    M3e.Attributes.inline


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


{-| Place an element into the named `actions` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
actions : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
actions element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "actions") (HtmlIr.Element.toNode element))


{-| Place an element into the named `content` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
content : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
content element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "content") (HtmlIr.Element.toNode element))


{-| Place an element into the named `footer` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
footer : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
footer element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "footer") (HtmlIr.Element.toNode element))


{-| Place an element into the named `header` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
header : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
header element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "header") (HtmlIr.Element.toNode element))


{-| The pipe-builder: capabilities are consumed Available→Used, so writing
a singular attribute or slot twice is unwritable.
-}
type Builder attrCaps slotCaps msg
    = Builder { attrs : List (Attr Attrs msg), children : List (Node msg) }


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    { actionable : Available
    , ariaLabel : Available
    , class : Available
    , disabled : Available
    , disabledInteractive : Available
    , download : Available
    , href : Available
    , id : Available
    , inline : Available
    , name : Available
    , onClick : Available
    , orientation : Available
    , rel : Available
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
    { actions : Available
    , content : Available
    , footer : Available
    , header : Available
    }


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg
build =
    Builder { attrs = [], children = [] }


{-| Close the pipe-builder.
-}
toElement : Builder attrCaps slotCaps msg -> Element (Is s) admittedBy msg
toElement (Builder b) =
    Ir.fromNode (Ir.node "m3e-card" (List.reverse b.attrs) (List.reverse b.children))


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


{-| Pipe form of `actionable` — consumes its capability (write-once).
-}
withActionable : Bool -> Builder { a | actionable : Available } slotCaps msg -> Builder { a | actionable : Used } slotCaps msg
withActionable value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.actionable value_ :: b.attrs }


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


{-| Pipe form of `inline` — consumes its capability (write-once).
-}
withInline : Bool -> Builder { a | inline : Available } slotCaps msg -> Builder { a | inline : Used } slotCaps msg
withInline value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.inline value_ :: b.attrs }


{-| Pipe form of `name` — consumes its capability (write-once).
-}
withName : String -> Builder { a | name : Available } slotCaps msg -> Builder { a | name : Used } slotCaps msg
withName value_ (Builder b) =
    Builder { b | attrs = Ir.attribute "name" value_ :: b.attrs }


{-| Pipe form of `orientation` — consumes its capability (write-once).
-}
withOrientation : Value Orientation -> Builder { a | orientation : Available } slotCaps msg -> Builder { a | orientation : Used } slotCaps msg
withOrientation value_ (Builder b) =
    Builder { b | attrs = orientation value_ :: b.attrs }


{-| Pipe form of `rel` — consumes its capability (write-once).
-}
withRel : String -> Builder { a | rel : Available } slotCaps msg -> Builder { a | rel : Used } slotCaps msg
withRel value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.rel value_ :: b.attrs }


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


{-| Pipe form of the `actions` slot — consumes its capability (write-once).
-}
withActions : Element childAccepts admittedBy msg -> Builder attrCaps { s | actions : Available } msg -> Builder attrCaps { s | actions : Used } msg
withActions element (Builder b) =
    Builder { b | children = HtmlIr.Element.toNode (actions element) :: b.children }


{-| Pipe form of the `content` slot — consumes its capability (write-once).
-}
withContent : Element childAccepts admittedBy msg -> Builder attrCaps { s | content : Available } msg -> Builder attrCaps { s | content : Used } msg
withContent element (Builder b) =
    Builder { b | children = HtmlIr.Element.toNode (content element) :: b.children }


{-| Pipe form of the `footer` slot — consumes its capability (write-once).
-}
withFooter : Element childAccepts admittedBy msg -> Builder attrCaps { s | footer : Available } msg -> Builder attrCaps { s | footer : Used } msg
withFooter element (Builder b) =
    Builder { b | children = HtmlIr.Element.toNode (footer element) :: b.children }


{-| Pipe form of the `header` slot — consumes its capability (write-once).
-}
withHeader : Element childAccepts admittedBy msg -> Builder attrCaps { s | header : Available } msg -> Builder attrCaps { s | header : Used } msg
withHeader element (Builder b) =
    Builder { b | children = HtmlIr.Element.toNode (header element) :: b.children }


{-| Pipe form of a default-slot child (repeatable).
-}
withChild : Element childAccepts (ChildAdmittedBy childAdm) msg -> Builder attrCaps slotCaps msg -> Builder attrCaps slotCaps msg
withChild element (Builder b) =
    Builder { b | children = HtmlIr.Element.toNode element :: b.children }
