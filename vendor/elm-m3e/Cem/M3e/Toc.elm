module Cem.M3e.Toc exposing (component, for, maxDepth, overlineSlot, titleSlot)

{-| 
A table of contents that provides in-page scroll navigation.

## Component

@docs component

### Attributes

@docs for, maxDepth

### Slots

@docs overlineSlot, titleSlot
-}


import Html
import Html.Attributes
import Json.Encode


{-| A table of contents that provides in-page scroll navigation.

**Slots:**
- `overline`: Renders the overline of the table of contents.
- `title`: Renders the title of the table of contents.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-toc" attributes children


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for : String -> Html.Attribute msg
for val_ =
    Html.Attributes.attribute "for" val_


{-| The maximum depth of the table of contents. (default: `2`) -}
maxDepth : Float -> Html.Attribute msg
maxDepth val_ =
    Html.Attributes.property "max-depth" (Json.Encode.float val_)


{-| Renders the overline of the table of contents. -}
overlineSlot : Html.Attribute msg
overlineSlot =
    Html.Attributes.attribute "slot" "overline"


{-| Renders the title of the table of contents. -}
titleSlot : Html.Attribute msg
titleSlot =
    Html.Attributes.attribute "slot" "title"