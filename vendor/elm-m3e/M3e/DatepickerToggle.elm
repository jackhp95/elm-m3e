module M3e.DatepickerToggle exposing (component)

{-| An element, nested within a clickable element, used to toggle a datepicker.


## Component

@docs component

-}

import Html


{-| An element, nested within a clickable element, used to toggle a datepicker.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-datepicker-toggle" attributes children
