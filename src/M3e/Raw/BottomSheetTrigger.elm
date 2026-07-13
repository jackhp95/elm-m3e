module M3e.Raw.BottomSheetTrigger exposing (bottomSheetTrigger, detent, secondary, for)

{-| Bottom layer for `<m3e-bottom-sheet-trigger>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, faithful DOM emission, no phantom typing. The rawest escape in the gradient.

@docs bottomSheetTrigger, detent, secondary, for

-}

import Html
import Html.Attributes


{-| The raw `<m3e-bottom-sheet-trigger>` element — a partial application of `Html.node`.
-}
bottomSheetTrigger : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
bottomSheetTrigger =
    Html.node "m3e-bottom-sheet-trigger"


{-| The zero‑based index of the detent the sheet should open to.
-}
detent : Float -> Html.Attribute msg
detent val_ =
    Html.Attributes.attribute "detent" (String.fromFloat val_)


{-| Marks this trigger as a secondary trigger for accessibility. Secondary triggers do not receive ARIA ownership. (default: `false`)
-}
secondary : Bool -> Html.Attribute msg
secondary val_ =
    if val_ then
        Html.Attributes.attribute "secondary" ""

    else
        Html.Attributes.classList []


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for : String -> Html.Attribute msg
for =
    Html.Attributes.attribute "for"
