module M3e.Paginator exposing
    ( component
    , firstPageLabel, hidePageSize, itemsPerPageLabel, lastPageLabel, length, pageIndex, pageSize, pageSizes, pageSizeVariant, showFirstLastButtons
    , onPage
    , firstPageIconSlot, previousPageIconSlot, nextPageIconSlot, lastPageIconSlot
    )

{-| Provides navigation for paged information, typically used with a table.


## Component

@docs component


### Attributes

@docs firstPageLabel, hidePageSize, itemsPerPageLabel, lastPageLabel, length, pageIndex, pageSize, pageSizes, pageSizeVariant, showFirstLastButtons


### Events

@docs onPage


### Slots

@docs firstPageIconSlot, previousPageIconSlot, nextPageIconSlot, lastPageIconSlot

-}

import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| Provides navigation for paged information, typically used with a table.

**Events:**

  - `page`: Dispatched when a user selects a different page size or navigates to another page.

**Slots:**

  - `first-page-icon`: Slot for a custom first-page icon.
  - `previous-page-icon`: Slot for a custom previous-page icon.
  - `next-page-icon`: Slot for a custom next-page icon.
  - `last-page-icon`: Slot for a custom last-page icon.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-paginator" attributes children


{-| The accessible label given to the button used to move to the first page. (default: `"First page"`)
-}
firstPageLabel : String -> Html.Attribute msg
firstPageLabel val_ =
    Html.Attributes.attribute "first-page-label" val_


{-| Whether to hide page size selection. (default: `false`)
-}
hidePageSize : Bool -> Html.Attribute msg
hidePageSize val_ =
    Html.Attributes.property "hide-page-size" (Json.Encode.bool val_)


{-| The label for the page size selector. (default: `"Items per page:"`)
-}
itemsPerPageLabel : String -> Html.Attribute msg
itemsPerPageLabel val_ =
    Html.Attributes.attribute "items-per-page-label" val_


{-| The accessible label given to the button used to move to the last page. (default: `"Last page"`)
-}
lastPageLabel : String -> Html.Attribute msg
lastPageLabel val_ =
    Html.Attributes.attribute "last-page-label" val_


{-| The length of the total number of items which are being paginated. (default: `0`)
-}
length : Float -> Html.Attribute msg
length val_ =
    Html.Attributes.property "length" (Json.Encode.float val_)


{-| The zero-based page index of the displayed list of items. (default: `0`)
-}
pageIndex : Float -> Html.Attribute msg
pageIndex val_ =
    Html.Attributes.property "page-index" (Json.Encode.float val_)


{-| The number of items to display in a page. (default: `50`)
-}
pageSize : String -> Html.Attribute msg
pageSize val_ =
    Html.Attributes.attribute "page-size" val_


{-| A comma separated list of available page sizes. (default: `"5,10,25,50,100"`)
-}
pageSizes : String -> Html.Attribute msg
pageSizes val_ =
    Html.Attributes.attribute "page-sizes" val_


{-| The appearance variant of the page size field. (default: `"outlined"`)
-}
pageSizeVariant : String -> Html.Attribute msg
pageSizeVariant val_ =
    Html.Attributes.attribute "page-size-variant" val_


{-| Whether to show first/last buttons. (default: `false`)
-}
showFirstLastButtons : Bool -> Html.Attribute msg
showFirstLastButtons val_ =
    Html.Attributes.property "show-first-last-buttons" (Json.Encode.bool val_)


{-| Dispatched when a user selects a different page size or navigates to another page.

**Payload type:** `CustomEvent`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

-}
onPage : Json.Decode.Decoder msg -> Html.Attribute msg
onPage decoder =
    Html.Events.on "page" decoder


{-| Slot for a custom first-page icon.
-}
firstPageIconSlot : Html.Attribute msg
firstPageIconSlot =
    Html.Attributes.attribute "slot" "first-page-icon"


{-| Slot for a custom previous-page icon.
-}
previousPageIconSlot : Html.Attribute msg
previousPageIconSlot =
    Html.Attributes.attribute "slot" "previous-page-icon"


{-| Slot for a custom next-page icon.
-}
nextPageIconSlot : Html.Attribute msg
nextPageIconSlot =
    Html.Attributes.attribute "slot" "next-page-icon"


{-| Slot for a custom last-page icon.
-}
lastPageIconSlot : Html.Attribute msg
lastPageIconSlot =
    Html.Attributes.attribute "slot" "last-page-icon"
