module Cem.M3e.OptionPanel exposing
    ( component
    , State(..), state, ScrollStrategy(..), scrollStrategy, fitAnchorWidth, anchorOffset
    , onBeforetoggle, onToggle
    , scrollStrategyToString, stateToString
    )

{-| Presents a list of options on a temporary surface.


## Component

@docs component


### Attributes

@docs State, state, ScrollStrategy, scrollStrategy, fitAnchorWidth, anchorOffset


### Events

@docs onBeforetoggle, onToggle

-}

import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| Presents a list of options on a temporary surface.

**Events:**

  - `beforetoggle`: Dispatched before the toggle state changes.
  - `toggle`: Dispatched after the toggle state has changed.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-option-panel" attributes children


{-| Values for the `state` attribute.
-}
type State
    = Content
    | Loading
    | NoData


{-| The state for which to present content. (default: `"content"`)
-}
state : State -> Html.Attribute msg
state val_ =
    Html.Attributes.attribute "state" (stateToString val_)


stateToString : State -> String
stateToString val_ =
    case val_ of
        Content ->
            "content"

        Loading ->
            "loading"

        NoData ->
            "no-data"


{-| Values for the `scroll-strategy` attribute.
-}
type ScrollStrategy
    = Hide
    | Reposition


{-| The strategy that controls how the panel behaves when its trigger scrolls. (default: `"hide"`)
-}
scrollStrategy : ScrollStrategy -> Html.Attribute msg
scrollStrategy val_ =
    Html.Attributes.attribute "scroll-strategy" (scrollStrategyToString val_)


scrollStrategyToString : ScrollStrategy -> String
scrollStrategyToString val_ =
    case val_ of
        Hide ->
            "hide"

        Reposition ->
            "reposition"


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
