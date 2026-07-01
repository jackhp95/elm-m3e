module M3e.Paginator exposing (disabled, firstPageIcon, firstPageLabel, hidePageSize, itemsPerPageLabel, lastPageIcon, lastPageLabel, length, nextPageIcon, nextPageLabel, onPage, pageIndex, pageSize, pageSizeVariant, pageSizes, paginator, previousPageIcon, previousPageLabel, showFirstLastButtons)

{-| 
@docs paginator, disabled, firstPageLabel, hidePageSize, itemsPerPageLabel, lastPageLabel, length, nextPageLabel, pageIndex, pageSize, pageSizes, pageSizeVariant, previousPageLabel, showFirstLastButtons, onPage, firstPageIcon, previousPageIcon, nextPageIcon, lastPageIcon
-}


import M3e.Cem.Attr
import M3e.Cem.Paginator
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-paginator>` element (lazy IR). -}
paginator :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , firstPageLabel : M3e.Value.Supported
    , hidePageSize : M3e.Value.Supported
    , itemsPerPageLabel : M3e.Value.Supported
    , lastPageLabel : M3e.Value.Supported
    , length : M3e.Value.Supported
    , nextPageLabel : M3e.Value.Supported
    , pageIndex : M3e.Value.Supported
    , pageSize : M3e.Value.Supported
    , pageSizes : M3e.Value.Supported
    , pageSizeVariant : M3e.Value.Supported
    , previousPageLabel : M3e.Value.Supported
    , showFirstLastButtons : M3e.Value.Supported
    , onPage : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { firstPageIcon : M3e.Value.Supported
    , previousPageIcon : M3e.Value.Supported
    , nextPageIcon : M3e.Value.Supported
    , lastPageIcon : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | paginator : M3e.Value.Supported } msg
paginator attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.Paginator.paginator
                    (List.map M3e.Cem.Attr.forget erased)
                    ch
            )
            (List.map M3e.Cem.Attr.forget attributes)
            (List.map M3e.Content.toNode content_)
        )


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.Paginator.disabled


{-| The accessible label given to the button used to move to the first page. (default: `"First page"`) -}
firstPageLabel :
    String -> M3e.Cem.Attr.Attr { c | firstPageLabel : M3e.Value.Supported } msg
firstPageLabel =
    M3e.Cem.Paginator.firstPageLabel


{-| Whether to hide page size selection. (default: `false`) -}
hidePageSize :
    Bool -> M3e.Cem.Attr.Attr { c | hidePageSize : M3e.Value.Supported } msg
hidePageSize =
    M3e.Cem.Paginator.hidePageSize


{-| The label for the page size selector. (default: `"Items per page:"`) -}
itemsPerPageLabel :
    String
    -> M3e.Cem.Attr.Attr { c | itemsPerPageLabel : M3e.Value.Supported } msg
itemsPerPageLabel =
    M3e.Cem.Paginator.itemsPerPageLabel


{-| The accessible label given to the button used to move to the last page. (default: `"Last page"`) -}
lastPageLabel :
    String -> M3e.Cem.Attr.Attr { c | lastPageLabel : M3e.Value.Supported } msg
lastPageLabel =
    M3e.Cem.Paginator.lastPageLabel


{-| The length of the total number of items which are being paginated. (default: `0`) -}
length : Float -> M3e.Cem.Attr.Attr { c | length : M3e.Value.Supported } msg
length =
    M3e.Cem.Paginator.length


{-| The accessible label given to the button used to move to the next page. (default: `"Next page"`) -}
nextPageLabel :
    String -> M3e.Cem.Attr.Attr { c | nextPageLabel : M3e.Value.Supported } msg
nextPageLabel =
    M3e.Cem.Paginator.nextPageLabel


{-| The zero-based page index of the displayed list of items. (default: `0`) -}
pageIndex :
    Float -> M3e.Cem.Attr.Attr { c | pageIndex : M3e.Value.Supported } msg
pageIndex =
    M3e.Cem.Paginator.pageIndex


{-| The number of items to display in a page. (default: `50`) -}
pageSize :
    String -> M3e.Cem.Attr.Attr { c | pageSize : M3e.Value.Supported } msg
pageSize =
    M3e.Cem.Paginator.pageSize


{-| A comma separated list of available page sizes. (default: `"5,10,25,50,100"`) -}
pageSizes :
    String -> M3e.Cem.Attr.Attr { c | pageSizes : M3e.Value.Supported } msg
pageSizes =
    M3e.Cem.Paginator.pageSizes


{-| The appearance variant of the page size field. (default: `"outlined"`) -}
pageSizeVariant :
    M3e.Value.Value { filled : M3e.Value.Supported
    , outlined : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | pageSizeVariant : M3e.Value.Supported } msg
pageSizeVariant =
    M3e.Cem.Paginator.pageSizeVariant


{-| The accessible label given to the button used to move to the previous page. (default: `"Previous page"`) -}
previousPageLabel :
    String
    -> M3e.Cem.Attr.Attr { c | previousPageLabel : M3e.Value.Supported } msg
previousPageLabel =
    M3e.Cem.Paginator.previousPageLabel


{-| Whether to show first/last buttons. (default: `false`) -}
showFirstLastButtons :
    Bool
    -> M3e.Cem.Attr.Attr { c | showFirstLastButtons : M3e.Value.Supported } msg
showFirstLastButtons =
    M3e.Cem.Paginator.showFirstLastButtons


{-| Listen for `page` events. -}
onPage : msg -> M3e.Cem.Attr.Attr { c | onPage : M3e.Value.Supported } msg
onPage =
    M3e.Cem.Paginator.onPage


{-| Place content in the `first-page-icon` slot. -}
firstPageIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | firstPageIcon : M3e.Value.Supported } msg
firstPageIcon el =
    M3e.Content.slot "first-page-icon" el


{-| Place content in the `previous-page-icon` slot. -}
previousPageIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | previousPageIcon : M3e.Value.Supported } msg
previousPageIcon el =
    M3e.Content.slot "previous-page-icon" el


{-| Place content in the `next-page-icon` slot. -}
nextPageIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | nextPageIcon : M3e.Value.Supported } msg
nextPageIcon el =
    M3e.Content.slot "next-page-icon" el


{-| Place content in the `last-page-icon` slot. -}
lastPageIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | lastPageIcon : M3e.Value.Supported } msg
lastPageIcon el =
    M3e.Content.slot "last-page-icon" el