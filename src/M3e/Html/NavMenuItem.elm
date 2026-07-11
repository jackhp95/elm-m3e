module M3e.Html.NavMenuItem exposing
    ( navMenuItem, disabled, open, selected, onOpening, onOpened
    , onClosing, onClosed, onClick
    )

{-| Middle layer for `<m3e-nav-menu-item>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.NavMenuItem` module for everyday use.

@docs navMenuItem, disabled, open, selected, onOpening, onOpened
@docs onClosing, onClosed, onClick

-}

import Html
import Json.Decode
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Raw.NavMenuItem
import M3e.Token


{-| An expandable item, selectable item within a navigation menu.

**Component Info:**

  - **Extends:** `LitElement`

**Events:**

  - `opening`: Dispatched when the item begins to open.
  - `opened`: Dispatched when the item has opened.
  - `closing`: Dispatched when the item begins to close.
  - `closed`: Dispatched when the item has closed.
  - `click`: Dispatched when the element is clicked.

**Slots:**

  - `label`: Renders the label of the item.
  - `icon`: Renders the icon of the item.
  - `badge`: Renders the badge of the item.
  - `selected-icon`: Renders the icon of the item when selected.
  - `toggle-icon`: Renders the toggle icon.

-}
navMenuItem :
    List
        (M3e.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , open : M3e.Token.Supported
            , selected : M3e.Token.Supported
            , onOpening : M3e.Token.Supported
            , onOpened : M3e.Token.Supported
            , onClosing : M3e.Token.Supported
            , onClosed : M3e.Token.Supported
            , onClick : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
navMenuItem attributes children =
    M3e.Raw.NavMenuItem.navMenuItem
        (List.map M3e.Html.Attr.toAttribute attributes)
        children


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> M3e.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    M3e.Html.Attr.Internal.attribute M3e.Raw.NavMenuItem.disabled


{-| Whether the item is expanded. (default: `false`)
-}
open : Bool -> M3e.Html.Attr.Attr { c | open : M3e.Token.Supported } msg
open =
    M3e.Html.Attr.Internal.attribute M3e.Raw.NavMenuItem.open


{-| Whether the item is selected. (default: `false`)
-}
selected : Bool -> M3e.Html.Attr.Attr { c | selected : M3e.Token.Supported } msg
selected =
    M3e.Html.Attr.Internal.attribute M3e.Raw.NavMenuItem.selected


{-| Listen for `opening` events.
-}
onOpening : msg -> M3e.Html.Attr.Attr { c | onOpening : M3e.Token.Supported } msg
onOpening f_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.NavMenuItem.onOpening
        (Json.Decode.succeed f_)


{-| Listen for `opened` events.
-}
onOpened : msg -> M3e.Html.Attr.Attr { c | onOpened : M3e.Token.Supported } msg
onOpened f_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.NavMenuItem.onOpened
        (Json.Decode.succeed f_)


{-| Listen for `closing` events.
-}
onClosing : msg -> M3e.Html.Attr.Attr { c | onClosing : M3e.Token.Supported } msg
onClosing f_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.NavMenuItem.onClosing
        (Json.Decode.succeed f_)


{-| Listen for `closed` events.
-}
onClosed : msg -> M3e.Html.Attr.Attr { c | onClosed : M3e.Token.Supported } msg
onClosed f_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.NavMenuItem.onClosed
        (Json.Decode.succeed f_)


{-| Listen for `click` events.
-}
onClick : msg -> M3e.Html.Attr.Attr { c | onClick : M3e.Token.Supported } msg
onClick f_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.NavMenuItem.onClick
        (Json.Decode.succeed f_)
