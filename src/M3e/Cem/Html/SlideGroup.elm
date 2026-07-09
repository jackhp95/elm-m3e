module M3e.Cem.Html.SlideGroup exposing
    ( slideGroup, disabled, nextPageLabel, previousPageLabel, threshold, vertical
    )

{-|
Bottom layer for `<m3e-slide-group>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, R1-correct DOM emission, no phantom typing. The rawest escape in the gradient.

@docs slideGroup, disabled, nextPageLabel, previousPageLabel, threshold, vertical
-}


import Html
import Html.Attributes


{-| The raw `<m3e-slide-group>` element — a partial application of `Html.node`. -}
slideGroup : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
slideGroup =
    Html.node "m3e-slide-group"


{-| Whether scroll buttons are disabled. (default: `false`) -}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    if val_ then
        Html.Attributes.attribute "disabled" ""
    
    else
        Html.Attributes.classList []


{-| The accessible label given to the button used to move to the next page. (default: `"Next page"`) -}
nextPageLabel : String -> Html.Attribute msg
nextPageLabel =
    Html.Attributes.attribute "next-page-label"


{-| The accessible label given to the button used to move to the previous page. (default: `"Previous page"`) -}
previousPageLabel : String -> Html.Attribute msg
previousPageLabel =
    Html.Attributes.attribute "previous-page-label"


{-| A value, in pixels, indicating the scroll threshold at which to begin showing pagination controls. (default: `0`) -}
threshold : Float -> Html.Attribute msg
threshold val_ =
    Html.Attributes.attribute "threshold" (String.fromFloat val_)


{-| Whether content is oriented vertically. (default: `false`) -}
vertical : Bool -> Html.Attribute msg
vertical val_ =
    if val_ then
        Html.Attributes.attribute "vertical" ""
    
    else
        Html.Attributes.classList []