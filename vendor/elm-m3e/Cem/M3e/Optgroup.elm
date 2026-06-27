module Cem.M3e.Optgroup exposing
    ( component
    , labelSlot
    )

{-| Groups options under a subheading.


## Component

@docs component


### Slots

@docs labelSlot

-}

import Html
import Html.Attributes


{-| Groups options under a subheading.

**Slots:**

  - `label`: Renders the label of the group.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-optgroup" attributes children


{-| Renders the label of the group.
-}
labelSlot : Html.Attribute msg
labelSlot =
    Html.Attributes.attribute "slot" "label"
