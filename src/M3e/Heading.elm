module M3e.Heading exposing
    ( view, el, build, toElement
    , Is, Attrs, Content, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , Size, size, Variant, variant
    , emphasized, level, tocIgnore
    , withChild, withClass, withEmphasized, withId, withLevel, withSize, withSlot, withStyle, withTocIgnore, withVariant
    )

{-| The `m3e-heading` component — strict per-component surface.

A heading to a page or section.

@docs view, el, build, toElement
@docs Is, Attrs, Content, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs Size, size, Variant, variant
@docs emphasized, level, tocIgnore
@docs withChild, withClass, withEmphasized, withId, withLevel, withSize, withSlot, withStyle, withTocIgnore, withVariant

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Node exposing (Node)
import HtmlIr.Value exposing (Value)
import M3e.Attributes
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-heading` produces (open — composes into any slot naming it).
-}
type alias Is s =
    { s | heading : Brand }


{-| The closed attribute-capability row.
-}
type alias Attrs =
    { class : Supported
    , emphasized : Supported
    , id : Supported
    , level : Supported
    , size : Supported
    , slot : Supported
    , style : Supported
    , tocIgnore : Supported
    , variant : Supported
    }


{-| The kinds the default slot admits.
-}
type alias Content =
    { sharedText : Shared }


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    { childAdm | heading : Ctx }


{-| The `size` values valid on this component (compile-tight narrowing).
-}
type alias Size =
    { large : Supported
    , medium : Supported
    , small : Supported
    }


{-| The `variant` values valid on this component (compile-tight narrowing).
-}
type alias Variant =
    { display : Supported
    , headline : Supported
    , label : Supported
    , title : Supported
    }


{-| Standard constructor: `[attributes] [children]`.
-}
view :
    List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
view attrs children =
    Ir.fromNode (Ir.node "m3e-heading" attrs (List.map HtmlIr.Element.toNode children))


{-| Required-content (and action) constructor — omissions are unwritable.
-}
el :
    { content : Element Content (ChildAdmittedBy childAdm) msg }
    -> List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el required_ attrs children =
    view attrs (required_.content :: children)


{-| Narrowed value setter for `size`. Tokens come from `M3e.Values`.
-}
size : Value Size -> Attr { c | size : Supported } msg
size value_ =
    Ir.attribute "size" (HtmlIr.Value.toString value_)


{-| Narrowed value setter for `variant`. Tokens come from `M3e.Values`.
-}
variant : Value Variant -> Attr { c | variant : Supported } msg
variant value_ =
    Ir.attribute "variant" (HtmlIr.Value.toString value_)


{-| See `M3e.Attributes.emphasized`.
-}
emphasized : Bool -> Attr { c | emphasized : Supported } msg
emphasized =
    M3e.Attributes.emphasized


{-| See `M3e.Attributes.level`.
-}
level : Int -> Attr { c | level : Supported } msg
level =
    M3e.Attributes.level


{-| See `M3e.Attributes.tocIgnore`.
-}
tocIgnore : Bool -> Attr { c | tocIgnore : Supported } msg
tocIgnore =
    M3e.Attributes.tocIgnore


{-| The pipe-builder: capabilities are consumed Available→Used, so writing
a singular attribute or slot twice is unwritable.
-}
type Builder attrCaps slotCaps msg
    = Builder { attrs : List (Attr Attrs msg), children : List (Node msg) }


{-| Every attribute/event capability, still writable.
-}
type alias AttrCaps =
    { class : Available
    , emphasized : Available
    , id : Available
    , level : Available
    , size : Available
    , slot : Available
    , style : Available
    , tocIgnore : Available
    , variant : Available
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
    Ir.fromNode (Ir.node "m3e-heading" (List.reverse b.attrs) (List.reverse b.children))


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


{-| Pipe form of `emphasized` — consumes its capability (write-once).
-}
withEmphasized : Bool -> Builder { a | emphasized : Available } slotCaps msg -> Builder { a | emphasized : Used } slotCaps msg
withEmphasized value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.emphasized value_ :: b.attrs }


{-| Pipe form of `level` — consumes its capability (write-once).
-}
withLevel : Int -> Builder { a | level : Available } slotCaps msg -> Builder { a | level : Used } slotCaps msg
withLevel value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.level value_ :: b.attrs }


{-| Pipe form of `size` — consumes its capability (write-once).
-}
withSize : Value Size -> Builder { a | size : Available } slotCaps msg -> Builder { a | size : Used } slotCaps msg
withSize value_ (Builder b) =
    Builder { b | attrs = size value_ :: b.attrs }


{-| Pipe form of `tocIgnore` — consumes its capability (write-once).
-}
withTocIgnore : Bool -> Builder { a | tocIgnore : Available } slotCaps msg -> Builder { a | tocIgnore : Used } slotCaps msg
withTocIgnore value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.tocIgnore value_ :: b.attrs }


{-| Pipe form of `variant` — consumes its capability (write-once).
-}
withVariant : Value Variant -> Builder { a | variant : Available } slotCaps msg -> Builder { a | variant : Used } slotCaps msg
withVariant value_ (Builder b) =
    Builder { b | attrs = variant value_ :: b.attrs }


{-| Pipe form of a default-slot child (repeatable).
-}
withChild : Element Content (ChildAdmittedBy childAdm) msg -> Builder attrCaps slotCaps msg -> Builder attrCaps slotCaps msg
withChild element (Builder b) =
    Builder { b | children = HtmlIr.Element.toNode element :: b.children }
