module M3e.Build.Paginator exposing
    ( Builder, AttrCaps, SlotCaps, paginator, attr, disabled
    , firstPageLabel, hidePageSize, itemsPerPageLabel, lastPageLabel, length, nextPageLabel
    , pageIndex, pageSize, pageSizes, pageSizeVariant, previousPageLabel, showFirstLastButtons
    , onPage, firstPageIcon, previousPageIcon, nextPageIcon, lastPageIcon, build
    )

{-| The Build form for `<m3e-paginator>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Paginator as Paginator`.

@docs Builder, AttrCaps, SlotCaps, paginator, attr, disabled
@docs firstPageLabel, hidePageSize, itemsPerPageLabel, lastPageLabel, length, nextPageLabel
@docs pageIndex, pageSize, pageSizes, pageSizeVariant, previousPageLabel, showFirstLastButtons
@docs onPage, firstPageIcon, previousPageIcon, nextPageIcon, lastPageIcon, build

-}

import M3e.Build.Internal
import M3e.Element
import M3e.Element.Internal
import M3e.Html.Attr.Internal
import M3e.Html.Paginator
import M3e.Node
import M3e.Token


{-| Phantom-typed opaque builder for `<m3e-paginator>`.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder
        { kind
            | paginator : M3e.Token.Supported
        }
        attrCaps
        slotCaps
        msg


{-| Per-component attribute capability row for the phantom-typed Builder.
-}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , firstPageLabel : M3e.Build.Internal.Available
    , hidePageSize : M3e.Build.Internal.Available
    , itemsPerPageLabel : M3e.Build.Internal.Available
    , lastPageLabel : M3e.Build.Internal.Available
    , length : M3e.Build.Internal.Available
    , nextPageLabel : M3e.Build.Internal.Available
    , pageIndex : M3e.Build.Internal.Available
    , pageSize : M3e.Build.Internal.Available
    , pageSizes : M3e.Build.Internal.Available
    , pageSizeVariant : M3e.Build.Internal.Available
    , previousPageLabel : M3e.Build.Internal.Available
    , showFirstLastButtons : M3e.Build.Internal.Available
    , onPage : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder.
-}
type alias SlotCaps =
    { firstPageIcon : M3e.Build.Internal.Available
    , previousPageIcon : M3e.Build.Internal.Available
    , nextPageIcon : M3e.Build.Internal.Available
    , lastPageIcon : M3e.Build.Internal.Available
    }


{-| Seed a `Builder` for `<m3e-paginator>`.
-}
paginator : Builder AttrCaps SlotCaps msg kind
paginator =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
            (\erased_ ch_ ->
                M3e.Html.Paginator.paginator
                    (List.map M3e.Html.Attr.Internal.forget erased_)
                    ch_
            )
            []
            []
        )


{-| Inject an already-built universal `Attr` (e.g. from `M3e.Aria.*`) into the pipeline, appending it to the accumulated attrs. Unlike the typed per-attribute setters it consumes no phantom capability, so it can be applied any number of times.
-}
attr :
    M3e.Html.Attr.Internal.Attr caps msg
    -> Builder a s msg kind
    -> Builder a s msg kind
attr a_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget a_)
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether the element is disabled. (default: `false`)
-}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg kind
disabled v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.Paginator.disabled v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The accessible label given to the button used to move to the first page. (default: `"First page"`)
-}
firstPageLabel :
    String
    -> Builder { a | firstPageLabel : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | firstPageLabel : M3e.Build.Internal.Used } s msg kind
firstPageLabel v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget
                (M3e.Html.Paginator.firstPageLabel v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether to hide page size selection. (default: `false`)
-}
hidePageSize :
    Bool
    -> Builder { a | hidePageSize : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | hidePageSize : M3e.Build.Internal.Used } s msg kind
hidePageSize v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.Paginator.hidePageSize v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The label for the page size selector. (default: `"Items per page:"`)
-}
itemsPerPageLabel :
    String
    ->
        Builder
            { a
                | itemsPerPageLabel : M3e.Build.Internal.Available
            }
            s
            msg
            kind
    -> Builder { a | itemsPerPageLabel : M3e.Build.Internal.Used } s msg kind
itemsPerPageLabel v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget
                (M3e.Html.Paginator.itemsPerPageLabel v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| The accessible label given to the button used to move to the last page. (default: `"Last page"`)
-}
lastPageLabel :
    String
    -> Builder { a | lastPageLabel : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | lastPageLabel : M3e.Build.Internal.Used } s msg kind
