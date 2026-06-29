module Cem.M3e.NavMenuItemGroup exposing (component, labelSlot)

{-| A top-level semantic grouping of items in a navigation menu.

@docs component, labelSlot

-}

import Html
import Html.Attributes


{-| A top-level semantic grouping of items in a navigation menu.

**Slots:**

  - `label`: Renders the label of the group.

**CSS Custom Properties:**

  - `--m3e-nav-menu-item-group-label-inset`: Insets the label from the start edge of the group.
  - `--m3e-nav-menu-item-group-label-space`: Vertical spacing around the group's label.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-nav-menu-item-group" attributes children


{-| Renders the label of the group.
-}
labelSlot : Html.Attribute msg
labelSlot =
    Html.Attributes.attribute "slot" "label"
