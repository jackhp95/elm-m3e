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
import HtmlIr.Element exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Node exposing (Node)
import HtmlIr.Value exposing (Value)
import M3e.Attributes
import M3e.Events
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
view attrs children =
    Ir.fromNode (Ir.node "m3e-paginator" attrs (List.map HtmlIr.Element.toNode children))


{-| Narrowed value setter for `pageSizeVariant`. Tokens come from `M3e.Values`.
-}
pageSizeVariant : Value PageSizeVariant -> Attr { c | pageSizeVariant : Supported } msg
pageSizeVariant value_ =
    Ir.attribute "page-size-variant" (HtmlIr.Value.toString value_)


{-| See `M3e.Attributes.disabled`.
-}
disabled : Bool -> Attr { c | disabled : Supported } msg
disabled =
    M3e.Attributes.disabled


{-| See `M3e.Attributes.firstPageLabel`.
-}
firstPageLabel : String -> Attr { c | firstPageLabel : Supported } msg
firstPageLabel =
    M3e.Attributes.firstPageLabel


{-| See `M3e.Attributes.hidePageSize`.
-}
hidePageSize : Bool -> Attr { c | hidePageSize : Supported } msg
hidePageSize =
    M3e.Attributes.hidePageSize


{-| See `M3e.Attributes.itemsPerPageLabel`.
-}
itemsPerPageLabel : String -> Attr { c | itemsPerPageLabel : Supported } msg
itemsPerPageLabel =
    M3e.Attributes.itemsPerPageLabel


{-| See `M3e.Attributes.lastPageLabel`.
-}
lastPageLabel : String -> Attr { c | lastPageLabel : Supported } msg
lastPageLabel =
    M3e.Attributes.lastPageLabel


{-| See `M3e.Attributes.length`.
-}
length : Float -> Attr { c | length : Supported } msg
length =
    M3e.Attributes.length


{-| See `M3e.Attributes.nextPageLabel`.
-}
nextPageLabel : String -> Attr { c | nextPageLabel : Supported } msg
nextPageLabel =
    M3e.Attributes.nextPageLabel


{-| See `M3e.Attributes.pageIndex`.
-}
pageIndex : Float -> Attr { c | pageIndex : Supported } msg
pageIndex =
    M3e.Attributes.pageIndex


{-| See `M3e.Attributes.pageSize`.
-}
pageSize : String -> Attr { c | pageSize : Supported } msg
pageSize =
    M3e.Attributes.pageSize


{-| See `M3e.Attributes.pageSizes`.
-}
pageSizes : String -> Attr { c | pageSizes : Supported } msg
pageSizes =
    M3e.Attributes.pageSizes


{-| See `M3e.Attributes.previousPageLabel`.
-}
previousPageLabel : String -> Attr { c | previousPageLabel : Supported } msg
previousPageLabel =
    M3e.Attributes.previousPageLabel


{-| See `M3e.Attributes.showFirstLastButtons`.
-}
showFirstLastButtons : Bool -> Attr { c | showFirstLastButtons : Supported } msg
showFirstLastButtons =
    M3e.Attributes.showFirstLastButtons


{-| See `M3e.Events.onPage`.
-}
onPage : msg -> Attr { c | onPage : Supported } msg
onPage =
    M3e.Events.onPage


{-| Place an element into the named `first-page-icon` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
firstPageIcon : Element FirstPageIconSlot admittedBy msg -> Element free freeAdmittedBy msg
firstPageIcon element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "first-page-icon") (HtmlIr.Element.toNode element))


{-| Place an element into the named `last-page-icon` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
lastPageIcon : Element LastPageIconSlot admittedBy msg -> Element free freeAdmittedBy msg
lastPageIcon element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "last-page-icon") (HtmlIr.Element.toNode element))


{-| Place an element into the named `next-page-icon` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
nextPageIcon : Element NextPageIconSlot admittedBy msg -> Element free freeAdmittedBy msg
nextPageIcon element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "next-page-icon") (HtmlIr.Element.toNode element))


{-| Place an element into the named `previous-page-icon` slot (input constrained to the
slot's kinds; output row free so it composes into the child list).
-}
previousPageIcon : Element PreviousPageIconSlot admittedBy msg -> Element free freeAdmittedBy msg
previousPageIcon element =
    Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" "previous-page-icon") (HtmlIr.Element.toNode element))


{-| The pipe-builder: capabilities are consumed Available→Used, so writing
a singular attribute or slot twice is unwritable.
-}
type Builder attrCaps slotCaps msg
    = Builder { attrs : List (Attr Attrs msg), children : List (Node msg) }


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
    Builder { attrs = [], children = [] }


{-| Close the pipe-builder.
-}
toElement : Builder attrCaps slotCaps msg -> Element (Is s) admittedBy msg
toElement (Builder b) =
    Ir.fromNode (Ir.node "m3e-paginator" (List.reverse b.attrs) (List.reverse b.children))


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


{-| Pipe form of `firstPageLabel` — consumes its capability (write-once).
-}
withFirstPageLabel : String -> Builder { a | firstPageLabel : Available } slotCaps msg -> Builder { a | firstPageLabel : Used } slotCaps msg
withFirstPageLabel value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.firstPageLabel value_ :: b.attrs }


{-| Pipe form of `hidePageSize` — consumes its capability (write-once).
-}
withHidePageSize : Bool -> Builder { a | hidePageSize : Available } slotCaps msg -> Builder { a | hidePageSize : Used } slotCaps msg
withHidePageSize value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.hidePageSize value_ :: b.attrs }


