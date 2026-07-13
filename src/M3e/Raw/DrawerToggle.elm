module M3e.Raw.DrawerToggle exposing (drawerToggle, for)

{-| Bottom layer for `<m3e-drawer-toggle>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, faithful DOM emission, no phantom typing. The rawest escape in the gradient.

@docs drawerToggle, for

-}

import Html
import Html.Attributes


{-| The raw `<m3e-drawer-toggle>` element — a partial application of `Html.node`.
-}
drawerToggle : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
drawerToggle =
    Html.node "m3e-drawer-toggle"


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for : String -> Html.Attribute msg
for =
    Html.Attributes.attribute "for"
