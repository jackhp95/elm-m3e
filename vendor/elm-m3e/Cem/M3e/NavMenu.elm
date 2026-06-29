module Cem.M3e.NavMenu exposing (component)

{-| A hierarchical menu, typically used on larger devices, that allows a user to switch between views.

@docs component

-}

import Html


{-| A hierarchical menu, typically used on larger devices, that allows a user to switch between views.

**CSS Custom Properties:**

  - `--m3e-nav-menu-padding-top`: Top padding for the menu.
  - `--m3e-nav-menu-padding-bottom`: Bottom padding for the menu.
  - `--m3e-nav-menu-padding-left`: Left padding for the menu.
  - `--m3e-nav-menu-padding-right`: Right padding for the menu.
  - `--m3e-nav-menu-divider-margin`: Margin for divider elements in the menu.
  - `--m3e-nav-menu-scrollbar-width`: Width of the menu scrollbar.
  - `--m3e-nav-menu-scrollbar-color`: Color of the menu scrollbar.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-nav-menu" attributes children
