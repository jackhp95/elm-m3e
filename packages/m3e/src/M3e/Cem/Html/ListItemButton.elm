module M3e.Cem.Html.ListItemButton exposing (disabled, download, href, listItemButton, onClick, rel, target)

{-| 
@docs listItemButton, href, target, rel, download, disabled, onClick
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| The raw `<m3e-list-item-button>` element — a partial application of `Html.node`. -}
listItemButton :
    List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
listItemButton =
    Html.node "m3e-list-item-button"


{-| The URL to which the link button points. (default: `""`) -}
href : String -> Html.Attribute msg
href =
    Html.Attributes.attribute "href"


{-| The target of the link button. (default: `""`) -}
target : String -> Html.Attribute msg
target =
    Html.Attributes.attribute "target"


{-| The relationship between the `target` of the link button and the document. (default: `""`) -}
rel : String -> Html.Attribute msg
rel =
    Html.Attributes.attribute "rel"


{-| A value indicating whether the `target` of the link button will be downloaded,
optionally specifying the new name of the file. (default: `null`)
-}
download : String -> Html.Attribute msg
download =
    Html.Attributes.attribute "download"


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| Listen for `click` events. -}
onClick : Json.Decode.Decoder msg -> Html.Attribute msg
onClick =
    Html.Events.on "click"