module M3e.Tooltip exposing
    ( view, el, build, toElement
    , Is, Attrs, Content, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , Position, position, TouchGestures, touchGestures
    , disabled, for, hideDelay, showDelay
    , withChild, withClass, withDisabled, withFor, withHideDelay, withId, withPosition, withShowDelay, withSlot, withStyle, withTouchGestures
    )

{-| The `m3e-tooltip` component — strict per-component surface.

Adds additional context to a button or other UI element.

@docs view, el, build, toElement
@docs Is, Attrs, Content, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs Position, position, TouchGestures, touchGestures
@docs disabled, for, hideDelay, showDelay
@docs withChild, withClass, withDisabled, withFor, withHideDelay, withId, withPosition, withShowDelay, withSlot, withStyle, withTouchGestures

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Node exposing (Node)
import HtmlIr.Value exposing (Value)
import M3e.Attributes
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-tooltip` produces (open — composes into any slot naming it).
-}
type alias Is s =
    { s | tooltip : Brand }


{-| The closed attribute-capability row.
-}
type alias Attrs =
    { class : Supported
    , disabled : Supported
    , for : Supported
    , hideDelay : Supported
    , id : Supported
    , position : Supported
    , showDelay : Supported
    , slot : Supported
    , style : Supported
    , touchGestures : Supported
    }


{-| The kinds the default slot admits.
-}
type alias Content =
    { sharedText : Shared }


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    { childAdm | tooltip : Ctx }


{-| The `position` values valid on this component (compile-tight narrowing).
-}
type alias Position =
    { above : Supported
    , after : Supported
    , before : Supported
    , below : Supported
    }


{-| The `touchGestures` values valid on this component (compile-tight narrowing).
-}
type alias TouchGestures =
    { auto : Supported
    , off : Supported
    , on : Supported
    }


{-| Standard constructor: `[attributes] [children]`.
-}
view :
    List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
view attrs children =
    Ir.fromNode (Ir.node "m3e-tooltip" attrs (List.map HtmlIr.Element.toNode children))


{-| Required-content constructor — missing required content is unwritable.
-}
el :
    { content : Element Content (ChildAdmittedBy childAdm) msg }
    -> List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el required_ attrs children =
    view attrs (required_.content :: children)


{-| Narrowed value setter for `position`. Tokens come from `M3e.Values`.
-}
position : Value Position -> Attr { c | position : Supported } msg
position value_ =
    Ir.attribute "position" (HtmlIr.Value.toString value_)


{-| Narrowed value setter for `touchGestures`. Tokens come from `M3e.Values`.
-}
touchGestures : Value TouchGestures -> Attr { c | touchGestures : Supported } msg
touchGestures value_ =
    Ir.attribute "touch-gestures" (HtmlIr.Value.toString value_)


{-| See `M3e.Attributes.disabled`.
-}
disabled : Bool -> Attr { c | disabled : Supported } msg
disabled =
    M3e.Attributes.disabled


{-| See `M3e.Attributes.for`.
-}
for : String -> Attr { c | for : Supported } msg
for =
    M3e.Attributes.for


{-| See `M3e.Attributes.hideDelay`.
-}
hideDelay : Float -> Attr { c | hideDelay : Supported } msg
hideDelay =
    M3e.Attributes.hideDelay


{-| See `M3e.Attributes.showDelay`.
-}
showDelay : Float -> Attr { c | showDelay : Supported } msg
showDelay =
    M3e.Attributes.showDelay


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
    , for : Available
    , hideDelay : Available
    , id : Available
    , position : Available
    , showDelay : Available
    , slot : Available
    , style : Available
    , touchGestures : Available
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
    Ir.fromNode (Ir.node "m3e-tooltip" (List.reverse b.attrs) (List.reverse b.children))


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


{-| Pipe form of `for` — consumes its capability (write-once).
-}
withFor : String -> Builder { a | for : Available } slotCaps msg -> Builder { a | for : Used } slotCaps msg
withFor value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.for value_ :: b.attrs }


{-| Pipe form of `hideDelay` — consumes its capability (write-once).
-}
withHideDelay : Float -> Builder { a | hideDelay : Available } slotCaps msg -> Builder { a | hideDelay : Used } slotCaps msg
withHideDelay value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.hideDelay value_ :: b.attrs }


{-| Pipe form of `position` — consumes its capability (write-once).
-}
withPosition : Value Position -> Builder { a | position : Available } slotCaps msg -> Builder { a | position : Used } slotCaps msg
withPosition value_ (Builder b) =
    Builder { b | attrs = position value_ :: b.attrs }


{-| Pipe form of `showDelay` — consumes its capability (write-once).
-}
withShowDelay : Float -> Builder { a | showDelay : Available } slotCaps msg -> Builder { a | showDelay : Used } slotCaps msg
withShowDelay value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.showDelay value_ :: b.attrs }


{-| Pipe form of `touchGestures` — consumes its capability (write-once).
-}
withTouchGestures : Value TouchGestures -> Builder { a | touchGestures : Available } slotCaps msg -> Builder { a | touchGestures : Used } slotCaps msg
withTouchGestures value_ (Builder b) =
    Builder { b | attrs = touchGestures value_ :: b.attrs }


{-| Pipe form of a default-slot child (repeatable).
-}
withChild : Element Content (ChildAdmittedBy childAdm) msg -> Builder attrCaps slotCaps msg -> Builder attrCaps slotCaps msg
withChild element (Builder b) =
    Builder { b | children = HtmlIr.Element.toNode element :: b.children }
