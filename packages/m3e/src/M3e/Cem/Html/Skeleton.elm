module M3e.Cem.Html.Skeleton exposing (animation, loaded, shape, skeleton)

{-| 
@docs skeleton, animation, shape, loaded
-}


import Html
import Html.Attributes
import Json.Encode


{-| The raw `<m3e-skeleton>` element — a partial application of `Html.node`. -}
skeleton : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
skeleton =
    Html.node "m3e-skeleton"


{-| The animation effect of the skeleton. (default: `"wave"`) -}
animation : String -> Html.Attribute msg
animation =
    Html.Attributes.attribute "animation"


{-| The shape of the skeleton. (default: `"auto"`) -}
shape : String -> Html.Attribute msg
shape =
    Html.Attributes.attribute "shape"


{-| Whether the content of the skeleton has been loaded. (default: `false`) -}
loaded : Bool -> Html.Attribute msg
loaded val_ =
    Html.Attributes.property "loaded" (Json.Encode.bool val_)