module M3e.Cem.Html.Fab exposing
    ( fab, disabled, disabledInteractive, download, extended, href
    , lowered, name, rel, size, target, type_, value
    , variant, onClick
    )

{-|
Bottom layer for `<m3e-fab>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, R1-correct DOM emission, no phantom typing. The rawest escape in the gradient.

@docs fab, disabled, disabledInteractive, download, extended, href
@docs lowered, name, rel, size, target, type_
@docs value, variant, onClick
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode


{-| The raw `<m3e-fab>` element — a partial application of `Html.node`. -}
fab : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
fab =
    Html.node "m3e-fab"


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    if val_ then
        Html.Attributes.attribute "disabled" ""
    
    else
        Html.Attributes.classList []


{-| Whether the element is disabled and interactive. (default: `false`) -}
disabledInteractive : Bool -> Html.Attribute msg
disabledInteractive val_ =
    if val_ then
        Html.Attributes.attribute "disabled-interactive" ""
    
    else
        Html.Attributes.classList []


{-| A value indicating whether the `target` of the link button will be downloaded, optionally specifying the new name of the file. (default: `null`) -}
download : String -> Html.Attribute msg
download =
    Html.Attributes.attribute "download"


{-| Whether the button is extended to show the label. (default: `false`) -}
extended : Bool -> Html.Attribute msg
extended val_ =
    if val_ then
        Html.Attributes.attribute "extended" ""
    
    else
        Html.Attributes.classList []


{-| The URL to which the link button points. (default: `""`) -}
href : String -> Html.Attribute msg
href =
    Html.Attributes.attribute "href"


{-| Whether to present a lowered elevation. (default: `false`) -}
lowered : Bool -> Html.Attribute msg
lowered val_ =
    if val_ then
        Html.Attributes.attribute "lowered" ""
    
    else
        Html.Attributes.classList []


{-| The name of the element, submitted as a pair with the element's `value` as part of form data, when the element is used to submit a form. -}
name : String -> Html.Attribute msg
name =
    Html.Attributes.attribute "name"


{-| The relationship between the `target` of the link button and the document. (default: `""`) -}
rel : String -> Html.Attribute msg
rel =
    Html.Attributes.attribute "rel"


{-| The size of the button. (default: `"medium"`) -}
size : String -> Html.Attribute msg
size =
    Html.Attributes.attribute "size"


{-| The target of the link button. (default: `""`) -}
target : String -> Html.Attribute msg
target =
    Html.Attributes.attribute "target"


{-| The type of the element. (default: `"button"`) -}
type_ : String -> Html.Attribute msg
type_ =
    Html.Attributes.attribute "type"


{-| The value associated with the element's name when it's submitted with form data. -}
value : String -> Html.Attribute msg
value =
    Html.Attributes.attribute "value"


{-| The appearance variant of the button. (default: `"primary-container"`) -}
variant : String -> Html.Attribute msg
variant =
    Html.Attributes.attribute "variant"


{-| Listen for `click` events. -}
onClick : Json.Decode.Decoder msg -> Html.Attribute msg
onClick =
    Html.Events.on "click"