module M3e.ProgressElementIndicatorBase exposing
    ( component
    , value
    )

{-| A base implementation for an element used to convey progress. This class must be inherited.


## Component

@docs component


### Attributes

@docs value

-}

import Html
import Html.Attributes


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
