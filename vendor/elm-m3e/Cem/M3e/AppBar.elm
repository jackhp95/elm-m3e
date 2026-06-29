module Cem.M3e.AppBar exposing
    ( component, centered, for, size, leadingSlot, subtitleSlot
    , titleSlot, trailingSlot, leadingIconSlot, trailingIconSlot
    )

{-| A bar, placed a the top of a screen, used to help users navigate through an application.

@docs component, centered, for, size, leadingSlot, subtitleSlot
@docs titleSlot, trailingSlot, leadingIconSlot, trailingIconSlot

-}

import Cem.M3e.Common
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

**CSS Custom Properties:**

  - `--m3e-app-bar-container-color`: Background color of the app bar container.
  - `--m3e-app-bar-container-color-on-scroll`: Background color of the app bar container when scrolled.
  - `--m3e-app-bar-container-elevation`: Elevation (shadow) of the app bar container.
  - `--m3e-app-bar-container-elevation-on-scroll`: Elevation (shadow) of the app bar container when scrolled.
  - `--m3e-app-bar-title-text-color`: Color of the app bar title text.
  - `--m3e-app-bar-subtitle-text-color`: Color of the app bar subtitle text.
  - `--m3e-app-bar-padding-left`: Left padding for the app bar container.
  - `--m3e-app-bar-padding-right`: Right padding for the app bar container.
  - `--m3e-app-bar-small-container-height`: Height of the small app bar container.
  - `--m3e-app-bar-small-title-text-font-size`: Font size for the small app bar title text.
  - `--m3e-app-bar-small-title-text-font-weight`: Font weight for the small app bar title text.
  - `--m3e-app-bar-small-title-text-line-height`: Line height for the small app bar title text.
  - `--m3e-app-bar-small-subtitle-text-tracking`: Letter spacing (tracking) for the small app bar title text.
  - `--m3e-app-bar-small-subtitle-text-font-size`: Font size for the small app bar subtitle text.
  - `--m3e-app-bar-small-subtitle-text-font-weight`: Font weight for the small app bar subtitle text.
  - `--m3e-app-bar-small-subtitle-text-line-height`: Line height for the small app bar subtitle text.
  - `--m3e-app-bar-small-subtitle-text-tracking`: Letter spacing (tracking) for the small app bar subtitle text.
  - `--m3e-app-bar-small-heading-padding-left`: Left padding for the small app bar heading.
  - `--m3e-app-bar-small-heading-padding-right`: Right padding for the small app bar heading.
  - `--m3e-app-bar-medium-container-height`: Height of the medium app bar container.
  - `--m3e-app-bar-medium-container-height-with-subtitle`: Height of the medium app bar container with subtitle.
  - `--m3e-app-bar-medium-title-text-font-size`: Font size for the medium app bar title text.
  - `--m3e-app-bar-medium-title-text-font-weight`: Font weight for the medium app bar title text.
  - `--m3e-app-bar-medium-title-text-line-height`: Line height for the medium app bar title text.
  - `--m3e-app-bar-medium-subtitle-text-tracking`: Letter spacing (tracking) for the medium app bar title text.
  - `--m3e-app-bar-medium-subtitle-text-font-size`: Font size for the medium app bar subtitle text.
  - `--m3e-app-bar-medium-subtitle-text-font-weight`: Font weight for the medium app bar subtitle text.
  - `--m3e-app-bar-medium-subtitle-text-line-height`: Line height for the medium app bar subtitle text.
  - `--m3e-app-bar-medium-subtitle-text-tracking`: Letter spacing (tracking) for the medium app bar subtitle text.
  - `--m3e-app-bar-medium-heading-padding-left`: Left padding for the medium app bar heading.
  - `--m3e-app-bar-medium-heading-padding-right`: Right padding for the medium app bar heading.
  - `--m3e-app-bar-medium-padding-top`: Top padding for the medium app bar.
  - `--m3e-app-bar-medium-padding-bottom`: Bottom padding for the medium app bar.
  - `--m3e-app-bar-medium-title-max-lines`: Maximum number of lines for the medium app bar title.
  - `--m3e-app-bar-medium-subtitle-max-lines`: Maximum number of lines for the medium app bar subtitle.
  - `--m3e-app-bar-large-container-height`: Height of the large app bar container.
  - `--m3e-app-bar-large-container-height-with-subtitle`: Height of the large app bar container with subtitle.
  - `--m3e-app-bar-large-title-text-font-size`: Font size for the large app bar title text.
  - `--m3e-app-bar-large-title-text-font-weight`: Font weight for the large app bar title text.
  - `--m3e-app-bar-large-title-text-line-height`: Line height for the large app bar title text.
  - `--m3e-app-bar-large-subtitle-text-tracking`: Letter spacing (tracking) for the large app bar title text.
  - `--m3e-app-bar-large-subtitle-text-font-size`: Font size for the large app bar subtitle text.
  - `--m3e-app-bar-large-subtitle-text-font-weight`: Font weight for the large app bar subtitle text.
  - `--m3e-app-bar-large-subtitle-text-line-height`: Line height for the large app bar subtitle text.
  - `--m3e-app-bar-large-subtitle-text-tracking`: Letter spacing (tracking) for the large app bar subtitle text.
  - `--m3e-app-bar-large-heading-padding-left`: Left padding for the large app bar heading.
  - `--m3e-app-bar-large-heading-padding-right`: Right padding for the large app bar heading.
  - `--m3e-app-bar-large-padding-top`: Top padding for the large app bar.
  - `--m3e-app-bar-large-padding-bottom`: Bottom padding for the large app bar.
  - `--m3e-app-bar-large-title-max-lines`: Maximum number of lines for the large app bar title.
  - `--m3e-app-bar-large-subtitle-max-lines`: Maximum number of lines for the large app bar subtitle.

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


{-| The size of the bar. (default: `"small"`)
-}
size :
    Cem.M3e.Common.Value
        { large : Cem.M3e.Common.Supported
        , medium : Cem.M3e.Common.Supported
        , small : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
size =
    Cem.M3e.Common.size


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
