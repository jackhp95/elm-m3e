module M3e.Theme exposing
    ( view, build, toElement
    , Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , Contrast, contrast, Motion, motion, Scheme, scheme, Variant, variant
    , color, density, strongFocus, onChange
    , withChild, withClass, withColor, withContrast, withDensity, withId, withMotion, withOnChange, withScheme, withSlot, withStrongFocus, withStyle, withVariant
    )

{-| The `m3e-theme` component — strict per-component surface.

A non-visual element responsible for application-level theming.

@docs view, build, toElement
@docs Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs Contrast, contrast, Motion, motion, Scheme, scheme, Variant, variant
@docs color, density, strongFocus, onChange
@docs withChild, withClass, withColor, withContrast, withDensity, withId, withMotion, withOnChange, withScheme, withSlot, withStrongFocus, withStyle, withVariant

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import HtmlIr.Node exposing (Node)
import HtmlIr.Value exposing (Value)
import M3e.Attributes
import M3e.Events
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
view attrs children =
    Ir.fromNode (Ir.node "m3e-theme" attrs (List.map HtmlIr.Element.toNode children))


{-| Narrowed value setter for `contrast`. Tokens come from `M3e.Values`.
-}
contrast : Value Contrast -> Attr { c | contrast : Supported } msg
contrast value_ =
    Ir.attribute "contrast" (HtmlIr.Value.toString value_)


{-| Narrowed value setter for `motion`. Tokens come from `M3e.Values`.
-}
motion : Value Motion -> Attr { c | motion : Supported } msg
motion value_ =
    Ir.attribute "motion" (HtmlIr.Value.toString value_)


{-| Narrowed value setter for `scheme`. Tokens come from `M3e.Values`.
-}
scheme : Value Scheme -> Attr { c | scheme : Supported } msg
scheme value_ =
    Ir.attribute "scheme" (HtmlIr.Value.toString value_)


{-| Narrowed value setter for `variant`. Tokens come from `M3e.Values`.
-}
variant : Value Variant -> Attr { c | variant : Supported } msg
variant value_ =
    Ir.attribute "variant" (HtmlIr.Value.toString value_)


{-| See `M3e.Attributes.color`.
-}
color : String -> Attr { c | color : Supported } msg
color =
    M3e.Attributes.color


{-| See `M3e.Attributes.density`.
-}
density : Float -> Attr { c | density : Supported } msg
density =
    M3e.Attributes.density


{-| See `M3e.Attributes.strongFocus`.
-}
strongFocus : Bool -> Attr { c | strongFocus : Supported } msg
strongFocus =
    M3e.Attributes.strongFocus


{-| See `M3e.Events.onChange`.
-}
onChange : msg -> Attr { c | onChange : Supported } msg
onChange =
    M3e.Events.onChange


{-| The pipe-builder: capabilities are consumed Available→Used, so writing
a singular attribute or slot twice is unwritable.
-}
type Builder attrCaps slotCaps msg
    = Builder { attrs : List (Attr Attrs msg), children : List (Node msg) }


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
    Builder { attrs = [], children = [] }


{-| Close the pipe-builder.
-}
toElement : Builder attrCaps slotCaps msg -> Element (Is s) admittedBy msg
toElement (Builder b) =
    Ir.fromNode (Ir.node "m3e-theme" (List.reverse b.attrs) (List.reverse b.children))


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


{-| Pipe form of `color` — consumes its capability (write-once).
-}
withColor : String -> Builder { a | color : Available } slotCaps msg -> Builder { a | color : Used } slotCaps msg
withColor value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.color value_ :: b.attrs }


{-| Pipe form of `contrast` — consumes its capability (write-once).
-}
withContrast : Value Contrast -> Builder { a | contrast : Available } slotCaps msg -> Builder { a | contrast : Used } slotCaps msg
withContrast value_ (Builder b) =
    Builder { b | attrs = contrast value_ :: b.attrs }


{-| Pipe form of `density` — consumes its capability (write-once).
-}
withDensity : Float -> Builder { a | density : Available } slotCaps msg -> Builder { a | density : Used } slotCaps msg
withDensity value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.density value_ :: b.attrs }


{-| Pipe form of `motion` — consumes its capability (write-once).
-}
withMotion : Value Motion -> Builder { a | motion : Available } slotCaps msg -> Builder { a | motion : Used } slotCaps msg
withMotion value_ (Builder b) =
    Builder { b | attrs = motion value_ :: b.attrs }


{-| Pipe form of `scheme` — consumes its capability (write-once).
-}
withScheme : Value Scheme -> Builder { a | scheme : Available } slotCaps msg -> Builder { a | scheme : Used } slotCaps msg
withScheme value_ (Builder b) =
    Builder { b | attrs = scheme value_ :: b.attrs }


{-| Pipe form of `strongFocus` — consumes its capability (write-once).
-}
withStrongFocus : Bool -> Builder { a | strongFocus : Available } slotCaps msg -> Builder { a | strongFocus : Used } slotCaps msg
withStrongFocus value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.strongFocus value_ :: b.attrs }


{-| Pipe form of `variant` — consumes its capability (write-once).
-}
withVariant : Value Variant -> Builder { a | variant : Available } slotCaps msg -> Builder { a | variant : Used } slotCaps msg
withVariant value_ (Builder b) =
    Builder { b | attrs = variant value_ :: b.attrs }


{-| Pipe form of `onChange` — consumes its capability (write-once).
-}
withOnChange : msg -> Builder { a | onChange : Available } slotCaps msg -> Builder { a | onChange : Used } slotCaps msg
withOnChange value_ (Builder b) =
    Builder { b | attrs = M3e.Events.onChange value_ :: b.attrs }


{-| Pipe form of a default-slot child (repeatable).
-}
withChild : Element childAccepts (ChildAdmittedBy childAdm) msg -> Builder attrCaps slotCaps msg -> Builder attrCaps slotCaps msg
withChild element (Builder b) =
    Builder { b | children = HtmlIr.Element.toNode element :: b.children }
