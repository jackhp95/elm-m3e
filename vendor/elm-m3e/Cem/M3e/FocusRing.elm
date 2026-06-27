module Cem.M3e.FocusRing exposing
    ( component
    , disabled, inward, for
    )

{-| A focus ring used to depict a strong focus indicator.


## Component

@docs component


### Attributes

@docs disabled, inward, for

-}

import Html
import Html.Attributes
import Json.Encode


{-| A focus ring used to depict a strong focus indicator.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-focus-ring" attributes children


{-| Whether the focus events will not trigger the focus ring.
Focus rings can be still controlled manually by using the `show` and `hide` methods. (default: `false`)
-}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| Whether the focus ring animates inward instead of outward. (default: `false`)
-}
inward : Bool -> Html.Attribute msg
inward val_ =
    Html.Attributes.property "inward" (Json.Encode.bool val_)


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for : String -> Html.Attribute msg
for val_ =
    Html.Attributes.attribute "for" val_
