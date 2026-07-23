module M3e.Paginator exposing
    ( view, build, toElement
    , Is, Attrs, FirstPageIconSlot, LastPageIconSlot, NextPageIconSlot, PreviousPageIconSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
    , PageSizeVariant, pageSizeVariant
    , disabled, firstPageLabel, hidePageSize, itemsPerPageLabel, lastPageLabel, length, nextPageLabel, pageIndex, pageSize, pageSizes, previousPageLabel, showFirstLastButtons, onPage
    , firstPageIcon, lastPageIcon, nextPageIcon, previousPageIcon
    , withClass, withDisabled, withFirstPageIcon, withFirstPageLabel, withHidePageSize, withId, withItemsPerPageLabel, withLastPageIcon, withLastPageLabel, withLength, withNextPageIcon, withNextPageLabel, withOnPage, withPageIndex, withPageSize, withPageSizeVariant, withPageSizes, withPreviousPageIcon, withPreviousPageLabel, withShowFirstLastButtons, withSlot, withStyle
    )

{-| The `m3e-paginator` component — strict per-component surface.

Provides navigation for paged information, typically used with a table.

@docs view, build, toElement
@docs Is, Attrs, FirstPageIconSlot, LastPageIconSlot, NextPageIconSlot, PreviousPageIconSlot, ChildAdmittedBy, Builder, AttrCaps, SlotCaps
@docs PageSizeVariant, pageSizeVariant
@docs disabled, firstPageLabel, hidePageSize, itemsPerPageLabel, lastPageLabel, length, nextPageLabel, pageIndex, pageSize, pageSizes, previousPageLabel, showFirstLastButtons, onPage
@docs firstPageIcon, lastPageIcon, nextPageIcon, previousPageIcon
@docs withClass, withDisabled, withFirstPageIcon, withFirstPageLabel, withHidePageSize, withId, withItemsPerPageLabel, withLastPageIcon, withLastPageLabel, withLength, withNextPageIcon, withNextPageLabel, withOnPage, withPageIndex, withPageSize, withPageSizeVariant, withPageSizes, withPreviousPageIcon, withPreviousPageLabel, withShowFirstLastButtons, withSlot, withStyle

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element as El exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Value as Val exposing (Value)
import Json.Decode
import M3e.Attributes as A
import M3e.Build.Internal as B
import M3e.Events as Ev
import M3e.Html as H
import M3e.Kind exposing (Available, Brand, Ctx, Used)


{-| The kind row `m3e-paginator` produces (open — composes into any slot naming it).
-}
type alias Is s =
    { s | paginator : Brand }


{-| The closed attribute-capability row.
-}
type alias Attrs =
    { class : Supported
    , disabled : Supported
    , firstPageLabel : Supported
    , hidePageSize : Supported
    , id : Supported
    , itemsPerPageLabel : Supported
    , lastPageLabel : Supported
    , length : Supported
    , nextPageLabel : Supported
    , onPage : Supported
    , pageIndex : Supported
    , pageSize : Supported
    , pageSizeVariant : Supported
    , pageSizes : Supported
    , previousPageLabel : Supported
    , showFirstLastButtons : Supported
    , slot : Supported
    , style : Supported
    }


{-| The kinds the `first-page-icon` slot admits.
-}
type alias FirstPageIconSlot =
    { sharedIcon : Shared }


{-| The kinds the `last-page-icon` slot admits.
-}
type alias LastPageIconSlot =
    { sharedIcon : Shared }


{-| The kinds the `next-page-icon` slot admits.
-}
type alias NextPageIconSlot =
    { sharedIcon : Shared }


{-| The kinds the `previous-page-icon` slot admits.
-}
type alias PreviousPageIconSlot =
    { sharedIcon : Shared }


{-| The context demand this container injects into each child's admittedBy row.
-}
type alias ChildAdmittedBy childAdm =
    { childAdm | paginator : Ctx }


{-| The `pageSizeVariant` values valid on this component (compile-tight narrowing).
-}
type alias PageSizeVariant =
    { filled : Supported
    , outlined : Supported
    }


{-| Standard constructor: `[attributes] [children]`.
-}
view :
    List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
view =
    H.paginator


{-| The appearance variant of the page size field. (default: `"outlined"`)
-}
pageSizeVariant : Value PageSizeVariant -> Attr { c | pageSizeVariant : Supported } msg
pageSizeVariant value_ =
    Ir.attribute "page-size-variant" (Val.toString value_)


{-| See `M3e.Attributes.disabled`.
-}
disabled : Bool -> Attr { c | disabled : Supported } msg
disabled =
    A.disabled


{-| See `M3e.Attributes.firstPageLabel`.
-}
firstPageLabel : String -> Attr { c | firstPageLabel : Supported } msg
firstPageLabel =
    A.firstPageLabel


{-| See `M3e.Attributes.hidePageSize`.
-}
hidePageSize : Bool -> Attr { c | hidePageSize : Supported } msg
hidePageSize =
    A.hidePageSize


{-| See `M3e.Attributes.itemsPerPageLabel`.
-}
itemsPerPageLabel : String -> Attr { c | itemsPerPageLabel : Supported } msg
itemsPerPageLabel =
    A.itemsPerPageLabel


{-| See `M3e.Attributes.lastPageLabel`.
-}
lastPageLabel : String -> Attr { c | lastPageLabel : Supported } msg
lastPageLabel =
    A.lastPageLabel


{-| See `M3e.Attributes.length`.
-}
length : Float -> Attr { c | length : Supported } msg
length =
    A.length


{-| See `M3e.Attributes.nextPageLabel`.
-}
nextPageLabel : String -> Attr { c | nextPageLabel : Supported } msg
nextPageLabel =
    A.nextPageLabel


{-| See `M3e.Attributes.pageIndex`.
-}
pageIndex : Float -> Attr { c | pageIndex : Supported } msg
pageIndex =
    A.pageIndex


{-| See `M3e.Attributes.pageSize`.
-}
pageSize : String -> Attr { c | pageSize : Supported } msg
pageSize =
    A.pageSize


{-| See `M3e.Attributes.pageSizes`.
-}
pageSizes : String -> Attr { c | pageSizes : Supported } msg
pageSizes =
    A.pageSizes


{-| See `M3e.Attributes.previousPageLabel`.
-}
previousPageLabel : String -> Attr { c | previousPageLabel : Supported } msg
previousPageLabel =
    A.previousPageLabel


{-| See `M3e.Attributes.showFirstLastButtons`.
-}
showFirstLastButtons : Bool -> Attr { c | showFirstLastButtons : Supported } msg
showFirstLastButtons =
    A.showFirstLastButtons


{-| Typed `page` event: decodes `detail.pageIndex` as String.
-}
onPage : (String -> msg) -> Attr { c | onPage : Supported } msg
onPage toMsg =
    Ir.on "page" (Json.Decode.map toMsg (Json.Decode.at [ "detail", "pageIndex" ] Json.Decode.string))


{-| Place an element into the named `first-page-icon` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
firstPageIcon : Element FirstPageIconSlot admittedBy msg -> Element free freeAdmittedBy msg
firstPageIcon element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "first-page-icon") (El.toNode element))


