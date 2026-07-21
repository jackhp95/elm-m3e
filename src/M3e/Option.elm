module M3e.Option exposing
    ( view, el, build, toElement
    , Is, Attrs, Content, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , HighlightMode, highlightMode
    , disableHighlight, disabled, selected, term, value
    , withChild, withClass, withDisableHighlight, withDisabled, withHighlightMode, withId, withSelected, withSlot, withStyle, withTerm, withValue
    )

{-| The `m3e-option` component — strict per-component surface.

An option that can be selected.

@docs view, el, build, toElement
@docs Is, Attrs, Content, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs HighlightMode, highlightMode
@docs disableHighlight, disabled, selected, term, value
@docs withChild, withClass, withDisableHighlight, withDisabled, withHighlightMode, withId, withSelected, withSlot, withStyle, withTerm, withValue

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Node exposing (Node)
import HtmlIr.Value exposing (Value)
import M3e.Attributes
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-option` produces (open — composes into any slot naming it).
-}
type alias Is s =
    { s | option : Brand }


{-| The closed attribute-capability row.
-}
type alias Attrs =
    { class : Supported
    , disableHighlight : Supported
    , disabled : Supported
    , highlightMode : Supported
    , id : Supported
    , selected : Supported
    , slot : Supported
    , style : Supported
    , term : Supported
    , value : Supported
    }


{-| The kinds the default slot admits.
-}
type alias Content =
    { sharedText : Shared }


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    { childAdm | option : Ctx }


{-| The `highlightMode` values valid on this component (compile-tight narrowing).
-}
type alias HighlightMode =
    { contains : Supported
    , endsWith : Supported
    , startsWith : Supported
    }


{-| Standard constructor: `[attributes] [children]`.
-}
view :
    List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
view attrs children =
    Ir.fromNode (Ir.node "m3e-option" attrs (List.map HtmlIr.Element.toNode children))


{-| Required-content constructor — missing required content is unwritable.
-}
el :
    { content : Element Content (ChildAdmittedBy childAdm) msg }
    -> List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el required_ attrs children =
    view attrs (required_.content :: children)


{-| Narrowed value setter for `highlightMode`. Tokens come from `M3e.Values`.
-}
highlightMode : Value HighlightMode -> Attr { c | highlightMode : Supported } msg
highlightMode value_ =
    Ir.attribute "highlight-mode" (HtmlIr.Value.toString value_)


{-| See `M3e.Attributes.disableHighlight`.
-}
disableHighlight : Bool -> Attr { c | disableHighlight : Supported } msg
disableHighlight =
    M3e.Attributes.disableHighlight


{-| See `M3e.Attributes.disabled`.
-}
disabled : Bool -> Attr { c | disabled : Supported } msg
disabled =
    M3e.Attributes.disabled


{-| See `M3e.Attributes.selected`.
-}
selected : Bool -> Attr { c | selected : Supported } msg
selected =
    M3e.Attributes.selected


{-| See `M3e.Attributes.term`.
-}
term : String -> Attr { c | term : Supported } msg
term =
    M3e.Attributes.term


{-| See `M3e.Attributes.value`.
-}
value : String -> Attr { c | value : Supported } msg
value =
    M3e.Attributes.value


{-| The pipe-builder: capabilities are consumed Available→Used, so writing
a singular attribute or slot twice is unwritable.
-}
type Builder attrCaps slotCaps msg
    = Builder { attrs : List (Attr Attrs msg), children : List (Node msg) }


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    { class : Available
    , disableHighlight : Available
    , disabled : Available
    , highlightMode : Available
    , id : Available
    , selected : Available
    , slot : Available
    , style : Available
    , term : Available
    , value : Available
    }


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    {}


{-| Seed the pipe-builder.
-}
build :
    { content : Element Content (ChildAdmittedBy childAdm) msg }
    -> Builder AttrCaps SlotCaps msg
build required_ =
    Builder { attrs = [], children = [ HtmlIr.Element.toNode required_.content ] }


{-| Close the pipe-builder.
-}
toElement : Builder attrCaps slotCaps msg -> Element (Is s) admittedBy msg
toElement (Builder b) =
    Ir.fromNode (Ir.node "m3e-option" (List.reverse b.attrs) (List.reverse b.children))


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


{-| Pipe form of `disableHighlight` — consumes its capability (write-once).
-}
withDisableHighlight : Bool -> Builder { a | disableHighlight : Available } slotCaps msg -> Builder { a | disableHighlight : Used } slotCaps msg
withDisableHighlight value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.disableHighlight value_ :: b.attrs }


{-| Pipe form of `disabled` — consumes its capability (write-once).
-}
withDisabled : Bool -> Builder { a | disabled : Available } slotCaps msg -> Builder { a | disabled : Used } slotCaps msg
withDisabled value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.disabled value_ :: b.attrs }


{-| Pipe form of `highlightMode` — consumes its capability (write-once).
-}
withHighlightMode : Value HighlightMode -> Builder { a | highlightMode : Available } slotCaps msg -> Builder { a | highlightMode : Used } slotCaps msg
withHighlightMode value_ (Builder b) =
    Builder { b | attrs = highlightMode value_ :: b.attrs }


{-| Pipe form of `selected` — consumes its capability (write-once).
-}
withSelected : Bool -> Builder { a | selected : Available } slotCaps msg -> Builder { a | selected : Used } slotCaps msg
withSelected value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.selected value_ :: b.attrs }


{-| Pipe form of `term` — consumes its capability (write-once).
-}
withTerm : String -> Builder { a | term : Available } slotCaps msg -> Builder { a | term : Used } slotCaps msg
withTerm value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.term value_ :: b.attrs }


{-| Pipe form of `value` — consumes its capability (write-once).
-}
withValue : String -> Builder { a | value : Available } slotCaps msg -> Builder { a | value : Used } slotCaps msg
withValue value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.value value_ :: b.attrs }


{-| Pipe form of a default-slot child (repeatable).
-}
withChild : Element Content (ChildAdmittedBy childAdm) msg -> Builder attrCaps slotCaps msg -> Builder attrCaps slotCaps msg
withChild element (Builder b) =
    Builder { b | children = HtmlIr.Element.toNode element :: b.children }