{-| Pipe form of `itemsPerPageLabel` — consumes its capability (write-once).
-}
withItemsPerPageLabel : String -> Builder { a | itemsPerPageLabel : Available } slotCaps msg -> Builder { a | itemsPerPageLabel : Used } slotCaps msg
withItemsPerPageLabel value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.itemsPerPageLabel value_ :: b.attrs }


{-| Pipe form of `lastPageLabel` — consumes its capability (write-once).
-}
withLastPageLabel : String -> Builder { a | lastPageLabel : Available } slotCaps msg -> Builder { a | lastPageLabel : Used } slotCaps msg
withLastPageLabel value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.lastPageLabel value_ :: b.attrs }


{-| Pipe form of `length` — consumes its capability (write-once).
-}
withLength : Float -> Builder { a | length : Available } slotCaps msg -> Builder { a | length : Used } slotCaps msg
withLength value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.length value_ :: b.attrs }


{-| Pipe form of `nextPageLabel` — consumes its capability (write-once).
-}
withNextPageLabel : String -> Builder { a | nextPageLabel : Available } slotCaps msg -> Builder { a | nextPageLabel : Used } slotCaps msg
withNextPageLabel value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.nextPageLabel value_ :: b.attrs }


{-| Pipe form of `pageIndex` — consumes its capability (write-once).
-}
withPageIndex : Float -> Builder { a | pageIndex : Available } slotCaps msg -> Builder { a | pageIndex : Used } slotCaps msg
withPageIndex value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.pageIndex value_ :: b.attrs }


{-| Pipe form of `pageSize` — consumes its capability (write-once).
-}
withPageSize : String -> Builder { a | pageSize : Available } slotCaps msg -> Builder { a | pageSize : Used } slotCaps msg
withPageSize value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.pageSize value_ :: b.attrs }


{-| Pipe form of `pageSizeVariant` — consumes its capability (write-once).
-}
withPageSizeVariant : Value PageSizeVariant -> Builder { a | pageSizeVariant : Available } slotCaps msg -> Builder { a | pageSizeVariant : Used } slotCaps msg
withPageSizeVariant value_ (Builder b) =
    Builder { b | attrs = pageSizeVariant value_ :: b.attrs }


{-| Pipe form of `pageSizes` — consumes its capability (write-once).
-}
withPageSizes : String -> Builder { a | pageSizes : Available } slotCaps msg -> Builder { a | pageSizes : Used } slotCaps msg
withPageSizes value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.pageSizes value_ :: b.attrs }


{-| Pipe form of `previousPageLabel` — consumes its capability (write-once).
-}
withPreviousPageLabel : String -> Builder { a | previousPageLabel : Available } slotCaps msg -> Builder { a | previousPageLabel : Used } slotCaps msg
withPreviousPageLabel value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.previousPageLabel value_ :: b.attrs }


{-| Pipe form of `showFirstLastButtons` — consumes its capability (write-once).
-}
withShowFirstLastButtons : Bool -> Builder { a | showFirstLastButtons : Available } slotCaps msg -> Builder { a | showFirstLastButtons : Used } slotCaps msg
withShowFirstLastButtons value_ (Builder b) =
    Builder { b | attrs = M3e.Attributes.showFirstLastButtons value_ :: b.attrs }


{-| Pipe form of `onPage` — consumes its capability (write-once).
-}
withOnPage : msg -> Builder { a | onPage : Available } slotCaps msg -> Builder { a | onPage : Used } slotCaps msg
withOnPage value_ (Builder b) =
    Builder { b | attrs = M3e.Events.onPage value_ :: b.attrs }


{-| Pipe form of the `first-page-icon` slot — consumes its capability (write-once).
-}
withFirstPageIcon : Element FirstPageIconSlot admittedBy msg -> Builder attrCaps { s | firstPageIcon : Available } msg -> Builder attrCaps { s | firstPageIcon : Used } msg
withFirstPageIcon element (Builder b) =
    Builder { b | children = HtmlIr.Element.toNode (firstPageIcon element) :: b.children }


{-| Pipe form of the `last-page-icon` slot — consumes its capability (write-once).
-}
withLastPageIcon : Element LastPageIconSlot admittedBy msg -> Builder attrCaps { s | lastPageIcon : Available } msg -> Builder attrCaps { s | lastPageIcon : Used } msg
withLastPageIcon element (Builder b) =
    Builder { b | children = HtmlIr.Element.toNode (lastPageIcon element) :: b.children }


{-| Pipe form of the `next-page-icon` slot — consumes its capability (write-once).
-}
withNextPageIcon : Element NextPageIconSlot admittedBy msg -> Builder attrCaps { s | nextPageIcon : Available } msg -> Builder attrCaps { s | nextPageIcon : Used } msg
withNextPageIcon element (Builder b) =
    Builder { b | children = HtmlIr.Element.toNode (nextPageIcon element) :: b.children }


{-| Pipe form of the `previous-page-icon` slot — consumes its capability (write-once).
-}
withPreviousPageIcon : Element PreviousPageIconSlot admittedBy msg -> Builder attrCaps { s | previousPageIcon : Available } msg -> Builder attrCaps { s | previousPageIcon : Used } msg
withPreviousPageIcon element (Builder b) =
    Builder { b | children = HtmlIr.Element.toNode (previousPageIcon element) :: b.children }
