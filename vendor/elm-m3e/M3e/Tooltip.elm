module M3e.Tooltip exposing (component)

{-| Adds additional context to a button or other UI element.


## Component

@docs component

-}

import Html


{-| Adds additional context to a button or other UI element.

**Component Info:**

  - **Extends:** `TooltipElementBase` from `/src/tooltip/TooltipElementBase`

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-tooltip" attributes children
