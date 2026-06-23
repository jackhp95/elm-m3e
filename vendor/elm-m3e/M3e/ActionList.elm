module M3e.ActionList exposing (component)

{-| A list of actions.


## Component

@docs component

-}

import Html


{-| A list of actions.

**Component Info:**

  - **Extends:** `M3eListElement` from `/src/list/ListElement`

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-action-list" attributes children
