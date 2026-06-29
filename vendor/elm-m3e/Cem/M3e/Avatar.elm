module Cem.M3e.Avatar exposing (component)

{-| An image, icon or textual initials representing a user or other identity.

@docs component

-}

import Html


{-| An image, icon or textual initials representing a user or other identity.

**CSS Custom Properties:**

  - `--m3e-avatar-size`: Size of the avatar.
  - `--m3e-avatar-shape`: Border radius of the avatar.
  - `--m3e-avatar-font-size`: Font size for the avatar.
  - `--m3e-avatar-font-weight`: Font weight for the avatar.
  - `--m3e-avatar-line-height`: Line height for the avatar.
  - `--m3e-avatar-tracking`: Letter spacing for the avatar.
  - `--m3e-avatar-color`: Background color of the avatar.
  - `--m3e-avatar-label-color`: Text color of the avatar.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-avatar" attributes children
