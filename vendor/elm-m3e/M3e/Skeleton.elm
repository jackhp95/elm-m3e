module M3e.Skeleton exposing
    ( component
    , animation, loaded
    )

{-| A visual placeholder that mimics the layout of content while it's still loading.


## Component

@docs component


### Attributes

@docs animation, loaded

-}

import Html
import Html.Attributes
import Json.Encode


{-| A visual placeholder that mimics the layout of content while it's still loading.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-skeleton" attributes children


{-| The animation effect of the skeleton. (default: `"wave"`)
-}
animation : String -> Html.Attribute msg
animation val_ =
    Html.Attributes.attribute "animation" val_


{-| Whether the content of the skeleton has been loaded. (default: `false`)
-}
loaded : Bool -> Html.Attribute msg
loaded val_ =
    Html.Attributes.property "loaded" (Json.Encode.bool val_)
