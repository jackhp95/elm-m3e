module M3e.Cem.Html.BreadcrumbItem exposing
    ( breadcrumbItem, itemLabel, disabled, current, href, target
    , download, rel, onClick
    )

{-|
Bottom layer for `<m3e-breadcrumb-item>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, R1-correct DOM emission, no phantom typing. The rawest escape in the gradient.

@docs breadcrumbItem, itemLabel, disabled, current, href, target
@docs download, rel, onClick
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode


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
    if val_ then
        Html.Attributes.attribute "disabled" ""
    
    else
        Html.Attributes.classList []


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