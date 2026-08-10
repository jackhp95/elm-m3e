module M3e.Component.Icon exposing
    ( view, build, toElement
    , Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , Grade, grade, Variant, variant
    , filled, name, opticalSize, weight
    , withClass, withFilled, withGrade, withId, withName, withOpticalSize, withSlot, withStyle, withVariant, withWeight
    )

{-| The `m3e-icon` component — strict per-component surface.

A small symbol used to easily identify an action or category.

@docs view, build, toElement
@docs Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs Grade, grade, Variant, variant
@docs filled, name, opticalSize, weight
@docs withClass, withFilled, withGrade, withId, withName, withOpticalSize, withSlot, withStyle, withVariant, withWeight

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Value as Val exposing (Value)
import Json.Encode
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Html as H
import M3e.Internal.Types.Icon
import M3e.Kind exposing (Available, Ctx, Used)


{-| The kind row `m3e-icon` produces — the SHARED icon atom kind, admissible
into any library's opted-in slot.
-}
type alias Is s =
    M3e.Internal.Types.Icon.Is s


{-| The closed attribute-capability row.
-}
type alias Attrs =
    M3e.Internal.Types.Icon.Attrs


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    M3e.Internal.Types.Icon.ChildAdmittedBy childAdm


{-| The `grade` values valid on this component (compile-tight narrowing).
-}
type alias Grade =
    M3e.Internal.Types.Icon.Grade


{-| The `variant` values valid on this component (compile-tight narrowing).
-}
type alias Variant =
    M3e.Internal.Types.Icon.Variant


{-| Standard constructor: `[attributes] [children]`.
-}
view :
    List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
view =
    H.icon


{-| The grade of the icon. (default: `"medium"`)
-}
grade : Value Grade -> Attr { c | grade : Supported } msg
grade value_ =
    Ir.attribute "grade" (Val.toString value_)


{-| The appearance variant of the icon. (default: `"outlined"`)
-}
variant : Value Variant -> Attr { c | variant : Supported } msg
variant value_ =
    Ir.attribute "variant" (Val.toString value_)


{-| See `M3e.Attributes.filled`.
-}
filled : Bool -> Attr { c | filled : Supported } msg
filled =
    A.filled


{-| The name of the icon. (default: `""`)
-}
name : String -> Attr { c | name : Supported } msg
name value_ =
    Ir.attribute "name" value_


{-| See `M3e.Attributes.opticalSize`.
-}
opticalSize : Float -> Attr { c | opticalSize : Supported } msg
opticalSize =
    A.opticalSize


{-| See `M3e.Attributes.weight`.
-}
weight : Int -> Attr { c | weight : Supported } msg
weight =
    A.weight


{-| The pipe-builder: capabilities are consumed Available→Used, so writing
a singular attribute or slot twice is unwritable. Aliases the shared builder in
`Build.Internal`, closed over this component's `Attrs` row and `Is s` kind.
-}
type alias Builder attrCaps slotCaps msg s =
    M3e.Internal.Types.Icon.Builder attrCaps slotCaps msg s


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    M3e.Internal.Types.Icon.AttrCaps


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    {}


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg kind
build =
    B.init "m3e-icon" [] []


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


{-| Pipe form of `filled` — consumes its capability (write-once).
-}
withFilled : Bool -> Builder { a | filled : Available } slotCaps msg kind -> Builder { a | filled : Used } slotCaps msg kind
withFilled value_ =
    B.withAttribute (A.filled value_)


{-| Pipe form of `grade` — consumes its capability (write-once).
-}
withGrade : Value Grade -> Builder { a | grade : Available } slotCaps msg kind -> Builder { a | grade : Used } slotCaps msg kind
withGrade value_ =
    B.withAttribute (grade value_)


{-| Pipe form of `name` — consumes its capability (write-once).
-}
withName : String -> Builder { a | name : Available } slotCaps msg kind -> Builder { a | name : Used } slotCaps msg kind
withName value_ =
    B.withAttribute (Ir.attribute "name" value_)


{-| Pipe form of `opticalSize` — consumes its capability (write-once).
-}
withOpticalSize : Float -> Builder { a | opticalSize : Available } slotCaps msg kind -> Builder { a | opticalSize : Used } slotCaps msg kind
withOpticalSize value_ =
    B.withAttribute (A.opticalSize value_)


{-| Pipe form of `variant` — consumes its capability (write-once).
-}
withVariant : Value Variant -> Builder { a | variant : Available } slotCaps msg kind -> Builder { a | variant : Used } slotCaps msg kind
withVariant value_ =
    B.withAttribute (variant value_)


{-| Pipe form of `weight` — consumes its capability (write-once).
-}
withWeight : Int -> Builder { a | weight : Available } slotCaps msg kind -> Builder { a | weight : Used } slotCaps msg kind
withWeight value_ =
    B.withAttribute (A.weight value_)
