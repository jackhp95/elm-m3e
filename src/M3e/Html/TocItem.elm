module M3e.Html.TocItem exposing (tocItem, disabled, selected, onClick)

{-| Middle layer for `<m3e-toc-item>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.TocItem` module for everyday use.

@docs tocItem, disabled, selected, onClick

-}

import Html
import Json.Decode
import M3e.Raw.TocItem
import M3e.Token
import Markup.Html.Attr
import Markup.Html.Attr.Internal


{-| An item in a table of contents.

**Component Info:**

  - **Extends:** `LitElement`

**Events:**

  - `click`: Dispatched when the element is clicked.

-}
tocItem :
    List
        (Markup.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , selected : M3e.Token.Supported
            , onClick : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
tocItem attributes children =
    M3e.Raw.TocItem.tocItem
        (List.map Markup.Html.Attr.toAttribute attributes)
        children


{-| A value indicating whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Markup.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    Markup.Html.Attr.Internal.attribute M3e.Raw.TocItem.disabled


{-| Whether the element is selected. (default: `false`)
-}
selected : Bool -> Markup.Html.Attr.Attr { c | selected : M3e.Token.Supported } msg
selected =
    Markup.Html.Attr.Internal.attribute M3e.Raw.TocItem.selected


{-| Listen for `click` events.
-}
onClick : msg -> Markup.Html.Attr.Attr { c | onClick : M3e.Token.Supported } msg
onClick f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.TocItem.onClick
        (Json.Decode.succeed f_)
