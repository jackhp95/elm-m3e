module M3e.SlideGroup exposing (component, disabled, nextIconSlot, nextPageLabel, prevIconSlot, previousPageLabel, threshold, vertical)

{-| 
Presents pagination controls used to scroll overflowing content.

## Component

@docs component

### Attributes

@docs disabled, nextPageLabel, previousPageLabel, threshold, vertical

### Slots

@docs nextIconSlot, prevIconSlot
-}


import Html
import Html.Attributes
import Json.Encode


{-| Presents pagination controls used to scroll overflowing content.

**Slots:**
- `next-icon`: Renders the icon to present for the next button.
- `prev-icon`: Renders the icon to present for the previous button.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-slide-group" attributes children


{-| Whether scroll buttons are disabled. (default: `false`) -}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| The accessible label given to the button used to move to the next page. (default: `"Next page"`) -}
nextPageLabel : String -> Html.Attribute msg
nextPageLabel val_ =
    Html.Attributes.attribute "next-page-label" val_


{-| The accessible label given to the button used to move to the previous page. (default: `"Previous page"`) -}
previousPageLabel : String -> Html.Attribute msg
previousPageLabel val_ =
    Html.Attributes.attribute "previous-page-label" val_


{-| A value, in pixels, indicating the scroll threshold at which to begin showing pagination controls. (default: `0`) -}
threshold : Float -> Html.Attribute msg
threshold val_ =
    Html.Attributes.property "threshold" (Json.Encode.float val_)


{-| Whether content is oriented vertically. (default: `false`) -}
vertical : Bool -> Html.Attribute msg
vertical val_ =
    Html.Attributes.property "vertical" (Json.Encode.bool val_)


{-| Renders the icon to present for the next button. -}
nextIconSlot : Html.Attribute msg
nextIconSlot =
    Html.Attributes.attribute "slot" "next-icon"


{-| Renders the icon to present for the previous button. -}
prevIconSlot : Html.Attribute msg
prevIconSlot =
    Html.Attributes.attribute "slot" "prev-icon"