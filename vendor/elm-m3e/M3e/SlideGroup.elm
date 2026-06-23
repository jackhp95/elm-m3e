module M3e.SlideGroup exposing (component, nextIconSlot, prevIconSlot, threshold)

{-| 
Presents pagination controls used to scroll overflowing content.

## Component

@docs component

### Attributes

@docs threshold

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


{-| A value, in pixels, indicating the scroll threshold at which to begin showing pagination controls. (default: `0`) -}
threshold : Float -> Html.Attribute msg
threshold val_ =
    Html.Attributes.property "threshold" (Json.Encode.float val_)


{-| Renders the icon to present for the next button. -}
nextIconSlot : Html.Attribute msg
nextIconSlot =
    Html.Attributes.attribute "slot" "next-icon"


{-| Renders the icon to present for the previous button. -}
prevIconSlot : Html.Attribute msg
prevIconSlot =
    Html.Attributes.attribute "slot" "prev-icon"