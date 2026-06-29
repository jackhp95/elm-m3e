module Cem.M3e.TextHighlight exposing
    ( component, caseSensitive, disabled, mode, term, issupported
    , onHighlight
    )

{-| Highlights text which matches a given search term.

@docs component, caseSensitive, disabled, mode, term, issupported
@docs onHighlight

-}

import Cem.M3e.Common
import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| Highlights text which matches a given search term.

**Events:**

  - `highlight`: Dispatched when content is highlighted.

**CSS Custom Properties:**

  - `--m3e-text-highlight-container-color`: Background color applied to highlighted text ranges.
  - `--m3e-text-highlight-color`: Foreground color of highlighted text content.
  - `--m3e-text-highlight-decoration`: Optional text decoration (e.g., underline, line-through) for highlighted text.
  - `--m3e-text-highlight-shadow`: Optional text shadow for emphasis or contrast.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-text-highlight" attributes children


{-| Whether matching is case sensitive. (default: `false`)
-}
caseSensitive : Bool -> Html.Attribute msg
caseSensitive val_ =
    Html.Attributes.property "case-sensitive" (Json.Encode.bool val_)


{-| A value indicating whether text highlighting is disabled. (default: `false`)
-}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| The mode in which to highlight text. (default: `"contains"`)
-}
mode :
    Cem.M3e.Common.Value
        { contains : Cem.M3e.Common.Supported
        , endsWith : Cem.M3e.Common.Supported
        , startsWith : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
mode =
    Cem.M3e.Common.mode


{-| The term to highlight. (default: `""`)
-}
term : String -> Html.Attribute msg
term val_ =
    Html.Attributes.attribute "term" val_


{-| A value indicating whether text highlighting is supported by the browser.
-}
issupported : Bool -> Html.Attribute msg
issupported val_ =
    Html.Attributes.property "isSupported" (Json.Encode.bool val_)


{-| Dispatched when content is highlighted.

**Payload type:** `CustomEvent`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

-}
onHighlight : Json.Decode.Decoder msg -> Html.Attribute msg
onHighlight decoder =
    Html.Events.on "highlight" decoder
