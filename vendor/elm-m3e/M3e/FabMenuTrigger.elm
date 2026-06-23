module M3e.FabMenuTrigger exposing (component)

{-| An element, nested within a clickable element, used to open a floating action button (FAB) menu.


## Component

@docs component

-}

import Html


{-| An element, nested within a clickable element, used to open a floating action button (FAB) menu.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-fab-menu-trigger" attributes children
