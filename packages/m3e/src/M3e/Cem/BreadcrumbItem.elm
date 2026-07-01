module M3e.Cem.BreadcrumbItem exposing (breadcrumbItem, current, disabled, download, href, itemLabel, onClick, rel, target)

{-| 
@docs breadcrumbItem, itemLabel, disabled, current, href, target, download, rel, onClick
-}


import Html
import Json.Decode
import M3e.Cem.Attr
import M3e.Cem.Html.BreadcrumbItem
import M3e.Value


{-| An item in a breadcrumb.

**Events:**
- `click`: Dispatched when the element is clicked.

**Slots:**
- `icon`: Renders an icon before the item's label.
-}
breadcrumbItem :
    List (M3e.Cem.Attr.Attr { itemLabel : M3e.Value.Supported
    , disabled : M3e.Value.Supported
    , current : M3e.Value.Supported
    , href : M3e.Value.Supported
    , target : M3e.Value.Supported
    , download : M3e.Value.Supported
    , rel : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
breadcrumbItem attributes children =
    M3e.Cem.Html.BreadcrumbItem.breadcrumbItem
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| The accessible label given to the item's internal button. (default: `""`) -}
itemLabel :
    String -> M3e.Cem.Attr.Attr { c | itemLabel : M3e.Value.Supported } msg
itemLabel =
    M3e.Cem.Attr.attribute M3e.Cem.Html.BreadcrumbItem.itemLabel


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.Attr.attribute M3e.Cem.Html.BreadcrumbItem.disabled


{-| Indicates the current item in the breadcrumb path. -}
current :
    M3e.Value.Value { date : M3e.Value.Supported
    , location : M3e.Value.Supported
    , page : M3e.Value.Supported
    , step : M3e.Value.Supported
    , time : M3e.Value.Supported
    , true : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | current : M3e.Value.Supported } msg
current v_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.BreadcrumbItem.current
        (M3e.Value.toString v_)


{-| The URL to which the internal breadcrumb link button points. (default: `""`) -}
href : String -> M3e.Cem.Attr.Attr { c | href : M3e.Value.Supported } msg
href =
    M3e.Cem.Attr.attribute M3e.Cem.Html.BreadcrumbItem.href


{-| The target of the internal breadcrumb link button. (default: `""`) -}
target : String -> M3e.Cem.Attr.Attr { c | target : M3e.Value.Supported } msg
target =
    M3e.Cem.Attr.attribute M3e.Cem.Html.BreadcrumbItem.target


{-| A value indicating whether the internal link target will be downloaded, optionally specifying a file name. (default: `null`) -}
download :
    String -> M3e.Cem.Attr.Attr { c | download : M3e.Value.Supported } msg
download =
    M3e.Cem.Attr.attribute M3e.Cem.Html.BreadcrumbItem.download


{-| The relationship between the internal link target and the document. (default: `""`) -}
rel : String -> M3e.Cem.Attr.Attr { c | rel : M3e.Value.Supported } msg
rel =
    M3e.Cem.Attr.attribute M3e.Cem.Html.BreadcrumbItem.rel


{-| Listen for `click` events. -}
onClick : msg -> M3e.Cem.Attr.Attr { c | onClick : M3e.Value.Supported } msg
onClick f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.BreadcrumbItem.onClick
        (Json.Decode.succeed f_)