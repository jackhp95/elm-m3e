module M3e.CircularProgressIndicator exposing
    ( component
    , value
    )

{-| A circular indicator of progress and activity.


## Component

@docs component


### Attributes

@docs value

-}

import Html
import Html.Attributes


{-| A circular indicator of progress and activity.

**Component Info:**

  - **Extends:** `ProgressElementIndicatorBase` from `/src/progress-indicator/ProgressElementIndicatorBase`

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-circular-progress-indicator" attributes children


{-| A fractional value, between 0 and `max`, indicating progress. (default: `0`)
-}
value : String -> Html.Attribute msg
value =
    Html.Attributes.value
