module Cem.M3e.Icon exposing
    ( component, filled, grade, opticalSize, name, variant
    , weight
    )

{-| A small symbol used to easily identify an action or category.

@docs component, filled, grade, opticalSize, name, variant
@docs weight

-}

import Cem.M3e.Common
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
grade :
    Cem.M3e.Common.Value
        { high : Cem.M3e.Common.Supported
        , low : Cem.M3e.Common.Supported
        , medium : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
grade =
    Cem.M3e.Common.grade


{-| A value from 20 to 48 indicating the optical size of the icon. (default: `24`)
-}
opticalSize : Float -> Html.Attribute msg
opticalSize val_ =
    Html.Attributes.property "optical-size" (Json.Encode.float val_)


{-| The name of the icon. (default: `""`)
-}
name : String -> Html.Attribute msg
name val_ =
    Html.Attributes.attribute "name" val_


{-| The appearance variant of the icon. (default: `"outlined"`)
-}
variant :
    Cem.M3e.Common.Value
        { outlined : Cem.M3e.Common.Supported
        , rounded : Cem.M3e.Common.Supported
        , sharp : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
variant =
    Cem.M3e.Common.variant


{-| A value from 100 to 700 indicating the weight of the icon. (default: `400`)
-}
weight : String -> Html.Attribute msg
weight val_ =
    Html.Attributes.attribute "weight" val_
