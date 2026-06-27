module Cem.M3e.BottomSheetTrigger exposing
    ( component
    , detent, secondary, for
    )

{-| An element, nested within a clickable element, used to trigger a bottom sheet.


## Component

@docs component


### Attributes

@docs detent, secondary, for

-}

import Html
import Html.Attributes
import Json.Encode


{-| An element, nested within a clickable element, used to trigger a bottom sheet.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-bottom-sheet-trigger" attributes children


{-| The zero‑based index of the detent the sheet should open to.
-}
detent : Float -> Html.Attribute msg
detent val_ =
    Html.Attributes.property "detent" (Json.Encode.float val_)


{-| Marks this trigger as a secondary trigger for accessibility. Secondary triggers do not receive ARIA ownership. (default: `false`)
-}
secondary : Bool -> Html.Attribute msg
secondary val_ =
    Html.Attributes.property "secondary" (Json.Encode.bool val_)


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for : String -> Html.Attribute msg
for val_ =
    Html.Attributes.attribute "for" val_
