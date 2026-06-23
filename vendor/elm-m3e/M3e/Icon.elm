module M3e.Icon exposing
    ( component
    , filled, grade, opticalSize, weight
    )

{-| A small symbol used to easily identify an action or category.


## Component

@docs component


### Attributes

@docs filled, grade, opticalSize, weight

-}

import Html
import Html.Attributes
import Json.Encode


{-| A small symbol used to easily identify an action or category.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-icon" attributes children


{-| Whether the icon is filled. (default: `false`)
-}
filled : Bool -> Html.Attribute msg
filled val_ =
    Html.Attributes.property "filled" (Json.Encode.bool val_)


{-| The grade of the icon. (default: `"medium"`)
-}
grade : String -> Html.Attribute msg
grade val_ =
    Html.Attributes.attribute "grade" val_


{-| A value from 20 to 48 indicating the optical size of the icon. (default: `24`)
-}
opticalSize : Float -> Html.Attribute msg
opticalSize val_ =
    Html.Attributes.property "optical-size" (Json.Encode.float val_)


{-| A value from 100 to 700 indicating the weight of the icon. (default: `400`)
-}
weight : String -> Html.Attribute msg
weight val_ =
    Html.Attributes.attribute "weight" val_
