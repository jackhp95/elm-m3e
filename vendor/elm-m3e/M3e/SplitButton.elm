module M3e.SplitButton exposing
    ( component
    , leadingButtonSlot, trailingButtonSlot
    )

{-| A button used to show an action with a menu of related actions.


## Component

@docs component


### Slots

@docs leadingButtonSlot, trailingButtonSlot

-}

import Html
import Html.Attributes


{-| A button used to show an action with a menu of related actions.

**Slots:**

  - `leading-button`: The leading button used to perform the primary action.
  - `trailing-button`: The trailing icon button used to open a menu of related actions.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-split-button" attributes children


{-| The leading button used to perform the primary action.
-}
leadingButtonSlot : Html.Attribute msg
leadingButtonSlot =
    Html.Attributes.attribute "slot" "leading-button"


{-| The trailing icon button used to open a menu of related actions.
-}
trailingButtonSlot : Html.Attribute msg
trailingButtonSlot =
    Html.Attributes.attribute "slot" "trailing-button"
