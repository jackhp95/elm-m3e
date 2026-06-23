module M3e.LoadingIndicator exposing (component)

{-| Shows indeterminate progress for a short wait time.


## Component

@docs component

-}

import Html


{-| Shows indeterminate progress for a short wait time.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-loading-indicator" attributes children
