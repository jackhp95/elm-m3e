module M3e.Cem.Html.BreadcrumbItemButton exposing
    ( breadcrumbItemButton, current, href, target, rel, download
    , disabled, onClick
    )

{-|
Bottom layer for `<m3e-breadcrumb-item-button>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, R1-correct DOM emission, no phantom typing. The rawest escape in the gradient.

@docs breadcrumbItemButton, current, href, target, rel, download
@docs disabled, onClick
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode


{-| The raw `<m3e-breadcrumb-item-button>` element — a partial application of `Html.node`. -}
breadcrumbItemButton :
    List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
breadcrumbItemButton =
    Html.node "m3e-breadcrumb-item-button"


{-| Indicates the current item in the breadcrumb path. -}
current : String -> Html.Attribute msg
current =
    Html.Attributes.attribute "current"


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
    if val_ then
        Html.Attributes.attribute "disabled" ""
    
    else
        Html.Attributes.classList []


{-| Listen for `click` events. -}
onClick : Json.Decode.Decoder msg -> Html.Attribute msg
onClick =
    Html.Events.on "click"