module M3e.Cem.ListAction exposing (disabled, download, href, listAction, onClick, rel, target)

{-| 
@docs listAction, disabled, download, href, rel, target, onClick
-}


import Html
import Json.Decode
import M3e.Cem.Attr
import M3e.Cem.Html.ListAction
import M3e.Value


{-| An item in a list that performs an action.

**Component Info:**
- **Extends:** `M3eListItemElement` from `/src/list/ListItemElement`

**Events:**
- `click`: Dispatched when the element is clicked.

**Slots:**
- `leading`: Renders the leading content of the list item.
- `overline`: Renders the overline of the list item.
- `supporting-text`: Renders the supporting text of the list item.
- `trailing`: Renders the trailing content of the list item.
-}
listAction :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , download : M3e.Value.Supported
    , href : M3e.Value.Supported
    , rel : M3e.Value.Supported
    , target : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
listAction attributes children =
    M3e.Cem.Html.ListAction.listAction
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.Attr.attribute M3e.Cem.Html.ListAction.disabled


{-| A value indicating whether the `target` of the link button will be downloaded, optionally specifying the new name of the file. (default: `null`) -}
download :
    String -> M3e.Cem.Attr.Attr { c | download : M3e.Value.Supported } msg
download =
    M3e.Cem.Attr.attribute M3e.Cem.Html.ListAction.download


{-| The URL to which the link button points. (default: `""`) -}
href : String -> M3e.Cem.Attr.Attr { c | href : M3e.Value.Supported } msg
href =
    M3e.Cem.Attr.attribute M3e.Cem.Html.ListAction.href


{-| The relationship between the `target` of the link button and the document. (default: `""`) -}
rel : String -> M3e.Cem.Attr.Attr { c | rel : M3e.Value.Supported } msg
rel =
    M3e.Cem.Attr.attribute M3e.Cem.Html.ListAction.rel


{-| The target of the link button. (default: `""`) -}
target : String -> M3e.Cem.Attr.Attr { c | target : M3e.Value.Supported } msg
target =
    M3e.Cem.Attr.attribute M3e.Cem.Html.ListAction.target


{-| Listen for `click` events. -}
onClick : msg -> M3e.Cem.Attr.Attr { c | onClick : M3e.Value.Supported } msg
onClick f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.ListAction.onClick
        (Json.Decode.succeed f_)