lastPageLabel v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget
                (M3e.Html.Paginator.lastPageLabel v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| The length of the total number of items which are being paginated. (default: `0`)
-}
length :
    Float
    -> Builder { a | length : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | length : M3e.Build.Internal.Used } s msg kind
length v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.Paginator.length v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The accessible label given to the button used to move to the next page. (default: `"Next page"`)
-}
nextPageLabel :
    String
    -> Builder { a | nextPageLabel : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | nextPageLabel : M3e.Build.Internal.Used } s msg kind
nextPageLabel v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget
                (M3e.Html.Paginator.nextPageLabel v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| The zero-based page index of the displayed list of items. (default: `0`)
-}
pageIndex :
    Float
    -> Builder { a | pageIndex : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | pageIndex : M3e.Build.Internal.Used } s msg kind
pageIndex v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.Paginator.pageIndex v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The number of items to display in a page. (default: `50`)
-}
pageSize :
    M3e.Token.Value { number : M3e.Token.Supported, all : M3e.Token.Supported }
    -> Builder { a | pageSize : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | pageSize : M3e.Build.Internal.Used } s msg kind
pageSize v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.Paginator.pageSize v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| A comma separated list of available page sizes. (default: `"5,10,25,50,100"`)
-}
pageSizes :
    String
    -> Builder { a | pageSizes : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | pageSizes : M3e.Build.Internal.Used } s msg kind
pageSizes v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.Paginator.pageSizes v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The appearance variant of the page size field. (default: `"outlined"`)
-}
pageSizeVariant :
    M3e.Token.Value
        { filled : M3e.Token.Supported
        , outlined : M3e.Token.Supported
        }
    -> Builder { a | pageSizeVariant : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | pageSizeVariant : M3e.Build.Internal.Used } s msg kind
pageSizeVariant v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget
                (M3e.Html.Paginator.pageSizeVariant v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| The accessible label given to the button used to move to the previous page. (default: `"Previous page"`)
-}
previousPageLabel :
    String
    ->
        Builder
            { a
                | previousPageLabel : M3e.Build.Internal.Available
            }
            s
            msg
            kind
    -> Builder { a | previousPageLabel : M3e.Build.Internal.Used } s msg kind
previousPageLabel v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget
                (M3e.Html.Paginator.previousPageLabel v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether to show first/last buttons. (default: `false`)
-}
showFirstLastButtons :
    Bool
    ->
        Builder
            { a
                | showFirstLastButtons : M3e.Build.Internal.Available
            }
            s
            msg
            kind
    -> Builder { a | showFirstLastButtons : M3e.Build.Internal.Used } s msg kind
showFirstLastButtons v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget
                (M3e.Html.Paginator.showFirstLastButtons v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when a user selects a different page size or navigates to another page.
-}
onPage :
    (Int -> msg)
    -> Builder { a | onPage : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onPage : M3e.Build.Internal.Used } s msg kind
onPage v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.Paginator.onPage v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `first-page-icon` slot.
-}
firstPageIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> Builder a { s | firstPageIcon : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | firstPageIcon : M3e.Build.Internal.Used } msg kind
firstPageIcon el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Element.toNode (M3e.Element.withSlot "first-page-icon" el_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `previous-page-icon` slot.
-}
previousPageIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    ->
        Builder
            a
            { s
                | previousPageIcon : M3e.Build.Internal.Available
            }
            msg
            kind
    -> Builder a { s | previousPageIcon : M3e.Build.Internal.Used } msg kind
previousPageIcon el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Element.toNode (M3e.Element.withSlot "previous-page-icon" el_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `next-page-icon` slot.
-}
nextPageIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> Builder a { s | nextPageIcon : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | nextPageIcon : M3e.Build.Internal.Used } msg kind
nextPageIcon el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Element.toNode (M3e.Element.withSlot "next-page-icon" el_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `last-page-icon` slot.
-}
lastPageIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> Builder a { s | lastPageIcon : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | lastPageIcon : M3e.Build.Internal.Used } msg kind
lastPageIcon el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Element.toNode (M3e.Element.withSlot "last-page-icon" el_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-paginator>` element from a `Builder`.
-}
build :
    Builder a s msg kind
    -> M3e.Element.Element { paginator : M3e.Token.Supported } msg
build b_ =
    M3e.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)
