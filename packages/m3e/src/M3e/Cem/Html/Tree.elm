module M3e.Cem.Html.Tree exposing ( tree, multi, cascade, onChange )

{-|
Bottom layer for `<m3e-tree>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, R1-correct DOM emission, no phantom typing. The rawest escape in the gradient.

@docs tree, multi, cascade, onChange
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode


{-| The raw `<m3e-tree>` element — a partial application of `Html.node`. -}
tree : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
tree =
    Html.node "m3e-tree"


{-| Whether multiple items can be selected. (default: `false`) -}
multi : Bool -> Html.Attribute msg
multi val_ =
    if val_ then
        Html.Attributes.attribute "multi" ""
    
    else
        Html.Attributes.classList []


{-| Whether multiple item selection cascades to child items. (default: `false`) -}
cascade : Bool -> Html.Attribute msg
cascade val_ =
    if val_ then
        Html.Attributes.attribute "cascade" ""
    
    else
        Html.Attributes.classList []


{-| Listen for `change` events. -}
onChange : Json.Decode.Decoder msg -> Html.Attribute msg
onChange =
    Html.Events.on "change"