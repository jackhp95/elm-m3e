module M3e.Cem.Html.DrawerToggle exposing (drawerToggle, for)

{-| 
@docs drawerToggle, for
-}


import Html
import Html.Attributes


{-| The raw `<m3e-drawer-toggle>` element — a partial application of `Html.node`. -}
drawerToggle :
    List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
drawerToggle =
    Html.node "m3e-drawer-toggle"


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for : String -> Html.Attribute msg
for =
    Html.Attributes.attribute "for"