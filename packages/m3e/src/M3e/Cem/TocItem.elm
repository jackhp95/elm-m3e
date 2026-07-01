module M3e.Cem.TocItem exposing (disabled, onClick, selected, tocItem)

{-| 
@docs tocItem, disabled, selected, onClick
-}


import Html
import Json.Decode
import M3e.Cem.Attr
import M3e.Cem.Html.TocItem
import M3e.Value


{-| An item in a table of contents.

**Events:**
- `click`: Dispatched when the element is clicked.
-}
tocItem :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , selected : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
tocItem attributes children =
    M3e.Cem.Html.TocItem.tocItem
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| A value indicating whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.Attr.attribute M3e.Cem.Html.TocItem.disabled


{-| Whether the element is selected. (default: `false`) -}
selected : Bool -> M3e.Cem.Attr.Attr { c | selected : M3e.Value.Supported } msg
selected =
    M3e.Cem.Attr.attribute M3e.Cem.Html.TocItem.selected


{-| Listen for `click` events. -}
onClick : msg -> M3e.Cem.Attr.Attr { c | onClick : M3e.Value.Supported } msg
onClick f_ =
    M3e.Cem.Attr.attribute M3e.Cem.Html.TocItem.onClick (Json.Decode.succeed f_)