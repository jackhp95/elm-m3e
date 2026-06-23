module M3e.FocusRing exposing
    ( component
    , inward
    )

{-| A focus ring used to depict a strong focus indicator.


## Component

@docs component


### Attributes

@docs inward

-}

import Html
import Html.Attributes
import Json.Encode


{-| A focus ring used to depict a strong focus indicator.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-focus-ring" attributes children


{-| Whether the focus ring animates inward instead of outward. (default: `false`)
-}
inward : Bool -> Html.Attribute msg
inward val_ =
    Html.Attributes.property "inward" (Json.Encode.bool val_)
