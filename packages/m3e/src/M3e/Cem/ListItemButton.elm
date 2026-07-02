module M3e.Cem.ListItemButton exposing
    ( listItemButton, href, target, rel, download, disabled
    , onClick
    )

{-|
Middle layer for `<m3e-list-item-button>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.ListItemButton` module for everyday use.

@docs listItemButton, href, target, rel, download, disabled
@docs onClick
-}


import Html
import Json.Decode
import M3e.Cem.Attr
import M3e.Cem.Html.ListItemButton
import M3e.Value


{-| Create a m3e-list-item-button element

**Component Info:**
- **Extends:** `M3eListItemElement` from `/src/list/ListItemElement`

**Events:**
- `click`: No description

**Slots:**
- `leading`: Renders the leading content of the list item.
- `overline`: Renders the overline of the list item.
- `supporting-text`: Renders the supporting text of the list item.
- `trailing`: Renders the trailing content of the list item.
-}
listItemButton :
    List (M3e.Cem.Attr.Attr { href : M3e.Value.Supported
    , target : M3e.Value.Supported
    , rel : M3e.Value.Supported
    , download : M3e.Value.Supported
    , disabled : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
listItemButton attributes children =
    M3e.Cem.Html.ListItemButton.listItemButton
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| The URL to which the link button points. (default: `""`) -}
href : String -> M3e.Cem.Attr.Attr { c | href : M3e.Value.Supported } msg
href =
    M3e.Cem.Attr.attribute M3e.Cem.Html.ListItemButton.href


{-| The target of the link button. (default: `""`) -}
target : String -> M3e.Cem.Attr.Attr { c | target : M3e.Value.Supported } msg
target =
    M3e.Cem.Attr.attribute M3e.Cem.Html.ListItemButton.target


{-| The relationship between the `target` of the link button and the document. (default: `""`) -}
rel : String -> M3e.Cem.Attr.Attr { c | rel : M3e.Value.Supported } msg
rel =
    M3e.Cem.Attr.attribute M3e.Cem.Html.ListItemButton.rel


{-| A value indicating whether the `target` of the link button will be downloaded,
optionally specifying the new name of the file. (default: `null`)
-}
download :
    String -> M3e.Cem.Attr.Attr { c | download : M3e.Value.Supported } msg
download =
    M3e.Cem.Attr.attribute M3e.Cem.Html.ListItemButton.download


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.Attr.attribute M3e.Cem.Html.ListItemButton.disabled


{-| Listen for `click` events. -}
onClick : msg -> M3e.Cem.Attr.Attr { c | onClick : M3e.Value.Supported } msg
onClick f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.ListItemButton.onClick
        (Json.Decode.succeed f_)