module M3e.Cem.Html.Icon exposing
    ( icon, filled, grade, opticalSize, name, variant
    , weight
    )

{-|
Bottom layer for `<m3e-icon>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, R1-correct DOM emission, no phantom typing. The rawest escape in the gradient.

@docs icon, filled, grade, opticalSize, name, variant
@docs weight
-}


import Html
import Html.Attributes
import Json.Encode


{-| The raw `<m3e-icon>` element — a partial application of `Html.node`. -}
icon : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
icon =
    Html.node "m3e-icon"


{-| Whether the icon is filled. (default: `false`) -}
filled : Bool -> Html.Attribute msg
filled val_ =
    Html.Attributes.property "filled" (Json.Encode.bool val_)


{-| The grade of the icon. (default: `"medium"`) -}
grade : String -> Html.Attribute msg
grade =
    Html.Attributes.attribute "grade"


{-| A value from 20 to 48 indicating the optical size of the icon. (default: `24`) -}
opticalSize : Float -> Html.Attribute msg
opticalSize val_ =
    Html.Attributes.property "opticalSize" (Json.Encode.float val_)


{-| The name of the icon. (default: `""`) -}
name : String -> Html.Attribute msg
name =
    Html.Attributes.attribute "name"


{-| The appearance variant of the icon. (default: `"outlined"`) -}
variant : String -> Html.Attribute msg
variant =
    Html.Attributes.attribute "variant"


{-| A value from 100 to 700 indicating the weight of the icon. (default: `400`) -}
weight : String -> Html.Attribute msg
weight =
    Html.Attributes.attribute "weight"