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
import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Value as Val exposing (Value)
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Html as H
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
view =
    H.tooltip


{-| Required-content (and action) constructor — omissions are unwritable.
-}
el :
    { content : Element Content (ChildAdmittedBy childAdm) msg }
    -> List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el required_ attrs children =
    view attrs (required_.content :: children)


{-| The position of the tooltip. (default: `"below"`)
-}
position : Value Position -> Attr { c | position : Supported } msg
position value_ =
    Ir.attribute "position" (Val.toString value_)


{-| The mode in which to handle touch gestures. (default: `"auto"`)
-}
touchGestures : Value TouchGestures -> Attr { c | touchGestures : Supported } msg
touchGestures value_ =
    Ir.attribute "touch-gestures" (Val.toString value_)


{-| See `M3e.Attributes.disabled`.
-}
disabled : Bool -> Attr { c | disabled : Supported } msg
disabled =
    A.disabled


{-| See `M3e.Attributes.for`.
-}
for : String -> Attr { c | for : Supported } msg
for =
    A.for


{-| See `M3e.Attributes.hideDelay`.
-}
hideDelay : Float -> Attr { c | hideDelay : Supported } msg
hideDelay =
    A.hideDelay


{-| See `M3e.Attributes.showDelay`.
-}
showDelay : Float -> Attr { c | showDelay : Supported } msg
showDelay =
    A.showDelay


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
    B.init "m3e-tooltip" [] [ El.toNode required_.content ]


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


{-| Pipe form of `for` — consumes its capability (write-once).
-}
withFor : String -> Builder { a | for : Available } slotCaps msg -> Builder { a | for : Used } slotCaps msg
withFor value_ =
    B.withAttribute (A.for value_)


{-| Pipe form of `hideDelay` — consumes its capability (write-once).
-}
withHideDelay : Float -> Builder { a | hideDelay : Available } slotCaps msg -> Builder { a | hideDelay : Used } slotCaps msg
withHideDelay value_ =
    B.withAttribute (A.hideDelay value_)


{-| Pipe form of `position` — consumes its capability (write-once).
-}
withPosition : Value Position -> Builder { a | position : Available } slotCaps msg -> Builder { a | position : Used } slotCaps msg
withPosition value_ =
    B.withAttribute (position value_)


{-| Pipe form of `showDelay` — consumes its capability (write-once).
-}
withShowDelay : Float -> Builder { a | showDelay : Available } slotCaps msg -> Builder { a | showDelay : Used } slotCaps msg
withShowDelay value_ =
    B.withAttribute (A.showDelay value_)


{-| Pipe form of `touchGestures` — consumes its capability (write-once).
-}
withTouchGestures : Value TouchGestures -> Builder { a | touchGestures : Available } slotCaps msg -> Builder { a | touchGestures : Used } slotCaps msg
withTouchGestures value_ =
    B.withAttribute (touchGestures value_)


{-| Pipe form of a default-slot child (repeatable).
-}
withChild : Element Content (ChildAdmittedBy childAdm) msg -> Builder attrCaps slotCaps msg -> Builder attrCaps slotCaps msg
withChild element =
    B.withChild (El.toNode element)
