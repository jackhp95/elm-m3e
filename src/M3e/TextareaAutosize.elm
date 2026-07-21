module M3e.TextareaAutosize exposing
    ( view, build, toElement
    , Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , disabled, for, maxRows, minRows
    , withAriaLabel, withClass, withDisabled, withFor, withId, withMaxRows, withMinRows, withSlot, withStyle
    )

{-| The `m3e-textarea-autosize` component — strict per-component surface.

A non-visual element used to automatically resize a `textarea` to fit its content.

@docs view, build, toElement
@docs Is, Attrs, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs disabled, for, maxRows, minRows
@docs withAriaLabel, withClass, withDisabled, withFor, withId, withMaxRows, withMinRows, withSlot, withStyle

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import HtmlIr.Node exposing (Node)
import M3e.Attributes
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-textarea-autosize` produces (open — composes into any slot naming it).
-}
type alias Is s =
    { s | textareaAutosize : Brand }


{-| The closed attribute-capability row.
-}
type alias Attrs =
    { ariaLabel : Supported
    , class : Supported
    , disabled : Supported
    , for : Supported
    , id : Supported
    , maxRows : Supported
    , minRows : Supported
    , slot : Supported
    , style : Supported
    }


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    { childAdm | textareaAutosize : Ctx }


{-| Standard constructor: `[attributes] [children]`.
-}
view :
    List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
view attrs children =
    Ir.fromNode (Ir.node "m3e-textarea-autosize" attrs (List.map HtmlIr.Element.toNode children))


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


{-| See `M3e.Attributes.maxRows`.
-}
maxRows : Float -> Attr { c | maxRows : Supported } msg
maxRows =
    M3e.Attributes.maxRows


{-| See `M3e.Attributes.minRows`.
-}
minRows : Float -> Attr { c | minRows : Supported } msg
minRows =
    M3e.Attributes.minRows


{-| The pipe-builder: capabilities are consumed Available→Used, so writing
a singular attribute or slot twice is unwritable.
-}
type Builder attrCaps slotCaps msg
    = Builder { attrs : List (Attr Attrs msg), children : List (Node msg) }


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    { ariaLabel : Available
    , class : Available
    , disabled : Available
    , for : Available
    , id : Available
    , maxRows : Available
    , minRows : Available
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
    Builder { attrs = [], children = [] }


{-| Close the pipe-builder.
-}
toElement : Builder attrCaps slotCaps msg -> Element (Is s) admittedBy msg
toElement (Builder b) =
    Ir.fromNode (Ir.node "m3e-textarea-autosize" (List.reverse b.attrs) (List.reverse b.children))


{-| Pipe form of `ariaLabel` — consumes its capability (write-once).
-}
withAriaLabel : String -> Builder { a | ariaLabel : Available } slotCaps msg -> Builder { a | ariaLabel : Used } slotCaps msg
withAriaLabel value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.ariaLabel value_ :: b.attrs }


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


{-| Pipe form of `maxRows` — consumes its capability (write-once).
-}
withMaxRows : Float -> Builder { a | maxRows : Available } slotCaps msg -> Builder { a | maxRows : Used } slotCaps msg
withMaxRows value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.maxRows value_ :: b.attrs }


{-| Pipe form of `minRows` — consumes its capability (write-once).
-}
withMinRows : Float -> Builder { a | minRows : Available } slotCaps msg -> Builder { a | minRows : Used } slotCaps msg
withMinRows value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.minRows value_ :: b.attrs }
