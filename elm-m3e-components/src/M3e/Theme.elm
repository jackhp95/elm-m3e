module M3e.Theme exposing
    ( view, build, toElement
    , Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , Contrast, contrast, Motion, motion, Scheme, scheme, Variant, variant
    , color, density, strongFocus, onChange
    , child
    , withChild, withClass, withColor, withContrast, withDensity, withId, withMotion, withOnChange, withScheme, withSlot, withStrongFocus, withStyle, withVariant
    )

{-| The `m3e-theme` component — strict per-component surface.

A non-visual element responsible for application-level theming.

@docs view, build, toElement
@docs Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs Contrast, contrast, Motion, motion, Scheme, scheme, Variant, variant
@docs color, density, strongFocus, onChange
@docs child
@docs withChild, withClass, withColor, withContrast, withDensity, withId, withMotion, withOnChange, withScheme, withSlot, withStrongFocus, withStyle, withVariant

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import HtmlIr.Value as Val exposing (Value)
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Events as Ev
import M3e.Html as H
import M3e.Internal.Types.Theme
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-theme` produces (open — composes into any slot naming it).
-}
type alias Is s =
    M3e.Internal.Types.Theme.Is s


{-| The closed attribute-capability row.
-}
type alias Attrs =
    M3e.Internal.Types.Theme.Attrs


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    M3e.Internal.Types.Theme.ChildAdmittedBy childAdm


{-| The `contrast` values valid on this component (compile-tight narrowing).
-}
type alias Contrast =
    M3e.Internal.Types.Theme.Contrast


{-| The `motion` values valid on this component (compile-tight narrowing).
-}
type alias Motion =
    M3e.Internal.Types.Theme.Motion


{-| The `scheme` values valid on this component (compile-tight narrowing).
-}
type alias Scheme =
    M3e.Internal.Types.Theme.Scheme


{-| The `variant` values valid on this component (compile-tight narrowing).
-}
type alias Variant =
    M3e.Internal.Types.Theme.Variant


{-| Standard constructor: `[attributes] [children]`. The default slot is
kind-permissive (`any`): children of any kind compose, but each child's OWN
admittedBy must still admit this context — a restricted-parent element is
rejected here at compile time.
-}
view :
    List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
view =
    H.theme


{-| The contrast level of the theme. (default: `"standard"`)
-}
contrast : Value Contrast -> Attr { c | contrast : Supported } msg
contrast value_ =
    Ir.attribute "contrast" (Val.toString value_)


{-| The motion scheme. (default: `"standard"`)
-}
motion : Value Motion -> Attr { c | motion : Supported } msg
motion value_ =
    Ir.attribute "motion" (Val.toString value_)


{-| The color scheme of the theme. (default: `"auto"`)
-}
scheme : Value Scheme -> Attr { c | scheme : Supported } msg
scheme value_ =
    Ir.attribute "scheme" (Val.toString value_)


{-| The color variant of the theme. (default: `"neutral"`)
-}
variant : Value Variant -> Attr { c | variant : Supported } msg
variant value_ =
    Ir.attribute "variant" (Val.toString value_)


{-| See `M3e.Attributes.color`.
-}
color : String -> Attr { c | color : Supported } msg
color =
    A.color


{-| See `M3e.Attributes.density`.
-}
density : Float -> Attr { c | density : Supported } msg
density =
    A.density


{-| See `M3e.Attributes.strongFocus`.
-}
strongFocus : Bool -> Attr { c | strongFocus : Supported } msg
strongFocus =
    A.strongFocus


{-| See `M3e.Events.onChange`.
-}
onChange : msg -> Attr { c | onChange : Supported } msg
onChange =
    Ev.onChange


{-| Place a pre-built element into the default (unnamed) slot (input
constrained to the slot's kinds; output row free so it composes into the
child list). The list-form sibling of the builder's `withChild`.
-}
child : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
child element =
    Ir.fromNode (El.toNode element)


{-| The pipe-builder: capabilities are consumed Available→Used, so writing
a singular attribute or slot twice is unwritable. Aliases the shared builder in
`Build.Internal`, closed over this component's `Attrs` row and `Is s` kind.
-}
type alias Builder attrCaps slotCaps msg s =
    M3e.Internal.Types.Theme.Builder attrCaps slotCaps msg s


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    M3e.Internal.Types.Theme.AttrCaps


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    {}


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg kind
build =
    B.init "m3e-theme" [] []


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


{-| Pipe form of `color` — consumes its capability (write-once).
-}
withColor : String -> Builder { a | color : Available } slotCaps msg kind -> Builder { a | color : Used } slotCaps msg kind
withColor value_ =
    B.withAttribute (A.color value_)


{-| Pipe form of `contrast` — consumes its capability (write-once).
-}
withContrast : Value Contrast -> Builder { a | contrast : Available } slotCaps msg kind -> Builder { a | contrast : Used } slotCaps msg kind
withContrast value_ =
    B.withAttribute (contrast value_)


{-| Pipe form of `density` — consumes its capability (write-once).
-}
withDensity : Float -> Builder { a | density : Available } slotCaps msg kind -> Builder { a | density : Used } slotCaps msg kind
withDensity value_ =
    B.withAttribute (A.density value_)


{-| Pipe form of `motion` — consumes its capability (write-once).
-}
withMotion : Value Motion -> Builder { a | motion : Available } slotCaps msg kind -> Builder { a | motion : Used } slotCaps msg kind
withMotion value_ =
    B.withAttribute (motion value_)


{-| Pipe form of `scheme` — consumes its capability (write-once).
-}
withScheme : Value Scheme -> Builder { a | scheme : Available } slotCaps msg kind -> Builder { a | scheme : Used } slotCaps msg kind
withScheme value_ =
    B.withAttribute (scheme value_)


{-| Pipe form of `strongFocus` — consumes its capability (write-once).
-}
withStrongFocus : Bool -> Builder { a | strongFocus : Available } slotCaps msg kind -> Builder { a | strongFocus : Used } slotCaps msg kind
withStrongFocus value_ =
    B.withAttribute (A.strongFocus value_)


{-| Pipe form of `variant` — consumes its capability (write-once).
-}
withVariant : Value Variant -> Builder { a | variant : Available } slotCaps msg kind -> Builder { a | variant : Used } slotCaps msg kind
withVariant value_ =
    B.withAttribute (variant value_)


{-| Pipe form of `onChange` — consumes its capability (write-once).
-}
withOnChange : msg -> Builder { a | onChange : Available } slotCaps msg kind -> Builder { a | onChange : Used } slotCaps msg kind
withOnChange value_ =
    B.withAttribute (Ev.onChange value_)


{-| Pipe form of a default-slot child (repeatable).
-}
withChild : Element childAccepts (ChildAdmittedBy childAdm) msg -> Builder attrCaps slotCaps msg kind -> Builder attrCaps slotCaps msg kind
withChild element =
    B.withChild (El.toNode element)
