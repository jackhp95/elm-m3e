module M3e.Cem.Html.BreadcrumbItem exposing (breadcrumbItem, current, disabled, download, href, itemLabel, onClick, rel, target)

{-| 
@docs breadcrumbItem, itemLabel, disabled, current, href, target, download, rel, onClick
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| The raw `<m3e-breadcrumb-item>` element — a partial application of `Html.node`. -}
breadcrumbItem :
    List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
breadcrumbItem =
    Html.node "m3e-breadcrumb-item"


{-| The accessible label given to the item's internal button. (default: `""`) -}
itemLabel : String -> Html.Attribute msg
itemLabel =
    Html.Attributes.attribute "item-label"


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| Indicates the current item in the breadcrumb path. -}
current : String -> Html.Attribute msg
current =
    Html.Attributes.attribute "current"


{-| The URL to which the internal breadcrumb link button points. (default: `""`) -}
href : String -> Html.Attribute msg
href =
    Html.Attributes.attribute "href"


{-| The target of the internal breadcrumb link button. (default: `""`) -}
target : String -> Html.Attribute msg
target =
    Html.Attributes.attribute "target"


{-| A value indicating whether the internal link target will be downloaded, optionally specifying a file name. (default: `null`) -}
download : String -> Html.Attribute msg
download =
    Html.Attributes.attribute "download"


{-| The relationship between the internal link target and the document. (default: `""`) -}
rel : String -> Html.Attribute msg
rel =
    Html.Attributes.attribute "rel"


{-| Listen for `click` events. -}
onClick : Json.Decode.Decoder msg -> Html.Attribute msg
onClick =
    Html.Events.on "click"