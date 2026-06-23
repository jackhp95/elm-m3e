module M3e.ListItem exposing
    ( component
    , leadingSlot, overlineSlot, supportingTextSlot, trailingSlot
    )

{-| An item in a list.


## Component

@docs component


### Slots

@docs leadingSlot, overlineSlot, supportingTextSlot, trailingSlot

-}

import Html
import Html.Attributes


{-| An item in a list.

**Slots:**

  - `leading`: Renders the leading content of the list item.
  - `overline`: Renders the overline of the list item.
  - `supporting-text`: Renders the supporting text of the list item.
  - `trailing`: Renders the trailing content of the list item.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-list-item" attributes children


{-| Renders the leading content of the list item.
-}
leadingSlot : Html.Attribute msg
leadingSlot =
    Html.Attributes.attribute "slot" "leading"


{-| Renders the overline of the list item.
-}
overlineSlot : Html.Attribute msg
overlineSlot =
    Html.Attributes.attribute "slot" "overline"


{-| Renders the supporting text of the list item.
-}
supportingTextSlot : Html.Attribute msg
supportingTextSlot =
    Html.Attributes.attribute "slot" "supporting-text"


{-| Renders the trailing content of the list item.
-}
trailingSlot : Html.Attribute msg
trailingSlot =
    Html.Attributes.attribute "slot" "trailing"
