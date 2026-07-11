module M3e.BreadcrumbItem exposing
    ( view, itemLabel, disabled, current, href, target
    , download, rel, onClick, icon
    )

{-| An item in a breadcrumb.

**Component Info:**

  - **Extends:** `LitElement`

**Events:**

  - `click`: Dispatched when the element is clicked.

**Slots:**

  - `icon`: Renders an icon before the item's label.

@docs view, itemLabel, disabled, current, href, target
@docs download, rel, onClick, icon

-}

import M3e.Element
import M3e.Element.Internal
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Html.BreadcrumbItem
import M3e.Node
import M3e.Token


{-| Build the `<m3e-breadcrumb-item>` element (lazy IR).
-}
view :
    List
        (M3e.Html.Attr.Attr
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
    ->
        List
            (M3e.Element.Element
                { text : M3e.Token.Supported
                , icon : M3e.Token.Supported
                }
                msg
            )
    -> M3e.Element.Element { s | breadcrumbItem : M3e.Token.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Html.BreadcrumbItem.breadcrumbItem
                    (List.map M3e.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map M3e.Html.Attr.Internal.forget attributes)
            (List.map M3e.Element.toNode children)
        )


{-| The accessible label given to the item's internal button. (default: `""`)
-}
itemLabel : String -> M3e.Html.Attr.Attr { c | itemLabel : M3e.Token.Supported } msg
itemLabel =
    M3e.Html.BreadcrumbItem.itemLabel


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> M3e.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    M3e.Html.BreadcrumbItem.disabled


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
    -> M3e.Html.Attr.Attr { c | current : M3e.Token.Supported } msg
current =
    M3e.Html.BreadcrumbItem.current


{-| The URL to which the internal breadcrumb link button points. (default: `""`)
-}
href : String -> M3e.Html.Attr.Attr { c | href : M3e.Token.Supported } msg
href =
    M3e.Html.BreadcrumbItem.href


{-| The target of the internal breadcrumb link button. (default: `""`)
-}
target : String -> M3e.Html.Attr.Attr { c | target : M3e.Token.Supported } msg
target =
    M3e.Html.BreadcrumbItem.target


{-| A value indicating whether the internal link target will be downloaded, optionally specifying a file name. (default: `null`)
-}
download : String -> M3e.Html.Attr.Attr { c | download : M3e.Token.Supported } msg
download =
    M3e.Html.BreadcrumbItem.download


{-| The relationship between the internal link target and the document. (default: `""`)
-}
rel : String -> M3e.Html.Attr.Attr { c | rel : M3e.Token.Supported } msg
rel =
    M3e.Html.BreadcrumbItem.rel


{-| Listen for `click` events.
-}
onClick : msg -> M3e.Html.Attr.Attr { c | onClick : M3e.Token.Supported } msg
onClick =
    M3e.Html.BreadcrumbItem.onClick


{-| Place content in the `icon` slot.
-}
icon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
icon el =
    M3e.Element.Internal.placeSlot "icon" el
