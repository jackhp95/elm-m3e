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
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-theme` produces (open — composes into any slot naming it).
-}
type alias Is s =
    { s | theme : Brand }


{-| The closed attribute-capability row.
-}
type alias Attrs =
    { class : Supported
    , color : Supported
    , contrast : Supported
    , density : Supported
    , id : Supported
    , motion : Supported
    , onChange : Supported
    , scheme : Supported
    , slot : Supported
    , strongFocus : Supported
    , style : Supported
    , variant : Supported
    }


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    { childAdm | theme : Ctx }


{-| The `contrast` values valid on this component (compile-tight narrowing).
-}
type alias Contrast =
    { high : Supported
    , medium : Supported
    , standard : Supported
    }


{-| The `motion` values valid on this component (compile-tight narrowing).
-}
type alias Motion =
    { expressive : Supported
    , standard : Supported
    }


{-| The `scheme` values valid on this component (compile-tight narrowing).
-}
type alias Scheme =
    { auto : Supported
    , dark : Supported
    , light : Supported
    }


{-| The `variant` values valid on this component (compile-tight narrowing).
-}
type alias Variant =
    { content : Supported
    , expressive : Supported
    , fidelity : Supported
    , fruitSalad : Supported
    , monochrome : Supported
    , neutral : Supported
    , rainbow : Supported
    , tonalSpot : Supported
    , vibrant : Supported
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
`Build.Internal`, closed over this component's `Attrs` row.
-}
type alias Builder attrCaps slotCaps msg =
    B.Builder Attrs attrCaps slotCaps msg


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    { class : Available
    , color : Available
    , contrast : Available
    , density : Available
    , id : Available
    , motion : Available
    , onChange : Available
    , scheme : Available
    , slot : Available
    , strongFocus : Available
    , style : Available
    , variant : Available
    }


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    {}


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg
build =
    B.init "m3e-theme" [] []


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


{-| Pipe form of `color` — consumes its capability (write-once).
-}
withColor : String -> Builder { a | color : Available } slotCaps msg -> Builder { a | color : Used } slotCaps msg
withColor value_ =
    B.withAttribute (A.color value_)


{-| Pipe form of `contrast` — consumes its capability (write-once).
-}
withContrast : Value Contrast -> Builder { a | contrast : Available } slotCaps msg -> Builder { a | contrast : Used } slotCaps msg
withContrast value_ =
    B.withAttribute (contrast value_)


{-| Pipe form of `density` — consumes its capability (write-once).
-}
withDensity : Float -> Builder { a | density : Available } slotCaps msg -> Builder { a | density : Used } slotCaps msg
withDensity value_ =
    B.withAttribute (A.density value_)


{-| Pipe form of `motion` — consumes its capability (write-once).
-}
withMotion : Value Motion -> Builder { a | motion : Available } slotCaps msg -> Builder { a | motion : Used } slotCaps msg
withMotion value_ =
    B.withAttribute (motion value_)


{-| Pipe form of `scheme` — consumes its capability (write-once).
-}
withScheme : Value Scheme -> Builder { a | scheme : Available } slotCaps msg -> Builder { a | scheme : Used } slotCaps msg
withScheme value_ =
    B.withAttribute (scheme value_)


{-| Pipe form of `strongFocus` — consumes its capability (write-once).
-}
withStrongFocus : Bool -> Builder { a | strongFocus : Available } slotCaps msg -> Builder { a | strongFocus : Used } slotCaps msg
withStrongFocus value_ =
    B.withAttribute (A.strongFocus value_)


{-| Pipe form of `variant` — consumes its capability (write-once).
-}
withVariant : Value Variant -> Builder { a | variant : Available } slotCaps msg -> Builder { a | variant : Used } slotCaps msg
withVariant value_ =
    B.withAttribute (variant value_)


{-| Pipe form of `onChange` — consumes its capability (write-once).
-}
withOnChange : msg -> Builder { a | onChange : Available } slotCaps msg -> Builder { a | onChange : Used } slotCaps msg
withOnChange value_ =
    B.withAttribute (Ev.onChange value_)


{-| Pipe form of a default-slot child (repeatable).
-}
withChild : Element childAccepts (ChildAdmittedBy childAdm) msg -> Builder attrCaps slotCaps msg -> Builder attrCaps slotCaps msg
withChild element =
    B.withChild (El.toNode element)
