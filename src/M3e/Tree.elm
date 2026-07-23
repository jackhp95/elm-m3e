module M3e.Tree exposing
    ( view, build, toElement
    , Is, Attrs, Content, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , cascade, multi, onChange
    , withCascade, withChild, withClass, withId, withMulti, withOnChange, withSlot, withStyle
    )

{-| The `m3e-tree` component — strict per-component surface.

Presents hierarchical data in a tree structure.

@docs view, build, toElement
@docs Is, Attrs, Content, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs cascade, multi, onChange
@docs withCascade, withChild, withClass, withId, withMulti, withOnChange, withSlot, withStyle

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Events as Ev
import M3e.Html as H
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-tree` produces (open — composes into any slot naming it).
-}
type alias Is s =
    { s | tree : Brand }


{-| The closed attribute-capability row.
-}
type alias Attrs =
    { cascade : Supported
    , class : Supported
    , id : Supported
    , multi : Supported
    , onChange : Supported
    , slot : Supported
    , style : Supported
    }


{-| The kinds the default slot admits.
-}
type alias Content =
    { treeItem : Brand }


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    { childAdm | tree : Ctx }


{-| Standard constructor: `[attributes] [children]`.
-}
view :
    List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
view =
    H.tree


{-| See `M3e.Attributes.cascade`.
-}
cascade : Bool -> Attr { c | cascade : Supported } msg
cascade =
    A.cascade


{-| See `M3e.Attributes.multi`.
-}
multi : Bool -> Attr { c | multi : Supported } msg
multi =
    A.multi


{-| See `M3e.Events.onChange`.
-}
onChange : msg -> Attr { c | onChange : Supported } msg
onChange =
    Ev.onChange


{-| The pipe-builder: capabilities are consumed Available→Used, so writing
a singular attribute or slot twice is unwritable. Aliases the shared builder in
`Build.Internal`, closed over this component's `Attrs` row.
-}
type alias Builder attrCaps slotCaps msg =
    B.Builder Attrs attrCaps slotCaps msg


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    { cascade : Available
    , class : Available
    , id : Available
    , multi : Available
    , onChange : Available
    , slot : Available
    , style : Available
    }


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    {}


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg
build =
    B.init "m3e-tree" [] []


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


{-| Pipe form of `cascade` — consumes its capability (write-once).
-}
withCascade : Bool -> Builder { a | cascade : Available } slotCaps msg -> Builder { a | cascade : Used } slotCaps msg
withCascade value_ =
    B.withAttribute (A.cascade value_)


{-| Pipe form of `multi` — consumes its capability (write-once).
-}
withMulti : Bool -> Builder { a | multi : Available } slotCaps msg -> Builder { a | multi : Used } slotCaps msg
withMulti value_ =
    B.withAttribute (A.multi value_)


{-| Pipe form of `onChange` — consumes its capability (write-once).
-}
withOnChange : msg -> Builder { a | onChange : Available } slotCaps msg -> Builder { a | onChange : Used } slotCaps msg
withOnChange value_ =
    B.withAttribute (Ev.onChange value_)


{-| Pipe form of a default-slot child (repeatable).
-}
withChild : Element Content (ChildAdmittedBy childAdm) msg -> Builder attrCaps slotCaps msg -> Builder attrCaps slotCaps msg
withChild element =
    B.withChild (El.toNode element)
