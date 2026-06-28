module Cem.M3e.TextHighlight exposing
    ( component
    , caseSensitive, disabled, Mode(..), mode, term
    , onHighlight
    , modeToString
    )

{-| Highlights text which matches a given search term.


## Component

@docs component


### Attributes

@docs caseSensitive, disabled, Mode, mode, term


### Events

@docs onHighlight

-}

import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| Highlights text which matches a given search term.

**Events:**

  - `highlight`: Dispatched when content is highlighted.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-text-highlight" attributes children


{-| Whether matching is case sensitive. (default: `false`)
-}
caseSensitive : Bool -> Html.Attribute msg
caseSensitive val_ =
    Html.Attributes.property "caseSensitive" (Json.Encode.bool val_)


{-| A value indicating whether text highlighting is disabled. (default: `false`)
-}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| Values for the `mode` attribute.
-}
type Mode
    = Contains
    | EndsWith
    | StartsWith


{-| The mode in which to highlight text. (default: `"contains"`)
-}
mode : Mode -> Html.Attribute msg
mode val_ =
    Html.Attributes.attribute "mode" (modeToString val_)


modeToString : Mode -> String
modeToString val_ =
    case val_ of
        Contains ->
            "contains"

        EndsWith ->
            "ends-with"

        StartsWith ->
            "starts-with"


{-| The term to highlight. (default: `""`)
-}
term : String -> Html.Attribute msg
term val_ =
    Html.Attributes.attribute "term" val_


{-| Dispatched when content is highlighted.

**Payload type:** `CustomEvent`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

-}
onHighlight : Json.Decode.Decoder msg -> Html.Attribute msg
onHighlight decoder =
    Html.Events.on "highlight" decoder
