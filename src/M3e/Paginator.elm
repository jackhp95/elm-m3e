module M3e.Paginator exposing
    ( view, disabled, firstPageLabel, hidePageSize, itemsPerPageLabel, lastPageLabel
    , length, nextPageLabel, pageIndex, pageSize, pageSizes, pageSizeVariant
    , previousPageLabel, showFirstLastButtons, onPage, firstPageIcon, previousPageIcon, nextPageIcon
    , lastPageIcon
    )

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

<!-- elm-cem:docmeta category=Navigation -->


## Examples


### Examples

<!-- elm-cem:example title="Basic usage" -->
```elm
M3e.Paginator.view [ M3e.Paginator.length 100 ] []
```

<!-- elm-cem:example title="Navigation actions" -->
```elm
M3e.Paginator.view [ M3e.Paginator.length 100, M3e.Paginator.showFirstLastButtons True ] []
```

<!-- elm-cem:example title="Density" -->
```elm
M3e.Paginator.view [ M3e.Attributes.class "density-3", M3e.Paginator.length 100, M3e.Paginator.showFirstLastButtons True ] []
```

@docs view, disabled, firstPageLabel, hidePageSize, itemsPerPageLabel, lastPageLabel
@docs length, nextPageLabel, pageIndex, pageSize, pageSizes, pageSizeVariant
@docs previousPageLabel, showFirstLastButtons, onPage, firstPageIcon, previousPageIcon, nextPageIcon
@docs lastPageIcon

-}

import M3e.Html.Paginator
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Kind
import Markup.Node


{-| Build the `<m3e-paginator>` element (lazy IR).
-}
view :
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
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | paginator : M3e.Kind.Brand } msg
view attributes children =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.Paginator.paginator
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.map Markup.Element.toNode children)
        )


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Markup.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    M3e.Html.Paginator.disabled


{-| The accessible label given to the button used to move to the first page. (default: `"First page"`)
-}
firstPageLabel :
    String
    -> Markup.Html.Attr.Attr { c | firstPageLabel : M3e.Token.Supported } msg
firstPageLabel =
    M3e.Html.Paginator.firstPageLabel


{-| Whether to hide page size selection. (default: `false`)
-}
hidePageSize : Bool -> Markup.Html.Attr.Attr { c | hidePageSize : M3e.Token.Supported } msg
hidePageSize =
    M3e.Html.Paginator.hidePageSize


{-| The label for the page size selector. (default: `"Items per page:"`)
-}
itemsPerPageLabel :
    String
    -> Markup.Html.Attr.Attr { c | itemsPerPageLabel : M3e.Token.Supported } msg
itemsPerPageLabel =
    M3e.Html.Paginator.itemsPerPageLabel


{-| The accessible label given to the button used to move to the last page. (default: `"Last page"`)
-}
lastPageLabel :
    String
    -> Markup.Html.Attr.Attr { c | lastPageLabel : M3e.Token.Supported } msg
lastPageLabel =
    M3e.Html.Paginator.lastPageLabel


{-| The length of the total number of items which are being paginated. (default: `0`)
-}
length : Float -> Markup.Html.Attr.Attr { c | length : M3e.Token.Supported } msg
length =
    M3e.Html.Paginator.length


{-| The accessible label given to the button used to move to the next page. (default: `"Next page"`)
-}
nextPageLabel :
    String
    -> Markup.Html.Attr.Attr { c | nextPageLabel : M3e.Token.Supported } msg
nextPageLabel =
    M3e.Html.Paginator.nextPageLabel


{-| The zero-based page index of the displayed list of items. (default: `0`)
-}
pageIndex : Float -> Markup.Html.Attr.Attr { c | pageIndex : M3e.Token.Supported } msg
pageIndex =
    M3e.Html.Paginator.pageIndex


{-| The number of items to display in a page. (default: `50`)
-}
pageSize :
    M3e.Token.Value { number : M3e.Token.Supported, all : M3e.Token.Supported }
    -> Markup.Html.Attr.Attr { c | pageSize : M3e.Token.Supported } msg
pageSize =
    M3e.Html.Paginator.pageSize


{-| A comma separated list of available page sizes. (default: `"5,10,25,50,100"`)
-}
pageSizes : String -> Markup.Html.Attr.Attr { c | pageSizes : M3e.Token.Supported } msg
pageSizes =
    M3e.Html.Paginator.pageSizes


{-| The appearance variant of the page size field. (default: `"outlined"`)
-}
pageSizeVariant :
    M3e.Token.Value
        { filled : M3e.Token.Supported
        , outlined : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | pageSizeVariant : M3e.Token.Supported } msg
pageSizeVariant =
    M3e.Html.Paginator.pageSizeVariant


{-| The accessible label given to the button used to move to the previous page. (default: `"Previous page"`)
-}
previousPageLabel :
    String
    -> Markup.Html.Attr.Attr { c | previousPageLabel : M3e.Token.Supported } msg
previousPageLabel =
    M3e.Html.Paginator.previousPageLabel


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
    M3e.Html.Paginator.showFirstLastButtons


{-| Listen for `page` events.
-}
onPage :
    (Int -> msg)
    -> Markup.Html.Attr.Attr { c | onPage : M3e.Token.Supported } msg
onPage =
    M3e.Html.Paginator.onPage


{-| Place content in the `first-page-icon` slot.
-}
firstPageIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
firstPageIcon el =
    Markup.Element.Internal.placeSlot "first-page-icon" el


{-| Place content in the `previous-page-icon` slot.
-}
previousPageIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
previousPageIcon el =
    Markup.Element.Internal.placeSlot "previous-page-icon" el


{-| Place content in the `next-page-icon` slot.
-}
nextPageIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
nextPageIcon el =
    Markup.Element.Internal.placeSlot "next-page-icon" el


{-| Place content in the `last-page-icon` slot.
-}
lastPageIcon :
    Markup.Element.Element { icon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
lastPageIcon el =
    Markup.Element.Internal.placeSlot "last-page-icon" el
