module M3e.Ripple exposing
    ( view, build, toElement
    , Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , centered, disabled, for, radius, unbounded
    , withCentered, withClass, withDisabled, withFor, withId, withRadius, withSlot, withStyle, withUnbounded
    )

{-| The `m3e-ripple` component — strict per-component surface.

Connects user input to screen reactions using ripples.

@docs view, build, toElement
@docs Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs centered, disabled, for, radius, unbounded
@docs withCentered, withClass, withDisabled, withFor, withId, withRadius, withSlot, withStyle, withUnbounded

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Html as H
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-ripple` produces (open — composes into any slot naming it).
-}
type alias Is s =
    { s | ripple : Brand }


{-| The closed attribute-capability row.
-}
type alias Attrs =
    { centered : Supported
    , class : Supported
    , disabled : Supported
    , for : Supported
    , id : Supported
    , radius : Supported
    , slot : Supported
    , style : Supported
    , unbounded : Supported
    }


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    { childAdm | ripple : Ctx }


{-| Standard constructor: `[attributes] [children]`.
-}
view :
    List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
view =
    H.ripple


{-| See `M3e.Attributes.centered`.
-}
centered : Bool -> Attr { c | centered : Supported } msg
centered =
    A.centered


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


{-| See `M3e.Attributes.radius`.
-}
radius : Float -> Attr { c | radius : Supported } msg
radius =
    A.radius


{-| See `M3e.Attributes.unbounded`.
-}
unbounded : Bool -> Attr { c | unbounded : Supported } msg
unbounded =
    A.unbounded


{-| The pipe-builder: capabilities are consumed Available→Used, so writing
a singular attribute or slot twice is unwritable. Aliases the shared builder in
`Build.Internal`, closed over this component's `Attrs` row.
-}
type alias Builder attrCaps slotCaps msg =
    B.Builder Attrs attrCaps slotCaps msg


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    { centered : Available
    , class : Available
    , disabled : Available
    , for : Available
    , id : Available
    , radius : Available
    , slot : Available
    , style : Available
    , unbounded : Available
    }


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    {}


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg
build =
    B.init "m3e-ripple" [] []


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


{-| Pipe form of `centered` — consumes its capability (write-once).
-}
withCentered : Bool -> Builder { a | centered : Available } slotCaps msg -> Builder { a | centered : Used } slotCaps msg
withCentered value_ =
    B.withAttribute (A.centered value_)


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


{-| Pipe form of `radius` — consumes its capability (write-once).
-}
withRadius : Float -> Builder { a | radius : Available } slotCaps msg -> Builder { a | radius : Used } slotCaps msg
withRadius value_ =
    B.withAttribute (A.radius value_)


{-| Pipe form of `unbounded` — consumes its capability (write-once).
-}
withUnbounded : Bool -> Builder { a | unbounded : Available } slotCaps msg -> Builder { a | unbounded : Used } slotCaps msg
withUnbounded value_ =
    B.withAttribute (A.unbounded value_)
