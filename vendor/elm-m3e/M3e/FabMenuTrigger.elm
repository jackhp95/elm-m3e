module M3e.FabMenuTrigger exposing (component, for)

{-| 
An element, nested within a clickable element, used to open a floating action button (FAB) menu.

## Component

@docs component

### Attributes

@docs for
-}


import Html
import Html.Attributes


{-| An element, nested within a clickable element, used to open a floating action button (FAB) menu. -}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-fab-menu-trigger" attributes children


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for : String -> Html.Attribute msg
for val_ =
    Html.Attributes.attribute "for" val_