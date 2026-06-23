module M3e.BottomSheetTrigger exposing
    ( component
    , secondary
    )

{-| An element, nested within a clickable element, used to trigger a bottom sheet.


## Component

@docs component


### Attributes

@docs secondary

-}

import Html
import Html.Attributes
import Json.Encode


{-| An element, nested within a clickable element, used to trigger a bottom sheet.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-bottom-sheet-trigger" attributes children


{-| Marks this trigger as a secondary trigger for accessibility. Secondary triggers do not receive ARIA ownership. (default: `false`)
-}
secondary : Bool -> Html.Attribute msg
secondary val_ =
    Html.Attributes.property "secondary" (Json.Encode.bool val_)