{-| Place an element into the named `last-page-icon` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
lastPageIcon : Element LastPageIconSlot admittedBy msg -> Element free freeAdmittedBy msg
lastPageIcon element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "last-page-icon") (El.toNode element))


{-| Place an element into the named `next-page-icon` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
nextPageIcon : Element NextPageIconSlot admittedBy msg -> Element free freeAdmittedBy msg
nextPageIcon element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "next-page-icon") (El.toNode element))


{-| Place an element into the named `previous-page-icon` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
previousPageIcon : Element PreviousPageIconSlot admittedBy msg -> Element free freeAdmittedBy msg
previousPageIcon element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "previous-page-icon") (El.toNode element))


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
    , firstPageLabel : Available
    , hidePageSize : Available
    , id : Available
    , itemsPerPageLabel : Available
    , lastPageLabel : Available
    , length : Available
    , nextPageLabel : Available
    , onPage : Available
    , pageIndex : Available
    , pageSize : Available
    , pageSizeVariant : Available
    , pageSizes : Available
    , previousPageLabel : Available
    , showFirstLastButtons : Available
    , slot : Available
    , style : Available
    }


{-| Every singular named-slot capability, still writable.
-}
type alias SlotCaps =
    { firstPageIcon : Available
    , lastPageIcon : Available
    , nextPageIcon : Available
    , previousPageIcon : Available
    }


{-| Seed the pipe-builder.
-}
build : Builder AttrCaps SlotCaps msg
build =
    B.init "m3e-paginator" [] []


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


{-| Pipe form of `firstPageLabel` — consumes its capability (write-once).
-}
withFirstPageLabel : String -> Builder { a | firstPageLabel : Available } slotCaps msg -> Builder { a | firstPageLabel : Used } slotCaps msg
withFirstPageLabel value_ =
    B.withAttribute (A.firstPageLabel value_)


{-| Pipe form of `hidePageSize` — consumes its capability (write-once).
-}
withHidePageSize : Bool -> Builder { a | hidePageSize : Available } slotCaps msg -> Builder { a | hidePageSize : Used } slotCaps msg
withHidePageSize value_ =
    B.withAttribute (A.hidePageSize value_)


{-| Pipe form of `itemsPerPageLabel` — consumes its capability (write-once).
-}
withItemsPerPageLabel : String -> Builder { a | itemsPerPageLabel : Available } slotCaps msg -> Builder { a | itemsPerPageLabel : Used } slotCaps msg
withItemsPerPageLabel value_ =
    B.withAttribute (A.itemsPerPageLabel value_)


