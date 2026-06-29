module Cem.M3e.ActionElementBase exposing (component)

{-| A base implementation for an element, nested within a clickable element, used to
perform an action. This class must be inherited.

@docs component

-}

import Html


{-| A base implementation for an element, nested within a clickable element, used to
perform an action. This class must be inherited.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "div" attributes children
