module M3e.Cem.Paginator exposing
    ( paginator, disabled, firstPageLabel, hidePageSize, itemsPerPageLabel, lastPageLabel
    , length, nextPageLabel, pageIndex, pageSize, pageSizes, pageSizeVariant, previousPageLabel
    , showFirstLastButtons, onPage
    )

{-|
Middle layer for `<m3e-paginator>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.Paginator` module for everyday use.

@docs paginator, disabled, firstPageLabel, hidePageSize, itemsPerPageLabel, lastPageLabel
@docs length, nextPageLabel, pageIndex, pageSize, pageSizes, pageSizeVariant
@docs previousPageLabel, showFirstLastButtons, onPage
-}


import Html
import Json.Decode
import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.Html.Paginator
import M3e.Value


{-| Provides navigation for paged information, typically used with a table.

**Component Info:**
- **Extends:** `LitElement`

**Events:**
- `page`: Dispatched when a user selects a different page size or navigates to another page.

**Slots:**
- `first-page-icon`: Slot for a custom first-page icon.
- `previous-page-icon`: Slot for a custom previous-page icon.
- `next-page-icon`: Slot for a custom next-page icon.
- `last-page-icon`: Slot for a custom last-page icon.
-}
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
    -> List (Html.Html msg)
    -> Html.Html msg
paginator attributes children =
    M3e.Cem.Html.Paginator.paginator
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Paginator.disabled


{-| The accessible label given to the button used to move to the first page. (default: `"First page"`) -}
firstPageLabel :
    String -> M3e.Cem.Attr.Attr { c | firstPageLabel : M3e.Value.Supported } msg
firstPageLabel =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Paginator.firstPageLabel


{-| Whether to hide page size selection. (default: `false`) -}
hidePageSize :
    Bool -> M3e.Cem.Attr.Attr { c | hidePageSize : M3e.Value.Supported } msg
hidePageSize =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Paginator.hidePageSize


{-| The label for the page size selector. (default: `"Items per page:"`) -}
itemsPerPageLabel :
    String
    -> M3e.Cem.Attr.Attr { c | itemsPerPageLabel : M3e.Value.Supported } msg
itemsPerPageLabel =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Paginator.itemsPerPageLabel


{-| The accessible label given to the button used to move to the last page. (default: `"Last page"`) -}
lastPageLabel :
    String -> M3e.Cem.Attr.Attr { c | lastPageLabel : M3e.Value.Supported } msg
lastPageLabel =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Paginator.lastPageLabel


{-| The length of the total number of items which are being paginated. (default: `0`) -}
length : Float -> M3e.Cem.Attr.Attr { c | length : M3e.Value.Supported } msg
length =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Paginator.length


{-| The accessible label given to the button used to move to the next page. (default: `"Next page"`) -}
nextPageLabel :
    String -> M3e.Cem.Attr.Attr { c | nextPageLabel : M3e.Value.Supported } msg
nextPageLabel =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Paginator.nextPageLabel


{-| The zero-based page index of the displayed list of items. (default: `0`) -}
pageIndex :
    Float -> M3e.Cem.Attr.Attr { c | pageIndex : M3e.Value.Supported } msg
pageIndex =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Paginator.pageIndex


{-| The number of items to display in a page. (default: `50`) -}
pageSize :
    M3e.Value.Value { number : M3e.Value.Supported, all : M3e.Value.Supported }
    -> M3e.Cem.Attr.Attr { c | pageSize : M3e.Value.Supported } msg
pageSize v_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.Paginator.pageSize
        (M3e.Value.toString v_)


{-| A comma separated list of available page sizes. (default: `"5,10,25,50,100"`) -}
pageSizes :
    String -> M3e.Cem.Attr.Attr { c | pageSizes : M3e.Value.Supported } msg
pageSizes =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Paginator.pageSizes


{-| The appearance variant of the page size field. (default: `"outlined"`) -}
pageSizeVariant :
    M3e.Value.Value { filled : M3e.Value.Supported
    , outlined : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | pageSizeVariant : M3e.Value.Supported } msg
pageSizeVariant v_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.Paginator.pageSizeVariant
        (M3e.Value.toString v_)


{-| The accessible label given to the button used to move to the previous page. (default: `"Previous page"`) -}
previousPageLabel :
    String
    -> M3e.Cem.Attr.Attr { c | previousPageLabel : M3e.Value.Supported } msg
previousPageLabel =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Paginator.previousPageLabel


{-| Whether to show first/last buttons. (default: `false`) -}
showFirstLastButtons :
    Bool
    -> M3e.Cem.Attr.Attr { c | showFirstLastButtons : M3e.Value.Supported } msg
showFirstLastButtons =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.Paginator.showFirstLastButtons


{-| Listen for `page` events. -}
onPage : msg -> M3e.Cem.Attr.Attr { c | onPage : M3e.Value.Supported } msg
onPage f_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.Paginator.onPage
        (Json.Decode.succeed f_)