module Cem.M3e.DialogTrigger exposing (component, for)

{-| 
An element, nested within a clickable element, used to open a dialog.

## Component

@docs component

### Attributes

@docs for
-}


import Html
import Html.Attributes


{-| An element, nested within a clickable element, used to open a dialog. -}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-dialog-trigger" attributes children


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for : String -> Html.Attribute msg
for val_ =
    Html.Attributes.attribute "for" val_