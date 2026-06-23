module M3e.ThemeIcon exposing (component)

{-| An icon that visually presents a preview of a theme.


## Component

@docs component

-}

import Html


{-| An icon that visually presents a preview of a theme.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-theme-icon" attributes children
