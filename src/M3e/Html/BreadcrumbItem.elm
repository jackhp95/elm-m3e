module M3e.Html.BreadcrumbItem exposing
    ( breadcrumbItem, itemLabel, disabled, current, href, target
    , download, rel, onClick
    )

{-| Middle layer for `<m3e-breadcrumb-item>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.BreadcrumbItem` module for everyday use.

@docs breadcrumbItem, itemLabel, disabled, current, href, target
@docs download, rel, onClick

-}

import Html
import Json.Decode
import M3e.Raw.BreadcrumbItem
import M3e.Token
import Markup.Html.Attr
import Markup.Html.Attr.Internal


{-| An item in a breadcrumb.

**Component Info:**

  - **Extends:** `LitElement`

**Events:**

  - `click`: Dispatched when the element is clicked.

**Slots:**

  - `icon`: Renders an icon before the item's label.

-}
breadcrumbItem :
    List
        (Markup.Html.Attr.Attr
            { itemLabel : M3e.Token.Supported
            , disabled : M3e.Token.Supported
            , current : M3e.Token.Supported
            , href : M3e.Token.Supported
            , target : M3e.Token.Supported
            , download : M3e.Token.Supported
            , rel : M3e.Token.Supported
            , onClick : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
breadcrumbItem attributes children =
    M3e.Raw.BreadcrumbItem.breadcrumbItem
        (List.map Markup.Html.Attr.toAttribute attributes)
        children


{-| The accessible label given to the item's internal button. (default: `""`)
-}
itemLabel : String -> Markup.Html.Attr.Attr { c | itemLabel : M3e.Token.Supported } msg
itemLabel =
    Markup.Html.Attr.Internal.attribute M3e.Raw.BreadcrumbItem.itemLabel


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Markup.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    Markup.Html.Attr.Internal.attribute M3e.Raw.BreadcrumbItem.disabled


{-| Indicates the current item in the breadcrumb path.
-}
current :
    M3e.Token.Value
        { date : M3e.Token.Supported
        , location : M3e.Token.Supported
        , page : M3e.Token.Supported
        , step : M3e.Token.Supported
        , time : M3e.Token.Supported
        , true : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | current : M3e.Token.Supported } msg
current v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.BreadcrumbItem.current
        (M3e.Token.toString v_)


{-| The URL to which the internal breadcrumb link button points. (default: `""`)
-}
href : String -> Markup.Html.Attr.Attr { c | href : M3e.Token.Supported } msg
href =
    Markup.Html.Attr.Internal.attribute M3e.Raw.BreadcrumbItem.href


{-| The target of the internal breadcrumb link button. (default: `""`)
-}
target : String -> Markup.Html.Attr.Attr { c | target : M3e.Token.Supported } msg
target =
    Markup.Html.Attr.Internal.attribute M3e.Raw.BreadcrumbItem.target


{-| A value indicating whether the internal link target will be downloaded, optionally specifying a file name. (default: `null`)
-}
download : String -> Markup.Html.Attr.Attr { c | download : M3e.Token.Supported } msg
download =
    Markup.Html.Attr.Internal.attribute M3e.Raw.BreadcrumbItem.download


{-| The relationship between the internal link target and the document. (default: `""`)
-}
rel : String -> Markup.Html.Attr.Attr { c | rel : M3e.Token.Supported } msg
rel =
    Markup.Html.Attr.Internal.attribute M3e.Raw.BreadcrumbItem.rel


{-| Listen for `click` events.
-}
onClick : msg -> Markup.Html.Attr.Attr { c | onClick : M3e.Token.Supported } msg
onClick f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.BreadcrumbItem.onClick
        (Json.Decode.succeed f_)
