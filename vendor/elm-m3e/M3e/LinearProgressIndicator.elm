module M3e.LinearProgressIndicator exposing
    ( component
    , bufferValue, value
    )

{-| A horizontal bar for indicating progress and activity.


## Component

@docs component


### Attributes

@docs bufferValue, value

-}

import Html
import Html.Attributes
import Json.Encode


{-| A horizontal bar for indicating progress and activity.

**Component Info:**

  - **Extends:** `ProgressElementIndicatorBase` from `/src/progress-indicator/ProgressElementIndicatorBase`

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-linear-progress-indicator" attributes children


{-| A fractional value, between 0 and `max`, indicating buffer progress. (default: `0`)
-}
bufferValue : Float -> Html.Attribute msg
bufferValue val_ =
    Html.Attributes.property "buffer-value" (Json.Encode.float val_)


{-| A fractional value, between 0 and `max`, indicating progress. (default: `0`)
-}
value : String -> Html.Attribute msg
value =
    Html.Attributes.value
