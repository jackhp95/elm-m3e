module M3e.Toc exposing
    ( component
    , maxDepth
    , overlineSlot, titleSlot
    )

{-| A table of contents that provides in-page scroll navigation.


## Component

@docs component


### Attributes

@docs maxDepth


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


{-| The maximum depth of the table of contents. (default: `2`)
-}
maxDepth : Float -> Html.Attribute msg
maxDepth val_ =
    Html.Attributes.property "max-depth" (Json.Encode.float val_)


{-| Renders the overline of the table of contents.
-}
overlineSlot : Html.Attribute msg
overlineSlot =
    Html.Attributes.attribute "slot" "overline"


{-| Renders the title of the table of contents.
-}
titleSlot : Html.Attribute msg
titleSlot =
    Html.Attributes.attribute "slot" "title"
