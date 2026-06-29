module Cem.M3e.ProgressElementIndicatorBase exposing (component, value, maxAttr, variant)

{-| A base implementation for an element used to convey progress. This class must be inherited.

@docs component, value, maxAttr, variant

-}

import Cem.M3e.Common
import Html
import Html.Attributes
import Json.Encode


{-| A base implementation for an element used to convey progress. This class must be inherited.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "div" attributes children


{-| A fractional value, between 0 and `max`, indicating progress. (default: `0`)
-}
value : String -> Html.Attribute msg
value =
    Html.Attributes.value


{-| The maximum progress value. (default: `100`)
-}
maxAttr : Float -> Html.Attribute msg
maxAttr val_ =
    Html.Attributes.property "max" (Json.Encode.float val_)


{-| The appearance of the indicator. (default: `"flat"`)
-}
variant :
    Cem.M3e.Common.Value
        { flat : Cem.M3e.Common.Supported
        , wavy : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
variant =
    Cem.M3e.Common.variant
