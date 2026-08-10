module M3e.Option exposing
    ( view, el, build, toElement
    , Is, Attrs, Content, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , HighlightMode, highlightMode
    , disableHighlight, disabled, selected, term, value, defaultSelected, defaultValue
    , child
    , withChild, withClass, withDisableHighlight, withDisabled, withHighlightMode, withId, withSelected, withSlot, withStyle, withTerm, withValue
    )

{-| The `m3e-option` component — strict per-component surface.

An option that can be selected.

@docs view, el, build, toElement
@docs Is, Attrs, Content, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs HighlightMode, highlightMode
@docs disableHighlight, disabled, selected, term, value, defaultSelected, defaultValue
@docs child
@docs withChild, withClass, withDisableHighlight, withDisabled, withHighlightMode, withId, withSelected, withSlot, withStyle, withTerm, withValue

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Value as Val exposing (Value)
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Html as H
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
    { heading : Brand
    , sharedText : Shared
    }


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
view =
    H.option


{-| Required-content (and action) constructor — omissions are unwritable.
-}
el :
    { content : Element Content (ChildAdmittedBy childAdm) msg }
    -> List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el required_ attrs children =
    view attrs (required_.content :: children)


{-| The mode in which to highlight a term. (default: `"contains"`)
-}
highlightMode : Value HighlightMode -> Attr { c | highlightMode : Supported } msg
highlightMode value_ =
    Ir.attribute "highlight-mode" (Val.toString value_)


{-| See `M3e.Attributes.disableHighlight`.
-}
disableHighlight : Bool -> Attr { c | disableHighlight : Supported } msg
disableHighlight =
    A.disableHighlight


{-| See `M3e.Attributes.disabled`.
-}
disabled : Bool -> Attr { c | disabled : Supported } msg
disabled =
    A.disabled


{-| See `M3e.Attributes.selected`.
-}
selected : Bool -> Attr { c | selected : Supported } msg
selected =
    A.selected


{-| See `M3e.Attributes.term`.
-}
term : String -> Attr { c | term : Supported } msg
term =
    A.term


{-| See `M3e.Attributes.value`.
-}
value : String -> Attr { c | value : Supported } msg
value =
    A.value


{-| See `M3e.Attributes.defaultSelected`.
-}
defaultSelected : Bool -> Attr { c | selected : Supported } msg
defaultSelected =
    A.defaultSelected


{-| See `M3e.Attributes.defaultValue`.
-}
defaultValue : String -> Attr { c | value : Supported } msg
defaultValue =
    A.defaultValue


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
    B.Builder Attrs attrCaps slotCaps (Is s) msg


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
    -> Builder AttrCaps SlotCaps msg kind
build required_ =
    B.init "m3e-option" [] [ El.toNode required_.content ]


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


{-| Pipe form of `disableHighlight` — consumes its capability (write-once).
-}
withDisableHighlight : Bool -> Builder { a | disableHighlight : Available } slotCaps msg kind -> Builder { a | disableHighlight : Used } slotCaps msg kind
withDisableHighlight value_ =
    B.withAttribute (A.disableHighlight value_)


{-| Pipe form of `disabled` — consumes its capability (write-once).
-}
withDisabled : Bool -> Builder { a | disabled : Available } slotCaps msg kind -> Builder { a | disabled : Used } slotCaps msg kind
withDisabled value_ =
    B.withAttribute (A.disabled value_)


{-| Pipe form of `highlightMode` — consumes its capability (write-once).
-}
withHighlightMode : Value HighlightMode -> Builder { a | highlightMode : Available } slotCaps msg kind -> Builder { a | highlightMode : Used } slotCaps msg kind
withHighlightMode value_ =
    B.withAttribute (highlightMode value_)


{-| Pipe form of `selected` — consumes its capability (write-once).
-}
withSelected : Bool -> Builder { a | selected : Available } slotCaps msg kind -> Builder { a | selected : Used } slotCaps msg kind
withSelected value_ =
    B.withAttribute (A.selected value_)


{-| Pipe form of `term` — consumes its capability (write-once).
-}
withTerm : String -> Builder { a | term : Available } slotCaps msg kind -> Builder { a | term : Used } slotCaps msg kind
withTerm value_ =
    B.withAttribute (A.term value_)


{-| Pipe form of `value` — consumes its capability (write-once).
-}
withValue : String -> Builder { a | value : Available } slotCaps msg kind -> Builder { a | value : Used } slotCaps msg kind
withValue value_ =
    B.withAttribute (A.value value_)


{-| Pipe form of a default-slot child (repeatable).
-}
withChild : Element Content (ChildAdmittedBy childAdm) msg -> Builder attrCaps slotCaps msg kind -> Builder attrCaps slotCaps msg kind
withChild element =
    B.withChild (El.toNode element)
