module M3e.Cem.Html.Paginator exposing (disabled, firstPageLabel, hidePageSize, itemsPerPageLabel, lastPageLabel, length, nextPageLabel, onPage, pageIndex, pageSize, pageSizeVariant, pageSizes, paginator, previousPageLabel, showFirstLastButtons)

{-| 
@docs paginator, disabled, firstPageLabel, hidePageSize, itemsPerPageLabel, lastPageLabel, length, nextPageLabel, pageIndex, pageSize, pageSizes, pageSizeVariant, previousPageLabel, showFirstLastButtons, onPage
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| The raw `<m3e-paginator>` element — a partial application of `Html.node`. -}
paginator : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
paginator =
    Html.node "m3e-paginator"


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| The accessible label given to the button used to move to the first page. (default: `"First page"`) -}
firstPageLabel : String -> Html.Attribute msg
firstPageLabel =
    Html.Attributes.attribute "first-page-label"


{-| Whether to hide page size selection. (default: `false`) -}
hidePageSize : Bool -> Html.Attribute msg
hidePageSize val_ =
    Html.Attributes.property "hidePageSize" (Json.Encode.bool val_)


{-| The label for the page size selector. (default: `"Items per page:"`) -}
itemsPerPageLabel : String -> Html.Attribute msg
itemsPerPageLabel =
    Html.Attributes.attribute "items-per-page-label"


{-| The accessible label given to the button used to move to the last page. (default: `"Last page"`) -}
lastPageLabel : String -> Html.Attribute msg
lastPageLabel =
    Html.Attributes.attribute "last-page-label"


{-| The length of the total number of items which are being paginated. (default: `0`) -}
length : Float -> Html.Attribute msg
length val_ =
    Html.Attributes.property "length" (Json.Encode.float val_)


{-| The accessible label given to the button used to move to the next page. (default: `"Next page"`) -}
nextPageLabel : String -> Html.Attribute msg
nextPageLabel =
    Html.Attributes.attribute "next-page-label"


{-| The zero-based page index of the displayed list of items. (default: `0`) -}
pageIndex : Float -> Html.Attribute msg
pageIndex val_ =
    Html.Attributes.property "pageIndex" (Json.Encode.float val_)


{-| The number of items to display in a page. (default: `50`) -}
pageSize : String -> Html.Attribute msg
pageSize =
    Html.Attributes.attribute "page-size"


{-| A comma separated list of available page sizes. (default: `"5,10,25,50,100"`) -}
pageSizes : String -> Html.Attribute msg
pageSizes =
    Html.Attributes.attribute "page-sizes"


{-| The appearance variant of the page size field. (default: `"outlined"`) -}
pageSizeVariant : String -> Html.Attribute msg
pageSizeVariant =
    Html.Attributes.attribute "page-size-variant"


{-| The accessible label given to the button used to move to the previous page. (default: `"Previous page"`) -}
previousPageLabel : String -> Html.Attribute msg
previousPageLabel =
    Html.Attributes.attribute "previous-page-label"


{-| Whether to show first/last buttons. (default: `false`) -}
showFirstLastButtons : Bool -> Html.Attribute msg
showFirstLastButtons val_ =
    Html.Attributes.property "showFirstLastButtons" (Json.Encode.bool val_)


{-| Listen for `page` events. -}
onPage : Json.Decode.Decoder msg -> Html.Attribute msg
onPage =
    Html.Events.on "page"