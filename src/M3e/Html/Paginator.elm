module M3e.Html.Paginator exposing
    ( paginator, disabled, firstPageLabel, hidePageSize, itemsPerPageLabel, lastPageLabel
    , length, nextPageLabel, pageIndex, pageSize, pageSizes, pageSizeVariant
    , previousPageLabel, showFirstLastButtons, onPage
    )

{-| Middle layer for `<m3e-paginator>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.Paginator` module for everyday use.

@docs paginator, disabled, firstPageLabel, hidePageSize, itemsPerPageLabel, lastPageLabel
@docs length, nextPageLabel, pageIndex, pageSize, pageSizes, pageSizeVariant
@docs previousPageLabel, showFirstLastButtons, onPage

-}

import Html
import Json.Decode
import M3e.Raw.Paginator
import M3e.Token
import Markup.Html.Attr
import Markup.Html.Attr.Internal


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
    List
        (Markup.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , firstPageLabel : M3e.Token.Supported
            , hidePageSize : M3e.Token.Supported
            , itemsPerPageLabel : M3e.Token.Supported
            , lastPageLabel : M3e.Token.Supported
            , length : M3e.Token.Supported
            , nextPageLabel : M3e.Token.Supported
            , pageIndex : M3e.Token.Supported
            , pageSize : M3e.Token.Supported
            , pageSizes : M3e.Token.Supported
            , pageSizeVariant : M3e.Token.Supported
            , previousPageLabel : M3e.Token.Supported
            , showFirstLastButtons : M3e.Token.Supported
            , onPage : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
paginator attributes children =
    M3e.Raw.Paginator.paginator
        (List.map Markup.Html.Attr.toAttribute attributes)
        children


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Markup.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Paginator.disabled


{-| The accessible label given to the button used to move to the first page. (default: `"First page"`)
-}
firstPageLabel :
    String
    -> Markup.Html.Attr.Attr { c | firstPageLabel : M3e.Token.Supported } msg
firstPageLabel =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Paginator.firstPageLabel


{-| Whether to hide page size selection. (default: `false`)
-}
hidePageSize : Bool -> Markup.Html.Attr.Attr { c | hidePageSize : M3e.Token.Supported } msg
hidePageSize =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Paginator.hidePageSize


{-| The label for the page size selector. (default: `"Items per page:"`)
-}
itemsPerPageLabel :
    String
    -> Markup.Html.Attr.Attr { c | itemsPerPageLabel : M3e.Token.Supported } msg
itemsPerPageLabel =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Paginator.itemsPerPageLabel


{-| The accessible label given to the button used to move to the last page. (default: `"Last page"`)
-}
lastPageLabel :
    String
    -> Markup.Html.Attr.Attr { c | lastPageLabel : M3e.Token.Supported } msg
lastPageLabel =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Paginator.lastPageLabel


{-| The length of the total number of items which are being paginated. (default: `0`)
-}
length : Float -> Markup.Html.Attr.Attr { c | length : M3e.Token.Supported } msg
length =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Paginator.length


{-| The accessible label given to the button used to move to the next page. (default: `"Next page"`)
-}
nextPageLabel :
    String
    -> Markup.Html.Attr.Attr { c | nextPageLabel : M3e.Token.Supported } msg
nextPageLabel =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Paginator.nextPageLabel


{-| The zero-based page index of the displayed list of items. (default: `0`)
-}
pageIndex : Float -> Markup.Html.Attr.Attr { c | pageIndex : M3e.Token.Supported } msg
pageIndex =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Paginator.pageIndex


{-| The number of items to display in a page. (default: `50`)
-}
pageSize :
    M3e.Token.Value { number : M3e.Token.Supported, all : M3e.Token.Supported }
    -> Markup.Html.Attr.Attr { c | pageSize : M3e.Token.Supported } msg
pageSize v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Paginator.pageSize
        (M3e.Token.toString v_)


{-| A comma separated list of available page sizes. (default: `"5,10,25,50,100"`)
-}
pageSizes : String -> Markup.Html.Attr.Attr { c | pageSizes : M3e.Token.Supported } msg
pageSizes =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Paginator.pageSizes


{-| The appearance variant of the page size field. (default: `"outlined"`)
-}
pageSizeVariant :
    M3e.Token.Value
        { filled : M3e.Token.Supported
        , outlined : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | pageSizeVariant : M3e.Token.Supported } msg
pageSizeVariant v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Paginator.pageSizeVariant
        (M3e.Token.toString v_)


{-| The accessible label given to the button used to move to the previous page. (default: `"Previous page"`)
-}
previousPageLabel :
    String
    -> Markup.Html.Attr.Attr { c | previousPageLabel : M3e.Token.Supported } msg
previousPageLabel =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Paginator.previousPageLabel


{-| Whether to show first/last buttons. (default: `false`)
-}
showFirstLastButtons :
    Bool
    ->
        Markup.Html.Attr.Attr
            { c
                | showFirstLastButtons : M3e.Token.Supported
            }
            msg
showFirstLastButtons =
    Markup.Html.Attr.Internal.attribute M3e.Raw.Paginator.showFirstLastButtons


{-| Listen for `page` events.
-}
onPage :
    (Int -> msg)
    -> Markup.Html.Attr.Attr { c | onPage : M3e.Token.Supported } msg
onPage f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.Paginator.onPage
        (Json.Decode.map
            f_
            (Json.Decode.at [ "detail", "pageIndex" ] Json.Decode.int)
        )