{-| Pipe form of `lastPageLabel` — consumes its capability (write-once).
-}
withLastPageLabel : String -> Builder { a | lastPageLabel : Available } slotCaps msg -> Builder { a | lastPageLabel : Used } slotCaps msg
withLastPageLabel value_ =
    B.withAttribute (A.lastPageLabel value_)


{-| Pipe form of `length` — consumes its capability (write-once).
-}
withLength : Float -> Builder { a | length : Available } slotCaps msg -> Builder { a | length : Used } slotCaps msg
withLength value_ =
    B.withAttribute (A.length value_)


{-| Pipe form of `nextPageLabel` — consumes its capability (write-once).
-}
withNextPageLabel : String -> Builder { a | nextPageLabel : Available } slotCaps msg -> Builder { a | nextPageLabel : Used } slotCaps msg
withNextPageLabel value_ =
    B.withAttribute (A.nextPageLabel value_)


{-| Pipe form of `pageIndex` — consumes its capability (write-once).
-}
withPageIndex : Float -> Builder { a | pageIndex : Available } slotCaps msg -> Builder { a | pageIndex : Used } slotCaps msg
withPageIndex value_ =
    B.withAttribute (A.pageIndex value_)


{-| Pipe form of `pageSize` — consumes its capability (write-once).
-}
withPageSize : String -> Builder { a | pageSize : Available } slotCaps msg -> Builder { a | pageSize : Used } slotCaps msg
withPageSize value_ =
    B.withAttribute (A.pageSize value_)


{-| Pipe form of `pageSizeVariant` — consumes its capability (write-once).
-}
withPageSizeVariant : Value PageSizeVariant -> Builder { a | pageSizeVariant : Available } slotCaps msg -> Builder { a | pageSizeVariant : Used } slotCaps msg
withPageSizeVariant value_ =
    B.withAttribute (pageSizeVariant value_)


{-| Pipe form of `pageSizes` — consumes its capability (write-once).
-}
withPageSizes : String -> Builder { a | pageSizes : Available } slotCaps msg -> Builder { a | pageSizes : Used } slotCaps msg
withPageSizes value_ =
    B.withAttribute (A.pageSizes value_)


{-| Pipe form of `previousPageLabel` — consumes its capability (write-once).
-}
withPreviousPageLabel : String -> Builder { a | previousPageLabel : Available } slotCaps msg -> Builder { a | previousPageLabel : Used } slotCaps msg
withPreviousPageLabel value_ =
    B.withAttribute (A.previousPageLabel value_)


{-| Pipe form of `showFirstLastButtons` — consumes its capability (write-once).
-}
withShowFirstLastButtons : Bool -> Builder { a | showFirstLastButtons : Available } slotCaps msg -> Builder { a | showFirstLastButtons : Used } slotCaps msg
withShowFirstLastButtons value_ =
    B.withAttribute (A.showFirstLastButtons value_)


{-| Pipe form of `onPage` — consumes its capability (write-once).
-}
withOnPage : (String -> msg) -> Builder { a | onPage : Available } slotCaps msg -> Builder { a | onPage : Used } slotCaps msg
withOnPage value_ =
    B.withAttribute (onPage value_)


{-| Pipe form of the `first-page-icon` slot — consumes its capability (write-once).
-}
withFirstPageIcon : Element FirstPageIconSlot admittedBy msg -> Builder attrCaps { s | firstPageIcon : Available } msg -> Builder attrCaps { s | firstPageIcon : Used } msg
withFirstPageIcon element =
    B.withChild (El.toNode (firstPageIcon element))


{-| Pipe form of the `last-page-icon` slot — consumes its capability (write-once).
-}
withLastPageIcon : Element LastPageIconSlot admittedBy msg -> Builder attrCaps { s | lastPageIcon : Available } msg -> Builder attrCaps { s | lastPageIcon : Used } msg
withLastPageIcon element =
    B.withChild (El.toNode (lastPageIcon element))


{-| Pipe form of the `next-page-icon` slot — consumes its capability (write-once).
-}
withNextPageIcon : Element NextPageIconSlot admittedBy msg -> Builder attrCaps { s | nextPageIcon : Available } msg -> Builder attrCaps { s | nextPageIcon : Used } msg
withNextPageIcon element =
    B.withChild (El.toNode (nextPageIcon element))


{-| Pipe form of the `previous-page-icon` slot — consumes its capability (write-once).
-}
withPreviousPageIcon : Element PreviousPageIconSlot admittedBy msg -> Builder attrCaps { s | previousPageIcon : Available } msg -> Builder attrCaps { s | previousPageIcon : Used } msg
withPreviousPageIcon element =
    B.withChild (El.toNode (previousPageIcon element))
