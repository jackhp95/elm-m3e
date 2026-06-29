module Cem.M3e.FloatingPanel exposing (component, scrollStrategy, fitAnchorWidth, anchorOffset, onBeforetoggle, onToggle)

{-| A lightweight, generic floating surface used to present content above the page.

@docs component, scrollStrategy, fitAnchorWidth, anchorOffset, onBeforetoggle, onToggle

-}

import Cem.M3e.Common
import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| A lightweight, generic floating surface used to present content above the page.

**Events:**

  - `beforetoggle`: Dispatched before the toggle state changes.
  - `toggle`: Dispatched after the toggle state has changed.

**CSS Custom Properties:**

  - `--m3e-floating-panel-container-shape`: Corner radius of the panel container.
  - `--m3e-floating-panel-container-min-width`: Minimum width of the panel container.
  - `--m3e-floating-panel-container-max-width`: Maximum width of the panel container.
  - `--m3e-floating-panel-container-max-height`: Maximum height of the panel container.
  - `--m3e-floating-panel-container-padding-block`: Vertical padding inside the panel container.
  - `--m3e-floating-panel-container-padding-inline`: Horizontal padding inside the panel container.
  - `--m3e-floating-panel-container-color`: Background color of the panel container.
  - `--m3e-floating-panel-container-elevation`: Box shadow elevation of the panel container.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-floating-panel" attributes children


{-| The strategy that controls how the panel behaves when its trigger scrolls. (default: `"hide"`)
-}
scrollStrategy :
    Cem.M3e.Common.Value
        { hide : Cem.M3e.Common.Supported
        , reposition : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
scrollStrategy =
    Cem.M3e.Common.scrollStrategy


{-| Whether the panel's width should match its anchor's width. (default: `false`)
-}
fitAnchorWidth : Bool -> Html.Attribute msg
fitAnchorWidth val_ =
    Html.Attributes.property "fit-anchor-width" (Json.Encode.bool val_)


{-| The logical margin, in pixels, between the panel and its anchor. (default: `0`)
-}
anchorOffset : Float -> Html.Attribute msg
anchorOffset val_ =
    Html.Attributes.property "anchor-offset" (Json.Encode.float val_)


{-| Dispatched before the toggle state changes.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

-}
onBeforetoggle : Json.Decode.Decoder msg -> Html.Attribute msg
onBeforetoggle decoder =
    Html.Events.on "beforetoggle" decoder


{-| Dispatched after the toggle state has changed.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

-}
onToggle : Json.Decode.Decoder msg -> Html.Attribute msg
onToggle decoder =
    Html.Events.on "toggle" decoder
