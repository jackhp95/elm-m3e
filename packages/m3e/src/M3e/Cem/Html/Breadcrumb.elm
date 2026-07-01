module M3e.Cem.Html.Breadcrumb exposing (breadcrumb, wrap)

{-| 
@docs breadcrumb, wrap
-}


import Html
import Html.Attributes
import Json.Encode


{-| The raw `<m3e-breadcrumb>` element — a partial application of `Html.node`. -}
breadcrumb : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
breadcrumb =
    Html.node "m3e-breadcrumb"


{-| Whether items wrap to a new line. (default: `false`) -}
wrap : Bool -> Html.Attribute msg
wrap val_ =
    Html.Attributes.property "wrap" (Json.Encode.bool val_)