module M3e.Html.ListItemButton exposing
    ( listItemButton, href, target, rel, download, disabled
    , onClick
    )

{-| Middle layer for `<m3e-list-item-button>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.ListItemButton` module for everyday use.

@docs listItemButton, href, target, rel, download, disabled
@docs onClick

-}

import Html
import Json.Decode
import M3e.Raw.ListItemButton
import M3e.Token
import Markup.Html.Attr
import Markup.Html.Attr.Internal


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
    List
        (Markup.Html.Attr.Attr
            { href : M3e.Token.Supported
            , target : M3e.Token.Supported
            , rel : M3e.Token.Supported
            , download : M3e.Token.Supported
            , disabled : M3e.Token.Supported
            , onClick : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
listItemButton attributes children =
    M3e.Raw.ListItemButton.listItemButton
        (List.map Markup.Html.Attr.toAttribute attributes)
        children


{-| The URL to which the link button points. (default: `""`)
-}
href : String -> Markup.Html.Attr.Attr { c | href : M3e.Token.Supported } msg
href =
    Markup.Html.Attr.Internal.attribute M3e.Raw.ListItemButton.href


{-| The target of the link button. (default: `""`)
-}
target : String -> Markup.Html.Attr.Attr { c | target : M3e.Token.Supported } msg
target =
    Markup.Html.Attr.Internal.attribute M3e.Raw.ListItemButton.target


{-| The relationship between the `target` of the link button and the document. (default: `""`)
-}
rel : String -> Markup.Html.Attr.Attr { c | rel : M3e.Token.Supported } msg
rel =
    Markup.Html.Attr.Internal.attribute M3e.Raw.ListItemButton.rel


{-| A value indicating whether the `target` of the link button will be downloaded,
optionally specifying the new name of the file. (default: `null`)
-}
download : String -> Markup.Html.Attr.Attr { c | download : M3e.Token.Supported } msg
download =
    Markup.Html.Attr.Internal.attribute M3e.Raw.ListItemButton.download


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Markup.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    Markup.Html.Attr.Internal.attribute M3e.Raw.ListItemButton.disabled


{-| Listen for `click` events.
-}
onClick : msg -> Markup.Html.Attr.Attr { c | onClick : M3e.Token.Supported } msg
onClick f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.ListItemButton.onClick
        (Json.Decode.succeed f_)
