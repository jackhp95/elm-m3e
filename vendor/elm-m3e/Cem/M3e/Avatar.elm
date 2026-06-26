module Cem.M3e.Avatar exposing (component)

{-| 
An image, icon or textual initials representing a user or other identity.

## Component

@docs component
-}


import Html


{-| An image, icon or textual initials representing a user or other identity. -}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-avatar" attributes children