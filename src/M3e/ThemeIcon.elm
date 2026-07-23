module M3e.ThemeIcon exposing
    ( view, build, toElement
    , Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , Scheme, scheme, Variant, variant
    , color
    , withClass, withColor, withId, withScheme, withSlot, withStyle, withVariant
    )

{-| The `m3e-theme-icon` component — strict per-component surface.

An icon that visually presents a preview of a theme.

@docs view, build, toElement
@docs Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs Scheme, scheme, Variant, variant
@docs color
@docs withClass, withColor, withId, withScheme, withSlot, withStyle, withVariant

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import HtmlIr.Value as Val exposing (Value)
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Html as H
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-theme-icon` produces (open — composes into any slot naming it).
-}
type alias Is s =
    { s | themeIcon : Brand }


{-| The closed attribute-capability row.
-}
type alias Attrs =
    { class : Supported
    , color : Supported
    , id : Supported
    , scheme : Supported
    , slot : Supported
    , style : Supported
    , variant : Supported
    }


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    { childAdm | themeIcon : Ctx }


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


{-| Standard constructor: `[attributes] [children]`.
-}
view :
    List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
view =
    H.themeIcon


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
    , id : Available
    , scheme : Available
    , slot : Available
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
    B.init "m3e-theme-icon" [] []


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


{-| Pipe form of `scheme` — consumes its capability (write-once).
-}
withScheme : Value Scheme -> Builder { a | scheme : Available } slotCaps msg -> Builder { a | scheme : Used } slotCaps msg
withScheme value_ =
    B.withAttribute (scheme value_)


{-| Pipe form of `variant` — consumes its capability (write-once).
-}
withVariant : Value Variant -> Builder { a | variant : Available } slotCaps msg -> Builder { a | variant : Used } slotCaps msg
withVariant value_ =
    B.withAttribute (variant value_)
