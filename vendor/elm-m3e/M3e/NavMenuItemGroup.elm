module M3e.NavMenuItemGroup exposing
    ( component
    , labelSlot
    )

{-| A top-level semantic grouping of items in a navigation menu.


## Component

@docs component


### Slots

@docs labelSlot

-}

import Html
import Html.Attributes


{-| A top-level semantic grouping of items in a navigation menu.

**Slots:**

  - `label`: Renders the label of the group.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-nav-menu-item-group" attributes children


{-| Renders the label of the group.
-}
labelSlot : Html.Attribute msg
labelSlot =
    Html.Attributes.attribute "slot" "label"
