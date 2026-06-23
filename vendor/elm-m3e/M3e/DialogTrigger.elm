module M3e.DialogTrigger exposing (component)

{-| An element, nested within a clickable element, used to open a dialog.


## Component

@docs component

-}

import Html


{-| An element, nested within a clickable element, used to open a dialog.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-dialog-trigger" attributes children
