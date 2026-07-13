module M3e.Raw.ListAction exposing
    ( listAction, disabled, download, href, rel, target
    , onClick
    )

{-| Bottom layer for `<m3e-list-action>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, faithful DOM emission, no phantom typing. The rawest escape in the gradient.

@docs listAction, disabled, download, href, rel, target
@docs onClick

-}

import Html
import Html.Attributes
import Html.Events
import Json.Decode


{-| The raw `<m3e-list-action>` element — a partial application of `Html.node`.
-}
listAction : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
listAction =
    Html.node "m3e-list-action"


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    if val_ then
        Html.Attributes.attribute "disabled" ""

    else
        Html.Attributes.classList []


{-| A value indicating whether the `target` of the link button will be downloaded, optionally specifying the new name of the file. (default: `null`)
-}
download : String -> Html.Attribute msg
download =
    Html.Attributes.attribute "download"


{-| The URL to which the link button points. (default: `""`)
-}
href : String -> Html.Attribute msg
href =
    Html.Attributes.attribute "href"


{-| The relationship between the `target` of the link button and the document. (default: `""`)
-}
rel : String -> Html.Attribute msg
rel =
    Html.Attributes.attribute "rel"


{-| The target of the link button. (default: `""`)
-}
target : String -> Html.Attribute msg
target =
    Html.Attributes.attribute "target"


{-| Listen for `click` events.
-}
onClick : Json.Decode.Decoder msg -> Html.Attribute msg
onClick =
    Html.Events.on "click"
