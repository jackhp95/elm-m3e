module M3e.Cem.Html.BottomSheetTrigger exposing (bottomSheetTrigger, detent, for, secondary)

{-| 
@docs bottomSheetTrigger, detent, secondary, for
-}


import Html
import Html.Attributes
import Json.Encode


{-| The raw `<m3e-bottom-sheet-trigger>` element — a partial application of `Html.node`. -}
bottomSheetTrigger :
    List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
bottomSheetTrigger =
    Html.node "m3e-bottom-sheet-trigger"


{-| The zero‑based index of the detent the sheet should open to. -}
detent : Float -> Html.Attribute msg
detent val_ =
    Html.Attributes.property "detent" (Json.Encode.float val_)


{-| Marks this trigger as a secondary trigger for accessibility. Secondary triggers do not receive ARIA ownership. (default: `false`) -}
secondary : Bool -> Html.Attribute msg
secondary val_ =
    Html.Attributes.property "secondary" (Json.Encode.bool val_)


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for : String -> Html.Attribute msg
for =
    Html.Attributes.attribute "for"