module M3e.FilterChipSet exposing
    ( view, build, toElement
    , Is, Attrs, Content, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , disabled, hideSelectionIndicator, multi, name, vertical, onChange, onBeforeinput, onInput
    , withChild, withClass, withDisabled, withHideSelectionIndicator, withId, withMulti, withName, withOnBeforeinput, withOnChange, withOnInput, withSlot, withStyle, withVertical
    )

{-| The `m3e-filter-chip-set` component — strict per-component surface.

A container that organizes filter chips into a cohesive group, enabling selection and
deselection of values used to refine content or trigger contextual behavior.

@docs view, build, toElement
@docs Is, Attrs, Content, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs disabled, hideSelectionIndicator, multi, name, vertical, onChange, onBeforeinput, onInput
@docs withChild, withClass, withDisabled, withHideSelectionIndicator, withId, withMulti, withName, withOnBeforeinput, withOnChange, withOnInput, withSlot, withStyle, withVertical

-}

import Html.Attributes
import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Supported)
import Json.Encode
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Events as Ev
import M3e.Html as H
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-filter-chip-set` produces (open — composes into any slot naming it).
-}
type alias Is s =
    { s | filterChipSet : Brand }


{-| The closed attribute-capability row.
-}
type alias Attrs =
    { class : Supported
    , disabled : Supported
    , hideSelectionIndicator : Supported
    , id : Supported
    , multi : Supported
    , name : Supported
    , onBeforeinput : Supported
    , onChange : Supported
    , onInput : Supported
    , slot : Supported
    , style : Supported
    , vertical : Supported
    }


{-| The kinds the default slot admits.
-}
type alias Content =
    { filterChip : Brand }


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    { childAdm | filterChipSet : Ctx }


{-| Standard constructor: `[attributes] [children]`.
-}
view :
    List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
view =
    H.filterChipSet


{-| See `M3e.Attributes.disabled`.
-}
disabled : Bool -> Attr { c | disabled : Supported } msg
disabled =
    A.disabled


{-| See `M3e.Attributes.hideSelectionIndicator`.
-}
hideSelectionIndicator : Bool -> Attr { c | hideSelectionIndicator : Supported } msg
hideSelectionIndicator =
    A.hideSelectionIndicator


{-| See `M3e.Attributes.multi`.
-}
multi : Bool -> Attr { c | multi : Supported } msg
multi =
    A.multi


{-| The name that identifies the element when submitting the associated form.
-}
name : String -> Attr { c | name : Supported } msg
name value_ =
    Ir.attribute "name" value_


{-| See `M3e.Attributes.vertical`.
-}
vertical : Bool -> Attr { c | vertical : Supported } msg
vertical =
    A.vertical


{-| See `M3e.Events.onChange`.
-}
onChange : msg -> Attr { c | onChange : Supported } msg
onChange =
    Ev.onChange


{-| See `M3e.Events.onBeforeinput`.
-}
onBeforeinput : msg -> Attr { c | onBeforeinput : Supported } msg
onBeforeinput =
    Ev.onBeforeinput


{-| See `M3e.Events.onInput`.
-}
onInput : msg -> Attr { c | onInput : Supported } msg
onInput =
    Ev.onInput


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
    , hideSelectionIndicator : Available
    , id : Available
    , multi : Available
    , name : Available
    , onBeforeinput : Available
    , onChange : Available
    , onInput : Available
    , slot : Available
    , style : Available
    , vertical : Available
    }


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    {}


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg
build =
    B.init "m3e-filter-chip-set" [] []


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


{-| Pipe form of `hideSelectionIndicator` — consumes its capability (write-once).
-}
withHideSelectionIndicator : Bool -> Builder { a | hideSelectionIndicator : Available } slotCaps msg -> Builder { a | hideSelectionIndicator : Used } slotCaps msg
withHideSelectionIndicator value_ =
    B.withAttribute (A.hideSelectionIndicator value_)


{-| Pipe form of `multi` — consumes its capability (write-once).
-}
withMulti : Bool -> Builder { a | multi : Available } slotCaps msg -> Builder { a | multi : Used } slotCaps msg
withMulti value_ =
    B.withAttribute (A.multi value_)


{-| Pipe form of `name` — consumes its capability (write-once).
-}
withName : String -> Builder { a | name : Available } slotCaps msg -> Builder { a | name : Used } slotCaps msg
withName value_ =
    B.withAttribute (Ir.attribute "name" value_)


{-| Pipe form of `vertical` — consumes its capability (write-once).
-}
withVertical : Bool -> Builder { a | vertical : Available } slotCaps msg -> Builder { a | vertical : Used } slotCaps msg
withVertical value_ =
    B.withAttribute (A.vertical value_)


{-| Pipe form of `onChange` — consumes its capability (write-once).
-}
withOnChange : msg -> Builder { a | onChange : Available } slotCaps msg -> Builder { a | onChange : Used } slotCaps msg
withOnChange value_ =
    B.withAttribute (Ev.onChange value_)


{-| Pipe form of `onBeforeinput` — consumes its capability (write-once).
-}
withOnBeforeinput : msg -> Builder { a | onBeforeinput : Available } slotCaps msg -> Builder { a | onBeforeinput : Used } slotCaps msg
withOnBeforeinput value_ =
    B.withAttribute (Ev.onBeforeinput value_)


{-| Pipe form of `onInput` — consumes its capability (write-once).
-}
withOnInput : msg -> Builder { a | onInput : Available } slotCaps msg -> Builder { a | onInput : Used } slotCaps msg
withOnInput value_ =
    B.withAttribute (Ev.onInput value_)


{-| Pipe form of a default-slot child (repeatable).
-}
withChild : Element Content (ChildAdmittedBy childAdm) msg -> Builder attrCaps slotCaps msg -> Builder attrCaps slotCaps msg
withChild element =
    B.withChild (El.toNode element)
