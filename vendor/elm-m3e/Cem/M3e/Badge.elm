module Cem.M3e.Badge exposing
    ( component
    , Size(..), size, Position(..), position, for
    , positionToString, sizeToString
    )

{-| A visual indicator used to label content.


## Component

@docs component


### Attributes

@docs Size, size, Position, position, for

-}

import Html
import Html.Attributes


{-| A visual indicator used to label content.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-badge" attributes children


{-| Values for the `size` attribute.
-}
type Size
    = Large
    | Medium
    | Small


{-| The size of the badge. (default: `"medium"`)
-}
size : Size -> Html.Attribute msg
size val_ =
    Html.Attributes.attribute "size" (sizeToString val_)


sizeToString : Size -> String
sizeToString val_ =
    case val_ of
        Large ->
            "large"

        Medium ->
            "medium"

        Small ->
            "small"


{-| Values for the `position` attribute.
-}
type Position
    = Above
    | AboveAfter
    | AboveBefore
    | After
    | Before
    | Below
    | BelowAfter
    | BelowBefore


{-| The position of the badge, when attached to another element. (default: `"above-after"`)
-}
position : Position -> Html.Attribute msg
position val_ =
    Html.Attributes.attribute "position" (positionToString val_)


positionToString : Position -> String
positionToString val_ =
    case val_ of
        Above ->
            "above"

        AboveAfter ->
            "above-after"

        AboveBefore ->
            "above-before"

        After ->
            "after"

        Before ->
            "before"

        Below ->
            "below"

        BelowAfter ->
            "below-after"

        BelowBefore ->
            "below-before"


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for : String -> Html.Attribute msg
for val_ =
    Html.Attributes.attribute "for" val_
