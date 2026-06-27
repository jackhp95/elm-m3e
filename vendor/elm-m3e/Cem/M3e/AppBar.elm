module Cem.M3e.AppBar exposing
    ( component
    , centered, for, Size(..), size
    , leadingSlot, subtitleSlot, titleSlot, trailingSlot, leadingIconSlot, trailingIconSlot
    , sizeToString
    )

{-| A bar, placed a the top of a screen, used to help users navigate through an application.


## Component

@docs component


### Attributes

@docs centered, for, Size, size


### Slots

@docs leadingSlot, subtitleSlot, titleSlot, trailingSlot, leadingIconSlot, trailingIconSlot

-}

import Html
import Html.Attributes
import Json.Encode


{-| A bar, placed a the top of a screen, used to help users navigate through an application.

**Slots:**

  - `leading`: Renders content positioned at the start of the bar.
  - `subtitle`: Renders the subtitle of the bar.
  - `title`: Renders the title of the bar.
  - `trailing`: Renders one or more action buttons aligned to the end of the bar.
  - `leading-icon`: Deprecated: use the `leading` slot.
  - `trailing-icon`: Deprecated: use the `trailing` slot.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-app-bar" attributes children


{-| Whether the title and subtitle are centered. (default: `false`)
-}
centered : Bool -> Html.Attribute msg
centered val_ =
    Html.Attributes.property "centered" (Json.Encode.bool val_)


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for : String -> Html.Attribute msg
for val_ =
    Html.Attributes.attribute "for" val_


{-| Values for the `size` attribute.
-}
type Size
    = Large
    | Medium
    | Small


{-| The size of the bar. (default: `"small"`)
-}
size : Size -> Html.Attribute msg
size val_ =
    Html.Attributes.attribute "size" (sizeToString val_)


sizeToString : Size -> String
sizeToString val_ =
    case val_ of
        Large ->
            "large"

        Medium ->
            "medium"

        Small ->
            "small"


{-| Renders content positioned at the start of the bar.
-}
leadingSlot : Html.Attribute msg
leadingSlot =
    Html.Attributes.attribute "slot" "leading"


{-| Renders the subtitle of the bar.
-}
subtitleSlot : Html.Attribute msg
subtitleSlot =
    Html.Attributes.attribute "slot" "subtitle"


{-| Renders the title of the bar.
-}
titleSlot : Html.Attribute msg
titleSlot =
    Html.Attributes.attribute "slot" "title"


{-| Renders one or more action buttons aligned to the end of the bar.
-}
trailingSlot : Html.Attribute msg
trailingSlot =
    Html.Attributes.attribute "slot" "trailing"


{-| Deprecated: use the `leading` slot.
-}
leadingIconSlot : Html.Attribute msg
leadingIconSlot =
    Html.Attributes.attribute "slot" "leading-icon"


{-| Deprecated: use the `trailing` slot.
-}
trailingIconSlot : Html.Attribute msg
trailingIconSlot =
    Html.Attributes.attribute "slot" "trailing-icon"
