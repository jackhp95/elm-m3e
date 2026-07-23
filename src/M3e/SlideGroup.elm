module M3e.SlideGroup exposing
    ( view, build, toElement
    , Is, Attrs, NextIconSlot, PrevIconSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , disabled, nextPageLabel, previousPageLabel, threshold, vertical
    , nextIcon, prevIcon
    , withChild, withClass, withDisabled, withId, withNextIcon, withNextPageLabel, withPrevIcon, withPreviousPageLabel, withSlot, withStyle, withThreshold, withVertical
    )

{-| The `m3e-slide-group` component — strict per-component surface.

Presents pagination controls used to scroll overflowing content.

@docs view, build, toElement
@docs Is, Attrs, NextIconSlot, PrevIconSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs disabled, nextPageLabel, previousPageLabel, threshold, vertical
@docs nextIcon, prevIcon
@docs withChild, withClass, withDisabled, withId, withNextIcon, withNextPageLabel, withPrevIcon, withPreviousPageLabel, withSlot, withStyle, withThreshold, withVertical

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Shared, Supported)
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Html as H
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-slide-group` produces (open — composes into any slot naming it).
-}
type alias Is s =
    { s | slideGroup : Brand }


{-| The closed attribute-capability row.
-}
type alias Attrs =
    { class : Supported
    , disabled : Supported
    , id : Supported
    , nextPageLabel : Supported
    , previousPageLabel : Supported
    , slot : Supported
    , style : Supported
    , threshold : Supported
    , vertical : Supported
    }


{-| The kinds the `next-icon` slot admits.
-}
type alias NextIconSlot =
    { sharedIcon : Shared }


{-| The kinds the `prev-icon` slot admits.
-}
type alias PrevIconSlot =
    { sharedIcon : Shared }


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    { childAdm | slideGroup : Ctx }


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
    H.slideGroup


{-| See `M3e.Attributes.disabled`.
-}
disabled : Bool -> Attr { c | disabled : Supported } msg
disabled =
    A.disabled


{-| See `M3e.Attributes.nextPageLabel`.
-}
nextPageLabel : String -> Attr { c | nextPageLabel : Supported } msg
nextPageLabel =
    A.nextPageLabel


{-| See `M3e.Attributes.previousPageLabel`.
-}
previousPageLabel : String -> Attr { c | previousPageLabel : Supported } msg
previousPageLabel =
    A.previousPageLabel


{-| See `M3e.Attributes.threshold`.
-}
threshold : Float -> Attr { c | threshold : Supported } msg
threshold =
    A.threshold


{-| See `M3e.Attributes.vertical`.
-}
vertical : Bool -> Attr { c | vertical : Supported } msg
vertical =
    A.vertical


{-| Place an element into the named `next-icon` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
nextIcon : Element NextIconSlot admittedBy msg -> Element free freeAdmittedBy msg
nextIcon element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "next-icon") (El.toNode element))


{-| Place an element into the named `prev-icon` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
prevIcon : Element PrevIconSlot admittedBy msg -> Element free freeAdmittedBy msg
prevIcon element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "prev-icon") (El.toNode element))


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
    , id : Available
    , nextPageLabel : Available
    , previousPageLabel : Available
    , slot : Available
    , style : Available
    , threshold : Available
    , vertical : Available
    }


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    { nextIcon : Available
    , prevIcon : Available
    }


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg
build =
    B.init "m3e-slide-group" [] []


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


{-| Pipe form of `nextPageLabel` — consumes its capability (write-once).
-}
withNextPageLabel : String -> Builder { a | nextPageLabel : Available } slotCaps msg -> Builder { a | nextPageLabel : Used } slotCaps msg
withNextPageLabel value_ =
    B.withAttribute (A.nextPageLabel value_)


{-| Pipe form of `previousPageLabel` — consumes its capability (write-once).
-}
withPreviousPageLabel : String -> Builder { a | previousPageLabel : Available } slotCaps msg -> Builder { a | previousPageLabel : Used } slotCaps msg
withPreviousPageLabel value_ =
    B.withAttribute (A.previousPageLabel value_)


{-| Pipe form of `threshold` — consumes its capability (write-once).
-}
withThreshold : Float -> Builder { a | threshold : Available } slotCaps msg -> Builder { a | threshold : Used } slotCaps msg
withThreshold value_ =
    B.withAttribute (A.threshold value_)


{-| Pipe form of `vertical` — consumes its capability (write-once).
-}
withVertical : Bool -> Builder { a | vertical : Available } slotCaps msg -> Builder { a | vertical : Used } slotCaps msg
withVertical value_ =
    B.withAttribute (A.vertical value_)


{-| Pipe form of the `next-icon` slot — consumes its capability (write-once).
-}
withNextIcon : Element NextIconSlot admittedBy msg -> Builder attrCaps { s | nextIcon : Available } msg -> Builder attrCaps { s | nextIcon : Used } msg
withNextIcon element =
    B.withChild (El.toNode (nextIcon element))


{-| Pipe form of the `prev-icon` slot — consumes its capability (write-once).
-}
withPrevIcon : Element PrevIconSlot admittedBy msg -> Builder attrCaps { s | prevIcon : Available } msg -> Builder attrCaps { s | prevIcon : Used } msg
withPrevIcon element =
    B.withChild (El.toNode (prevIcon element))


{-| Pipe form of a default-slot child (repeatable).
-}
withChild : Element childAccepts (ChildAdmittedBy childAdm) msg -> Builder attrCaps slotCaps msg -> Builder attrCaps slotCaps msg
withChild element =
    B.withChild (El.toNode element)
